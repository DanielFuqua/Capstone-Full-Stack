using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class Instruction
    {
        public int Id { get; set; }
        public int PoseId { get; set; }
        public Pose Pose { get; set; }
        public string Content { get; set; }
    }
}
