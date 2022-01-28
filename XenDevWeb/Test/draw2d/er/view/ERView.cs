using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.Test.draw2d.er.view
{
    public class ERView
    {
        public string type { get; set; }
        public string id { get; set; }
        public double x { get; set; }
        public double y { get; set; }
        public double width { get; set; }
        public double height { get; set; }
        public UserDataERView userData { get; set; }
        public string cssClass { get; set; }
        public string bgColor { get; set; }
        public string color { get; set; }
        public double stroke { get; set; }
        public double alpha { get; set; }
        public double radius { get; set; }
        public string tableName { get; set; }
        public List<TablePortERView> tablePorts { get; set; }
        public List<AttributeERView> attributes { get; set; }
        public string name { get; set; }
        public string policy { get; set; }
        public string router { get; set; }
        public SourceERView source { get; set; }
        public TargetERView target { get; set; }
    }
}