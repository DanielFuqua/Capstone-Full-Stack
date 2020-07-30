using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class Comment
    {
        public int Id { get; set; }
        public int PoseId { get; set; }
        public Pose Pose { get; set; }
        public int UserProfileId { get; set; }
        public UserProfile UserProfile { get; set; }
        public string Content { get; set; }
        public DateTime CreateDateTime { get; set; }
    }
}
