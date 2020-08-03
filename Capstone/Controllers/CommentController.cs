
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
    public class CommentController : ControllerBase
    {
        private readonly CommentRepository _commentRepository;
        private readonly UserProfileRepository _userProfileRepository;

        public CommentController(ApplicationDbContext context)
        {
            _commentRepository = new CommentRepository(context);
            _userProfileRepository = new UserProfileRepository(context);
        }

        [Authorize]
        [HttpGet("{id}")]
        public IActionResult Get(int id)
        {
     

            var comments = _commentRepository.GetByPoseId(id);

            if (comments == null)
            {
                return NotFound();
            }
            return Ok(comments);
        }

        private UserProfile GetCurrentUserProfile()
        {
            var firebaseUserId = User.FindFirst(ClaimTypes.NameIdentifier).Value;
            return _userProfileRepository.GetByFirebaseUserId(firebaseUserId);
        }

        [HttpPost]
        public IActionResult Post(Comment comment)
        {
            var currentUser = GetCurrentUserProfile();
            comment.UserProfileId = currentUser.Id;

            _commentRepository.Add(comment);
            return CreatedAtAction("Get", new { id = comment.Id }, comment);
        }

        [HttpPut("{id}")]
        public IActionResult Put(int id, Comment comment)
        {
            if (id != comment.Id)
            {
                return BadRequest();
            }
            var currentUser = GetCurrentUserProfile();
            comment.UserProfileId = currentUser.Id;

            _commentRepository.Update(comment);
            return NoContent();
        }



    }

}