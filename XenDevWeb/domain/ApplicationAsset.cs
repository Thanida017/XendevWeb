using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace XenDevWeb.domain
{
    public class ApplicationAsset
    {
        public long id { get; set; }
        public virtual Project project { get; set; }
        public string assetFileName { get; set; }
        public string note { get; set; }
        public bool enabled { get; set; }
        public virtual List<ApplicationChange> applicationChanges { get; set; }
        public DateTime creationDate { get; set; }
        public DateTime lastUpdate { get; set; }
    }
}