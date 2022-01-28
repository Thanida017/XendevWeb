using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.api.param
{
    public class MeetingNoteResponse
    {
        public bool success { get; set; }        
        public List<MeetingNoteView> meetingNoteViews { get; set; }
    }
}