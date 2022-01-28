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
    public partial class F018__1_ApprovalHierarchyDetail : System.Web.UI.Page
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
        private UserAccountDAO usDAO;
        private CompanyDAO comDAO;

        protected StaffAccount currentStaff;
        private List<ApprovalHierarchyDetail> allApprovalDetail;

        public F018__1_ApprovalHierarchyDetail() : base()
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
            usDAO = new UserAccountDAO(ctx);
            comDAO = new CompanyDAO(ctx);

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

            if (ValidationUtil.isEmpty(Request.QueryString["approvalId"]))
            {
                Response.Redirect("F018.ApprovalHierarchy.aspx", true);
                return;
            }

            this.hndApprovalId.Value = QueryStringModule.Decrypt(Request.QueryString["approvalId"]);
            initForm();
            bindApprovalHierarchyDetailGrid();
        }

        private void initForm()
        {
            ApprovalHierarchy ahData = this.ahDAO.findById(long.Parse(this.hndApprovalId.Value), false);
        
            populatebuTitle(selUserAccount, 0);

            this.lblCode.Text = string.Format("{0}", ahData.code);
            List<ApprovalHierarchyDetail> ahdUpdate = ahData.details;

            for (int i = 0; i < ahdUpdate.Count; i++)
            {
                ApprovalHierarchyDetail ahdEdit = this.ahdDAO.findById(ahdUpdate[i].id, true);
                ahdEdit.authority = i + 1;
                ahdEdit.lastUpdate = DateTime.Now;
                this.ahdDAO.update(ahdEdit);
            }

            if (ValidationUtil.isEmpty(selUserAccount.SelectedValue))
            {
                selUserAccount.Enabled = false;
                btnAdd.Enabled = false;
            }
            else
            {
                selUserAccount.Enabled = true;
                btnAdd.Enabled = true;
                btnAdd.Text = "Add";
            }
        }

        private void populatebuCompany(DropDownList sel)
        {
            sel.Items.Clear();
            List<Company> allCompany = comDAO.getAllEnabledCompanies(false);
            foreach(Company com in allCompany)
            {
                ListItem li = new ListItem(string.Format("{0} ({1})", com.name, com.code), com.id.ToString());
                sel.Items.Add(li);
            }
        }

        private void populatebuTitle(DropDownList sel, long exceptId)
        {
            sel.Items.Clear();
            ApprovalHierarchy ahData = this.ahDAO.findById(long.Parse(this.hndApprovalId.Value), false);

            List<UserAccount> userEnabled = ahData.project.company.users.Where(u=>u.enabled).ToList();
            for (int i = 0; i < userEnabled.Count; i++)
            {
                ListItem li = new ListItem(string.Format("{0} ({1})", userEnabled[i].firstName, userEnabled[i].empNo), userEnabled[i].id.ToString());
                sel.Items.Add(li);
            }
        }

        private void bindApprovalHierarchyDetailGrid()
        {
            this.allApprovalDetail = this.ahdDAO.getAllApprovalHierachyById(long.Parse(this.hndApprovalId.Value),false);

            ahDetailInDatabaseGridView.DataSource = allApprovalDetail;
            ahDetailInDatabaseGridView.DataBind();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }


        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Page.Validate("vsAdditionGroup");
            if (!Page.IsValid)
            {
                return;
            }

            long userId = long.Parse(selUserAccount.SelectedValue);
            long ahId = long.Parse(this.hndApprovalId.Value);
            
            ApprovalHierarchy ah = this.ahDAO.findById(ahId, false);
            if (ah.isUserExists(userId))
            {
                this.errorMessages.Add(HttpContext.GetLocalResourceObject("~/admin/F018.1.ApprovalHierarchyDetail.aspx",
                                                                                   "job_title_already_exists",
                                                                                    culture).ToString());
                return;
            }
            
            ApprovalHierarchyDetail ahd = new ApprovalHierarchyDetail();
            ahd.userAccount = this.usDAO.findById(userId, true);
            ahd.approvalHierachy = this.ahDAO.findById(ahId, true);
            ahd.creationDate = DateTime.Now;
            ahd.lastUpdate = DateTime.Now;
            ahd.isEnabled = true;

            this.ahdDAO.create(ahd);

            WebUtils.ClearControls(this);
            this.initForm();
            this.bindApprovalHierarchyDetailGrid();

            this.infoMessages.Add(HttpContext.GetGlobalResourceObject("GlobalResource", "successfully_savedRc", culture).ToString());
        }

        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            long id = long.Parse(e.CommandArgument.ToString());

            ApprovalHierarchyDetail approvalDetailToDelete = this.ahdDAO.findById(id, true);
            approvalDetailToDelete.isEnabled = false;
            this.ahdDAO.update(approvalDetailToDelete);

            initForm();
            bindApprovalHierarchyDetailGrid();
            this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                            "successfully_deletedRc",
                                                                            culture)
                                                                            .ToString());
        }

        protected void ahDetailInDatabaseGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            this.ahDetailInDatabaseGridView.EditIndex = e.NewEditIndex;
            bindApprovalHierarchyDetailGrid();
        }

        protected void ahDetailInDatabaseGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            this.ahDetailInDatabaseGridView.EditIndex = -1;
            bindApprovalHierarchyDetailGrid();
        }

        protected void ahDetailInDatabaseGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }

            if (this.allApprovalDetail == null || e.Row.RowIndex >= this.allApprovalDetail.Count)
            {
                return;
            }

            ApprovalHierarchyDetail ahdData = e.Row.DataItem as ApprovalHierarchyDetail;

            Label lblApproDetailId = e.Row.FindControl("lblApproDetailId") as Label;
            lblApproDetailId.Text = ahdData.id.ToString();
            Label lblGrid_Authority = e.Row.FindControl("lblGrid_Authority") as Label;


            lblGrid_Authority.Text = ahdData.authority.ToString();

            if ((e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                DropDownList selGridUserAccount = e.Row.FindControl("selGridUserAccount") as DropDownList;
                populatebuTitle(selGridUserAccount, ahdData.userAccount.id);
                selGridUserAccount.SelectedValue = ahdData.userAccount.id.ToString();
            }
            else
            {
                Label lblGrid_JobTitle = e.Row.FindControl("lblGrid_UserAccount") as Label;

                lblGrid_JobTitle.Text = string.Format("{0} ({1})",ahdData.userAccount.firstName , ahdData.userAccount.empNo);
            }
        }

        protected void ahDetailInDatabaseGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Page.Validate("vsGridEditGroup");

            if (!Page.IsValid)
            {
                return;
            }
            GridViewRow row = this.ahDetailInDatabaseGridView.Rows[e.RowIndex];
            Label lblApproDetailId = row.FindControl("lblApproDetailId") as Label;
            DropDownList selGridUserAccount = row.FindControl("selGridUserAccount") as DropDownList;

            long userId = long.Parse(selGridUserAccount.SelectedValue);


            long ahdId = long.Parse(lblApproDetailId.Text);
            ApprovalHierarchyDetail ahdEdit = this.ahdDAO.findById(ahdId, true);
            ahdEdit.userAccount = this.usDAO.findById(userId, true);

            this.ahdDAO.update(ahdEdit);
            this.ahDetailInDatabaseGridView.EditIndex = -1;

            this.initForm();
            this.bindApprovalHierarchyDetailGrid();

            this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                             "successfully_savedRc",
                                                                             culture)
                                                                             .ToString());
        }

        protected void btnGoBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("F018.ApprovalHierarchy.aspx", true);
        }

        protected void selCompany_SelectedIndexChanged(object sender, EventArgs e)
        {
            initForm();
            bindApprovalHierarchyDetailGrid();
        }
    }
}