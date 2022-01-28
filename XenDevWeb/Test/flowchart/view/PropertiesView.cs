using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.Test.flowchart.view
{
    public class PropertiesView
    {
        public string title { get; set; }
        public InputsView inputs { get; set; }
        public OutputsView outputs { get; set; }
    }
}