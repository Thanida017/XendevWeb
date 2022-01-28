using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace XenDevWeb.domain
{
    [Serializable]
    public class ProjectMandays
    {
        [Key]
        public long id { get; set; }

        public virtual Project project { get; set; }

        public string poNumber { get; set; }

        public double mandays { get; set; }

        public DateTime creationDate { get; set; }

        public DateTime lastUpdate { get; set; }
    }
}