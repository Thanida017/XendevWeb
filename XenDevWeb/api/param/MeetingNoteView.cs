using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.api.param
{
    public class MeetingNoteView
    {
        public string text { get; set; }
        public string meetingDateTime { get; set; }
        public string textMeetingDateTime { get; set; }
        public string meetingColor { get; set; }
        public string lastUpdate { get; set; }
        public List<MeetingNoteImageView> meetingNoteImageViews { get; set; }
    }
}