using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace XenDevWeb.domain
{
    public enum APPROVALTYPE
    {
        MEETING = 1,
        REQUIREMENT = 2,
        DESIGN = 3,
        TESTING = 4,
    }

    [Serializable]
    public class Project
    {
        [Key]
        public int id { get; set; }

        public APPROVALTYPE approvalType { get; set; }

        public string code { get; set; }

        public string name { get; set; }

        public string description { get; set; }

        public string bannerImageFileName { get; set; }

        public string projectColor { get; set; }

        public virtual List<MeetingNote> meetingNotes { get; set; }

        public virtual Company company { get; set; }

        public virtual List<ApplicationAsset> applicationAssets { get; set; }

        public virtual List<ApprovalHierarchy> approvalHierarchies { get; set; }

        public DateTime creationDate { get; set; }

        public DateTime lastUpdate { get; set; }

        public virtual List<Ticket> tickets { get; set; }

        public virtual List<ProjectMandays> projectMandays { get; set; }

        public double remainingMandays { get; set; }

        public double totalManDay { get; set; }

        public string getNewMeetingRound()
        {
            if (this.meetingNotes == null || this.meetingNotes.Count == 0)
            {
                return "1 / " + DateTime.Now.Year;
            }
            int count = this.meetingNotes.Where(o => o.meetingDateTime.Year == DateTime.Now.Year)
            .Count();
            return (count + 1) + " / " + DateTime.Now.Year;
        }
    }
}