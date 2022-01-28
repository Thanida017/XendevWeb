using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.dao;
using XenDevWeb.domain;
using XenDevWeb.include;
using XenDevWeb.Utils;

namespace XenDevWeb.staff
{
    public partial class F019_CreateStaffTicket : CRUDPageControler
    {
        private ProjectDAO pjDAO;
        private StaffAccountDAO staffAcDAO;
        private TicketDAO ticketDAO;
        private ImageDAO imgDAO;
        private TicketAssignmentDAO ticketAssignDAO;
        private TicketCommentDAO ticketCommentDAO;

        public List<string> errorMessagesForUpload;
        public List<string> infoMessagesForUpload;
        public List<string> errorMessagesForCreate;
        public List<string> infoMessagesForCreate;

        private List<StaffAccount> allStaffs;

        protected void Page_Load(object sender, EventArgs e)
        {
            pjDAO = new ProjectDAO(ctx);
            staffAcDAO = new StaffAccountDAO(ctx);
            ticketDAO = new TicketDAO(ctx);
            imgDAO = new ImageDAO(ctx);
            ticketAssignDAO = new TicketAssignmentDAO(ctx);
            ticketCommentDAO = new TicketCommentDAO(ctx);

            errorMessagesForUpload = new List<string>();
            infoMessagesForUpload = new List<string>();
            errorMessagesForCreate = new List<string>();
            infoMessagesForCreate = new List<string>();

            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            if (!this.currentStaff.isAdmin)
            {
                Response.Redirect("F021.StaffTicket.aspx", true);
                return;
            }

            if (Session[Constants.SESSION_ADD_IMAGE_UPLOAD] != null)
            {
                Session.Remove(Constants.SESSION_ADD_IMAGE_UPLOAD);
            }

            this.initForm();
        }

        private void initForm()
        {
            this.txtDeliveryDate.Text = DateTime.Now.ToString("d/MM/yyyy", culture);
            this.txtAssignDate.Text = DateTime.Now.ToString("d/MM/yyyy", culture);
            this.txtDeliveryDate.Attributes["readonly"] = "readonly";
            this.txtAssignDate.Attributes["readonly"] = "readonly";

            this.populateProject(this.selProject);
            this.bindSatff();
        }

        public void bindSatff()
        {
            this.allStaffs = this.staffAcDAO.getAllEnableStaffAccount(false);

            //Set grid
            this.assignmentToGridView.DataSource = this.allStaffs;
            this.assignmentToGridView.DataBind();
        }

        private void populateProject(DropDownList sel)
        {
            sel.Items.Clear();

            List<Project> pjs = this.pjDAO.getAllProject(false)
                                                    .OrderBy(o => o.name)
                                                    .ToList();

            foreach (Project pj in pjs)
            {
                ListItem li = new ListItem(string.Format("{0} ({1})", pj.name, pj.code), pj.id.ToString());
                sel.Items.Add(li);
            }
        }

        protected void assignmentToGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.assignmentToGridView.PageIndex = e.NewPageIndex;
            this.bindSatff();
        }

        protected void assignmentToGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }
            if (this.allStaffs == null || e.Row.RowIndex >= this.allStaffs.Count)
            {
                return;
            }

            StaffAccount obj = e.Row.DataItem as StaffAccount;
            CheckBox chkIsSelectedGrid = e.Row.FindControl("chkIsSelectedGrid") as CheckBox;
            Label lblAssignmentToGridView_FirstName = e.Row.FindControl("lblAssignmentToGridView_FirstName") as Label;
            lblAssignmentToGridView_FirstName.Text = obj.firstName.ToString();
            Label lblAssignmentToGridView_LastName = e.Row.FindControl("lblAssignmentToGridView_LastName") as Label;
            lblAssignmentToGridView_LastName.Text = obj.lastName.ToString();
            Label lblAssignmentToGridView_AssignToID = e.Row.FindControl("lblAssignmentToGridView_AssignToID") as Label;
            lblAssignmentToGridView_AssignToID.Text = obj.id.ToString();
            lblAssignmentToGridView_AssignToID.Visible = false;
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
                        string fullPath = string.Format("{0}\\{1}", Constants.TICKET_TYPE_INTERNAL_IMG_FOLDER
                                                          , img.serverImageFileName);
                        string[] files = Directory.GetFiles(Constants.TICKET_TYPE_INTERNAL_IMG_FOLDER + "\\");
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
            Response.Redirect("~/staff/F021.StaffTicket.aspx", true);
            return;
        }

        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            string serverImageFileName = e.CommandArgument.ToString();
            List<domain.Image> imgs = Session[Constants.SESSION_ADD_IMAGE_UPLOAD] as List<domain.Image>;
            List<domain.Image> imgDeleteCaches = getImageUploadCache();
            domain.Image img = imgDeleteCaches.Where(o => o.serverImageFileName.CompareTo(serverImageFileName) == 0).FirstOrDefault();
            string fullPath = string.Format("{0}\\{1}", Constants.TICKET_TYPE_INTERNAL_IMG_FOLDER
                                                      , img.serverImageFileName);
            string[] files = Directory.GetFiles(Constants.TICKET_TYPE_INTERNAL_IMG_FOLDER + "\\");
            string file = files.Where(m => m.CompareTo(fullPath) == 0).FirstOrDefault();
            File.Delete(file);

            List<domain.Image> imgReomveObjs = imgs.Where(n => n.serverImageFileName.CompareTo(img.serverImageFileName) == 0).ToList();
            for (int i = 0; i < imgReomveObjs.Count; i++)
            {
                imgs.Remove(imgReomveObjs[i]);
                Session[Constants.SESSION_ADD_IMAGE_UPLOAD] = imgs;
            }
            bindImageRepeater();
        }

        private void bindImageRepeater()
        {
            List<domain.Image> imgs = getImageUploadCache();

            imageRepeater.DataSource = imgs;
            imageRepeater.DataBind();

        }

        protected void lnkUpload_ServerClick(object sender, EventArgs e)
        {
            HttpPostedFile file = Request.Files["myFile"];
            if (file == null)
            {
                this.errorMessagesForUpload.Add(HttpContext.GetLocalResourceObject("~/staff/F019.CreateStaffTicket.aspx",
                                                                                   "pls_upload_image",
                                                                                    culture).ToString());
                return;
            }
            else if (!file.FileName.ToLower().EndsWith(".jpg"))
            {
                this.errorMessagesForUpload.Add(HttpContext.GetLocalResourceObject("~/staff/F019.CreateStaffTicket.aspx",
                                                                                   "only_jpeg",
                                                                                    culture).ToString());
                return;
            }

            string fileName = string.Format("{0}.jpg", Guid.NewGuid());
            string fullPath = string.Format("{0}\\{1}", Constants.TICKET_TYPE_INTERNAL_IMG_FOLDER
                                                      , fileName);

            WebUtils.writeImageToImageDisk(file , fullPath);

            domain.Image img = new domain.Image();
            img.originalImageFileName = file.FileName;
            img.serverImageFileName = fileName;
            img.lastUpDate = DateTime.Now;
            img.creationDate = DateTime.Now;
            img.description = txtDescription.Text;
            addImageUpload(img);

            txtDescription.Text = string.Empty;
            bindImageRepeater();
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

        protected void imageRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            domain.Image image = e.Item.DataItem as domain.Image;

            Label lblDescription = e.Item.FindControl("lblDescription") as Label;
            lblDescription.Text = image.description.ToString();

            System.Web.UI.WebControls.Image images = e.Item.FindControl("images") as System.Web.UI.WebControls.Image;
            images.ImageUrl = string.Format(Constants.URL_API_GETIMAGE, WebUtils.getAppServerPath(), image.serverImageFileName, Constants.TYPE_TICKET_TYPE_INTERNAL_IMAGE);
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            Page.Validate("vsAddTicketGroup");
            if (!Page.IsValid)
            {
                return;
            }

            Ticket someoneTicketNumber = this.ticketDAO.findByTicketNumberTicketTypeInternal(this.txtTicketNumber.Text, false);
            if (someoneTicketNumber != null)
            {
                string mesg = string.Format(HttpContext.GetLocalResourceObject("~/staff/F019.CreateStaffTicket.aspx",
                                                                                "ticketNumber_in_use",
                                                                                culture)
                                                                                .ToString(),
                                                                                this.txtTicketNumber.Text);
                this.errorMessagesForCreate.Add(mesg);
                return;
            }

            Project project = this.pjDAO.findByProjectId(long.Parse(this.selProject.SelectedValue), true);
            List<TicketAssignment> ticketAssigns = new List<TicketAssignment>();

            DateTime assignDate = DateTime.ParseExact(txtAssignDate.Text,
                                                    "d/MM/yyyy",
                                                     culture);

            for (int i = 0; i < this.assignmentToGridView.Rows.Count; i++)
            {
                GridViewRow itemRow = this.assignmentToGridView.Rows[i];
                CheckBox chkIsSelectedGrid = itemRow.FindControl("chkIsSelectedGrid") as CheckBox;
                Label lblAssignmentToGridView_FirstName = itemRow.FindControl("lblAssignmentToGridView_FirstName") as Label;
                Label lblAssignmentToGridView_LastName = itemRow.FindControl("lblAssignmentToGridView_LastName") as Label;
                Label lblAssignmentToGridView_AssignToID = itemRow.FindControl("lblAssignmentToGridView_AssignToID") as Label;
                if (chkIsSelectedGrid.Checked == true)
                {
                    StaffAccount assignTo = this.saDAO.findById(long.Parse(lblAssignmentToGridView_AssignToID.Text), true);

                    TicketAssignment ticketAssign = new TicketAssignment();
                    ticketAssign.assignTo = assignTo;
                    ticketAssign.creationDate = DateTime.Now;
                    ticketAssign.lastUpdate = DateTime.Now;
                    ticketAssign.assignDate = assignDate;
                    ticketAssign.note = null;
                    ticketAssign.enabled = true;
                    ticketAssigns.Add(ticketAssign);
                }
            }

            DateTime deliveryDate = DateTime.ParseExact(txtDeliveryDate.Text,
                                                    "d/MM/yyyy",
                                                     culture);

            StaffAccount sa = this.saDAO.findById(this.currentStaff.id, true);
            Ticket ticket = new Ticket();
            ticket.subject = WebUtils.getFieldIfNotNull(this.txtSubject.Text);
            ticket.ticketNumber = WebUtils.getFieldIfNotNull(this.txtTicketNumber.Text);
            ticket.ticket_type = TICKET_TYPE.INTERNAL;
            ticket.requester = sa;
            ticket.project = project;
            ticket.status = TICKET_STATUS.NEW;
            ticket.details = WebUtils.getFieldIfNotNull(this.txtDetail.Text);
            ticket.creationDate = DateTime.Now;
            ticket.lastUpDate = DateTime.Now;
            ticket.deliveryDate = deliveryDate;
            ticket.ticketToStaff = ticketAssigns;

            if (ticketAssigns.Count == 0)
            {
                this.errorMessagesForCreate.Add(HttpContext.GetLocalResourceObject("~/staff/F019.CreateStaffTicket.aspx",
                                                                                    "select_staff_to_assign",
                                                                                    culture).ToString());
                return;
            }

            ticket.images = new List<domain.Image>();
            
            List<domain.Image> imgs = getImageUploadCache();
            if (imgs != null)
            {
                foreach (domain.Image img in imgs)
                {
                    ticket.images.Add(img);
                }
            }
            
            ticketDAO.create(ticket);

            if (Session[Constants.SESSION_ADD_IMAGE_UPLOAD] != null)
            {
                Session.Remove(Constants.SESSION_ADD_IMAGE_UPLOAD);
            }

            bindImageRepeater();
            this.pnlAddTicket.Update();

            //Clear form
            WebUtils.ClearControls(this);

            //Refresh GUI
            this.initForm();

            this.infoMessagesForCreate.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                              "successfully_savedRc",
                                                                               culture).ToString());

        }

    }
}