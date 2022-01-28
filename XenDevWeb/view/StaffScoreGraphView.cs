using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.view
{
    public class StaffScoreGraphView
    {
        public string name { get; set; }

        public List<StaffScoreGraphElementsView> items { get; set; }
    }
}