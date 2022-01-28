using HtmlAgilityPack;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using XenDevWeb.dao;
using XenDevWeb.domain;
using XenDevWeb.include;
using XenDevWeb.Utils;

namespace XenDevWeb.secure
{
    public partial class F027_TicketComments : CRUDPageControler
    {
        private TicketDAO tkDAO;
        private ImageDAO imgDAO;
        private TicketAssignmentDAO tkAssignDAO;
        private TicketCommentDAO tkCommentDAO;

        public List<string> errorMessagesForUpload;
        public List<string> infoMessagesForUpload;
        public List<string> errorMessagesForAddComment;
        public List<string> infoMessagesForAddComment;
        public List<string> errorMessagesForAddTicketComplete;
        public List<string> infoMessagesForAddTicketComplete;

        public int ctn = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            tkDAO = new TicketDAO(ctx);
            imgDAO = new ImageDAO(ctx);
            tkAssignDAO = new TicketAssignmentDAO(ctx);
            tkCommentDAO = new TicketCommentDAO(ctx);

            errorMessagesForUpload = new List<string>();
            infoMessagesForUpload = new List<string>();
            errorMessagesForAddComment = new List<string>();
            infoMessagesForAddComment = new List<string>();
            errorMessagesForAddTicketComplete = new List<string>();
            infoMessagesForAddTicketComplete = new List<string>();

            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            if (ValidationUtil.isEmpty(Request.QueryString["ticketId"]))
            {
                Response.Redirect("~/staff/F021.StaffTicket.aspx", true);
                return;
            }

            if (Session[Constants.SESSION_ADD_IMAGE_UPLOAD] != null)
            {
                Session.Remove(Constants.SESSION_ADD_IMAGE_UPLOAD);
            }

            this.hndTicketId.Value = QueryStringModule.Decrypt(HttpUtility.UrlDecode(Request.QueryString["ticketId"]));

            this.initForm();
        }

        private void initForm()
        {
            bindTicket();
            bindComment();

            Ticket tk = this.tkDAO.findByStaffTicketTypeInternalId(long.Parse(this.hndTicketId.Value), false);
            this.tkCompletion.Visible = false;
            if (this.currentStaff.isAdmin && tk.status == TICKET_STATUS.SOLVED)
            {
                this.tkCompletion.Visible = true;
                populateStatus(selStatus);
                bindTicketCompletion();
            }
            
        }

        public void bindTicketCompletion()
        {
            Ticket tk = this.tkDAO.findByStaffTicketTypeInternalId(long.Parse(this.hndTicketId.Value), false);
            switch (selStatus.SelectedIndex)
            {
                case 0:
                    tk.status = TICKET_STATUS.SOLVED;
                    break;
                case 1:
                    tk.status = TICKET_STATUS.CLOSED;
                    break;
                case 2:
                    tk.status = TICKET_STATUS.CANCEL;
                    break;
                case 3:
                    tk.status = TICKET_STATUS.CLOSE_WITH_BUG;
                    break;
                case 4:
                    tk.status = TICKET_STATUS.CLOSE_WITH_OFF_SPEC;
                    break;
            }
            txtNote.Text = tk.completionNote;
        }

        private void populateStatus(DropDownList sel)
        {
            sel.Items.Clear();

            string solved = HttpContext.GetLocalResourceObject("~/secure/F027.TicketComments.aspx", "SOLVED", culture).ToString();
            sel.Items.Add(new ListItem(solved, "0"));

            string close = HttpContext.GetLocalResourceObject("~/secure/F027.TicketComments.aspx", "CLOSED", culture).ToString();
            sel.Items.Add(new ListItem(close, "1"));

            string cancel = HttpContext.GetLocalResourceObject("~/secure/F027.TicketComments.aspx", "CANCEL", culture).ToString();
            sel.Items.Add(new ListItem(cancel, "2"));

            string close_with_bug = HttpContext.GetLocalResourceObject("~/secure/F027.TicketComments.aspx", "CLOSE_WITH_BUG", culture).ToString();
            sel.Items.Add(new ListItem(close_with_bug, "3"));

            string close_with_off_spec = HttpContext.GetLocalResourceObject("~/secure/F027.TicketComments.aspx", "CLOSE_WITH_OFF_SPEC", culture).ToString();
            sel.Items.Add(new ListItem(close_with_off_spec, "4"));
        }

        public void bindTicket()
        {
            Ticket tk = this.tkDAO.findByStaffTicketTypeInternalId(long.Parse(this.hndTicketId.Value), false);
            TicketAssignment tkAssign = this.tkAssignDAO.findByTicketID(long.Parse(this.hndTicketId.Value), false);
            if (tk != null)
            {
                this.lblTicketTitle.Text = string.Format("{0} ({1})", tk.subject,tk.ticketNumber);
                this.detailTextDiv.InnerHtml = tk.details;
                this.lblAssignDate.Text = tkAssign.assignDate.ToString("dd/MM/yyyy", culture);
                this.lblDeliveryDate.Text = tk.deliveryDate.ToString("dd/MM/yyyy", culture);
            }
        }

        public void bindComment()
        {
            List<TicketComment> allTkComment = this.tkCommentDAO.getAllTicketCommentsByTicketId(long.Parse(this.hndTicketId.Value),false);

            ctn = 1;
            commentRepeater.DataSource = allTkComment;
            commentRepeater.DataBind();
        }

        protected void commentRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            TicketComment tkComment = e.Item.DataItem as TicketComment;
            Label lblCommentBy = e.Item.FindControl("lblCommentBy") as Label;
            Label lblCommentByTitle = e.Item.FindControl("lblCommentByTitle") as Label;
            Repeater imageRepeater = e.Item.FindControl("imageRepeater") as Repeater;
            Label lblCommentCreationDate = e.Item.FindControl("lblCommentCreationDate") as Label;
            HtmlGenericControl commentTextDiv = e.Item.FindControl("commentTextDiv") as HtmlGenericControl;

            lblCommentByTitle.Text = string.Format(HttpContext.GetLocalResourceObject("~/secure/F027.TicketComments.aspx",
                                                                                        "commentByTitle",
                                                                                        culture)
                                                                                        .ToString(),
                                                                                        ctn.ToString());
            lblCommentBy.Text = tkComment.by.username;
            commentTextDiv.InnerHtml = tkComment.commentText;

            lblCommentCreationDate.Text = tkComment.creationDate.ToString("dd/MM/yyyy HH:mm", culture);

            List<domain.Image> allCommentImg = this.imgDAO.getAllCommentById(tkComment.id, false);
            imageRepeater.DataSource = allCommentImg;
            imageRepeater.DataBind();
            ctn++;
        }

        protected void imageRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            domain.Image imgComment = e.Item.DataItem as domain.Image;
            Label lblDescriptionComment = e.Item.FindControl("lblDescriptionComment") as Label;
            System.Web.UI.WebControls.Image images = e.Item.FindControl("images") as System.Web.UI.WebControls.Image;

            lblDescriptionComment.Text = imgComment.description.ToString();
            images.ImageUrl = string.Format(Constants.URL_API_GETIMAGE, WebUtils.getAppServerPath(), imgComment.serverImageFileName, Constants.TYPE_COMMENT_IMAGE);
        }

        private void addImageUpload(domain.Image img)
        {
            List<domain.Image> itms;
            if (Session[Constants.SESSION_ADD_IMAGE_UPLOAD] == null)
            {
                itms = new List<domain.Image>();
                Session[Constants.SESSION_ADD_IMAGE_UPLOAD] = itms;
            }
            itms = Session[Constants.SESSION_ADD_IMAGE_UPLOAD] as List<domain.Image>;
            itms.Add(img);
        }

        private List<domain.Image> getImageUploadCache()
        {
            List<domain.Image> imgs = Session[Constants.SESSION_ADD_IMAGE_UPLOAD] as List<domain.Image>;
            return imgs;
        }

        protected void lnkUpload_ServerClick(object sender, EventArgs e)
        {
            HttpPostedFile file = Request.Files["myFile"];
            if (file == null)
            {
                this.errorMessagesForUpload.Add(HttpContext.GetLocalResourceObject("~/secure/F027.TicketComments.aspx",
                                                                                   "pls_upload_image",
                                                                                    culture).ToString());
                return;
            }
            else if (!file.FileName.ToLower().EndsWith(".jpg"))
            {
                this.errorMessagesForUpload.Add(HttpContext.GetLocalResourceObject("~/secure/F027.TicketComments.aspx",
                                                                                   "only_jpeg",
                                                                                    culture).ToString());
                return;
            }

            string fileName = string.Format("{0}.jpg", Guid.NewGuid());
            string fullPath = string.Format("{0}\\{1}", Constants.COMMENT_IMG_FOLDER
                                                      , fileName);

            WebUtils.writeImageToImageDisk(file, fullPath);

            domain.Image img = new domain.Image();
            img.originalImageFileName = file.FileName;
            img.serverImageFileName = fileName;
            img.lastUpDate = DateTime.Now;
            img.creationDate = DateTime.Now;
            img.description = txtDescription.Text;
            addImageUpload(img);

            txtDescription.Text = string.Empty;
            bindimageReplyRepeater();

        }

        private void bindimageReplyRepeater()
        {
            List<domain.Image> imgs = getImageUploadCache();

            imageReplyRepeater.DataSource = imgs;
            imageReplyRepeater.DataBind();
        }

        protected void imageReplyRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            domain.Image image = e.Item.DataItem as domain.Image;

            Label lblDescriptionReply = e.Item.FindControl("lblDescriptionReply") as Label;
            lblDescriptionReply.Text = image.description.ToString();

            System.Web.UI.WebControls.Image imagesReply = e.Item.FindControl("imagesReply") as System.Web.UI.WebControls.Image;
            imagesReply.ImageUrl = string.Format(Constants.URL_API_GETIMAGE, WebUtils.getAppServerPath(), image.serverImageFileName, Constants.TYPE_COMMENT_IMAGE);
        }
        
        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            string serverImageFileName = e.CommandArgument.ToString();
            List<domain.Image> imgs = Session[Constants.SESSION_ADD_IMAGE_UPLOAD] as List<domain.Image>;
            List<domain.Image> imgDeleteCaches = getImageUploadCache();
            domain.Image img = imgDeleteCaches.Where(o => o.serverImageFileName.CompareTo(serverImageFileName) == 0).FirstOrDefault();
            string fullPath = string.Format("{0}\\{1}", Constants.COMMENT_IMG_FOLDER
                                                      , img.serverImageFileName);
            string[] files = Directory.GetFiles(Constants.COMMENT_IMG_FOLDER + "\\");
            foreach (string file in files)
            {
                if (file.CompareTo(fullPath) == 0)
                {
                    File.Delete(file);
                }
            }
            imgs.Remove(img);
            Session[Constants.SESSION_ADD_IMAGE_UPLOAD] = imgs;

            bindimageReplyRepeater();
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            List<domain.Image> imgs = getImageUploadCache();
            if (imgs != null)
            {
                foreach (domain.Image img in imgs)
                {
                    domain.Image findImg = this.imgDAO.findByServerImageFileName(img.serverImageFileName, false);
                    if (findImg == null)
                    {
                        string fullPath = string.Format("{0}\\{1}", Constants.COMMENT_IMG_FOLDER
                                                          , img.serverImageFileName);
                        string[] files = Directory.GetFiles(Constants.COMMENT_IMG_FOLDER + "\\");
                        foreach (string file in files)
                        {
                            if (file.CompareTo(fullPath) == 0)
                            {
                                File.Delete(file);
                            }
                        }
                    }
                }
            }
            Response.Redirect(WebUtils.getAppServerPath() + "/staff/F021.StaffTicket.aspx", true);
            return;
        }

        protected void btnAddComment_Click(object sender, EventArgs e)
        {
            Page.Validate("vsAddReplyCommentGroup");
            if (!Page.IsValid)
            {
                return;
            }

            Ticket ticket = this.tkDAO.findByStaffTicketTypeInternalId(long.Parse(this.hndTicketId.Value), true);

            StaffAccount sa = this.saDAO.findById(this.currentStaff.id, true);
            
            TicketComment tkComment = new TicketComment();
            tkComment.commentText = WebUtils.getFieldIfNotNull(this.txtReplyComment.Text);
            tkComment.by = sa;
            tkComment.creationDate = DateTime.Now;
            tkComment.ticket = ticket;
            tkComment.images = new List<domain.Image>();

            List<domain.Image> imgs = getImageUploadCache();
            if (imgs != null)
            {
                foreach (domain.Image img in imgs)
                {
                    tkComment.images.Add(img);
                }
            }

            tkCommentDAO.create(tkComment);
            
            if (Session[Constants.SESSION_ADD_IMAGE_UPLOAD] != null)
            {
                Session.Remove(Constants.SESSION_ADD_IMAGE_UPLOAD);
            }
            
            bindTicket();
            bindComment();
            bindimageReplyRepeater();

            //Clear form
            WebUtils.ClearControls(this);

            //Refresh GUI
            this.initForm();

            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);

            this.infoMessagesForAddComment.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                              "successfully_savedRc",
                                                                               culture).ToString());
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Ticket tk = this.tkDAO.findByStaffTicketTypeInternalId(long.Parse(this.hndTicketId.Value) , true);
            switch (this.selStatus.SelectedIndex)
            {
                case 0:
                    tk.status = TICKET_STATUS.SOLVED;
                    break;
                case 1:
                    tk.status = TICKET_STATUS.CLOSED;
                    break;
                case 2:
                    tk.status = TICKET_STATUS.CANCEL;
                    break;
                case 3:
                    tk.status = TICKET_STATUS.CLOSE_WITH_BUG;
                    break;
                case 4:
                    tk.status = TICKET_STATUS.CLOSE_WITH_OFF_SPEC;
                    break;
            }

            tk.completionNote = txtNote.Text;
            tk.lastUpDate = DateTime.Now;
            this.tkDAO.update(tk);

            //Clear form
            WebUtils.ClearControls(this);
            initForm();
            this.infoMessagesForAddTicketComplete.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                              "successfully_savedRc",
                                                                               culture).ToString());
        }
    }
}