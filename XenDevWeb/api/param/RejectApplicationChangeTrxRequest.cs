using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.api.param
{
    public class RejectApplicationChangeTrxRequest
    {
        public long appChangeTrxId { get; set; }

        public long uaId { get; set; }

        public string rejectCode { get; set; }

        public string rejectNote { get; set; }

        public string otherRejectReason { get; set; }
    }
}