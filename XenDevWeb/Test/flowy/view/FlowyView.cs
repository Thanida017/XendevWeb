using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.Test.flowy.view
{
    public class FlowyView
    {
        public string html { get; set; }
        public List<BlockarrFlowyView> blockarr { get; set; }
        public List<BlockFlowyView> blocks { get; set; }
    }
}