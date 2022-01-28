using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.dao;
using XenDevWeb.domain;
using XenDevWeb.Utils;
using XenDevWeb.view;

namespace XenDevWeb.secure
{
    public partial class Meeing_note_download : System.Web.UI.Page
    {
        private XenDevWebDbContext ctx;
        private MeetingNoteDAO mtnDAO;
        private ProjectDAO pjDAO;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (ValidationUtil.isEmpty(Request.QueryString["mtnId"]))
            {
                Response.Redirect("F005.MeetingNote.aspx", true);
                return;
            }

            this.hndMeetingNoteId.Value = Request.QueryString["mtnId"];

            try
            {
                long mnID = long.Parse(this.hndMeetingNoteId.Value);
                ctx = new XenDevWebDbContext();
                mtnDAO = new MeetingNoteDAO(ctx);
                pjDAO = new ProjectDAO(ctx);

                MeetingNote mn = mtnDAO.findById(mnID, false);

                DataTable meetingNote = new DataTable();
                meetingNote.Columns.Add("logo", typeof(byte[]));
                meetingNote.Columns.Add("projectName", typeof(string));
                meetingNote.Columns.Add("meetingDateTime", typeof(DateTime));
                meetingNote.Columns.Add("text", typeof(string));
                meetingNote.Columns.Add("meetingTitle", typeof(string));
                meetingNote.Columns.Add("round", typeof(string));
                meetingNote.Columns.Add("createdBy", typeof(string));
                meetingNote.Columns.Add("attendNames", typeof(string));
                meetingNote.Columns.Add("ccTo", typeof(string));

                string path = "C:\\XenDevWeb\\ImagsUser\\logo.png";

                FileStream fs = new FileStream(path, System.IO.FileMode.Open, System.IO.FileAccess.Read);
                byte[] imgLogoCompany = new byte[fs.Length];
                fs.Read(imgLogoCompany, 0, Convert.ToInt32(fs.Length));
                fs.Close();

                string meetingTitle = mn.meetingTitle;
                Project proj = pjDAO.findByProjectId(mn.project.id, false);
                string round = string.Format("{0} ({1})", proj.getNewMeetingRound(), mn.meetingDateTime.ToString("dd MMMM yyyy", new CultureInfo("th-TH")));
                string createdBy = mn.createdBy != null ? string.Format("{0} {1}", mn.createdBy.firstName, mn.createdBy.lastName) : "";
                string attendNames = mn.attendNames.Replace("คุณ", "");
                attendNames = attendNames.Replace(",", ", คุณ");
                attendNames = string.Format("คุณ{0} ", attendNames);
                string ccTo = mn.ccTo.Replace("คุณ", "");
                ccTo = ccTo.Replace(",", ", คุณ");
                ccTo = string.Format("คุณ{0} ", ccTo);

                meetingNote.Rows.Add(imgLogoCompany, mn.project.name, mn.meetingDateTime, mn.text, meetingTitle, round, createdBy, attendNames, ccTo);

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

                MeetingNoteReport_2 meetingNoteReport = new MeetingNoteReport_2();
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