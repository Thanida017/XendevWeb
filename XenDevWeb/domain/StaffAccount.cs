using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace XenDevWeb.domain
{
    public enum USER_ROLE
    {
        SYSTEM = 1,
        PROGRAMMER = 2
    }
    [Serializable]
    public class StaffAccount
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

        public bool isAdmin { get; set; }

        public USER_ROLE role { get; set; }

        //For mobile
        public string token { get; set; }

        public string imageUserFileName { get; set; }

        public List<TicketAssignment> ticketToStaff { get; set; }

        public DateTime creationDate { get; set; }

        public DateTime lastUpdate { get; set; }
    }
}