using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.dao;
using XenDevWeb.domain;
using XenDevWeb.include;
using XenDevWeb.Utils;

namespace XenDevWeb.admin
{
    public partial class F029_ProjectMandays : CRUDPageControler
    {
        private ProjectDAO pjDAO;
        private ProjectMandaysDAO pjmdDAO;

        private List<ProjectMandays> allProjectMandays;

        protected void Page_Load(object sender, EventArgs e)
        {
            pjDAO = new ProjectDAO(ctx);
            pjmdDAO = new ProjectMandaysDAO(ctx);

            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            if (ValidationUtil.isEmpty(Request.QueryString["projectId"]))
            {
                Response.Redirect("F004.Project.aspx", true);
                return;
            }

            this.hndProjectId.Value = QueryStringModule.Decrypt(HttpUtility.UrlDecode(Request.QueryString["projectId"]));

            this.initForm();
        }

        private void initForm()
        {
            Project pj = this.pjDAO.findByProjectId(long.Parse(this.hndProjectId.Value), false);
            lblProjectName.Text = string.Format("{0} ({1})", pj.name, pj.code);
            txtRowPerPage.Text = Constants.DEFAULT_ROW_PER_PAGE;
            bindProjectMandays();
        }

        private void bindProjectMandays()
        {
            this.allProjectMandays = this.pjmdDAO.getAllProjectMandaysByProjectId(long.Parse(this.hndProjectId.Value), false);

            if (!ValidationUtil.isEmpty(this.txtSearchText.Text) && this.allProjectMandays != null)
            {
                this.allProjectMandays = this.allProjectMandays.Where(o => o.poNumber.ToLower().Trim().IndexOf(this.txtSearchText.Text.ToLower().Trim()) >= 0)
                                                                        .ToList();
            }
            //Set grid
            this.mandaysDataGridView.PageSize = int.Parse(this.txtRowPerPage.Text);
            this.mandaysDataGridView.DataSource = this.allProjectMandays;
            this.mandaysDataGridView.DataBind();
        }

        protected void mandaysDataGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.mandaysDataGridView.PageIndex = e.NewPageIndex;
            this.bindProjectMandays();
        }

        protected void mandaysDataGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            this.mandaysDataGridView.EditIndex = e.NewEditIndex;
            this.bindProjectMandays();
        }

        protected void mandaysDataGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Page.Validate("vsMandaysEditGrid");
            if (!Page.IsValid)
            {
                return;
            }

            GridViewRow row = this.mandaysDataGridView.Rows[e.RowIndex];
            Label lblprojectMandaysGrid_Id = row.FindControl("lblprojectMandaysGrid_Id") as Label;
            TextBox txtMandaysGridView_PoNumber = row.FindControl("txtMandaysGridView_PoNumber") as TextBox;
            TextBox txtMandaysGridView_mandays = row.FindControl("txtMandaysGridView_mandays") as TextBox;

            long projectMandaysToUpdateId = long.Parse(lblprojectMandaysGrid_Id.Text);
            ProjectMandays someone = this.pjmdDAO.findByPONumber(txtMandaysGridView_PoNumber.Text, false);
            if (someone != null && someone.id != projectMandaysToUpdateId)
            {
                string mesg = string.Format(HttpContext.GetLocalResourceObject("~/admin/F029.ProjectMandays.aspx",
                                                                                   "poNumber_in_use", culture).ToString(),
                                                                                    txtMandaysGridView_PoNumber.Text);
                this.errorMessagesForGrid.Add(mesg);
                return;

            }

            ProjectMandays obj = this.pjmdDAO.findById(projectMandaysToUpdateId, true);
            Project pj = this.pjDAO.findByProjectId(long.Parse(this.hndProjectId.Value), true);
            obj.poNumber = WebUtils.getFieldIfNotNull(txtMandaysGridView_PoNumber.Text);

            if (obj.mandays > double.Parse(WebUtils.getFieldIfNotNull(txtMandaysGridView_mandays.Text)))
            {
                double mandays = obj.mandays - double.Parse(WebUtils.getFieldIfNotNull(txtMandaysGridView_mandays.Text));
                pj.remainingMandays = obj.project.remainingMandays - mandays;
                pj.totalManDay = obj.project.totalManDay - mandays;
            }
            else if (obj.mandays < double.Parse(WebUtils.getFieldIfNotNull(txtMandaysGridView_mandays.Text)))
            {
                double mandays =  double.Parse(WebUtils.getFieldIfNotNull(txtMandaysGridView_mandays.Text)) - obj.mandays;
                pj.remainingMandays = obj.project.remainingMandays + mandays;
                pj.totalManDay = obj.project.totalManDay + mandays;
            }
            obj.mandays = double.Parse(WebUtils.getFieldIfNotNull(txtMandaysGridView_mandays.Text));
            
            obj.lastUpdate = DateTime.Now;

            pj.projectMandays.Add(obj);
            this.pjDAO.update(pj);
            //Refresh GUI
            this.mandaysDataGridView.EditIndex = -1;
            this.bindProjectMandays();
            //Give user feedback
            this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                             "successfully_savedRc",
                                                                             culture)
                                                                             .ToString());
        }

        protected void mandaysDataGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            this.mandaysDataGridView.EditIndex = -1;
            this.bindProjectMandays();
        }

        protected void mandaysDataGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }
            if (this.allProjectMandays == null || e.Row.RowIndex >= this.allProjectMandays.Count)
            {
                return;
            }

            ProjectMandays obj = e.Row.DataItem as ProjectMandays;
            Label lblprojectMandaysGrid_Id = e.Row.FindControl("lblprojectMandaysGrid_Id") as Label;
            lblprojectMandaysGrid_Id.Text = obj.id.ToString();

            Label lblMandaysDataGridView_CreationDate = e.Row.FindControl("lblMandaysDataGridView_CreationDate") as Label;
            lblMandaysDataGridView_CreationDate.Text = string.Format(obj.creationDate.ToString("dd/MM/yyyy HH:mm", culture));

            Label lblMandaysDataGridView_LastUpdate = e.Row.FindControl("lblMandaysDataGridView_LastUpdate") as Label;
            lblMandaysDataGridView_LastUpdate.Text = string.Format(obj.lastUpdate.ToString("dd/MM/yyyy HH:mm", culture));

            if ((e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                TextBox txtMandaysGridView_PoNumber = e.Row.FindControl("txtMandaysGridView_PoNumber") as TextBox;
                TextBox txtMandaysGridView_mandays = e.Row.FindControl("txtMandaysGridView_mandays") as TextBox;
                
                txtMandaysGridView_PoNumber.Text = obj.poNumber;
                txtMandaysGridView_mandays.Text = obj.mandays.ToString();
            }
            else
            {
                Label lblMandaysGridView_PoNumber = e.Row.FindControl("lblMandaysGridView_PoNumber") as Label;
                Label lblMandaysGridView_mandays = e.Row.FindControl("lblMandaysGridView_mandays") as Label;

                lblMandaysGridView_PoNumber.Text = obj.poNumber;
                lblMandaysGridView_mandays.Text = string.Format("{0:n0}", obj.mandays);
            }
        }

        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            long id = long.Parse(e.CommandArgument.ToString());
            ProjectMandays pjmdToDelete = this.pjmdDAO.findById(id, true);
            try
            {
                Project pj = this.pjDAO.findByProjectId(long.Parse(this.hndProjectId.Value), true);
                pj.remainingMandays = pj.remainingMandays - pjmdToDelete.mandays;
                pj.totalManDay = pj.totalManDay - pjmdToDelete.mandays;
                this.pjDAO.update(pj);

                this.pjmdDAO.delete(pjmdToDelete);
                this.bindProjectMandays();
                this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                                 "successfully_deletedRc",
                                                                                 culture)
                                                                                 .ToString());
            }
            catch (Exception exp)
            {
                this.errorMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                             "dataIsUse",
                                                                             culture)
                                                                             .ToString());
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Page.Validate("vsAddMandaysGroup");
            if (!Page.IsValid)
            {
                return;
            }

            ProjectMandays someonePONumber = this.pjmdDAO.findByPONumber(this.txtPONumber.Text, false);
            if (someonePONumber != null)
            {
                string mesg = string.Format(HttpContext.GetLocalResourceObject("~/admin/F029.ProjectMandays.aspx",
                                                                                   "poNumber_in_use", culture)
                                                                                   .ToString(),
                                                                                   this.txtPONumber.Text);
                this.errorMessages.Add(mesg);
                return;
            }

            ProjectMandays obj = new ProjectMandays();
            obj.poNumber = WebUtils.getFieldIfNotNull(txtPONumber.Text);
            obj.mandays = double.Parse(WebUtils.getFieldIfNotNull(txtMandays.Text));
            obj.creationDate = DateTime.Now;
            obj.lastUpdate = DateTime.Now;

            Project pj = this.pjDAO.findByProjectId(int.Parse(this.hndProjectId.Value), true);
            pj.remainingMandays = pj.remainingMandays + double.Parse(WebUtils.getFieldIfNotNull(txtMandays.Text));
            pj.totalManDay = pj.totalManDay + double.Parse(WebUtils.getFieldIfNotNull(txtMandays.Text));
            pj.projectMandays = new List<ProjectMandays>();

            pj.projectMandays.Add(obj);
            pjDAO.update(pj);
            
            //Clear screen
            WebUtils.ClearControls(this);

            //Refresh GUI
            this.initForm();
            this.bindProjectMandays();
            //Give user feedback
            this.infoMessages.Add(HttpContext.GetGlobalResourceObject("GlobalResource", "successfully_savedRc", culture).ToString());
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Page.Validate("vsSearchGroup");
            if (!Page.IsValid)
            {
                return;
            }
            bindProjectMandays();
        }
    }
}