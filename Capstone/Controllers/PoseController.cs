
using System.Security.Claims;
using Capstone.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Tabloid.Repositories;

namespace Tabloid.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PoseController : ControllerBase
    {
        private readonly PoseRepository _poseRepository;

        public PoseController(ApplicationDbContext context)
        {
            _poseRepository = new PoseRepository(context);
        }  

        
   
        [HttpGet]
        public IActionResult Get()
        {
            return Ok(_poseRepository.GetAll());
        }

       
        [Authorize]
        [HttpGet("{id}")]
        public IActionResult Get(int id)
        {
            var pose = _poseRepository.GetById(id);
            if (pose == null)
            {
                return NotFound();
            }
            return Ok(pose);
        }

       

        

        

       
    }

}