using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;
namespace XenDevWeb.domain
{
    [Serializable]
    public class Image
    {
        [Key]
        public long id { get; set; }

        //ชื่อไฟล์รูปที่เก็บบน server
        public string serverImageFileName { get; set; }

        //ชื่อรูปเดิมที่ใส่มาตอนทำ upload
        public string originalImageFileName { get; set; }

        public string description { get; set; }

        public virtual MeetingNote meetingNote { get; set; }

        public virtual ApplicationChangeTrx appChangeTrx { get; set; }

        public virtual Ticket ticket { get; set; }

        public virtual TicketComment ticketComment { get; set; }

        public DateTime creationDate { get; set; }

        public DateTime lastUpDate { get; set; }

        [NotMapped]
        public byte[] dataBytes { get; set; }
    }
}