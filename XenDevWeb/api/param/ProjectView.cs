using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.api.param
{
    public class ProjectView
    {
        public string pjId { get; set; }

        public string name { get; set; }

        public DateTime lastUpdate { get; set; }

        public string projectColor { get; set; }

        public string textProjectImage { get; set; }

        public string description { get; set; }

        public string bannerImageFileName { get; set; }

        public double remainingMandays { get; set; }

        public double totalManDay { get; set; }
    }
}