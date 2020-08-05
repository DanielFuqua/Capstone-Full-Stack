
using System.Security.Claims;
using Capstone.Data;
using Capstone.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Capstone.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BenefitController : ControllerBase
    {
        private readonly BenefitRepository _benefitRepository;

        public BenefitController(ApplicationDbContext context)
        {
            _benefitRepository = new BenefitRepository(context);
        }

        [Authorize]
        [HttpGet("{id}")]
        public IActionResult Get(int id)
        {
            var benefits = _benefitRepository.GetByPoseId(id);
            if (benefits == null)
            {
                return NotFound();
            }
            return Ok(benefits);
        }

    }

}