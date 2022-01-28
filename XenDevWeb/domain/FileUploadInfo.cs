using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace XenDevWeb.domain
{
    [Serializable]
    public class FileUploadInfo
    {
        [Key]
        public long id { get; set; }

        [NotMapped]
        public string guiKey { get; set; }

        public string originalFileName { get; set; }

        public string serverFileName { get; set; }

        public DateTime creationDate { get; set; }

        public virtual Ticket problemDetail { get; set; }
    }
}