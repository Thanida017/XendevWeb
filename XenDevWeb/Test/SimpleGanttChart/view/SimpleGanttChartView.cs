using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.Test.SimpleGanttChart.view
{
    public class SimpleGanttChartView
    {
        public string start { get; set; }
        public string end { get; set; }
        public string name { get; set; }
        public string id { get; set; }
        public int progress { get; set; }
        public string dependencies { get; set; }
        public string custom_class { get; set; }
    }
}