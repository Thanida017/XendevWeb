using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.api.param
{
    public class UpdateUserAccountProfileRequest
    {
        public long uaId { get; set; }

        public string firstName { get; set; }

        public string lastName { get; set; }

        public string email { get; set; }

        public string imageUserFileNameBase64 { get; set; }
    }
}