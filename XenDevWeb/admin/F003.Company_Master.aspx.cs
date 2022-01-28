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
    public partial class F003_Company_Master : CRUDPageControler
    {        
        private CompanyDAO comDAO;

        private List<Company> companies;

        protected void Page_Load(object sender, EventArgs e)
        {
            uaDAO = new UserAccountDAO(ctx);
            comDAO = new CompanyDAO(ctx);

            culture = CultureInfo.CreateSpecificCulture(Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName);

            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            this.initForm();
            
        }

        private void initForm()
        {
            populateTitle(this.selTitle);
            this.txtRowPerPage.Text = Constants.DEFAULT_ROW_PER_PAGE.ToString();
            populateSearchType();
            this.bindCompanyGrids();
            this.chkEnable.Checked = true;
        }
        
        public void populateTitle(DropDownList sel)
        {
            sel.Items.Clear();

            ListItem liCo_Ltd = new ListItem(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                             "co_Ltd",
                                                                             culture).ToString(), "0");
            sel.Items.Add(liCo_Ltd);

            ListItem liPub_Co_Ltd = new ListItem(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                            "pub_Co_Ltd",
                                                                            culture).ToString(), "1");
            sel.Items.Add(liPub_Co_Ltd);

            ListItem liPart_Ltd = new ListItem(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                            "part_Ltd",
                                                                            culture).ToString(), "2");
            sel.Items.Add(liPart_Ltd);

            ListItem liLEGAL_PERSON = new ListItem(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                            "legal_person",
                                                                            culture).ToString(), "3");
            sel.Items.Add(liLEGAL_PERSON);
        }

        private void populateSearchType()
        {
            this.selGridSearchType.Items.Clear();

            ListItem liComCode = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F003.Company_Master.aspx",
                                                                                   "lblCompanyCodeRc.text",
                                                                                    culture).ToString(), "0");
            this.selGridSearchType.Items.Add(liComCode);
            ListItem liComName = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F003.Company_Master.aspx",
                                                                                  "lblCompanyNameRc.text",
                                                                                   culture).ToString(), "1");
            this.selGridSearchType.Items.Add(liComName);
            ListItem liComNameEng = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F003.Company_Master.aspx",
                                                                                  "lblCompanyNameEngRc.text",
                                                                                   culture).ToString(), "2");
            this.selGridSearchType.Items.Add(liComNameEng);

        }
        
        protected void btnAddCompany_Click(object sender, EventArgs e)
        {
            Page.Validate("vsCompanyAdditionGroup");
            if (!Page.IsValid)
            {
                return;
            }

            //Check existing company code
            if (this.comDAO.findByCode(this.txtCompanyCode.Text, false) != null)
            {
                errorMessages.Add(string.Format(HttpContext.GetLocalResourceObject("~/admin/F003.Company_Master.aspx",
                                                                     "compCodeExists",
                                                                     culture).ToString(),
                                                this.txtCompanyCode.Text));
                return;
            }

            //Check existing tax id
            if (this.comDAO.findByTaxId(this.txtTaxId.Text, false) != null)
            {
                errorMessages.Add(string.Format(HttpContext.GetLocalResourceObject("~/admin/F003.Company_Master.aspx",
                                                                     "taxIdExists",
                                                                     culture).ToString(),
                                                this.txtTaxId.Text));
                return;
            }
            
            //Lets go create
            Company com = new Company();
            com.code = this.txtCompanyCode.Text.Trim();
            com.name = this.txtCompanyName.Text.Trim();
            com.nameEng = this.txtCompanyNameEng.Text.Trim();
            com.taxId = this.txtTaxId.Text.Trim();
            com.enabled = true;
            com.creationDate = DateTime.Now;
            com.lastUpdate = DateTime.Now;
            switch (this.selTitle.SelectedValue)
            {
                case "0":
                    com.title = TITLE.COMPANY_LIMITTED;
                    break;
                case "1":
                    com.title = TITLE.PUBLIC_COMPANY_LIMITTED;
                    break;
                case "2":
                    com.title = TITLE.PARTNERSHIP_LIMITTED;
                    break;
                case "3":
                    com.title = TITLE.LEGAL_PERSON;
                    break;
            }
            

            this.comDAO.create(com);

           

            string rowPerPage = this.txtRowPerPage.Text;
            //Clear form
            WebUtils.ClearControls(this);
            this.txtRowPerPage.Text = rowPerPage;
            this.bindCompanyGrids();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
            //Notify user
            this.infoMessages.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                       "successfully_savedRc",
                                                                       culture).ToString());
        }
        
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Page.Validate("vsSearchGroup");
            if (!Page.IsValid)
            {
                return;
            }
            this.bindCompanyGrids();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void companyGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.companyGridView.PageIndex = e.NewPageIndex;
            bindCompanyGrids();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void companyGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            this.companyGridView.EditIndex = e.NewEditIndex;
            bindCompanyGrids();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void companyGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Page.Validate("vsCompanyEditGroup");
            if (!Page.IsValid)
            {
                return;
            }

            GridViewRow row = this.companyGridView.Rows[e.RowIndex];
            Label lblCompanyGrid_Id = row.FindControl("lblCompanyGrid_Id") as Label;

            DropDownList selGrid_Title = row.FindControl("selGrid_Title") as DropDownList;

            TextBox txtCompanyGridView_CompCode = row.FindControl("txtCompanyGridView_CompCode") as TextBox;
            TextBox txtCompanyGridView_CompName = row.FindControl("txtCompanyGridView_CompName") as TextBox;
            TextBox txtCompanyGridView_CompNameEng = row.FindControl("txtCompanyGridView_CompNameEng") as TextBox;
            TextBox txtCompanyGridView_TaxId = row.FindControl("txtCompanyGridView_TaxId") as TextBox;

            CheckBox chkCompanyGrid_IsEnabled = row.FindControl("chkCompanyGrid_IsEnabled") as CheckBox;

            long companyToUpdateId = long.Parse(lblCompanyGrid_Id.Text);

            Company someone = this.comDAO.findByCode(txtCompanyGridView_CompCode.Text, false);
            if (someone != null && someone.id != companyToUpdateId)
            {
                string mesg = string.Format(HttpContext.
                                           GetGlobalResourceObject("GlobalResource", "code_in_use", culture).ToString(),
                                           txtCompanyGridView_CompCode.Text);
                this.errorMessagesForGrid.Add(mesg);
                return;

            }

            Company obj = this.comDAO.findById(companyToUpdateId, true);
            
            switch (selGrid_Title.SelectedIndex)
            {
                case 0:
                    obj.title = TITLE.COMPANY_LIMITTED;
                    break;
                case 1:
                    obj.title = TITLE.PUBLIC_COMPANY_LIMITTED;
                    break;
                case 2:
                    obj.title = TITLE.PARTNERSHIP_LIMITTED;
                    break;
                case 3:
                    obj.title = TITLE.LEGAL_PERSON;
                    break;
            }

            obj.code = WebUtils.getFieldIfNotNull(txtCompanyGridView_CompCode.Text);
            obj.name = WebUtils.getFieldIfNotNull(txtCompanyGridView_CompName.Text);
            obj.nameEng = WebUtils.getFieldIfNotNull(txtCompanyGridView_CompNameEng.Text);
            obj.taxId = WebUtils.getFieldIfNotNull(txtCompanyGridView_TaxId.Text);

            obj.enabled = chkCompanyGrid_IsEnabled.Checked;

            obj.lastUpdate = DateTime.Now;

            this.comDAO.update(obj);

            //Refresh GUI
            this.companyGridView.EditIndex = -1;
            this.bindCompanyGrids();

            //Give user feedback
            this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                             "successfully_savedRc",
                                                                             culture)
                                                                             .ToString());

            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void companyGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            this.companyGridView.EditIndex = -1;
            bindCompanyGrids();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void companyGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }

            if (this.companies == null || e.Row.RowIndex >= this.companies.Count)
            {
                return;
            }
            
            Company com = e.Row.DataItem as Company;
            Label lblCompanyGrid_Id = e.Row.FindControl("lblCompanyGrid_Id") as Label;
            Label lblCompanyGridView_LastUpdate = e.Row.FindControl("lblCompanyGridView_LastUpdate") as Label;

            lblCompanyGrid_Id.Text = com.id.ToString();
            lblCompanyGridView_LastUpdate.Text = string.Format(com.lastUpdate.ToString("dd/MM/yyyy HH:mm", new CultureInfo("en-Us")));

            if ((e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                DropDownList selGrid_Title = e.Row.FindControl("selGrid_Title") as DropDownList;

                TextBox txtCompanyGridView_CompCode = e.Row.FindControl("txtCompanyGridView_CompCode") as TextBox;
                TextBox txtCompanyGridView_CompName = e.Row.FindControl("txtCompanyGridView_CompName") as TextBox;
                TextBox txtCompanyGridView_CompNameEng = e.Row.FindControl("txtCompanyGridView_CompNameEng") as TextBox;
                TextBox txtCompanyGridView_TaxId = e.Row.FindControl("txtCompanyGridView_TaxId") as TextBox;

                CheckBox chkCompanyGrid_IsEnabled = e.Row.FindControl("chkCompanyGrid_IsEnabled") as CheckBox;

                populateTitle(selGrid_Title);
                switch (com.title)
                {
                    case TITLE.COMPANY_LIMITTED:
                        selGrid_Title.SelectedIndex = 0;
                        break;
                    case TITLE.PUBLIC_COMPANY_LIMITTED:
                        selGrid_Title.SelectedIndex = 1;
                        break;
                    case TITLE.PARTNERSHIP_LIMITTED:
                        selGrid_Title.SelectedIndex = 2;
                        break;
                    case TITLE.LEGAL_PERSON:
                        selGrid_Title.SelectedIndex = 3;
                        break;
                }

                chkCompanyGrid_IsEnabled.Checked = com.enabled;
                txtCompanyGridView_CompCode.Text = com.code;
                txtCompanyGridView_CompName.Text = com.name;
                txtCompanyGridView_CompNameEng.Text = com.nameEng;
                txtCompanyGridView_TaxId.Text = com.taxId;
            }
            else
            {
                Label lblCompanyGridView_CompCode = e.Row.FindControl("lblCompanyGridView_CompCode") as Label;
                Label lblCompanyGridView_CompTitle = e.Row.FindControl("lblCompanyGridView_CompTitle") as Label;
                Label lblCompanyGridView_CompName = e.Row.FindControl("lblCompanyGridView_CompName") as Label;
                Label lblCompanyGridView_CompNameEng = e.Row.FindControl("lblCompanyGridView_CompNameEng") as Label;
                Label lblCompanyGridView_TaxId = e.Row.FindControl("lblCompanyGridView_TaxId") as Label;
                CheckBox chkCompanyGrid_IsEnabled = e.Row.FindControl("chkCompanyGrid_IsEnabled") as CheckBox;

                lblCompanyGridView_CompCode.Text = com.code.ToString();
                lblCompanyGridView_CompName.Text = com.name.ToString();
                lblCompanyGridView_CompNameEng.Text = com.nameEng.ToString();
                lblCompanyGridView_TaxId.Text = com.taxId.ToString();
                chkCompanyGrid_IsEnabled.Checked = com.enabled;

                switch (com.title)
                {
                    case TITLE.COMPANY_LIMITTED:
                        lblCompanyGridView_CompTitle.Text = HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                             "co_Ltd", culture).ToString();
                        break;
                    case TITLE.PUBLIC_COMPANY_LIMITTED:
                        lblCompanyGridView_CompTitle.Text = HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                            "pub_Co_Ltd", culture).ToString();
                        break;
                    case TITLE.PARTNERSHIP_LIMITTED:
                        lblCompanyGridView_CompTitle.Text = HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                            "part_Ltd", culture).ToString();
                        break;
                    case TITLE.LEGAL_PERSON:
                        lblCompanyGridView_CompTitle.Text = HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                            "legal_person", culture).ToString();
                        break;
                }
            }
        }

        private void bindCompanyGrids()
        {
            this.companies = this.comDAO.getAllCompanies(false);

            //Search filter
            if (!ValidationUtil.isEmpty(this.txtSearchGridText.Text) && this.companies != null)
            {
                    switch (this.selGridSearchType.SelectedIndex)
                    {
                        case 0:
                        this.companies = this.companies.Where(o => o.code.ToLower().Trim()
                                                                .IndexOf(this.txtSearchGridText.Text.ToLower().Trim()) >= 0)
                                                                .ToList();
                            break;
                        case 1:
                        this.companies = this.companies.Where(o => o.name.ToLower().Trim()
                                                            .IndexOf(this.txtSearchGridText.Text.ToLower().Trim()) >= 0)
                                                            .ToList();
                        break;
                        case 2:
                        this.companies = this.companies.Where(o => o.nameEng.ToLower().Trim()
                                                            .IndexOf(this.txtSearchGridText.Text.ToLower().Trim()) >= 0)
                                                            .ToList();
                        break;
                }
            }

            //Set grid
            this.companyGridView.PageSize = int.Parse(this.txtRowPerPage.Text);
            this.companyGridView.DataSource = this.companies;
            this.companyGridView.DataBind();
        }

       
        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            long id = long.Parse(e.CommandArgument.ToString());

            Company com = this.comDAO.findById(id, true);

            if ((com.users != null && com.users.Count > 0))
            {
                this.errorMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                                 "dataIsUse",
                                                                                 culture).ToString());
                return;
            }

            this.comDAO.delete(com);

            //Redraw GUI
            this.bindCompanyGrids();

            //Notify
            this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                                 "successfully_deletedRc",
                                                                                 culture).ToString());
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }
    }
}