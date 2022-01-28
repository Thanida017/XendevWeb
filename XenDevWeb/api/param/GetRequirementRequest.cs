using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.api.param
{
    public class GetRequirementRequest
    {
        public long uaId { get; set; }
        public long pjId { get; set; }
    }
}