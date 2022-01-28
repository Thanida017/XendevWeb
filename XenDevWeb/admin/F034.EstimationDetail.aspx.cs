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
    public partial class F034_EstimationDetail : CRUDPageControler
    {
        private EstimationRequestDAO erDAO;

        private ReportDAO rDAO;

        public List<string> errorMessagesForUpdate;
        public List<string> infoMessagesForUpdate;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.erDAO = new EstimationRequestDAO(ctx);
            this.rDAO = new ReportDAO(ctx);

            errorMessagesForUpdate = new List<string>();
            infoMessagesForUpdate = new List<string>();

            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            if (ValidationUtil.isEmpty(Request.QueryString["estimationId"]))
            {
                Response.Redirect("F033.EstimationList.aspx", true);
                return;
            }

            this.hndEstimationId.Value = QueryStringModule.Decrypt(HttpUtility.UrlDecode(Request.QueryString["estimationId"]));

            initForm();
        }

        private void initForm()
        {
            EstimationRequest er = this.erDAO.findById(long.Parse(this.hndEstimationId.Value), false);

            this.txtCompanyName.Text = er.companyName;
            this.txtContactPersonName.Text = er.personName;
            this.txtContactEmail.Text = er.personName;
            this.txtContactPhoneNumber.Text = er.phoneNumber;
            this.txtProjectName.Text = er.projectName;
            this.descriptionTextDiv.InnerHtml = er.description;
            this.chkIsWeb.Checked = er.styleWeb;
            this.chkIsMobile.Checked = er.styleMobile;
            this.chkIsDesktop.Checked = er.styleDesktop;
            this.chkIsExcelUpload.Checked = er.inputExcel;
            this.chkIsFormEntry.Checked = er.inputFormEntry;
            this.chkIsFileUpload.Checked = er.inputFile;
            this.chkIsOther.Checked = er.inputOther;
            this.txtIsOther.Text = er.inputOtherDetail;
            this.chkIsMigrateFromOldDatabase.Checked = er.migrateOldDatabase;
            this.chkIsMigrateFromExcel.Checked = er.migrateExcel;
            this.chkIsMigrateFromOther.Checked = er.migrateOther;
            this.txtIsMigrateFromOther.Text = er.migrateOtherDetail;
            this.chkIsMustIntegrateToExistingSoftware.Checked = er.mustIntergrate;

            this.txtCompanyName.Attributes["readonly"] = "readonly";
            this.txtContactPersonName.Attributes["readonly"] = "readonly";
            this.txtContactEmail.Attributes["readonly"] = "readonly";
            this.txtContactPhoneNumber.Attributes["readonly"] = "readonly";
            this.txtProjectName.Attributes["readonly"] = "readonly";
            this.chkIsWeb.Enabled = false;
            this.chkIsMobile.Enabled = false;
            this.chkIsDesktop.Enabled = false;
            this.chkIsExcelUpload.Enabled = false;
            this.chkIsFormEntry.Enabled = false;
            this.chkIsFileUpload.Enabled = false;
            this.chkIsOther.Enabled = false;
            this.txtIsOther.Attributes["readonly"] = "readonly";
            this.chkIsMigrateFromOldDatabase.Enabled = false;
            this.chkIsMigrateFromExcel.Enabled = false;
            this.chkIsMigrateFromOther.Enabled = false;
            this.txtIsMigrateFromOther.Attributes["readonly"] = "readonly";
            this.chkIsMustIntegrateToExistingSoftware.Enabled = false;

            this.txtComment.Text = er.comment;
            populateStatus(selStatus);
            populateDefaultUserStatus(selStatus);

            bindReport();
        }

        public void bindReport()
        {
            List<Report> allReports = this.rDAO.getAllReports(false).Where(o => o.estimationRequest.id == long.Parse(this.hndEstimationId.Value)).ToList();

            reportInDatabaseGridView.DataSource = allReports;
            reportInDatabaseGridView.DataBind();
        }

        public void populateStatus(DropDownList sel)
        {
            sel.Items.Clear();
            
            ListItem liNew = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F034.EstimationDetail.aspx",
                                                                             "New", culture).ToString()
                                                                             , ESTIMATION_STATUS.NEW.ToString());
            sel.Items.Add(liNew);

            ListItem liAccepted = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F034.EstimationDetail.aspx",
                                                                         "Accepted", culture).ToString()
                                                                         , ESTIMATION_STATUS.ACCEPTED.ToString());
            sel.Items.Add(liAccepted);

            ListItem liRejected = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F034.EstimationDetail.aspx",
                                                                             "Rejected", culture).ToString()
                                                                             , ESTIMATION_STATUS.REJECTED.ToString());

            sel.Items.Add(liRejected);

        }

        public void populateDefaultUserStatus(DropDownList sel)
        {
            EstimationRequest er = this.erDAO.findById(long.Parse(this.hndEstimationId.Value), false);
            sel.SelectedValue = er.status.ToString();
        }

        protected void reportInDatabaseGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            reportInDatabaseGridView.PageIndex = e.NewPageIndex;
            bindReport();
        }

        protected void reportInDatabaseGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }

            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }

            Label lblReportId = e.Row.FindControl("lblReportId") as Label;
            Label lblGridReport_Name = e.Row.FindControl("lblGridReport_Name") as Label;
            Label lblGridReport_Description = e.Row.FindControl("lblGridReport_Description") as Label;

            Report report = e.Row.DataItem as Report;

            lblReportId.Text = report.id.ToString();
            lblGridReport_Name.Text = report.name;
            lblGridReport_Description.Text = report.description;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Page.Validate("vsAdditionCommentGroup");
            if (!Page.IsValid)
            {
                return;
            }

            EstimationRequest er = this.erDAO.findById(long.Parse(this.hndEstimationId.Value), false);
            er.comment = this.txtComment.Text;
            
            switch (selStatus.SelectedIndex)
            {
                case 0:
                    er.status = ESTIMATION_STATUS.NEW;
                    break;
                case 1:
                    er.status = ESTIMATION_STATUS.ACCEPTED;
                    break;
                case 2:
                    er.status = ESTIMATION_STATUS.REJECTED;
                    break;
            }

            er.lastUpdate = DateTime.Now;
            this.erDAO.update(er);

            //Clear form
            WebUtils.ClearControls(this);
            initForm();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
            //Notify user
            this.infoMessagesForUpdate.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                             "successfully_savedRc",
                                                                             culture).ToString());

        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/admin/F033.EstimationList.aspx", true);
            return;
        }
    }
}