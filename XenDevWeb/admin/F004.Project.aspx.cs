using System;
using System.Collections.Generic;
using System.Globalization;
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
    public partial class F004_Project : CRUDPageControler
    {
        private ProjectDAO proDAO;
        private CompanyDAO comDAO;
        private ProjectMandaysDAO pjmdDAO;

        private List<Project> allprojects;

        protected void Page_Load(object sender, EventArgs e)
        {
            culture = CultureInfo.CreateSpecificCulture(Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName);
                        
            proDAO = new ProjectDAO(ctx);
            comDAO = new CompanyDAO(ctx);
            pjmdDAO = new ProjectMandaysDAO(ctx);

            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            this.initForm();
            this.bindProjectList();
        }

        private void initForm()
        {
            this.populateSearchBy();
            this.populateCompany(this.selCompany);
            this.populateCompany(this.selSearchCompany);
            this.populateApprovalType(this.selApprovalType);
            this.txtRowPerPage.Text = Constants.DEFAULT_ROW_PER_PAGE.ToString();
        }

        private void bindProjectList()
        {
            this.allprojects = this.proDAO.getCompanyProject(long.Parse(this.selSearchCompany.SelectedValue), false);

            if (!ValidationUtil.isEmpty(this.txtSearchText.Text) && this.allprojects != null)
            {
                switch (this.selSearchBy.SelectedIndex)
                {
                    case 0:
                        this.allprojects = this.allprojects.Where(o => o.code.ToLower().Trim().IndexOf(this.txtSearchText.Text.ToLower().Trim()) >= 0)
                                                                    .ToList();
                        break;
                    case 1:
                        this.allprojects = this.allprojects.Where(o => o.name != null && o.name.ToLower().Trim().IndexOf(this.txtSearchText.Text.ToLower().Trim()) >= 0)
                                                                            .ToList();
                        break;
                }
            }
            //Set grid
            this.projectDataGridView.PageSize = int.Parse(this.txtRowPerPage.Text);
            this.projectDataGridView.DataSource = this.allprojects;
            this.projectDataGridView.DataBind();
        }

        private void populateSearchBy()
        {
            this.selSearchBy.Items.Clear();

            ListItem liProjectCode = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F004.Project.aspx",
                                                                                   "lblProjectCodeRc.text",
                                                                                    culture).ToString(), "0");
            this.selSearchBy.Items.Add(liProjectCode);
            ListItem liProjectName = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F004.Project.aspx",
                                                                                  "lblProjectNameRc.text",
                                                                                   culture).ToString(), "1");
            this.selSearchBy.Items.Add(liProjectName);

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Page.Validate("vsSearchGroup");
            if (!Page.IsValid)
            {
                return;
            }

            bindProjectList();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        private void populateCompany(DropDownList sel)
        {
            sel.Items.Clear();
            List<Company> coms = comDAO.getAllEnabledCompanies(false);

            foreach (Company com in coms)
            {
                ListItem li = new ListItem(string.Format("{0} ({1})", com.name, com.code), com.id.ToString());
                sel.Items.Add(li);
            }
        }

        private void populateApprovalType(DropDownList sel)
        {
            sel.Items.Clear();
            string meeting = HttpContext.GetGlobalResourceObject("GlobalResource", "meeting", culture).ToString();
            sel.Items.Add(new ListItem(meeting, ((int)APPROVALTYPE.MEETING).ToString()));

            string requirement = HttpContext.GetGlobalResourceObject("GlobalResource", "requirement", culture).ToString();
            sel.Items.Add(new ListItem(requirement, ((int)APPROVALTYPE.REQUIREMENT).ToString()));

            string design = HttpContext.GetGlobalResourceObject("GlobalResource", "design", culture).ToString();
            sel.Items.Add(new ListItem(design, ((int)APPROVALTYPE.DESIGN).ToString()));

            string testing = HttpContext.GetGlobalResourceObject("GlobalResource", "testing", culture).ToString();
            sel.Items.Add(new ListItem(testing, ((int)APPROVALTYPE.TESTING).ToString()));

        }

        protected void projectDataGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.projectDataGridView.PageIndex = e.NewPageIndex;
            this.bindProjectList();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void projectDataGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            this.projectDataGridView.EditIndex = e.NewEditIndex;
            this.bindProjectList();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void projectDataGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Page.Validate("vsProjectEditGrid");
            if (!Page.IsValid)
            {
                return;
            }

            GridViewRow row = this.projectDataGridView.Rows[e.RowIndex];
            Label lblprojectGrid_Id = row.FindControl("lblprojectGrid_Id") as Label;
            TextBox txtProjectDataGridView_Code = row.FindControl("txtProjectDataGridView_Code") as TextBox;
            TextBox txtProjectDataGridView_Name = row.FindControl("txtProjectDataGridView_Name") as TextBox;
            TextBox txtProjectDataGridView_Description = row.FindControl("txtProjectDataGridView_Description") as TextBox;
            DropDownList selAppUserGrid_Company = row.FindControl("selAppUserGrid_Company") as DropDownList;
            DropDownList selGridApprovalType = row.FindControl("selGridApprovalType") as DropDownList;
            TextBox txtProjectDataGridView_ProjectColor = row.FindControl("txtProjectDataGridView_ProjectColor") as TextBox;

            long projectToUpdateId = long.Parse(lblprojectGrid_Id.Text);

            Project someone = this.proDAO.findByProjectCode(txtProjectDataGridView_Code.Text, false);
            if (someone != null && someone.id != projectToUpdateId)
            {
                string mesg = string.Format(HttpContext.
                                           GetGlobalResourceObject("GlobalResource", "code_in_use", culture).ToString(),
                                           txtProjectDataGridView_Code.Text);
                this.errorMessagesForGrid.Add(mesg);
                return;

            }

            Project obj = this.proDAO.findByProjectId(projectToUpdateId, true);            
            obj.code = WebUtils.getFieldIfNotNull(txtProjectDataGridView_Code.Text);
            obj.name = WebUtils.getFieldIfNotNull(txtProjectDataGridView_Name.Text);
            obj.description = WebUtils.getFieldIfNotNull(txtProjectDataGridView_Description.Text);
            obj.company = comDAO.findById(long.Parse(selAppUserGrid_Company.SelectedValue), true);
            obj.projectColor = txtProjectDataGridView_ProjectColor.Text;
            switch (int.Parse(selGridApprovalType.SelectedValue))
            {
                case (int)APPROVALTYPE.MEETING:
                    obj.approvalType = APPROVALTYPE.MEETING;
                    break;
                case (int)APPROVALTYPE.REQUIREMENT:
                    obj.approvalType = APPROVALTYPE.REQUIREMENT;
                    break;
                case (int)APPROVALTYPE.DESIGN:
                    obj.approvalType = APPROVALTYPE.DESIGN;
                    break;
                case (int)APPROVALTYPE.TESTING:
                    obj.approvalType = APPROVALTYPE.TESTING;
                    break;
            }
            obj.lastUpdate = DateTime.Now;

            this.proDAO.update(obj);

            //Refresh GUI
            this.projectDataGridView.EditIndex = -1;
            this.bindProjectList();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
            //Give user feedback
            this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                             "successfully_savedRc",
                                                                             culture)
                                                                             .ToString());
        }

        protected void projectDataGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            this.projectDataGridView.EditIndex = -1;
            this.bindProjectList();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void projectDataGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }
            if (this.allprojects == null || e.Row.RowIndex >= this.allprojects.Count)
            {
                return;
            }

            Project obj = e.Row.DataItem as Project;

            Label lblprojectGrid_Id = e.Row.FindControl("lblprojectGrid_Id") as Label;
            lblprojectGrid_Id.Text = obj.id.ToString();

            Label lblProjectGridView_LastUpdate = e.Row.FindControl("lblProjectGridView_LastUpdate") as Label;
            lblProjectGridView_LastUpdate.Text = string.Format(obj.lastUpdate.ToString("dd/MM/yyyy HH:mm", new CultureInfo("en-Us")));
            TextBox txtProjectDataGridView_ProjectColor = e.Row.FindControl("txtProjectDataGridView_ProjectColor") as TextBox;
            txtProjectDataGridView_ProjectColor.Text = obj.projectColor;
            Label lblProjectGridView_ManDays = e.Row.FindControl("lblProjectGridView_ManDays") as Label;
            lblProjectGridView_ManDays.Text = string.Format("{0:n0}", obj.remainingMandays);


            if ((e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                TextBox txtProjectDataGridView_Code = e.Row.FindControl("txtProjectDataGridView_Code") as TextBox;
                TextBox txtProjectDataGridView_Name = e.Row.FindControl("txtProjectDataGridView_Name") as TextBox;
               
                TextBox txtProjectDataGridView_Description = e.Row.FindControl("txtProjectDataGridView_Description") as TextBox;
                DropDownList selAppUserGrid_Company = e.Row.FindControl("selAppUserGrid_Company") as DropDownList;
                DropDownList selGridApprovalType = e.Row.FindControl("selGridApprovalType") as DropDownList;

                txtProjectDataGridView_Code.Text = obj.code;
                txtProjectDataGridView_Name.Text = obj.name;
                txtProjectDataGridView_Description.Text = obj.description;
                populateCompany(selAppUserGrid_Company);
                selAppUserGrid_Company.SelectedValue = obj.company.id.ToString();
                populateApprovalType(selGridApprovalType);
                selGridApprovalType.SelectedValue = ((int)obj.approvalType).ToString();

            }
            else
            {
                Label lblProjectDataGridView_Code = e.Row.FindControl("lblProjectDataGridView_Code") as Label;
                Label lblProjectDataGridView_Name = e.Row.FindControl("lblProjectDataGridView_Name") as Label;
                Label lblProjectDataGridView_Description = e.Row.FindControl("lblProjectDataGridView_Description") as Label;
                Label lblAppUserGrid_Company = e.Row.FindControl("lblAppUserGrid_Company") as Label;
                Label lblAppUserGrid_ApprovalType = e.Row.FindControl("lblAppUserGrid_ApprovalType") as Label;

                lblProjectDataGridView_Code.Text = obj.code;
                lblProjectDataGridView_Name.Text = obj.name;
                lblProjectDataGridView_Description.Text = obj.description;
                
                if (obj.company != null)
                {
                    lblAppUserGrid_Company.Text = string.Format("{0} ({1})", obj.company.name, obj.company.code);
                }

                switch (obj.approvalType)
                {
                    case APPROVALTYPE.MEETING:
                        lblAppUserGrid_ApprovalType.Text = HttpContext.GetGlobalResourceObject("GlobalResource", "meeting", culture).ToString();
                        break;
                    case APPROVALTYPE.REQUIREMENT:
                        lblAppUserGrid_ApprovalType.Text = HttpContext.GetGlobalResourceObject("GlobalResource", "requirement", culture).ToString();
                        break;
                    case APPROVALTYPE.DESIGN:
                        lblAppUserGrid_ApprovalType.Text = HttpContext.GetGlobalResourceObject("GlobalResource", "design", culture).ToString();
                        break;
                    case APPROVALTYPE.TESTING:
                        lblAppUserGrid_ApprovalType.Text = HttpContext.GetGlobalResourceObject("GlobalResource", "testing", culture).ToString();
                        break;
                }
            }
        }

        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            //แปลงid.textเป็นlong
            long id = long.Parse(e.CommandArgument.ToString());
            //ค้นหา id ที่จะลบ
            Project projectToDelete = this.proDAO.findByProjectId(id, true);

            try
            {
                this.proDAO.delete(projectToDelete);
                this.bindProjectList();
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
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void btnAddProject_Click(object sender, EventArgs e)
        {
            Page.Validate("vsAddProjectGroup");
            if (!Page.IsValid)
            {
                return;
            }
            
            Project someoneProjectCode = this.proDAO.findByProjectCode(this.txtProjectCode.Text, false);
            if (someoneProjectCode != null)
            {
                string mesg = string.Format(HttpContext.GetGlobalResourceObject("GlobalResource", "code_in_use", culture).ToString(),
                                           this.txtProjectCode.Text);
                this.errorMessages.Add(mesg);
                return;
            }
            
            Project obj = new Project();
            obj.company = comDAO.findById(long.Parse(selCompany.SelectedValue), true);
            obj.code = WebUtils.getFieldIfNotNull(txtProjectCode.Text);
            obj.name = WebUtils.getFieldIfNotNull(txtProjectName.Text);
            obj.description = WebUtils.getFieldIfNotNull(txtDescription.Text);
            obj.projectColor = this.txtProjectColor.Text;
            switch (int.Parse(selApprovalType.SelectedValue))
            {
                case (int)APPROVALTYPE.MEETING:
                    obj.approvalType = APPROVALTYPE.MEETING;
                    break;
                case (int)APPROVALTYPE.REQUIREMENT:
                    obj.approvalType = APPROVALTYPE.REQUIREMENT;
                    break;
                case (int)APPROVALTYPE.DESIGN:
                    obj.approvalType = APPROVALTYPE.DESIGN;
                    break;
                case (int)APPROVALTYPE.TESTING:
                    obj.approvalType = APPROVALTYPE.TESTING;
                    break;
            }
            obj.creationDate = DateTime.Now;
            obj.lastUpdate = DateTime.Now;

            // create
            this.proDAO.create(obj);

            //Clear screen
            WebUtils.ClearControls(this);

            //Refresh GUI
            this.initForm();
            this.bindProjectList();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
            //Give user feedback
            this.infoMessages.Add(HttpContext.GetGlobalResourceObject("GlobalResource", "successfully_savedRc", culture).ToString());
        }

        protected void btnAssets_Command(object sender, CommandEventArgs e)
        {
            string projectId = e.CommandArgument.ToString();
            Response.Redirect("F007.ApplicationAsset.aspx?projectId=" + HttpUtility.UrlEncode(QueryStringModule.Encrypt(projectId)), true);
        }

        protected void btnBannerImage_Command(object sender, CommandEventArgs e)
        {
            string projectId = e.CommandArgument.ToString();
            Response.Redirect("F004.1.ProjectImage.aspx?projectId=" + HttpUtility.UrlEncode(QueryStringModule.Encrypt(projectId)), true);
        }

        protected void btnPo_Command(object sender, CommandEventArgs e)
        {
            string projectId = e.CommandArgument.ToString();
            Response.Redirect("F029.ProjectMandays.aspx?projectId=" + HttpUtility.UrlEncode(QueryStringModule.Encrypt(projectId)), true);
        }
    }
}