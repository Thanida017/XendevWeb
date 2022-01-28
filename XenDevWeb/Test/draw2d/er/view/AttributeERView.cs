using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.Test.draw2d.er.view
{
    public class AttributeERView
    {
        public string text { get; set; }
        public string id { get; set; }
        public string datatype { get; set; }
        public bool pk { get; set; }
        public bool fk { get; set; }
        public bool isNullable { get; set; }
        public bool isRequired { get; set; }
    }
}