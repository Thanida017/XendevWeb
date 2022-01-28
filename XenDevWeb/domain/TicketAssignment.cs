using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace XenDevWeb.domain
{
    [Serializable]
    public class TicketAssignment
    {
        [Key]
        public long id { get; set; }

        public virtual StaffAccount assignTo { get; set; }

        public virtual Ticket ticket { get; set; }

        public DateTime assignDate { get; set; }

        public String note { get; set; }

        public bool enabled { get; set; }

        public DateTime creationDate { get; set; }

        public DateTime lastUpdate { get; set; }

    }
}