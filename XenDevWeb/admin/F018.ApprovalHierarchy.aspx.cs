using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.dao;
using XenDevWeb.domain;
using XenDevWeb.Utils;

namespace XenDevWeb.admin
{
    public partial class F018_ApprovalHierarchy : System.Web.UI.Page
    {
        protected CultureInfo culture;
        protected List<string> errorMessages;
        protected List<string> infoMessages;
        protected List<string> errorMessagesForGrid;
        protected List<string> infoMessagesForGrid;

        public XenDevWebDbContext ctx;
        public StaffAccountDAO saDAO;
        private ApprovalHierarchyDAO ahDAO;
        private ApprovalHierarchyDetailDAO ahdDAO;
        private ProjectDAO pDAO;

        private List<ApprovalHierarchy> allApprovalHierachy;

        protected StaffAccount currentStaff;

        public F018_ApprovalHierarchy() : base()
        {
            culture = CultureInfo.CreateSpecificCulture(Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName);
            errorMessages = new List<string>();
            infoMessages = new List<string>();
            errorMessagesForGrid = new List<string>();
            infoMessagesForGrid = new List<string>();

            ctx = new XenDevWebDbContext();
            saDAO = new StaffAccountDAO(ctx);
            ahDAO = new ApprovalHierarchyDAO(ctx);
            ahdDAO = new ApprovalHierarchyDetailDAO(ctx);
            pDAO = new ProjectDAO(ctx);

            string username = System.Web.HttpContext.Current.User.Identity.Name;

            this.currentStaff = saDAO.findByUsername(username, false);
        }

        protected override void InitializeCulture()
        {
            if (this.currentStaff != null)
            {
                String selectedLanguage = this.currentStaff.language;
                UICulture = selectedLanguage;
                Culture = selectedLanguage;

                Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(selectedLanguage);
                Thread.CurrentThread.CurrentUICulture = new CultureInfo(selectedLanguage);

                culture = CultureInfo.CreateSpecificCulture(Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName);
            }
            else
            {
                FormsAuthentication.SignOut();
                Response.Redirect(WebUtils.getAppServerPath() + "/login_staff.aspx", true);
            }           

            base.InitializeCulture();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            initForm();
        }

        private void initForm()
        {
            populateSearchType();
            populateProject(selProject);
            this.txtRowPerPage.Text = Constants.DEFAULT_ROW_PER_PAGE.ToString();
            bindApprovalGrid();
            populateAppovalType(selApprovalType);
        }

        private void populateSearchType()
        {
            this.selSearchType.Items.Clear();

            ListItem licode = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F018.ApprovalHierarchy.aspx",
                                                                                   "lblCodeRc.text",
                                                                                    culture).ToString(), "0");
            this.selSearchType.Items.Add(licode);
            ListItem liDescript = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F018.ApprovalHierarchy.aspx",
                                                                                  "lblDescriptionRc.text",
                                                                                   culture).ToString(), "1");
            this.selSearchType.Items.Add(liDescript);
        }

        
        private void populateProject(DropDownList sel)
        {
            sel.Items.Clear();
            List<Project> allProject = pDAO.getAllProject(false);
            foreach(Project p in allProject)
            {
                ListItem liProject = new ListItem(string.Format("{0} ({1})", p.name, p.code), p.id.ToString());
                sel.Items.Add(liProject);
            }
        }

        private void populateAppovalType(DropDownList sel)
        {
            sel.Items.Clear();

            string hier_requirement = HttpContext.GetLocalResourceObject("~/admin/F018.ApprovalHierarchy.aspx", "HIER_REQUIREMENT", culture).ToString();
            sel.Items.Add(new ListItem(hier_requirement, "0"));

            string hier_app_change = HttpContext.GetLocalResourceObject("~/admin/F018.ApprovalHierarchy.aspx", "HIER_APP_CHANGE", culture).ToString();
            sel.Items.Add(new ListItem(hier_app_change, "1"));
        }

        private void bindApprovalGrid()
        {
            this.allApprovalHierachy = this.ahDAO.getAllApprovalHierachy(false);
            if (!ValidationUtil.isEmpty(this.txtSearchText.Text))
            {
                string searchText = this.txtSearchText.Text.Trim().ToLower();

                switch (this.selSearchType.SelectedIndex)
                {
                    case 0:
                        this.allApprovalHierachy = this.allApprovalHierachy.Where(o => o.code != null && o.code.Trim().ToLower().IndexOf(searchText) >= 0)
                                                     .OrderBy(o => o.code)
                                                     .ToList();
                        break;
                    case 1:
                        this.allApprovalHierachy = this.allApprovalHierachy.Where(o => o.description != null && o.description.Trim().ToLower().IndexOf(searchText) >= 0)
                                                     .OrderBy(o => o.description)
                                                     .ToList();
                        break;
                }
            }

            approvalHierachyDatabaseGridView.PageSize = int.Parse(this.txtRowPerPage.Text);
            approvalHierachyDatabaseGridView.DataSource = allApprovalHierachy;
            approvalHierachyDatabaseGridView.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Page.Validate("vsAdditionGroup");
            if (!Page.IsValid)
            {
                return;
            }

            ApprovalHierarchy checkCode = this.ahDAO.findByCode(this.txtCode.Text, false);
            if (checkCode != null)
            {
                string mesg = string.Format(HttpContext.
                                           GetGlobalResourceObject("GlobalResource", "code_in_use", culture)
                                           .ToString(),
                                           this.txtCode.Text);
                this.errorMessages.Add(mesg);
                return;
            }

            ApprovalHierarchy ahAdd = new ApprovalHierarchy();
            switch (this.selApprovalType.SelectedIndex)
            {
                case 0:
                    ahAdd.approval_type = APPROVAL_TYPE.HIER_REQUIREMENT;
                    break;
                case 1:
                    ahAdd.approval_type = APPROVAL_TYPE.HIER_APP_CHANGE;
                    break;
            }
            ahAdd.code = WebUtils.getFieldIfNotNull(txtCode.Text);
            ahAdd.description = WebUtils.getFieldIfNotNull(txtDescription.Text);
            ahAdd.project = pDAO.findByProjectId(long.Parse(selProject.SelectedValue), true);
            ahAdd.isEnabled = true;
            ahAdd.creationDate = DateTime.Now;
            ahAdd.lastUpdate = DateTime.Now;

            this.ahDAO.create(ahAdd);

            string rowPerPage = this.txtRowPerPage.Text;
            WebUtils.ClearControls(this);
            this.txtRowPerPage.Text = rowPerPage;

            this.initForm();
            this.bindApprovalGrid();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
            this.infoMessages.Add(HttpContext.GetGlobalResourceObject("GlobalResource", "successfully_savedRc", culture).ToString());

        }

        protected void approvalHierachyDatabaseGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.approvalHierachyDatabaseGridView.PageIndex = e.NewPageIndex;
            this.bindApprovalGrid();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void approvalHierachyDatabaseGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            this.approvalHierachyDatabaseGridView.EditIndex = e.NewEditIndex;
            this.bindApprovalGrid();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void approvalHierachyDatabaseGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            this.approvalHierachyDatabaseGridView.EditIndex = -1;
            this.bindApprovalGrid();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void approvalHierachyDatabaseGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }

            if (this.allApprovalHierachy == null || e.Row.RowIndex >= this.allApprovalHierachy.Count)
            {
                return;
            }

            ApprovalHierarchy ah = e.Row.DataItem as ApprovalHierarchy;

            Label lblApprovalHierarchyId = e.Row.FindControl("lblApprovalHierarchyId") as Label;
            lblApprovalHierarchyId.Text = ah.id.ToString();

            Label lblGridLastUpdate = e.Row.FindControl("lblGridLastUpdate") as Label;
            lblGridLastUpdate.Text = ah.lastUpdate.ToString("dd/MM/yyyy HH:mm", new CultureInfo("en-US"));

            if ((e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                TextBox txtGrid_Code = e.Row.FindControl("txtGrid_Code") as TextBox;
                TextBox txtGrid_Description = e.Row.FindControl("txtGrid_Description") as TextBox;
                CheckBox chkGrid_Enabled = e.Row.FindControl("chkGrid_Enabled") as CheckBox;
                DropDownList selGridProject = e.Row.FindControl("selGridProject") as DropDownList;
                DropDownList selGridApprovalType = e.Row.FindControl("selGridApprovalType") as DropDownList;

                txtGrid_Code.Text = ah.code;
                txtGrid_Description.Text = ah.description;
                chkGrid_Enabled.Checked = ah.isEnabled;
                populateProject(selGridProject);
                if(ah.project != null)
                {
                    selGridProject.SelectedValue = ah.project.id.ToString();
                }

                populateAppovalType(selGridApprovalType);
                switch (ah.approval_type)
                {
                    case APPROVAL_TYPE.HIER_REQUIREMENT:
                        selGridApprovalType.SelectedIndex = 0;
                        break;
                    case APPROVAL_TYPE.HIER_APP_CHANGE:
                        selGridApprovalType.SelectedIndex = 1;
                        break;
                }
            }
            else
            {
                Label lblGrid_Code = e.Row.FindControl("lblGrid_Code") as Label;
                Label lblGrid_Description = e.Row.FindControl("lblGrid_Description") as Label;
                Label lblGrid_Project = e.Row.FindControl("lblGrid_Project") as Label;
                CheckBox chkGrid_Enabled = e.Row.FindControl("chkGrid_Enabled") as CheckBox;
                Label lblGrid_ApprovalType = e.Row.FindControl("lblGrid_ApprovalType") as Label;

                lblGrid_Code.Text = ah.code;
                lblGrid_Description.Text = ah.description;
                chkGrid_Enabled.Checked = ah.isEnabled;
                lblGrid_Project.Text = ah.project != null ? string.Format("{0} ({1})", ah.project.name, ah.project.code) : "";
                switch (ah.approval_type)
                {
                    case APPROVAL_TYPE.HIER_REQUIREMENT:
                        lblGrid_ApprovalType.Text = HttpContext.GetLocalResourceObject("~/admin/F018.ApprovalHierarchy.aspx", "HIER_REQUIREMENT", culture).ToString();
                        break;
                    case APPROVAL_TYPE.HIER_APP_CHANGE:
                        lblGrid_ApprovalType.Text = HttpContext.GetLocalResourceObject("~/admin/F018.ApprovalHierarchy.aspx", "HIER_APP_CHANGE", culture).ToString();
                        break;
                }
            }
        }

        protected void approvalHierachyDatabaseGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Page.Validate("vsGridEditGroup");

            if (!Page.IsValid)
            {
                return;
            }

            GridViewRow row = this.approvalHierachyDatabaseGridView.Rows[e.RowIndex];
            Label lblApprovalHierarchyId = row.FindControl("lblApprovalHierarchyId") as Label;
            TextBox txtGrid_Code = row.FindControl("txtGrid_Code") as TextBox;
            TextBox txtGrid_Description = row.FindControl("txtGrid_Description") as TextBox;
            CheckBox chkGrid_Enabled = row.FindControl("chkGrid_Enabled") as CheckBox;
            DropDownList selGridProject = row.FindControl("selGridProject") as DropDownList;
            DropDownList selGridApprovalType = row.FindControl("selGridApprovalType") as DropDownList;

            long idToUpsdate = long.Parse(lblApprovalHierarchyId.Text);

            ApprovalHierarchy someone = this.ahDAO.findByCode(txtGrid_Code.Text, false);
            if (someone != null && someone.id != idToUpsdate)
            {
                string mesg = string.Format(HttpContext.
                                           GetGlobalResourceObject("GlobalResource", "code_in_use", culture).ToString(),
                                           txtGrid_Code.Text);
                this.errorMessagesForGrid.Add(mesg);
                return;
            }
            
            ApprovalHierarchy ahEdit = this.ahDAO.findById(idToUpsdate, true);
            switch (selGridApprovalType.SelectedIndex)
            {
                case 0:
                    ahEdit.approval_type = APPROVAL_TYPE.HIER_REQUIREMENT;
                    break;
                case 1:
                    ahEdit.approval_type = APPROVAL_TYPE.HIER_APP_CHANGE;
                    break;
            }
            ahEdit.code = WebUtils.getFieldIfNotNull(txtGrid_Code.Text);
            ahEdit.description = WebUtils.getFieldIfNotNull(txtGrid_Description.Text);
            ahEdit.isEnabled = chkGrid_Enabled.Checked;
            ahEdit.project = pDAO.findByProjectId(long.Parse(selGridProject.SelectedValue), true);
            ahEdit.lastUpdate = DateTime.Now;

            this.ahDAO.update(ahEdit);

            this.approvalHierachyDatabaseGridView.EditIndex = -1;
            this.initForm();
            this.bindApprovalGrid();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
            this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                             "successfully_savedRc",
                                                                             culture)
                                                                             .ToString());
        }

        protected void btnDetail_Command(object sender, CommandEventArgs e)
        {
            string approvalId = e.CommandArgument.ToString();

            Response.Redirect("F018.1.ApprovalHierarchyDetail.aspx?approvalId=" + QueryStringModule.Encrypt(approvalId), true);
        }

        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            long id = long.Parse(e.CommandArgument.ToString());

            ApprovalHierarchy approvalToDelete = this.ahDAO.findById(id, true);

            List<ApprovalHierarchyDetail> ahd = approvalToDelete.details;

            if (ahd != null)
            {
                for (int i = ahd.Count - 1; i >= 0; i--)
                {
                    this.ahdDAO.delete(ahd[i]);
                }
            }

            this.ahDAO.delete(approvalToDelete);

            initForm();
            bindApprovalGrid();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
            this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                            "successfully_deletedRc",
                                                                            culture)
                                                                            .ToString());
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Page.Validate("vsSearchGroup");
            if (!Page.IsValid)
            {
                return;
            }
            bindApprovalGrid();
        }
    }
}