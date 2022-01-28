using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Web;
using XenDevWeb.Utils;

namespace XenDevWeb.domain
{
    public enum TITLE
    {
        COMPANY_LIMITTED = 0, //บริษัทจำกัด
        PUBLIC_COMPANY_LIMITTED = 1, //บริษัท มหาชน จำกัด
        PARTNERSHIP_LIMITTED = 2, //ห้างหุ้นส่วนจำกัด
        LEGAL_PERSON = 3 //นิติบุคคล

    }
    [Serializable]
    public class Company
    {
        [Key]
        public int id { get; set; }

        public TITLE title { get; set; }

        public string code { get; set; }

        public string name { get; set; }

        //20200527 เพิ่มภาษาอังกฤษ
        public string nameEng { get; set; }

        public string taxId { get; set; }

        public bool enabled { get; set; }

        public virtual List<UserAccount> users { get; set; }

        public virtual List<Project> projects { get; set; }

        public byte[] logoImage { get; set; }

        public DateTime creationDate { get; set; }

        public DateTime lastUpdate { get; set; }
        
    }
}