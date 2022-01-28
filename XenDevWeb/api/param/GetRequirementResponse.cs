using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.api.view;

namespace XenDevWeb.api.param
{
    public class GetRequirementResponse
    {
        public bool success { get; set; }        

        public List<RequirementView> reqViews { get; set; }
    }
}