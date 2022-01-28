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
using XenDevWeb.view;

namespace XenDevWeb.public_pages
{
	public partial class F032_NewProject : System.Web.UI.Page
    {
        public XenDevWebDbContext ctx;
        private EstimationRequestDAO erDAO;
        private ReportDAO rDAO;

        protected CultureInfo culture;
        protected List<string> errorMessages;
        protected List<string> infoMessages;
        protected List<string> errorMessagesForGrid;
        protected List<string> infoMessagesForGrid;

        public List<string> errorMessagesForAddReport;
        public List<string> infoMessagesForForAddReport;

        public F032_NewProject() : base()
        {
            culture = CultureInfo.CreateSpecificCulture(Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName);
            errorMessages = new List<string>();
            infoMessages = new List<string>();
            errorMessagesForGrid = new List<string>();
            infoMessagesForGrid = new List<string>();
            errorMessagesForAddReport = new List<string>();
            infoMessagesForForAddReport = new List<string>();

            this.ctx = new XenDevWebDbContext();
            this.erDAO = new EstimationRequestDAO(ctx);
            this.rDAO = new ReportDAO(ctx);          
        }

        protected override void InitializeCulture()
        {
            string selectedLanguage = Constants.LANGUAGE_TH;

            if (HttpUtility.UrlDecode(Request.QueryString["language"]) != null)
            {
                selectedLanguage = HttpUtility.UrlDecode(Request.QueryString["language"]);
            }

            UICulture = selectedLanguage;
            Culture = selectedLanguage;

            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(selectedLanguage);
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(selectedLanguage);

            culture = CultureInfo.CreateSpecificCulture(Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }
            
            if (Session[Constants.SESSION_ADD_REPORT_CACHE] != null)
            {
                Session.Remove(Constants.SESSION_ADD_REPORT_CACHE);
            }

            Session[Constants.SESSION_ADD_LANGUAGE] = HttpUtility.UrlDecode(Request.QueryString["language"]);

            initForm();
        }

        private void initForm()
        {
            bindReport();
        }

        public void bindReport()
        {
            List<Report> allReports = getReportCache();

            reportInDatabaseGridView.DataSource = allReports;
            reportInDatabaseGridView.DataBind();
            
        }

        private void getAddReportCache(Report erport)
        {
            List<Report> itms;
            if (Session[Constants.SESSION_ADD_REPORT_CACHE] == null)
            {
                itms = new List<Report>();
                Session[Constants.SESSION_ADD_REPORT_CACHE] = itms;
            }
            itms = Session[Constants.SESSION_ADD_REPORT_CACHE] as List<Report>;
            itms.Add(erport);
        }

        private List<Report> getReportCache()
        {
            List<Report> reports = Session[Constants.SESSION_ADD_REPORT_CACHE] as List<Report>;
            return reports;
        }

        private void getUpdateReportCache(Report report, int id)
        {
            List<Report> itms = getReportCache();
            Report item = itms[id];
            if (item != null)
            {
                item.name = report.name;
                item.description = report.description;
            }
        }

        protected void reportInDatabaseGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.reportInDatabaseGridView.PageIndex = e.NewPageIndex;
            bindReport();
        }

        protected void reportInDatabaseGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }
            
            Report report = e.Row.DataItem as Report;
           
            if ((e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                TextBox txtGridReport_Name = e.Row.FindControl("txtGridReport_Name") as TextBox;
                TextBox txtGridReport_Description = e.Row.FindControl("txtGridReport_Description") as TextBox;

                txtGridReport_Name.Text = report.name;
                txtGridReport_Description.Text = report.description;
            }
            else
            {
                Label lblGridReport_Name = e.Row.FindControl("lblGridReport_Name") as Label;
                Label lblGridReport_Description = e.Row.FindControl("lblGridReport_Description") as Label;

                lblGridReport_Name.Text = report.name;
                lblGridReport_Description.Text = report.description;
            }

        }

        protected void reportInDatabaseGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            this.reportInDatabaseGridView.EditIndex = e.NewEditIndex;
            bindReport();
        }

        protected void reportInDatabaseGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            this.reportInDatabaseGridView.EditIndex = -1;
            bindReport();
        }

        protected void btnAddReport_Click(object sender, EventArgs e)
        {
            Report someoneName = this.rDAO.findByName(this.txtReportName.Text, false);
            if (someoneName != null)
            {
                errorMessagesForGrid.Add(string.Format(HttpContext.GetLocalResourceObject("~/public_pages/F032.NewProject.aspx",
                                                                     "reportNameNoExists",
                                                                     culture).ToString(),
                                                                      this.txtReportName.Text));
                return;
            }

            List<Report> reports = getReportCache();

            if (reports != null)
            {
                Report someoneNameChache = reports.Where(o => o.name.CompareTo(this.txtReportName.Text) == 0).FirstOrDefault();
                if (someoneNameChache != null)
                {
                    errorMessagesForGrid.Add(string.Format(HttpContext.GetLocalResourceObject("~/public_pages/F032.NewProject.aspx",
                                                                         "reportNameNoExists",
                                                                         culture).ToString(),
                                                                          this.txtReportName.Text));
                    return;
                }
            }
            
            string reportName = WebUtils.getFieldIfNotNull(this.txtReportName.Text);
            if (reportName == null)
            {
                return;
            }
            Report report = new Report();
            //report.id = Guid.NewGuid().ToString();
            report.name = reportName;
            report.description = this.txtReportDescription.Text;
            getAddReportCache(report);

            this.txtReportName.Text = null;
            this.txtReportDescription.Text = null;

            initForm();
            bindReport();

            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void reportInDatabaseGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Page.Validate("vsReportEditedGroup");
            if (!Page.IsValid)
            {
                return;
            }

            GridViewRow row = this.reportInDatabaseGridView.Rows[e.RowIndex];
            Label lblId = row.FindControl("lblId") as Label;

            TextBox txtGridReport_Name = row.FindControl("txtGridReport_Name") as TextBox;
            TextBox txtGridReport_Description = row.FindControl("txtGridReport_Description") as TextBox;

            List<Report> rports = getReportCache();

            int id = int.Parse(lblId.Text) - 1;
            Report report = rports[id];

            Report someoneName = this.rDAO.findByName(txtGridReport_Name.Text, false);
            if (someoneName != null && someoneName.name != report.name)
            {
                errorMessagesForGrid.Add(string.Format(HttpContext.GetLocalResourceObject("~/public_pages/F032.NewProject.aspx",
                                                                     "reportNameNoExists",
                                                                     culture).ToString(),
                                                                      txtGridReport_Name.Text));
                return;
            }

            Report someoneNameChache = rports.Where(o => o.name.CompareTo(txtGridReport_Name.Text) == 0).FirstOrDefault();
            if (someoneNameChache != null && someoneNameChache.name != report.name)
            {
                errorMessagesForGrid.Add(string.Format(HttpContext.GetLocalResourceObject("~/public_pages/F032.NewProject.aspx",
                                                                     "reportNameNoExists",
                                                                     culture).ToString(),
                                                                      txtGridReport_Name.Text));
                return;
            }
            
            report.name = txtGridReport_Name.Text;
            report.description = txtGridReport_Description.Text;

            getUpdateReportCache(report, id);

            //Refresh grid
            reportInDatabaseGridView.EditIndex = -1;
            bindReport();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);

        }

        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            string name = e.CommandArgument.ToString();

            List<Report> reports = Session[Constants.SESSION_ADD_REPORT_CACHE] as List<Report>;
            Report report = reports.Where(o => o.name.CompareTo(name) == 0).FirstOrDefault();

            reports.Remove(report);
            Session[Constants.SESSION_ADD_IMAGE_UPLOAD] = report;

            bindReport();

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Page.Validate("vsAdditionReportGroup");
            if (!Page.IsValid)
            {
                return;
            }

            Report someoneProjectName = this.rDAO.findByName(this.txtProjectName.Text, false);
            if (someoneProjectName != null)
            {
                errorMessagesForGrid.Add(string.Format(HttpContext.GetLocalResourceObject("~/public_pages/F032.NewProject.aspx",
                                                                     "projectNameNoExists",
                                                                     culture).ToString(),
                                                                      this.txtProjectName.Text));
                return;
            }

            EstimationRequest er = new EstimationRequest();

            er.companyName = WebUtils.getFieldIfNotNull(this.txtCompanyName.Text);
            er.personName = WebUtils.getFieldIfNotNull(this.txtContactPersonName.Text);
            er.email = WebUtils.getFieldIfNotNull(this.txtContactEmail.Text);
            er.phoneNumber = WebUtils.getFieldIfNotNull(this.txtContactPhoneNumber.Text);
            er.projectName = WebUtils.getFieldIfNotNull(this.txtProjectName.Text);
            er.description = this.txtDescription.Text;
            er.styleWeb = this.chkIsWeb.Checked;
            er.styleMobile = this.chkIsMobile.Checked;
            er.styleDesktop = this.chkIsDesktop.Checked;
            er.inputExcel = this.chkIsExcelUpload.Checked;
            er.inputFile = this.chkIsFileUpload.Checked;
            er.inputFormEntry = this.chkIsFormEntry.Checked;
            er.inputOther = this.chkIsOther.Checked;
            if (this.chkIsOther.Checked == true)
            {
                string other = WebUtils.getFieldIfNotNull(this.txtIsOther.Text);
                if (other == null)
                {
                    this.errorMessages.Add(HttpContext.GetLocalResourceObject("~/public_pages/F032.NewProject.aspx",
                                                                                "pls_enter_other",
                                                                                culture)
                                                                                .ToString());
                    return;
                }
                er.inputOtherDetail = other;
            }

            er.migrateOldDatabase = this.chkIsMigrateFromOldDatabase.Checked;
            er.migrateExcel = this.chkIsMigrateFromExcel.Checked;
            er.migrateOther = this.chkIsMigrateFromOther.Checked;
            if (this.chkIsMigrateFromOther.Checked == true)
            {
                string other = WebUtils.getFieldIfNotNull(this.txtIsMigrateFromOther.Text);
                if (other == null)
                {
                    this.errorMessages.Add(HttpContext.GetLocalResourceObject("~/public_pages/F032.NewProject.aspx",
                                                                                "pls_enter_other",
                                                                                culture)
                                                                                .ToString());
                    return;
                }
                er.migrateOtherDetail = other;
            }

            er.mustIntergrate = this.chkIsMustIntegrateToExistingSoftware.Checked;
            er.status = ESTIMATION_STATUS.NEW;
            er.creationDate = DateTime.Now;
            er.lastUpdate = DateTime.Now;

            er.reports = new List<Report>();
            List<Report> reports = getReportCache();

            if (reports != null)
            {
                foreach (Report report in reports)
                {
                    report.creationDate = DateTime.Now;
                    report.lastUpdate = DateTime.Now;
                    er.reports.Add(report);
                }
            }
            
            this.erDAO.create(er);

            if (Session[Constants.SESSION_ADD_REPORT_CACHE] != null)
            {
                Session.Remove(Constants.SESSION_ADD_REPORT_CACHE);
            }

            WebUtils.ClearControls(this);

            //Refresh GUI
            this.initForm();

            this.infoMessages.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                              "successfully_savedRc",
                                                                               culture).ToString());

        }
    }
}