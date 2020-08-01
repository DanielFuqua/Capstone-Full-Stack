using System;
using System.Collections.Generic;
using System.Linq;
using Capstone.Data;
using Capstone.Models;
using Microsoft.EntityFrameworkCore;

namespace Tabloid.Repositories
{
    public class InstructionRepository
    {
        private readonly ApplicationDbContext _context;

        public InstructionRepository(ApplicationDbContext context)
        {
            _context = context;
        }
        //public List<Instruction> GetAll()
        //{
        //    var All = _context.Pose.ToList();
        //    return All;
        //}

        public List<Instruction> GetByPoseId(int id)
        {
            return _context.Instruction.Where(i => i.PoseId == id)
                                        .Include(i => i.Pose)
                                        .ToList();
        }




    }
}