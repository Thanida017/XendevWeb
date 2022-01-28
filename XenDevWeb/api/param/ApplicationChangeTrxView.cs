using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.api.param
{
    public class ApplicationChangeTrxView
    {
        public string idAppChangeTrx { get; set; }

        public string status { get; set; }

        public bool isCanApprove { get; set; }

        public string lastUpdate { get; set; }

        public string changeDetails { get; set; }

        public double manDays { get; set; }

        public List<ImageView> images { get; set; }
    }
}