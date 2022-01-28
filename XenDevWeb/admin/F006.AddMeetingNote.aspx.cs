using System;
using System.Collections.Generic;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.dao;
using XenDevWeb.domain;
using XenDevWeb.include;
using XenDevWeb.Utils;

namespace XenDevWeb.admin
{
    public partial class F006_AddMeetingNote : CRUDPageControler
    {
        private MeetingNoteDAO mtnDAO;
        private ImageDAO imgDAO;

        private MeetingNote meetingNote;
        public List<string> errorMessagesForUpload;
        public List<string> infoMessagesForUpload;
        public List<string> errorMessagesForRepeater;
        public List<string> infoMessagesForRepeater;

        protected void Page_Load(object sender, EventArgs e)
        {
            mtnDAO = new MeetingNoteDAO(this.ctx);
            imgDAO = new ImageDAO(ctx);

            culture = CultureInfo.CreateSpecificCulture(Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName);

            errorMessages = new List<string>();
            infoMessages = new List<string>();
            errorMessagesForUpload = new List<string>();
            infoMessagesForUpload = new List<string>();
            errorMessagesForRepeater = new List<string>();
            infoMessagesForRepeater = new List<string>();

            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            if (ValidationUtil.isEmpty(Request.QueryString["mtnId"]))
            {
                Response.Redirect("F005.MeetingNote.aspx", true);
                return;
            }

            this.hndMeetingNoteId.Value = QueryStringModule.Decrypt(HttpUtility.UrlDecode(Request.QueryString["mtnId"]));

            initForm();
        }

        private void initForm()
        {
            TimeSpan meetingTime = new TimeSpan(00, 00, 00);
            this.txtMeetingTime.Text = meetingTime.ToString("hh\\:mm\\:ss");
            this.txtMeetingDate.Text = String.Format("{0:d/MM/yyyy}", DateTime.Now);
            this.txtMeetingDate.Attributes.Add("readonly", "readonly");

            meetingNote = mtnDAO.findById(long.Parse(this.hndMeetingNoteId.Value), false);

            this.lblAddMeetingNotes.Text = string.Format("Project {0}", meetingNote.project.name);
            this.txtTopic.Text = meetingNote.meetingTitle;
            this.txtAttendNames.Value = meetingNote.attendNames;
            this.txtCCTO.Value = meetingNote.ccTo;

            this.txtWYSIWYG.Text = meetingNote.text;
            bindImage();

        }

        public void bindImage()
        {
            meetingNote = mtnDAO.findById(long.Parse(this.hndMeetingNoteId.Value), false);
            List<domain.Image> imgs = meetingNote.images;
            imageRepeater.DataSource = imgs;
            imageRepeater.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Page.Validate("vsAddMeetingGroup");
            if (!Page.IsValid)
            {
                return;
            }

            var n = this.txtAttendNames.Value;

            MeetingNote mtn = mtnDAO.findById(long.Parse(this.hndMeetingNoteId.Value), true);
            mtn.text = WebUtils.getFieldIfNotNull(this.txtWYSIWYG.Text);
            DateTime meetingDateTime = DateTime.ParseExact(this.txtMeetingDate.Text, "d/MM/yyyy", Thread.CurrentThread.CurrentUICulture);
            int hours = int.Parse(txtMeetingTime.Text.Substring(0, 2));
            int minutes = int.Parse(txtMeetingTime.Text.Substring(3, 2));

            meetingDateTime.AddHours(hours);
            meetingDateTime.AddMinutes(minutes);

            mtn.meetingDateTime = meetingDateTime;
            mtn.attendNames = txtAttendNames.Value;
            mtn.meetingTitle = txtTopic.Text;
            mtn.ccTo = txtCCTO.Value;
            mtn.lastUpdate = DateTime.Now;
            mtnDAO.update(mtn);

            this.infoMessages.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                  "successfully_savedRc",
                                                                  culture).ToString());

        }

        protected void lnkUpload_ServerClick(object sender, EventArgs e)
        {
            HttpPostedFile file = Request.Files["myFile"];
            if (file == null)
            {
                this.errorMessages.Add(HttpContext.GetLocalResourceObject("~/secure/F006.AddMeetingNote.aspx",
                                                                                   "pls_upload_image",
                                                                                    culture).ToString());
                return;
            }
            else if (!file.FileName.ToLower().EndsWith(".jpg"))
            {
                this.errorMessages.Add(HttpContext.GetLocalResourceObject("~/secure/F006.AddMeetingNote.aspx",
                                                                                   "only_jpeg",
                                                                                    culture).ToString());
                return;
            }

            Bitmap bmp = new Bitmap(file.InputStream);

            if (bmp.Width > Constants.MAX_MEMBER_IMAGE_WIDTH || bmp.Height > Constants.MAX_MEMBER_IMAGE_HEIGHT)
            {
                bmp = WebUtils.ResizeImage(bmp, new Size(Constants.MAX_MEMBER_IMAGE_WIDTH,
                Constants.MAX_MEMBER_IMAGE_WIDTH));
            }

            string fileName = string.Format("{0}.jpg", Guid.NewGuid());
            string fullPath = string.Format("{0}\\{1}", Constants.MEETINGNOTE_IMG_FOLDER
                                                      , fileName);
            bmp.Save(fullPath);

            MeetingNote mtn = this.mtnDAO.findById(long.Parse(this.hndMeetingNoteId.Value), true);

            domain.Image img = new domain.Image();
            img.originalImageFileName = file.FileName;
            img.serverImageFileName = fileName;
            img.lastUpDate = DateTime.Now;
            img.creationDate = DateTime.Now;
            img.description = txtDescription.Text;
            img.meetingNote = mtn;
            imgDAO.create(img);

            bmp.Dispose();
            txtDescription.Text = string.Empty;
            bindImage();
            this.pnlImage.Update();

            this.infoMessagesForUpload.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                     "successfully_savedRc",
                                                                     culture).ToString());
        }

        protected void imageRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            domain.Image image = e.Item.DataItem as domain.Image;

            Label lblOverylay = e.Item.FindControl("lblOverylay") as Label;
            Label lblMeetingID = e.Item.FindControl("lblMeetingID") as Label;

            lblMeetingID.Text = image.id.ToString();
            lblOverylay.Text = image.description;

            System.Web.UI.WebControls.Image imageMeeting = e.Item.FindControl("imageMeeting") as System.Web.UI.WebControls.Image;

            imageMeeting.ImageUrl = WebUtils.getImageMeetingBase64(image.serverImageFileName);
        }

        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            long idToDelete = long.Parse(e.CommandArgument.ToString());

            domain.Image imgDelete = imgDAO.findById(idToDelete, true);

            if (!ValidationUtil.isEmpty(imgDelete.serverImageFileName))
            {
                string oldFullPath = string.Format("{0}\\{1}", Constants.MEETINGNOTE_IMG_FOLDER
                                                         , imgDelete.serverImageFileName);
                File.Delete(oldFullPath);
            }

            imgDAO.delete(imgDelete);
            initForm();

            this.pnlImage.Update();

            this.infoMessagesForRepeater.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                                "successfully_deletedRc",
                                                                                culture).ToString());

        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("F005.MeetingNote.aspx", true);
        }
    }
}