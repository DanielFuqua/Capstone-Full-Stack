using System;
using System.Collections.Generic;
using System.Linq;
using Capstone.Data;
using Capstone.Models;
using Microsoft.EntityFrameworkCore;

namespace Tabloid.Repositories
{
    public class NoteRepository
    {
        private readonly ApplicationDbContext _context;

        public NoteRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        public List<Note> GetByPoseIdAndUserProfileId(int poseId, int userProfileId)
        {
            return _context.Note.Where(n => n.PoseId == poseId && n.UserProfileId == userProfileId)
                                        .Include(n => n.Pose)
                                        .Include(n => n.UserProfile)
                                        .ToList();
        }

      




    }
}