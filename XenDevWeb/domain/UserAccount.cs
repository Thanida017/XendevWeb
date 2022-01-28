using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace XenDevWeb.domain
{
    public enum PERSON_TITLE
    {
        MR = 0,
        MISS = 1,
        MS = 2,
        KHUN = 3
    }

    [Serializable]
    public class UserAccount
    {
        [Key]
        public int id { get; set; }

        public string empNo { get; set; }

        public PERSON_TITLE title { get; set; }

        public string firstName { get; set; }

        public string lastName { get; set; }

        public string username { get; set; }

        public string password { get; set; }

        public bool enabled { get; set; }

        public string email { get; set; }

        public string language { get; set; }

        public string mobilePhoneNumber { get; set; }

        public virtual Company company { get; set; }

        public virtual List<ApplicationChange> applicationChanges { get; set; }

        public virtual List<ApplicationChangeTrx> applicationChangesTrxes { get; set; }

        public virtual List<MeetingNote> meetingNotes { get; set; }

        public bool isAdmin { get; set; }

        //For mobile
        public string token { get; set; }

        public string imageUserFileName { get; set; }

        public string activationCode { get; set; }

        public DateTime creationDate { get; set; }

        public DateTime lastUpdate { get; set; }

    }
}