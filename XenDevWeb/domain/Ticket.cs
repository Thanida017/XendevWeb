using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace XenDevWeb.domain
{
    public enum TICKET_STATUS
    {
        //ลูกค้าเพิ่งสร้าง ยังไม่มีใครเอาไปดู หรือ admin สร้างยังเขียนไม่เสร้จ
        NEW = 1,

        //กำลังวิเคราะห์เบื้องต้น ใช้กับ ticket_type client เท่านั้น
        ON_REVIEW = 2,

        //admin มอบหมาย ticket ไปให้ staff
        ASSIGNED = 3,

        //staff ระบุว่าแก้ไขเสร้จแล้ว
        SOLVED = 4,

        //admin ตรวจสอบแล้วว่าดำเนินการถูกต้อง ถ้าไม่ถูกจะกลับไปเป็น assigned ใหม่
        CLOSED = 5,

        //ถูกยกเลิก
        CANCEL = 6,

        //admin ตรวจสอบแล้วว่าแก้ไขถูกต้อง ใช้กับ ticket ที่เป็นงานแก้บั๊ก
        CLOSE_WITH_BUG = 7,

        //admin ตรวจสอบแล้วว่าแก้ไขถูกต้อง ใช้กับงานที่นอกเหนือ spec
        CLOSE_WITH_OFF_SPEC = 8
    }
    
    public enum TICKET_TYPE
    {
        INTERNAL = 1,
        CLIENT = 2
    }

    [Serializable]
    public class Ticket
    {
        [Key]
        public long id { get; set; }

        public string subject { get; set; }

        public TICKET_TYPE ticket_type { get; set; }

        public virtual StaffAccount requester { get; set; }

        public virtual Project project { get; set; }

        public virtual List<FileUploadInfo> files { get; set; }

        public string ticketNumber { get; set; }

        [Column(TypeName = "text")]
        public string details { get; set; }

        public virtual List<TicketComment> comments { get; set; }

        public virtual List<TicketAssignment> ticketToStaff { get; set; }

        public virtual List<Image> images { get; set; }

        public string completionNote { get; set; }

        public TICKET_STATUS status { get; set; }

        public DateTime deliveryDate { get; set; }

        public DateTime creationDate { get; set; }

        public DateTime lastUpDate { get; set; }

        public bool checkTicketToStaff(long staffId)
        {
            if(this.ticketToStaff == null || this.ticketToStaff.Count < 0)
            {
                return false;
            }
            List<StaffAccount> staffs = this.ticketToStaff.Where(o => o.assignTo.id == staffId).Select(e => e.assignTo).ToList();

            return (staffs != null && staffs.Count > 0);
        }
    }
}