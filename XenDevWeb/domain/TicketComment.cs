using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace XenDevWeb.domain
{
    [Serializable]
    public class TicketComment
    {
        [Key]
        public long id { get; set; }

        public virtual Ticket ticket { get; set; }

        public virtual StaffAccount by { get; set; }

        [Column(TypeName = "text")]
        public string commentText { get; set; }

        public virtual List<Image> images { get; set; }

        public DateTime creationDate { get; set; }
    }
}