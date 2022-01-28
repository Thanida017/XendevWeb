using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace XenDevWeb.domain
{
    public enum ESTIMATION_STATUS
    {
        NEW = 1,
        ACCEPTED = 2,
        REJECTED = 3
    }

    [Serializable]
    public class EstimationRequest
    {
        [Key]
        public long id { get; set; }

        public string companyName { get; set; }

        public string personName { get; set; }

        public string email { get; set; }

        public string phoneNumber { get; set; }

        public string projectName { get; set; }

        [Column(TypeName = "text")]
        public string description { get; set; }

        [Column(TypeName = "text")]
        public string comment { get; set; }

        public ESTIMATION_STATUS status { get; set; }

        public bool styleWeb { get; set; }

        public bool styleMobile { get; set; }

        public bool styleDesktop { get; set; }

        public bool inputExcel { get; set; }

        public bool inputFormEntry { get; set; }

        public bool inputFile { get; set; }

        public bool inputOther { get; set; }

        public string inputOtherDetail { get; set; }

        public bool migrateOldDatabase { get; set; }

        public bool migrateExcel { get; set; }

        public bool migrateOther { get; set; }

        public string migrateOtherDetail { get; set; }

        public bool mustIntergrate { get; set; }

        public virtual List<Report> reports { get; set; }

        public DateTime creationDate { get; set; }

        public DateTime lastUpdate { get; set; }


    }
}