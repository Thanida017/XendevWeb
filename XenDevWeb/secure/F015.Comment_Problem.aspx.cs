using System;
using System.Collections.Generic;
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

namespace XenDevWeb.secure
{
    public partial class F015_Comment_Problem : CRUDPageControler
    {
        public List<string> errorMessagesForUpload { get; set; }
        public List<string> infoMessagesForUpload { get; set; }

        private ProjectDAO projectDAO;
        private TicketDAO problemDAO;
        private FileUploadInfoDAO fiDAO;
        private TicketCommentDAO tiCommentDAO;
        private EmailServerDAO emailServerDAO;

        private List<FileUploadInfo> fileInfos;
        private List<TicketComment> allTickeComments;
        
        protected bool hasComment;
        protected void Page_Load(object sender, EventArgs e)
        {
            culture = CultureInfo.CreateSpecificCulture(Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName);

            projectDAO = new ProjectDAO(ctx);
            problemDAO = new TicketDAO(ctx);
            fiDAO = new FileUploadInfoDAO(ctx);
            tiCommentDAO = new TicketCommentDAO(ctx);
            emailServerDAO = new EmailServerDAO(ctx);

            infoMessagesForGrid = new List<string>();
            errorMessagesForGrid = new List<string>();
            errorMessagesForUpload = new List<string>();
            infoMessagesForUpload = new List<string>();
            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            if (ValidationUtil.isEmpty(Request.QueryString["problemId"]))
            {
                Response.Redirect("F014.Problem.aspx", true);
                return;
            }

            this.hndProblemId.Value = QueryStringModule.Decrypt(HttpUtility.UrlDecode(Request.QueryString["problemId"]));
            initForm();
        }

        public void initForm()
        {
            Ticket tk = this.problemDAO.findById(long.Parse(this.hndProblemId.Value), false);

            this.lblProblemDetail.Text = tk.details;
            this.txtProjectCode.Text = tk.project.code;
            this.txtSubject.Text = tk.project.name;
            this.txtRequester.Text = tk.requester.username;

            this.lblProblemDetail.Attributes.Add("readonly", "readonly");
            this.txtProjectCode.Attributes.Add("readonly", "readonly");
            this.txtRequester.Attributes.Add("readonly", "readonly");
            this.txtSubject.Attributes.Add("readonly", "readonly");

            this.lblProblemDetail.BackColor = System.Drawing.Color.FromArgb(211, 216, 220);
            this.txtProjectCode.BackColor = System.Drawing.Color.FromArgb(211, 216, 220);
            this.txtRequester.BackColor = System.Drawing.Color.FromArgb(211, 216, 220);
            this.txtSubject.BackColor = System.Drawing.Color.FromArgb(211, 216, 220);
            
            this.lblTicketNumber.Text = string.Format(HttpContext.GetLocalResourceObject("~/secure/F015.Comment_Problem.aspx",
                                                                                "ticketNumber", culture)
                                                                                .ToString(), tk.ticketNumber);

            switch (tk.status)
            {
                case TICKET_STATUS.NEW:
                case TICKET_STATUS.ON_REVIEW:
                case TICKET_STATUS.ASSIGNED:
                    this.hasComment = true;
                    break;
                case TICKET_STATUS.CANCEL:
                case TICKET_STATUS.CLOSED:
                case TICKET_STATUS.SOLVED:
                    this.hasComment = false;
                    this.pnlComment.Visible = false;
                    break;
            }

            //populateStatus(selStatus);

            bindUploadGridView();
            bindTicketComment();

        }

        public void populateStatus(DropDownList sel)
        {
            sel.Items.Clear();

            ListItem liNew = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F015.Comment_Problem.aspx",
                                                                             "New", culture).ToString()
                                                                             , TICKET_STATUS.NEW.ToString());
            sel.Items.Add(liNew);
            ListItem liAssigned = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F015.Comment_Problem.aspx",
                                                                             "Assigned", culture).ToString()
                                                                             , TICKET_STATUS.ASSIGNED.ToString());
            sel.Items.Add(liAssigned);
            ListItem liSolved = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F015.Comment_Problem.aspx",
                                                                             "Solved", culture).ToString()
                                                                             , TICKET_STATUS.SOLVED.ToString());
            sel.Items.Add(liSolved);
            ListItem liClosed = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F015.Comment_Problem.aspx",
                                                                             "Closed", culture).ToString()
                                                                             , TICKET_STATUS.CLOSED.ToString());
            sel.Items.Add(liClosed);
            ListItem liCancel = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F015.Comment_Problem.aspx",
                                                                             "Cancel", culture).ToString()
                                                                             , TICKET_STATUS.CANCEL.ToString());
            sel.Items.Add(liCancel);

        }

        public void bindProblemDetail()
        {
            Ticket tk = this.problemDAO.findById(long.Parse(this.hndProblemId.Value), true);
            if (tk != null)
            {
                this.txtProjectCode.Text = string.Format("{0}({1})", tk.project.name
                                                                   , tk.project.code);

                this.txtSubject.Text = tk.subject;
                this.txtRequester.Text = tk.requester.username;
                this.lblProblemDetail.Text = tk.details;
            }
        }

        public void bindUploadGridView()
        {
            this.fileInfos = this.fiDAO.getAllFileUploadInfo(false)
                                                            .Where(o => o.problemDetail.id == long.Parse(this.hndProblemId.Value))
                                                            .ToList();
            

            this.uploadDatabaseGridView.DataSource = this.fileInfos;
            this.uploadDatabaseGridView.DataBind();
        }

        public void bindTicketComment()
        {
            this.allTickeComments = this.tiCommentDAO.getAllTicketCommentsByTicketId(long.Parse(this.hndProblemId.Value), false)
                                                                                    .OrderByDescending(o => o.creationDate)
                                                                                    .ToList();

            ticketComment.DataSource = this.allTickeComments;
            this.ticketComment.DataBind();
        }

        protected void btnDelete_document_Command(object sender, CommandEventArgs e)
        {
            long idToDelete = long.Parse(e.CommandArgument.ToString());

            FileUploadInfo fileToDetete = this.fiDAO.findById(idToDelete, true);
            this.fiDAO.delete(fileToDetete);

            initForm();
            this.infoMessagesForUpload.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                           "successfully_savedRc",
                                                                           culture).ToString());
        }

        private void unBlockUI()
        {
            ScriptManager.RegisterStartupScript(this,
            this.GetType(),
             "dismissBlockUI",
             "dismissBlockUI();",
             true);
        }

        private string getEmailApprovalLink(string ticketId)
        {
            return WebUtils.getAppServerPath() + "/secure/F015.Comment_Problem.aspx?problemId=" + ticketId;
        }

        protected void btnAddComment_Click(object sender, EventArgs e)
        {
            if (!ValidationUtil.isEmpty(this.hndProblemId.Value))
            {
                Ticket ticket = this.problemDAO.findById(long.Parse(this.hndProblemId.Value), true);
                StaffAccount sa = this.saDAO.findById(this.currentStaff.id, true);

                TicketComment tiComment = new TicketComment();
                tiComment.by = sa;
                tiComment.ticket = ticket;
                tiComment.commentText = this.txtComment.Text;
                tiComment.creationDate = DateTime.Now;
                this.tiCommentDAO.create(tiComment);
                
                this.txtComment.Text = string.Empty;
                this.initForm();

                this.infoMessages.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                           "successfully_savedRc",
                                                                           culture).ToString());
            }
            
            unBlockUI();
        }

        protected void btnGoback_Click(object sender, EventArgs e)
        {
            Response.Redirect("F014.Problem.aspx", true);
        }

        protected void lnkUpload_ServerClick(object sender, EventArgs e)
        {
            Page.Validate("vsUploadGroup");
            if (!Page.IsValid)
            {
                return;
            }
            //Upload file check
            HttpPostedFile file = Request.Files["myFile"];
            if (file == null)
            {
                this.errorMessagesForUpload.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                                "pls_select_file_to_upload",
                                                                                culture)
                                                                                .ToString());
                return;
            }

            //Check file size
            int iFileSize = file.ContentLength;
            if (iFileSize > 10485760)  // 10MB
            {
                this.errorMessagesForUpload.Add(string.Format(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                                "too_large_upload_file",
                                                                                culture)
                                                                                .ToString()
                                                            , 10));
                return;
            }

            //Save file to upload folder
            string serverFileName = this.getServerFileName(file.FileName);
            string diskFileName = Constants.UPLOAD_FOLDER + "\\" + serverFileName;
            if (File.Exists(diskFileName))
            {
                File.Delete(diskFileName);
            }
            using (var fileStream = File.Create(diskFileName))
            {
                file.InputStream.Seek(0, SeekOrigin.Begin);
                file.InputStream.CopyTo(fileStream);
            }                        Ticket problem = this.problemDAO.findById(long.Parse(this.hndProblemId.Value), true);            FileUploadInfo doc = new FileUploadInfo();            doc.problemDetail = problem;            doc.originalFileName = file.FileName;            doc.serverFileName = serverFileName;            doc.creationDate = DateTime.Now;

            this.fiDAO.create(doc);            initForm();

            this.infoMessagesForUpload.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                           "successfully_savedRc",
                                                                           culture).ToString());
        }

        private string getServerFileName(string inputFileName)
        {
            string extention = System.IO.Path.GetExtension(inputFileName);
            string serverFileName = System.Guid.NewGuid() + "_F016" + extention;
            return serverFileName;
        }

        protected void uploadDatabaseGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }

            LinkButton btnDelete_document = e.Row.FindControl("btnDelete_document") as LinkButton;

            btnDelete_document.Visible = this.hasComment;
        }

        protected void uploadDatabaseGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            long id = long.Parse(e.CommandArgument.ToString());
            FileUploadInfo fi = this.fiDAO.findById(id, false);

            Response.Clear();
            Response.ContentType = "application/octet-stream";
            Response.AppendHeader("Content-Disposition", "filename=" + fi.originalFileName);

            string fullPath = Constants.UPLOAD_FOLDER + "\\" + fi.serverFileName;
            Response.TransmitFile(fullPath);
            Response.End();
        }

        protected void ticketComment_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            TicketComment tiComment = e.Item.DataItem as TicketComment;

            Label lblCommentby = e.Item.FindControl("lblCommentby") as Label;
            Label lblCommentText = e.Item.FindControl("lblCommentText") as Label;
            Label lblCreationDate = e.Item.FindControl("lblCreationDate") as Label;

            lblCommentby.Text = tiComment.by.username;
            lblCommentText.Text = tiComment.commentText;
            lblCreationDate.Text = tiComment.creationDate.ToString("dd/MM/yyyy HH:mm", new CultureInfo("en-US"));
        }
    }
}