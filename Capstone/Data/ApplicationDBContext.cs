using Capstone.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }

        public DbSet<UserProfile> UserProfile { get; set; }
        public DbSet<UserType> UserType { get; set; }
        public DbSet<Benefit> Benefit { get; set; }
        public DbSet<Comment> Comment { get; set; }
        public DbSet<Instruction> Instruction { get; set; }
        public DbSet<Modification> Modification { get; set; }
        public DbSet<Note> Note { get; set; }
        public DbSet<Pose> Pose { get; set; }
        public DbSet<UserPoseDifficulty> UserPoseDifficulty { get; set; }
        public DbSet<Vocabulary> Vocabulary { get; set; }

    }
}
