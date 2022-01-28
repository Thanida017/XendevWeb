using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.dao;
using XenDevWeb.domain;
using XenDevWeb.Utils;
using XenDevWeb.view;

namespace XenDevWeb.Test
{
    public partial class test_meeting_note_report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                long mnID = 5;
                XenDevWebDbContext ctx = new XenDevWebDbContext();
                MeetingNoteDAO mtnDAO = new MeetingNoteDAO(ctx);

                MeetingNote mn = mtnDAO.findById(mnID, true);

                DataTable meetingNote = new DataTable();
                meetingNote.Columns.Add("logo", typeof(byte[]));
                meetingNote.Columns.Add("projectName", typeof(string));
                meetingNote.Columns.Add("meetingDateTime", typeof(DateTime));
                meetingNote.Columns.Add("text", typeof(string));

                string path = "C:\\XenDevWeb\\Imags\\logo.png";

                FileStream fs = new FileStream(path, System.IO.FileMode.Open, System.IO.FileAccess.Read);
                byte[] imgLogoCompany = new byte[fs.Length];
                fs.Read(imgLogoCompany, 0, Convert.ToInt32(fs.Length));
                fs.Close();

                meetingNote.Rows.Add(imgLogoCompany, mn.project.name, mn.meetingDateTime, mn.text);

                DataTable imageMeetingNote = new DataTable();
                imageMeetingNote.Columns.Add("image", typeof(byte[]));
                imageMeetingNote.Columns.Add("description", typeof(string));

                if (mn.images != null && mn.images.Count > 0)
                {
                    //Loop แรก แปลงข้อมูล
                    foreach (domain.Image image in mn.images)
                    {
                        var bitmap = new Bitmap(Constants.MEETINGNOTE_IMG_FOLDER + "\\" + image.serverImageFileName);
                        bitmap = WebUtils.ResizeImage(bitmap, new Size(1920, 1080));

                        using (MemoryStream memoryStream = new MemoryStream())
                        {
                            bitmap.Save(memoryStream, ImageFormat.Bmp);
                            byte[] byts = memoryStream.ToArray();

                            image.dataBytes = new byte[byts.Length];
                            Array.Copy(byts, image.dataBytes, byts.Length);
                        }
                        bitmap.Dispose();
                    }

                    //Loop สอง ส่งเข้า CrystalReport
                    foreach (domain.Image image in mn.images)
                    {
                        imageMeetingNote.Rows.Add(image.dataBytes, image.description);
                    }
                }

                MeetingNoteReport meetingNoteReport = new MeetingNoteReport();
                meetingNoteReport.Database.Tables["MeetingNote"].SetDataSource(meetingNote);
                meetingNoteReport.Database.Tables["ImageView"].SetDataSource(imageMeetingNote);

                string reportFileName = "MeetingNote_" + DateTime.Now.ToString("yyyyMMdd_hhmm") + ".pdf";

                ReportUtil.sendReportToClient(meetingNoteReport, Response, reportFileName, true, CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

            }
            catch (Exception exp)
            {
                string s = exp.ToString();
            }
        }
    }
}