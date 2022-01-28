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

namespace XenDevWeb.admin
{
    public partial class F008_RejectReasonMaster : CRUDPageControler
    {
        private RejectReasonDAO reDAO;

        private List<RejectReason> allRejectReason;

        public const string CODE = "0";
        public const string NAME = "1";

        protected void Page_Load(object sender, EventArgs e)
        {
            reDAO = new RejectReasonDAO(ctx);
            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            initForm();
            bindRejectReason();

        }

        private void initForm()
        {
            populateSearchBy(this.selSearchBy);
            this.txtRowPerPage.Text = Constants.DEFAULT_ROW_PER_PAGE.ToString();
        }

        private void populateSearchBy(DropDownList sel)
        {
            sel.Items.Clear();

            ListItem liCode = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F008.RejectReasonMaster.aspx",
                                                                                 "lblCodeRc.text",
                                                                                  culture).ToString(), CODE);
            sel.Items.Add(liCode);

            ListItem liName = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F008.RejectReasonMaster.aspx",
                                                                                "lblNameRc.text",
                                                                                 culture).ToString(), NAME);
            sel.Items.Add(liName);
        }

        private void bindRejectReason()
        {
            this.allRejectReason = reDAO.getAllRejectReason(false);

            if (!ValidationUtil.isEmpty(this.txtSearchText.Text))
            {
                switch (this.selSearchBy.SelectedValue)
                {
                    case CODE:
                        this.allRejectReason = this.allRejectReason.Where(e => e.code != null && e.code.Trim().ToLower()
                                                                                .IndexOf(this.txtSearchText.Text.Trim().ToLower()) >= 0)
                                                                                .ToList();
                        break;
                    case NAME:
                        this.allRejectReason = this.allRejectReason.Where(e => e.name != null && e.name.Trim().ToLower()
                                                                               .IndexOf(this.txtSearchText.Text.Trim().ToLower()) >= 0)
                                                                               .ToList();
                        break;
                }
            }

            this.rejectReasonDataGridView.PageSize = int.Parse(this.txtRowPerPage.Text);
            this.rejectReasonDataGridView.DataSource = this.allRejectReason;
            this.rejectReasonDataGridView.DataBind();
        }

        protected void btnAddReason_Click(object sender, EventArgs e)
        {
            Page.Validate("vsAddGroup");
            if (!Page.IsValid)
            {
                return;
            }

            RejectReason check = reDAO.findByCode(this.txtCode.Text, false);
            if(check != null)
            {
                errorMessages.Add(string.Format(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                   "code_in_use",
                                                                   culture).ToString(),
                                              this.txtCode.Text));
                return;
            }

            RejectReason objAdd = new RejectReason();
            objAdd.code = WebUtils.getFieldIfNotNull(this.txtCode.Text);
            objAdd.name = WebUtils.getFieldIfNotNull(this.txtName.Text);
            objAdd.creationDate = DateTime.Now;
            objAdd.lastUpdate = DateTime.Now;

            reDAO.create(objAdd);
            int rowPerPage = int.Parse(this.txtRowPerPage.Text);
            WebUtils.ClearControls(this);
            this.txtRowPerPage.Text = rowPerPage.ToString();
            bindRejectReason();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
            this.infoMessages.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                            "successfully_savedRc",
                                                                            culture).ToString());
        }

        protected void rejectReasonDataGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            rejectReasonDataGridView.PageIndex = e.NewPageIndex;
            bindRejectReason();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void rejectReasonDataGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            rejectReasonDataGridView.EditIndex = e.NewEditIndex;
            bindRejectReason();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void rejectReasonDataGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Page.Validate("vsEditGrid");
            if (!Page.IsValid)
            {
                return;
            }

            GridViewRow row = this.rejectReasonDataGridView.Rows[e.RowIndex];
            Label lblRejectGrid_Id = row.FindControl("lblRejectGrid_Id") as Label;
            TextBox txtGrid_Code = row.FindControl("txtGrid_Code") as TextBox;
            TextBox txtGrid_Name = row.FindControl("txtGrid_Name") as TextBox;

            long idToUpdate = long.Parse(lblRejectGrid_Id.Text);

            RejectReason check = reDAO.findByCode(txtGrid_Code.Text, false);
            if(check != null && check.id != idToUpdate)
            {
                errorMessagesForGrid.Add(string.Format(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                  "code_in_use",
                                                                  culture).ToString(),
                                             txtGrid_Code.Text));
                return;
            }

            RejectReason objUpdate = reDAO.findById(idToUpdate, false);
            objUpdate.code = WebUtils.getFieldIfNotNull(txtGrid_Code.Text);
            objUpdate.name = WebUtils.getFieldIfNotNull(txtGrid_Name.Text);
            objUpdate.lastUpdate = DateTime.Now;
            reDAO.update(objUpdate);
            rejectReasonDataGridView.EditIndex = -1;
            bindRejectReason();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
            this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                           "successfully_savedRc",
                                                                           culture).ToString());
        }

        protected void rejectReasonDataGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            rejectReasonDataGridView.EditIndex = -1;
            bindRejectReason();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void rejectReasonDataGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }

            RejectReason obj = e.Row.DataItem as RejectReason;

            Label lblRejectGrid_Id = e.Row.FindControl("lblRejectGrid_Id") as Label;
            Label lblGrid_CreationDate = e.Row.FindControl("lblGrid_CreationDate") as Label;
            Label lblGrid_LastUpdate = e.Row.FindControl("lblGrid_LastUpdate") as Label;

            lblRejectGrid_Id.Text = obj.id.ToString();
            lblGrid_CreationDate.Text = string.Format(obj.creationDate.ToString("dd/MM/yyyy HH:mm", new CultureInfo("en-Us")));
            lblGrid_LastUpdate.Text = string.Format(obj.lastUpdate.ToString("dd/MM/yyyy HH:mm", new CultureInfo("en-Us")));

            if ((e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                TextBox txtGrid_Code = e.Row.FindControl("txtGrid_Code") as TextBox;
                TextBox txtGrid_Name = e.Row.FindControl("txtGrid_Name") as TextBox;

                txtGrid_Code.Text = obj.code;
                txtGrid_Name.Text = obj.name;
            }
            else
            {
                Label lblGrid_Code = e.Row.FindControl("lblGrid_Code") as Label;
                Label lblGrid_Name = e.Row.FindControl("lblGrid_Name") as Label;

                lblGrid_Name.Text = obj.name;
                lblGrid_Code.Text = obj.code;
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Page.Validate("vsSearchGroup");
            if (!Page.IsValid)
            {
                return;
            }
            bindRejectReason();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            long idToDelete = long.Parse(e.CommandArgument.ToString());

            RejectReason rejDelete = reDAO.findById(idToDelete, true);

            try
            {
                reDAO.delete(rejDelete);
                bindRejectReason();
                this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource", "successfully_savedRc", culture).ToString());
            }
            catch (Exception ex)
            {
                this.errorMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource", "dataIsUse", culture).ToString());
            }
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }
    }
}