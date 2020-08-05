
using System.Security.Claims;
using Capstone.Data;
using Capstone.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Capstone.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class InstructionController : ControllerBase
    {
        private readonly InstructionRepository _instructionRepository;

        public InstructionController(ApplicationDbContext context)
        {
            _instructionRepository = new InstructionRepository(context);
        }

        [Authorize]
        [HttpGet("{id}")]
        public IActionResult Get(int id)
        {
            var instructions = _instructionRepository.GetByPoseId(id);
            if (instructions == null)
            {
                return NotFound();
            }
            return Ok(instructions);
        }

    }

}