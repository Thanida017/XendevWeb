using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.Utils
{
    public class Constants
    {
        public const string DEFAULT_ROW_PER_PAGE = "15";

        public const string LANGUAGE_TH = "th-TH";
        public const string LANGUAGE_EN = "en-US";

        public const string COMPANY_HEAD_QUATER_CODE = "00000";
        public const string COMPANY_HEAD_QUATER_NAME = "สำนักงานใหญ่";
        public const string COMPANY_HEAD_QUATER_NAME_ENGLISH = "Head office";

        public const string MEETINGNOTE_IMG_FOLDER = "c:\\XenDevWeb\\imgMeetingNote";
        public const string UPLOAD_FOLDER = "c:\\XenDevWeb\\FileUpload";
        public const string USERACCOUNT_IMG_FOLDER = "c:\\XenDevWeb\\imgUser";
        public const string PROJECT_IMG_FOLDER = "c:\\XenDevWeb\\imgProject";
        public const string APPLICATION_CHANGE_IMG_FOLDER = "c:\\XenDevWeb\\imgApplicationChange";
        public const string TICKET_TYPE_INTERNAL_IMG_FOLDER = "c:\\XenDevWeb\\imgTicketTypeInternal";
        public const string TICKET_TYPE_CLIENT_IMG_FOLDER = "c:\\XenDevWeb\\imgTicketTypeClient";
        public const string COMMENT_IMG_FOLDER = "c:\\XenDevWeb\\imgComment";

        //F019
        public const string SESSION_ADD_IMAGE_UPLOAD = "SESSION_ADD_IMAGE_UPLOAD";

        //F032
        public const string SESSION_ADD_REPORT_CACHE = "SESSION_ADD_REPORT_CACHE";
        public const string SESSION_ADD_LANGUAGE = "SESSION_ADD_LANGUAGE";

        public const string TYPE_USER_IMAGE = "TYPE_USER_IMAGE";
        public const string TYPE_MEETING_NOTE_IMAGE = "TYPE_MEETING_NOTE_IMAGE";
        public const string TYPE_APPLICATION_CHANGE_IMAGE = "TYPE_APPLICATION_CHANGE_IMAGE";
        public const string TYPE_PROJECT_IMAGE = "TYPE_PROJECT_IMAGE";
        public const string TYPE_EMPTY_IMAGE = "TYPE_EMPTY_IMAGE";
        public const string TYPE_TICKET_TYPE_INTERNAL_IMAGE = "TYPE_TICKET_INTERNAL_IMAGE";
        public const string TYPE_COMMENT_IMAGE = "TYPE_COMMENT_IMAGE";
        public const string TYPE_TICKET_TYPE_CLIENT_IMAGE = "TYPE_TICKET_CLIENT_IMAGE";

        public const int MAX_MEMBER_IMAGE_WIDTH = 200;
        public const int MAX_MEMBER_IMAGE_HEIGHT = 200;

        public const int MAX_USER_IMAGE_WIDTH = 320;
        public const int MAX_USER_IMAGE_HEIGHT = 320;

        public const int MAX_AVATAR_USER_IMAGE_WIDTH = 25;
        public const int MAX_AVATAR_USER_IMAGE_HEIGHT = 25;

        public const string URL_API_GETIMAGE = "{0}WebServices/GetImage.ashx?imgFileName={1}&imageType={2}";

        public const string REQUIREMENT_JSON_FOLDER = "c:\\XenDevWeb\\RequirementJson";

        public const int DEFAULT_GRID_PAGE_SIZE = 5;


    }
}