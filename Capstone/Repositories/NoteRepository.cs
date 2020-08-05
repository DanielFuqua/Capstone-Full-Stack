using System;
using System.Collections.Generic;
using System.Linq;
using Capstone.Data;
using Capstone.Models;
using Microsoft.EntityFrameworkCore;

namespace Capstone.Repositories
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

        public void Add(Note note)
        {
            _context.Add(note);
            _context.SaveChanges();
        }

        public void Update(Note note)
        {
            _context.Entry(note).State = EntityState.Modified;
            _context.SaveChanges();
        }

        public void Delete(int id)
        {
            var note = GetById(id);


            _context.Note.Remove(note);
            _context.SaveChanges();
        }

        public Note GetById(int id)
        {
            return _context.Note
                .FirstOrDefault(n => n.Id == id);
        }






    }
}