using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.Test.flowy.view
{
    public class BlockFlowyView
    {
        public int id { get; set; }
        public int parent { get; set; }
        public List<DatumFlowyView> data { get; set; }
        public List<AttrFlowyView> attr { get; set; }
    }
}