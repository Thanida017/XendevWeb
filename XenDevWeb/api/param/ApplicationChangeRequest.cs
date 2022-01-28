using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.api.param
{
    public class ApplicationChangeRequest
    {
        public long pjId { get; set; }
        public long uaId { get; set; }
    }
}