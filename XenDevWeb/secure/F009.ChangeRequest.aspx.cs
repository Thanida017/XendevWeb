using System;
using System.Collections.Generic;
using System.Globalization;
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
    public partial class F009_ChangeRequest : CRUDPageControler
    {
        private ApplicationChangeDAO appChangDAO;
        private ProjectDAO pjDAO;
        private ApplicationAssetDAO aaDAO;
        private ApplicationChangeTrxDAO acTrxDAO;
        private CompanyDAO comDAO;
        private ApproveUtil approveUtilDAO;

        private List<ApplicationChange> allApplicationChange;

        public const string CHANGECODE = "0";

        protected void Page_Load(object sender, EventArgs e)
        {
            this.appChangDAO = new ApplicationChangeDAO(ctx);
            this.pjDAO = new ProjectDAO(ctx);
            this.aaDAO = new ApplicationAssetDAO(ctx);
            this.acTrxDAO = new ApplicationChangeTrxDAO(ctx);
            this.comDAO = new CompanyDAO(ctx);
            this.approveUtilDAO = new ApproveUtil(ctx);

            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            this.initForm();
            bindChangeReq();
        }

        private void initForm()
        {
            this.txtRowPerPage.Text = Constants.DEFAULT_ROW_PER_PAGE.ToString();
            this.populateCompany(this.selCompany);
            this.populateCompany(this.selSearchCompany);            

            this.txtRequestDate.Text = DateTime.Now.ToString("d/MM/yyyy", culture);
            this.txtSearchRequestDate.Text = DateTime.Now.ToString("d/MM/yyyy", culture);

            this.txtRequestDate.Attributes["readonly"] = "readonly";
            this.txtSearchRequestDate.Attributes["readonly"] = "readonly";

            setDefaultCompanySelection();
            checkChangingCompanyPrivileges();
            this.populateProject(this.selProject, this.selCompany);
            this.populateProject(this.selSearchProject, this.selSearchCompany);
            if (!ValidationUtil.isEmpty(this.selProject.SelectedValue))
            {
                this.populateAppAsset(this.selAppAsset, long.Parse(this.selProject.SelectedValue));             
            }
            this.populateChangeType(this.selChangeType);
        }

        private int getUserCompanyId()
        {
            return this.currentUser != null ? this.currentUser.company.id : 0;
        }

        private void setDefaultCompanySelection()
        {
            Company com = this.comDAO.findById(this.getUserCompanyId(), false);

            if (com != null)
            {
                this.selCompany.SelectedValue = com.id.ToString();
                this.selSearchCompany.SelectedValue = com.id.ToString();
            }
            //this.selCompanyForGrid.SelectedValue = com.id.ToString();
        }


        private void checkChangingCompanyPrivileges()
        {
            if (this.currentUser != null)
            {
                this.divSelCompany.Visible = false;
                this.divSelSearchCompany.Visible = false;
                //this.pnlSelCompanyForGrid.Visible = false;
            }
            else
            {
                this.divSelCompany.Visible = true;
                this.divSelSearchCompany.Visible = true;
            }
        }

        private void populateCompany(DropDownList sel)
        {
            sel.Items.Clear();

            List<Company> coms = this.comDAO.getAllEnabledCompanies(false)
                                                    .OrderBy(o => o.name)
                                                    .ToList();
            foreach (Company com in coms)
            {
                ListItem li = new ListItem(com.name, com.id.ToString());
                sel.Items.Add(li);
            }
        }


        private void populateTitle(DropDownList sel)
        {
            sel.Items.Clear();

            ListItem li = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F009.ChangeRequest.aspx",
                                                                                   "lblChangeCodeRc.text",
                                                                                    culture).ToString(), CHANGECODE);
            sel.Items.Add(li);

        }

        private void populateProject(DropDownList sel, DropDownList selCompany)
        {
            sel.Items.Clear();

            if (ValidationUtil.isEmpty(selCompany.SelectedValue))
            {
                return;
            }

            List<Project> pjs =this.pjDAO.getCompanyProject(long.Parse(selCompany.SelectedValue), false)
                                                    .OrderBy(o => o.name)
                                                    .ToList();

            foreach(Project pj in pjs)
            {
                ListItem li = new ListItem(string.Format("{0} ({1})", pj.name, pj.code), pj.id.ToString());
                sel.Items.Add(li);
            }
        }

        private void populateAppAsset(DropDownList sel,long projectId)
        {
            sel.Items.Clear();

            Project pj = pjDAO.findByProjectId(projectId, false);

            if (pj != null && pj.applicationAssets.Count >0)
            {
                foreach(ApplicationAsset aa in pj.applicationAssets)
                {
                    if (aa.enabled)
                    {
                        ListItem li = new ListItem(aa.assetFileName, aa.id.ToString());

                        sel.Items.Add(li);
                    }                    
                }
            }
        }

        private void populateChangeType(DropDownList sel)
        {
            sel.Items.Clear();

            ListItem li = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F009.ChangeRequest.aspx"
                                                                            , "NEW_FEATURE", culture).ToString()
                                                                            , CHANGE_TYPE.NEW_FEATURE.ToString());
            sel.Items.Add(li);

           li = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F009.ChangeRequest.aspx"
                                                                            , "BUG", culture).ToString()
                                                                            , CHANGE_TYPE.BUG.ToString());
            sel.Items.Add(li);

            li = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F009.ChangeRequest.aspx"
                                                                            , "CUSTOMER_REQUIREMENT_CHANGE", culture).ToString()
                                                                            , CHANGE_TYPE.CUSTOMER_REQUIREMENT_CHANGE.ToString());
            sel.Items.Add(li);

            li = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F009.ChangeRequest.aspx"
                                                                            , "DEV_DESIGN_CHANGE", culture).ToString()
                                                                            , CHANGE_TYPE.DEV_DESIGN_CHANGE.ToString());
            sel.Items.Add(li);

            li = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F009.ChangeRequest.aspx"
                                                                            , "BUSINESS_CHANGE", culture).ToString()
                                                                            , CHANGE_TYPE.BUSINESS_CHANGE.ToString());
            sel.Items.Add(li);
        }

        protected void selProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            populateAppAsset(this.selAppAsset, long.Parse(this.selProject.SelectedValue));
        }

        private void bindChangeReq()
        {
            if (!ValidationUtil.isEmpty(this.selSearchProject.SelectedValue))
            {
                this.allApplicationChange = appChangDAO.getAllApplicationChange(false, long.Parse(selSearchProject.SelectedValue));

                if (!ValidationUtil.isEmpty(this.txtSearchGridText.Text)){

                    this.allApplicationChange = this.allApplicationChange.Where(e => e.changeCode != null && e.changeCode.Trim().ToLower()
                                                                                            .IndexOf(this.txtSearchGridText.Text.Trim().ToLower()) >= 0)
                                                                                           .ToList();
                }
                DateTime requestDate = DateTime.ParseExact(txtSearchRequestDate.Text, "d/MM/yyyy", culture);

                this.allApplicationChange = this.allApplicationChange.Where(e => e.changeCode != null && e.changeCode.Trim().ToLower()
                                                                                        .IndexOf(this.txtSearchGridText.Text.Trim().ToLower()) >= 0
                                                                                        && e.requestDate.Date == requestDate.Date && e.requestDate.Month == requestDate.Month
                                                                                        && e.requestDate.Year == requestDate.Year)
                                                                                       .ToList();
            }
            changReqGridView.PageSize = int.Parse(this.txtRowPerPage.Text);
            changReqGridView.DataSource = this.allApplicationChange;
            changReqGridView.DataBind();
            
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Page.Validate("vsSearchGroup");
            if (!Page.IsValid)
            {
                return;
            }

            bindChangeReq();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Page.Validate("vsAdditionGroup");
            if (!Page.IsValid)
            {
                return;
            }

            ApplicationChange acCheck = appChangDAO.findByCode(this.txtChangeCode.Text, false);

            if (acCheck != null)
            {
                errorMessages.Add(string.Format(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                 "code_in_use",
                                                                 culture).ToString(),
                                            this.txtChangeCode.Text));
                return;
            }

            ApplicationChange ac = new ApplicationChange();
            ac.changeCode = WebUtils.getFieldIfNotNull(this.txtChangeCode.Text);

            string selectedValue = this.selChangeType.SelectedValue;
            if (selectedValue.CompareTo(CHANGE_TYPE.NEW_FEATURE.ToString()) == 0)
            {
                ac.changeType = CHANGE_TYPE.NEW_FEATURE;
            }
            else if (selectedValue.CompareTo(CHANGE_TYPE.BUG.ToString()) == 0)
            {
                ac.changeType = CHANGE_TYPE.BUG;
            }
            else if (selectedValue.CompareTo(CHANGE_TYPE.CUSTOMER_REQUIREMENT_CHANGE.ToString()) == 0)
            {
                ac.changeType = CHANGE_TYPE.CUSTOMER_REQUIREMENT_CHANGE;
            }
            else if (selectedValue.CompareTo(CHANGE_TYPE.DEV_DESIGN_CHANGE.ToString()) == 0)
            {
                ac.changeType = CHANGE_TYPE.DEV_DESIGN_CHANGE;
            }
            else if (selectedValue.CompareTo(CHANGE_TYPE.BUSINESS_CHANGE.ToString()) == 0)
            {
                ac.changeType = CHANGE_TYPE.BUSINESS_CHANGE;
            }

            if(this.currentUser != null)
            {
                ac.createdBy = this.uaDAO.findByUsername(this.currentUser.username, true);
            }

            ApplicationAsset aa = aaDAO.findById(long.Parse(selAppAsset.SelectedValue), true);
            ac.appAsset = aa;
            DateTime requestDate = DateTime.ParseExact(txtRequestDate.Text, "d/MM/yyyy", culture);
            ac.requestDate = requestDate;
            ac.manDays = double.Parse(WebUtils.getFieldIfNotNull(this.txtManday.Text));
            ac.creationDate = DateTime.Now;
            ac.lastUpdate = DateTime.Now;
            appChangDAO.create(ac);

            ApplicationChangeTrx acTrx = approveUtilDAO.getNextAppChangeApprover(ac);
            acTrxDAO.create(acTrx);

            this.txtChangeCode.Text = string.Empty;

            bindChangeReq();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
            this.infoMessages.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                            "successfully_savedRc",
                                                                            culture).ToString());

        }

        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            long idToDelete = long.Parse(e.CommandArgument.ToString());

            ApplicationChange acDelete = appChangDAO.findById(idToDelete, true);

            try
            {
                appChangDAO.delete(acDelete);
                bindChangeReq();
                this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource", "successfully_savedRc", culture).ToString());
            }
            catch(Exception ex)
            {
                this.errorMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource", "dataIsUse", culture).ToString());
            }
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void changReqGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            changReqGridView.PageIndex = e.NewPageIndex;
            bindChangeReq();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void changReqGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            changReqGridView.EditIndex = e.NewEditIndex;
            bindChangeReq();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void changReqGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Page.Validate("vsEditGroup");
            if (!Page.IsValid)
            {
                return;
            }

            GridViewRow row = this.changReqGridView.Rows[e.RowIndex];
            Label lblChangReq_Id = row.FindControl("lblChangReq_Id") as Label;
            DropDownList selGrid_AppAsset = row.FindControl("selGrid_AppAsset") as DropDownList;
            DropDownList selGrid_ChangeType = row.FindControl("selGrid_ChangeType") as DropDownList;
            TextBox txtGrid_ChangeCode = row.FindControl("txtGrid_ChangeCode") as TextBox;
            TextBox txtGrid_RequestDate = row.FindControl("txtGrid_RequestDate") as TextBox;
            TextBox txtGrid_mandays = row.FindControl("txtGrid_mandays") as TextBox;

            long idToUpdate = long.Parse(lblChangReq_Id.Text);

            ApplicationChange acCheck = appChangDAO.findByCode(txtGrid_ChangeCode.Text, false);

            if (acCheck != null && acCheck.id != idToUpdate)
            {
                errorMessagesForGrid.Add(string.Format(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                 "code_in_use",
                                                                 culture).ToString(),
                                            txtGrid_ChangeCode.Text));
                return;
            }

            ApplicationChange acUpdate = appChangDAO.findById(idToUpdate, true);
            DateTime requestDate = DateTime.ParseExact(txtGrid_RequestDate.Text, "d/MM/yyyy", new CultureInfo("en-US"));
            acUpdate.requestDate = requestDate;
            acUpdate.appAsset = aaDAO.findById(long.Parse(selGrid_AppAsset.SelectedValue), true);
            string selectedValue = selGrid_ChangeType.SelectedValue;
            if (selectedValue.CompareTo(CHANGE_TYPE.NEW_FEATURE.ToString()) == 0)
            {
                acUpdate.changeType = CHANGE_TYPE.NEW_FEATURE;
            }
            else if(selectedValue.CompareTo(CHANGE_TYPE.BUG.ToString()) == 0)
            {
                acUpdate.changeType = CHANGE_TYPE.BUG;
            }
            else if (selectedValue.CompareTo(CHANGE_TYPE.CUSTOMER_REQUIREMENT_CHANGE.ToString()) == 0)
            {
                acUpdate.changeType = CHANGE_TYPE.CUSTOMER_REQUIREMENT_CHANGE;
            }
            else if (selectedValue.CompareTo(CHANGE_TYPE.DEV_DESIGN_CHANGE.ToString()) == 0)
            {
                acUpdate.changeType = CHANGE_TYPE.DEV_DESIGN_CHANGE;
            }
            else if (selectedValue.CompareTo(CHANGE_TYPE.BUSINESS_CHANGE.ToString()) == 0)
            {
                acUpdate.changeType = CHANGE_TYPE.BUSINESS_CHANGE;
            }
            acUpdate.changeCode = txtGrid_ChangeCode.Text;
            acUpdate.manDays = double.Parse(WebUtils.getFieldIfNotNull(txtGrid_mandays.Text));
            appChangDAO.update(acUpdate);
            changReqGridView.EditIndex = -1;
            bindChangeReq();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
            this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                            "successfully_savedRc",
                                                                            culture).ToString());
        }

        protected void changReqGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            changReqGridView.EditIndex = -1;
            bindChangeReq();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void changReqGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }

            ApplicationChange obj = e.Row.DataItem as ApplicationChange;

            Label lblChangReq_Id = e.Row.FindControl("lblChangReq_Id") as Label;
            Label lblGrid_LastUpdate = e.Row.FindControl("lblGrid_LastUpdate") as Label;

            lblChangReq_Id.Text = obj.id.ToString();
            lblGrid_LastUpdate.Text = string.Format(obj.lastUpdate.ToString("dd/MM/yyyy", new CultureInfo("en-Us")));

            if ((e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                DropDownList selGrid_AppAsset = e.Row.FindControl("selGrid_AppAsset") as DropDownList;
                DropDownList selGrid_ChangeType = e.Row.FindControl("selGrid_ChangeType") as DropDownList;
                TextBox txtGrid_ChangeCode = e.Row.FindControl("txtGrid_ChangeCode") as TextBox;
                TextBox txtGrid_RequestDate = e.Row.FindControl("txtGrid_RequestDate") as TextBox;
                TextBox txtGrid_mandays = e.Row.FindControl("txtGrid_mandays") as TextBox;

                populateAppAsset(selGrid_AppAsset, obj.appAsset.project.id);
                populateChangeType(selGrid_ChangeType);
                selGrid_AppAsset.SelectedValue = obj.appAsset.id.ToString();
                selGrid_ChangeType.SelectedValue = obj.changeType.ToString();
                txtGrid_ChangeCode.Text = obj.changeCode;
                txtGrid_RequestDate.Text = string.Format(obj.requestDate.ToString("d/MM/yyyy", new CultureInfo("en-Us")));
                txtGrid_RequestDate.Attributes["readonly"] = "readonly";
                txtGrid_mandays.Text = obj.manDays.ToString();
            }
            else
            {
                Label lblGrid_AppAsset = e.Row.FindControl("lblGrid_AppAsset") as Label;
                Label lblGrid_ChangeType = e.Row.FindControl("lblGrid_ChangeType") as Label;
                Label lblGrid_ChangeCode = e.Row.FindControl("lblGrid_ChangeCode") as Label;
                Label lblGrid_RequestDate = e.Row.FindControl("lblGrid_RequestDate") as Label;
                Label lblGrid__mandays = e.Row.FindControl("lblGrid__mandays") as Label;

                lblGrid_RequestDate.Text = string.Format(obj.requestDate.ToString("d/MM/yyyy", new CultureInfo("en-Us")));

                switch (obj.changeType)
                {
                    case CHANGE_TYPE.NEW_FEATURE:
                        lblGrid_ChangeType.Text = HttpContext.GetLocalResourceObject("~/secure/F009.ChangeRequest.aspx"
                                                                            , "NEW_FEATURE", culture).ToString();
                        break;
                    case CHANGE_TYPE.BUG:
                        lblGrid_ChangeType.Text = HttpContext.GetLocalResourceObject("~/secure/F009.ChangeRequest.aspx"
                                                                            , "BUG", culture).ToString();
                        break;
                    case CHANGE_TYPE.CUSTOMER_REQUIREMENT_CHANGE:
                        lblGrid_ChangeType.Text = HttpContext.GetLocalResourceObject("~/secure/F009.ChangeRequest.aspx"
                                                                           , "CUSTOMER_REQUIREMENT_CHANGE", culture).ToString();
                        break;
                    case CHANGE_TYPE.DEV_DESIGN_CHANGE:
                        lblGrid_ChangeType.Text = HttpContext.GetLocalResourceObject("~/secure/F009.ChangeRequest.aspx"
                                                                           , "DEV_DESIGN_CHANGE", culture).ToString();
                        break;
                    case CHANGE_TYPE.BUSINESS_CHANGE:
                        lblGrid_ChangeType.Text = HttpContext.GetLocalResourceObject("~/secure/F009.ChangeRequest.aspx"
                                                                           , "BUSINESS_CHANGE", culture).ToString();
                        break;
                }

                lblGrid__mandays.Text = string.Format("{0:n0}", obj.manDays);
                lblGrid_AppAsset.Text = obj.appAsset.assetFileName;
                lblGrid_ChangeCode.Text = obj.changeCode;

            }
        }

        protected void btnChangeTrx_Command(object sender, CommandEventArgs e)
        {
            string acID = e.CommandArgument.ToString();

            Response.Redirect("F009.1.ChangeRequestDetails.aspx?acId=" + HttpUtility.UrlEncode(QueryStringModule.Encrypt(acID)), true);      
            
        }

        protected void selCompany_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.populateProject(this.selProject, this.selCompany);
            selProject_SelectedIndexChanged(null, null);
        }

        protected void SelSearchCompany_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.populateProject(this.selSearchProject, this.selSearchCompany);
        }
    }
}