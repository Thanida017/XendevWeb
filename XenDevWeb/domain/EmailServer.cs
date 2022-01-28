using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace XenDevWeb.domain
{
    [Serializable]
    public class EmailServer
    {
        [Key]
        public long id { get; set; }

        public string senderAddress { get; set; }
        public string stmpAddress { get; set; }
        public string port { get; set; }
        public string username { get; set; }
        public string password { get; set; }
    }
}