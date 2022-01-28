using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using XenDevWeb.Utils;

namespace XenDevWeb.WebServices
{
    /// <summary>
    /// Summary description for GetImage
    /// </summary>
    public class GetImage : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string imgFileName = context.Request.QueryString["imgFileName"];
            string imageType = context.Request.QueryString["imageType"];
            if (Utils.ValidationUtil.isEmpty(imgFileName)  ||
                Utils.ValidationUtil.isEmpty(imageType) )
            {
                return;
            }

            string fullPathFileName = "";
            if (Constants.TYPE_USER_IMAGE.CompareTo(imageType) == 0)
            {
                fullPathFileName = Constants.USERACCOUNT_IMG_FOLDER + "\\" + imgFileName;
            }
            else if(Constants.TYPE_MEETING_NOTE_IMAGE.CompareTo(imageType) == 0)
            {
                fullPathFileName = Constants.MEETINGNOTE_IMG_FOLDER + "\\" + imgFileName;
            }
            else if (Constants.TYPE_APPLICATION_CHANGE_IMAGE.CompareTo(imageType) == 0)
            {
                fullPathFileName = Constants.APPLICATION_CHANGE_IMG_FOLDER + "\\" + imgFileName;
            }
            else if (Constants.TYPE_PROJECT_IMAGE.CompareTo(imageType) == 0)
            {
                fullPathFileName = Constants.PROJECT_IMG_FOLDER + "\\" + imgFileName;
            }
            else if(Constants.TYPE_EMPTY_IMAGE.CompareTo(imageType) == 0)
            {
                fullPathFileName = context.Request.PhysicalApplicationPath + "\\include\\img\\" + imgFileName;
            }
            else if (Constants.TYPE_TICKET_TYPE_INTERNAL_IMAGE.CompareTo(imageType) == 0)
            {
                fullPathFileName = Constants.TICKET_TYPE_INTERNAL_IMG_FOLDER + "\\" + imgFileName;
            }
            else if (Constants.TYPE_TICKET_TYPE_CLIENT_IMAGE.CompareTo(imageType) == 0)
            {
                fullPathFileName = Constants.TICKET_TYPE_CLIENT_IMG_FOLDER + "\\" + imgFileName;
            }
            else if (Constants.TYPE_COMMENT_IMAGE.CompareTo(imageType) == 0)
            {
                fullPathFileName = Constants.COMMENT_IMG_FOLDER + "\\" + imgFileName;
            }

            context.Response.Clear();
            context.Response.ContentType = "image/pjpeg";
            context.Response.TransmitFile(fullPathFileName);
            context.Response.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}