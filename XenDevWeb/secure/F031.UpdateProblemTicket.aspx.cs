using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.dao;
using XenDevWeb.domain;
using XenDevWeb.include;
using XenDevWeb.Utils;

namespace XenDevWeb.secure
{
    public partial class F031_UpdateProblemTicket : CRUDPageControler
    {
        private ImageDAO imgDAO;
        private ProjectDAO pjDAO;
        private TicketDAO tkDAO;
        private TicketAssignmentDAO tkAssignDAO;
        private TicketCommentDAO tkCommentDAO;

        private List<StaffAccount> allSA;
        private List<domain.Image> allImg;

        public List<string> errorMessagesForUpdate;
        public List<string> infoMessagesForUpdate;

        protected void Page_Load(object sender, EventArgs e)
        {
            imgDAO = new ImageDAO(ctx);
            pjDAO = new ProjectDAO(ctx);
            tkDAO = new TicketDAO(ctx);
            tkAssignDAO = new TicketAssignmentDAO(ctx);
            tkCommentDAO = new TicketCommentDAO(ctx);

            errorMessagesForUpdate = new List<string>();
            infoMessagesForUpdate = new List<string>();

            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            if (ValidationUtil.isEmpty(Request.QueryString["ticketId"]))
            {
                Response.Redirect("F014.Problem.aspx", true);
                return;
            }

            if (!this.currentStaff.isAdmin)
            {
                Response.Redirect("F014.Problem.aspx", true);
                return;
            }

            if (Session[Constants.SESSION_ADD_IMAGE_UPLOAD] != null)
            {
                Session.Remove(Constants.SESSION_ADD_IMAGE_UPLOAD);
            }

            this.hndTicketUpdateId.Value = QueryStringModule.Decrypt(HttpUtility.UrlDecode(Request.QueryString["ticketId"]));
            this.hndImgItemID.Value = QueryStringModule.Decrypt(HttpUtility.UrlDecode(Request.QueryString["ticketId"]));

            this.initForm();
        }

        private void initForm()
        {
            TicketAssignment tkAssign = this.tkAssignDAO.findByTicketID(long.Parse(this.hndTicketUpdateId.Value), false);
            
            this.txtDeliveryDate.Text = tkAssign.ticket.deliveryDate.ToString("dd/MM/yyyy", culture);
            this.txtDeliveryDate.Attributes["readonly"] = "readonly";

            this.txtAssignDate.Text = tkAssign.assignDate.ToString("dd/MM/yyyy", culture);
            this.txtDeliveryDate.Attributes["readonly"] = "readonly";

            txtTicketNumber.Text = tkAssign.ticket.ticketNumber.ToString();
            txtSubject.Text = tkAssign.ticket.subject.ToString();
            txtDetail.Text = tkAssign.ticket.details;

            this.populateProject(this.selProject);
            selProject.SelectedValue = tkAssign.ticket.project.id.ToString();
            this.btnUpdate.Enabled = false;
            this.mpe.Enabled = false;

            this.divBtnAssign.Visible = false;
            if (tkAssign.ticket.status == TICKET_STATUS.NEW)
            {
                this.divBtnAssign.Visible = true;
                this.btnUpdate.Enabled = true;
                this.mpe.Enabled = true;
            }

            this.bindSatff();
            this.bindImageRepeater();

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

        public void bindSatff()
        {
            this.allSA = this.saDAO.getAllEnableStaffAccount(false);

            //Set grid
            this.assignmentToGridView.PageSize = Constants.DEFAULT_GRID_PAGE_SIZE;
            this.assignmentToGridView.DataSource = this.allSA;
            this.assignmentToGridView.DataBind();
        }

        private void bindImageRepeater()
        {
            this.allImg = this.imgDAO.getAllTicketById(long.Parse(this.hndImgItemID.Value), false);
            List<domain.Image> imgs = this.getImageUploadCache();
            if (imgs != null && imgs.Count > 0)
            {
                foreach (domain.Image img in imgs)
                {
                    this.allImg.Add(img);
                }
                imageRepeater.DataSource = allImg;
                imageRepeater.DataBind();
                return;
            }

            imageRepeater.DataSource = this.allImg;
            imageRepeater.DataBind();
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
            if (this.allSA == null || e.Row.RowIndex >= this.allSA.Count)
            {
                return;
            }

            StaffAccount obj = e.Row.DataItem as StaffAccount;
            CheckBox chkIsSelectedGrid = e.Row.FindControl("chkIsSelectedGrid") as CheckBox;
            Label lblAssignmentToGridView_FirstName = e.Row.FindControl("lblAssignmentToGridView_FirstName") as Label;
            lblAssignmentToGridView_FirstName.Text = obj.firstName.ToString();
            Label lblAssignmentToGridView_LastName = e.Row.FindControl("lblAssignmentToGridView_LastName") as Label;
            lblAssignmentToGridView_LastName.Text = obj.lastName.ToString();
            chkIsSelectedGrid.Checked = false;

            List<TicketAssignment> tkAssigns = this.tkAssignDAO.getAllTicketTypeClientById(long.Parse(this.hndTicketUpdateId.Value), false);

            TicketAssignment tkAssign = tkAssigns.Where(o => o.assignTo.id == obj.id).FirstOrDefault();
            if (tkAssign != null)
            {
                chkIsSelectedGrid.Checked = true;
            }
            else
            {
                chkIsSelectedGrid.Checked = false;
            }

            Label lblAssignmentToGridView_AssignToID = e.Row.FindControl("lblAssignmentToGridView_AssignToID") as Label;
            lblAssignmentToGridView_AssignToID.Text = obj.id.ToString();
            lblAssignmentToGridView_AssignToID.Visible = false;

        }

        protected void lnkUpload_ServerClick(object sender, EventArgs e)
        {
            HttpPostedFile file = Request.Files["myFile"];
            if (file == null)
            {
                this.errorMessagesForUpdate.Add(HttpContext.GetLocalResourceObject("~/secure/F031.UpdateProblemTicket.aspx",
                                                                                   "pls_upload_image",
                                                                                    culture).ToString());
                return;
            }
            else if (!file.FileName.ToLower().EndsWith(".jpg"))
            {
                this.errorMessagesForUpdate.Add(HttpContext.GetLocalResourceObject("~/secure/F031.UpdateProblemTicket.aspx",
                                                                                   "only_jpeg",
                                                                                    culture).ToString());
                return;
            }

            string fileName = string.Format("{0}.jpg", Guid.NewGuid());
            string fullPath = string.Format("{0}\\{1}", Constants.TICKET_TYPE_CLIENT_IMG_FOLDER
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
            bindImageRepeater();
        }

        protected void imageRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            domain.Image image = e.Item.DataItem as domain.Image;
            Label lblDescription = e.Item.FindControl("lblDescription") as Label;
            System.Web.UI.WebControls.Image images = e.Item.FindControl("images") as System.Web.UI.WebControls.Image;
            LinkButton btnDelete = e.Item.FindControl("btnDelete") as LinkButton;
            AjaxControlToolkit.ModalPopupExtender mpe = e.Item.FindControl("mpe") as AjaxControlToolkit.ModalPopupExtender;

            TicketAssignment tkAssign = this.tkAssignDAO.findByTicketID(long.Parse(this.hndTicketUpdateId.Value), false);
            if (tkAssign.ticket.status != TICKET_STATUS.NEW)
            {
                btnDelete.Enabled = false;
                mpe.Enabled = false;
            }

            if (this.allImg != null && this.allImg.Count > 0)
            {
                lblDescription.Text = image.description.ToString();
                images.ImageUrl = string.Format(Constants.URL_API_GETIMAGE, WebUtils.getAppServerPath(), image.serverImageFileName, Constants.TYPE_TICKET_TYPE_CLIENT_IMAGE);
            }
            lblDescription.Text = image.description.ToString();
            images.ImageUrl = string.Format(Constants.URL_API_GETIMAGE, WebUtils.getAppServerPath(), image.serverImageFileName, Constants.TYPE_TICKET_TYPE_CLIENT_IMAGE);
        }

        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            string serverImageFileName = e.CommandArgument.ToString();

            domain.Image imgDelete = imgDAO.findByServerImageFileName(serverImageFileName, true);
            List<domain.Image> imgDeleteCaches = getImageUploadCache();
            if (imgDelete != null)
            {
                string oldFullPath = string.Format("{0}\\{1}", Constants.TICKET_TYPE_CLIENT_IMG_FOLDER
                                                         , imgDelete.serverImageFileName);
                File.Delete(oldFullPath);
                this.imgDAO.delete(imgDelete);
            }
            else
            {
                List<domain.Image> imgs = Session[Constants.SESSION_ADD_IMAGE_UPLOAD] as List<domain.Image>;
                domain.Image img = imgDeleteCaches.Where(o => o.serverImageFileName.CompareTo(serverImageFileName) == 0).FirstOrDefault();
                string fullPath = string.Format("{0}\\{1}", Constants.TICKET_TYPE_CLIENT_IMG_FOLDER
                                                          , img.serverImageFileName);
                string[] files = Directory.GetFiles(Constants.TICKET_TYPE_CLIENT_IMG_FOLDER + "\\");
                string file = files.Where(m => m.CompareTo(fullPath) == 0).FirstOrDefault();
                File.Delete(file);

                List<domain.Image> imgReomveObjs = imgs.Where(n => n.serverImageFileName.CompareTo(img.serverImageFileName) == 0).ToList();
                for (int i = 0; i < imgReomveObjs.Count; i++)
                {
                    imgs.Remove(imgReomveObjs[i]);
                    Session[Constants.SESSION_ADD_IMAGE_UPLOAD] = imgs;
                }
            }

            bindImageRepeater();
            this.infoMessagesForUpdate.Add(HttpContext.GetGlobalResourceObject("GlobalResource", "successfully_deletedRc", culture).ToString());
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
                        string fullPath = string.Format("{0}\\{1}", Constants.TICKET_TYPE_CLIENT_IMG_FOLDER
                                                          , img.serverImageFileName);
                        string[] files = Directory.GetFiles(Constants.TICKET_TYPE_CLIENT_IMG_FOLDER + "\\");
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
            Response.Redirect("~/secure/F014.Problem.aspx", true);
            return;
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Page.Validate("vsUpdateTicketGroup");
            if (!Page.IsValid)
            {
                return;
            }
            long ticketToUpdateId = long.Parse(this.hndTicketUpdateId.Value);
            Ticket ticketUpdate = this.tkDAO.findByStaffTicketTypeClientId(ticketToUpdateId, true);

            Ticket someoneTicketNumber = this.tkDAO.findByTicketNumberTicketTypeClient(this.txtTicketNumber.Text, false);
            if (someoneTicketNumber != null && someoneTicketNumber.id != ticketUpdate.id)
            {
                string mesg = string.Format(HttpContext.GetLocalResourceObject("~/secure/F031.UpdateProblemTicket.aspx",
                                                                                "ticketNumber_in_use",
                                                                                culture)
                                                                                .ToString(),
                                                                                this.txtTicketNumber.Text);
                this.errorMessagesForUpdate.Add(mesg);
                return;
            }

            if (ticketUpdate != null)
            {
                Project project = this.pjDAO.findByProjectId(long.Parse(this.selProject.SelectedValue), true);
                List<TicketAssignment> ticketAssigns = this.tkAssignDAO.getAllTicketTypeClientById(ticketToUpdateId, true);
                List<TicketAssignment> ticketAssignsForDelete = new List<TicketAssignment>();

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

                    StaffAccount assignTo = this.saDAO.findById(long.Parse(lblAssignmentToGridView_AssignToID.Text), true);

                    if (chkIsSelectedGrid.Checked == true)
                    {
                        TicketAssignment tkAssign = ticketAssigns.Where(o => o.assignTo.id == int.Parse(lblAssignmentToGridView_AssignToID.Text)).FirstOrDefault();
                        if (tkAssign == null)
                        {
                            TicketAssignment newTicketAssigns = new TicketAssignment();
                            newTicketAssigns.assignTo = assignTo;
                            newTicketAssigns.creationDate = DateTime.Now;
                            newTicketAssigns.lastUpdate = DateTime.Now;
                            newTicketAssigns.assignDate = assignDate;
                            newTicketAssigns.enabled = true;
                            ticketUpdate.ticketToStaff.Add(newTicketAssigns);
                        }
                    }
                    if (chkIsSelectedGrid.Checked == false)
                    {
                        TicketAssignment tkAssign = ticketAssigns.Where(o => o.assignTo.id == int.Parse(lblAssignmentToGridView_AssignToID.Text)).FirstOrDefault();
                        if (tkAssign != null)
                        {
                            ticketAssignsForDelete.Add(tkAssign);
                        }
                    }
                }

                DateTime deliveryDate = DateTime.ParseExact(txtDeliveryDate.Text,
                                                    "d/MM/yyyy",
                                                     culture);

                ticketUpdate.subject = WebUtils.getFieldIfNotNull(this.txtSubject.Text);
                ticketUpdate.ticketNumber = WebUtils.getFieldIfNotNull(this.txtTicketNumber.Text);
                ticketUpdate.project = pjDAO.findByProjectId(long.Parse(selProject.SelectedValue), true);
                ticketUpdate.details = WebUtils.getFieldIfNotNull(this.txtDetail.Text);
                ticketUpdate.lastUpDate = DateTime.Now;
                ticketUpdate.deliveryDate = deliveryDate;

                if (ticketAssignsForDelete.Count == ticketUpdate.ticketToStaff.Count)
                {
                    this.errorMessagesForUpdate.Add(HttpContext.GetLocalResourceObject("~/secure/F031.UpdateProblemTicket.aspx",
                                                                                        "select_staff_to_assign",
                                                                                        culture).ToString());
                    return;
                }

                foreach (TicketAssignment tkAssignDelete in ticketAssignsForDelete)
                {
                    this.tkAssignDAO.delete(tkAssignDelete);
                }

                foreach (TicketAssignment ticketAssign in ticketAssigns)
                {
                    ticketUpdate.ticketToStaff.Add(ticketAssign);
                }

                List<domain.Image> imgs = getImageUploadCache();
                if (imgs != null && imgs.Count > 0)
                {
                    ticketUpdate.images = new List<domain.Image>();
                    foreach (domain.Image img in imgs)
                    {
                        ticketUpdate.images.Add(img);
                    }
                }

                tkDAO.update(ticketUpdate);

                if (Session[Constants.SESSION_ADD_IMAGE_UPLOAD] != null)
                {
                    Session.Remove(Constants.SESSION_ADD_IMAGE_UPLOAD);
                }

                this.pnlUpdateTicket.Update();

                bindImageRepeater();

                //Refresh GUI
                this.initForm();

                this.infoMessagesForUpdate.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                                  "successfully_savedRc",
                                                                                   culture).ToString());
            }


        }

        protected void btnAssigned_Click(object sender, EventArgs e)
        {
            Ticket tk = this.tkDAO.findByStaffTicketTypeClientId(long.Parse(this.hndTicketUpdateId.Value), true);

            tk.status = TICKET_STATUS.ASSIGNED;
            tk.lastUpDate = DateTime.Now;
            this.tkDAO.update(tk);

            //Refresh GUI
            this.btnAssigned.Enabled = false;
            this.btnUpdate.Enabled = false;
            this.mpe.Enabled = false;

            this.infoMessagesForUpdate.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                                  "successfully_savedRc",
                                                                                   culture).ToString());


        }
    }
}