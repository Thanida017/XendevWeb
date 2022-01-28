using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace XenDevWeb.domain
{
    [Serializable]
    public class Report
    {
        [Key]
        public long id { get; set; }

        public string name { get; set; }

        public string description { get; set; }

        public virtual EstimationRequest estimationRequest { get; set; }

        public DateTime creationDate { get; set; }

        public DateTime lastUpdate { get; set; }
    }
}