using System;
using System.Collections.Generic;
using System.Linq;
using Capstone.Data;
using Capstone.Models;
using Microsoft.EntityFrameworkCore;

namespace Tabloid.Repositories
{
    public class PoseRepository
    {
        private readonly ApplicationDbContext _context;

        public PoseRepository(ApplicationDbContext context)
        {
            _context = context;
        }
        public List<Pose> GetAll()
        {
            var All = _context.Pose.ToList();
            return All;
        }

        public Pose GetById(int id)
        {
            return _context.Pose.FirstOrDefault(p => p.Id == id);
        }


        

    }
}