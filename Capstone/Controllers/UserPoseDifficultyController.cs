using System.Security.Claims;
using Capstone.Data;
using Capstone.Models;
using Capstone.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Capstone.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserPoseDifficultyController : ControllerBase
    {
        private readonly UserPoseDifficultyRepository _userPoseDifficultyRepository;
        private readonly UserProfileRepository _userProfileRepository;


        public UserPoseDifficultyController(ApplicationDbContext context)
        {
            _userPoseDifficultyRepository = new UserPoseDifficultyRepository(context);
            _userProfileRepository = new UserProfileRepository(context);
        }

        //getting the authorized user's 
        private UserProfile GetCurrentUserProfile()
        {
            var firebaseUserId = User.FindFirst(ClaimTypes.NameIdentifier).Value;
            return _userProfileRepository.GetByFirebaseUserId(firebaseUserId);
        }

        [Authorize]
        [HttpGet("{id}")]
        public IActionResult Get(int id)
        {
            var currentUser = GetCurrentUserProfile();
            var userProfileId = currentUser.Id;

            var userPoseDifficulty = _userPoseDifficultyRepository.GetByPoseIdAndUserProfileId(id, userProfileId);

            if (userPoseDifficulty == null)
            {
                return NotFound();
            }
            return Ok(userPoseDifficulty);
        }

        [HttpPost]
        public IActionResult Post(UserPoseDifficulty userPoseDifficulty)
        {
            var currentUser = GetCurrentUserProfile();
            userPoseDifficulty.UserProfileId = currentUser.Id;

            var existingUserPoseDifficulty = _userPoseDifficultyRepository
                    .GetByPoseIdAndUserProfileId(userPoseDifficulty.PoseId, userPoseDifficulty.UserProfileId);

            
            

            if (existingUserPoseDifficulty == null)
            {
                _userPoseDifficultyRepository.Add(userPoseDifficulty);
                return CreatedAtAction("Get", new { id = userPoseDifficulty.Id }, userPoseDifficulty);
            }
            else
            {
                _userPoseDifficultyRepository.Delete(existingUserPoseDifficulty.Id);
                _userPoseDifficultyRepository.Add(userPoseDifficulty);
                return CreatedAtAction("Get", new { id = userPoseDifficulty.Id }, userPoseDifficulty);
            }
           
        }

        [HttpPut("{id}")]
        public IActionResult Put(int id, UserPoseDifficulty userPoseDifficulty)
        {
            if (id != userPoseDifficulty.Id)
            {
                return BadRequest();
            }
            var currentUser = GetCurrentUserProfile();
            userPoseDifficulty.UserProfileId = currentUser.Id;

            _userPoseDifficultyRepository.Update(userPoseDifficulty);
            return NoContent();
        }

    }

}