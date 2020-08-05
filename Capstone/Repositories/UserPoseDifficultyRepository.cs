using System;
using System.Collections.Generic;
using System.Linq;
using Capstone.Data;
using Capstone.Models;
using Microsoft.EntityFrameworkCore;

namespace Capstone.Repositories
{
    public class UserPoseDifficultyRepository
    {

        private readonly ApplicationDbContext _context;

        public UserPoseDifficultyRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        public UserPoseDifficulty GetByPoseIdAndUserProfileId(int poseId, int userProfileId)
        {
            return _context.UserPoseDifficulty.Include(upd => upd.Pose)
                                               .Include(upd => upd.UserProfile)
                                               .FirstOrDefault(upd => upd.PoseId == poseId && upd.UserProfileId == userProfileId);
                                                            
        }

        public void Add(UserPoseDifficulty userPoseDifficulty)
        {
            _context.Add(userPoseDifficulty);
            _context.SaveChanges();
        }

        public void Update(UserPoseDifficulty userPoseDifficulty)
        {
            _context.Entry(userPoseDifficulty).State = EntityState.Modified;
            _context.SaveChanges();
        }

        public void Delete(int id)
        {
            var userPoseDifficulty = GetById(id);


            _context.UserPoseDifficulty.Remove(userPoseDifficulty);
            _context.SaveChanges();
        }

        public UserPoseDifficulty GetById(int id)
        {
            return _context.UserPoseDifficulty
                .FirstOrDefault(upd => upd.Id == id);
        }
    }
}
