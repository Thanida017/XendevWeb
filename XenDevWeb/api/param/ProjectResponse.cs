using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.api.param
{
    public class ProjectResponse
    {
        public bool success { get; set; }

        public List<ProjectView> projectView { get; set; }
    }
}