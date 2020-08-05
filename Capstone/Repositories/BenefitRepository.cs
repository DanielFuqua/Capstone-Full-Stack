using System;
using System.Collections.Generic;
using System.Linq;
using Capstone.Data;
using Capstone.Models;
using Microsoft.EntityFrameworkCore;

namespace Capstone.Repositories
{
    public class BenefitRepository
    {
        private readonly ApplicationDbContext _context;

        public BenefitRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        public List<Benefit> GetByPoseId(int id)
        {
            return _context.Benefit.Where(b => b.PoseId == id)
                                        .Include(b => b.Pose)
                                        .ToList();
        }




    }
}