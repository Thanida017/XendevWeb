using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace XenDevWeb.domain
{
    [Serializable]
    public class MeetingNote
    {
        [Key]
        public long id { get; set; }

        [Column(TypeName = "text")]
        public string text { get; set; }

        public string meetingNoteColor { get; set; }

        public virtual Project project { get; set; }

        public virtual List<Image> images { get; set; }

        public virtual List<Requirement> requirements { get; set; }

        public virtual UserAccount createdBy { get; set; }

        public string attendNames { get; set; }

        public string ccTo { get; set; }

        public string meetingTitle { get; set; }

        public bool isEnabled { get; set; }

        public DateTime meetingDateTime { get; set; }

        public DateTime creationDate { get; set; }

        public DateTime lastUpdate { get; set; }
    }
}