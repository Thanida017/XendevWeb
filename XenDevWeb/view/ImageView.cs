using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.view
{
    public class ImageView
    {
        public string serverImageFileName { get; set; }
       
        public string originalImageFileName { get; set; }

        public string description { get; set; }

        public long meetingNote { get; set; }

        public long appChangeTrx { get; set; }

        public long ticket { get; set; }

        public DateTime creationDate { get; set; }

        public DateTime lastUpDate { get; set; }
    }
}