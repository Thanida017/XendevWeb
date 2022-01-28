using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.Test.drawflow.view
{
    public class DrawflowView
    {
        public string graphName { get; set; }
        public string json { get; set; }
        public DateTime creationDate { get; set; }
        public DateTime lastUpdate { get; set; }
    }
}