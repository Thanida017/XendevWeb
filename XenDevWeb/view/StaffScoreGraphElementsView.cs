using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.view
{
    public class StaffScoreGraphElementsView
    {
        public string personName { get; set; }
        public int assigned { get; set; }
        public int wip { get; set; }
        public int submitPass { get; set; }
        public int submitFailed { get; set; }
        
    }

    
}