
using System.Security.Claims;
using Capstone.Data;
using Capstone.Models;
using Capstone.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Tabloid.Repositories;

namespace Tabloid.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NoteController : ControllerBase
    {
        private readonly NoteRepository _noteRepository;
        private readonly UserProfileRepository _userProfileRepository;


        public NoteController(ApplicationDbContext context)
        {
            _noteRepository = new NoteRepository(context);
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

            var notes = _noteRepository.GetByPoseIdAndUserProfileId(id, userProfileId);

            if (notes == null)
            {
                return NotFound();
            }
            return Ok(notes);
        }

        

    }

}