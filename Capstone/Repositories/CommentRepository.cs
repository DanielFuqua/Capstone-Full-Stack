using System;
using System.Collections.Generic;
using System.Linq;
using Capstone.Data;
using Capstone.Models;
using Microsoft.EntityFrameworkCore;

namespace Tabloid.Repositories
{
    public class CommentRepository
    {
        private readonly ApplicationDbContext _context;

        public CommentRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        public List<Comment> GetByPoseId(int poseId)
        {
            return _context.Comment.Where(c => c.PoseId == poseId)
                                        .Include(c => c.Pose)
                                        .Include(c => c.UserProfile)
                                        .OrderByDescending(c => c.CreateDateTime)
                                        .ToList();
        }

        public void Add(Comment comment)
        {
            _context.Add(comment);
            _context.SaveChanges();
        }

        public void Update(Comment comment)
        {
            _context.Entry(comment).State = EntityState.Modified;
            _context.SaveChanges();
        }






    }
}