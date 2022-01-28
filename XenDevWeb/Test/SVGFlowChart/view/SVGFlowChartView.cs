using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.Test.SVGFlowChart.view
{
    public class SVGFlowChartView
    {
        public string label { get; set; }
        public string type { get; set; }
        public List<string> text { get; set; }
        public string yes { get; set; }
        public string no { get; set; }
        public List<LinkSVGFlowChartView> links { get; set; }
        public TipSVGFlowChartView tip { get; set; }
        public string next { get; set; }
        public OrientSVGFlowChartView orient { get; set; }
    }
}