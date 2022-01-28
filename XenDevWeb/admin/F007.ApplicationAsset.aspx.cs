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
    public partial class F007_ApplicationAsset : CRUDPageControler
    {
        private ApplicationAssetDAO appAssetDAO;
        private ProjectDAO projectDAO;
        private List<ApplicationAsset> allApplicationAsset;

        public const string ASSETFILENAME = "0";

        protected void Page_Load(object sender, EventArgs e)
        {
            appAssetDAO = new ApplicationAssetDAO(ctx);
            projectDAO = new ProjectDAO(ctx);

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
            bindApplicationAsset();
        }

        private void initForm()
        {
            populateSearchBy(this.selSearchBy);
            this.txtRowPerPage.Text = Constants.DEFAULT_ROW_PER_PAGE.ToString();
        }

        private void populateSearchBy(DropDownList sel)
        {
            sel.Items.Clear();

            ListItem liAssetFileName = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F007.ApplicationAsset.aspx",
                                                                                  "lblAssetFileNameRc.text",
                                                                                   culture).ToString(), ASSETFILENAME);
            sel.Items.Add(liAssetFileName);
        }

        private void bindApplicationAsset()
        {
            long idProject = long.Parse(this.hndProjectId.Value);
            this.allApplicationAsset = appAssetDAO.getAllApplicationAsset(idProject, false);

            if (!ValidationUtil.isEmpty(this.txtSearchText.Text))
            {
                switch (this.selSearchBy.SelectedValue)
                {
                    case ASSETFILENAME:
                        this.allApplicationAsset = this.allApplicationAsset.Where(e => e.assetFileName != null && e.assetFileName.Trim().ToLower()
                                                                               .IndexOf(this.txtSearchText.Text.Trim().ToLower()) >= 0).ToList();
                        break;
                }
            }

            this.appAssetDataGridView.PageSize = int.Parse(this.txtRowPerPage.Text);
            this.appAssetDataGridView.DataSource = this.allApplicationAsset;
            this.appAssetDataGridView.DataBind();
        }

        protected void btnAddAppAsset_Click(object sender, EventArgs e)
        {
            Page.Validate("vsAddGroup");
            if (!Page.IsValid)
            {
                return;
            }

            ApplicationAsset appAsset = new ApplicationAsset();
            Project pj = projectDAO.findByProjectId(long.Parse(hndProjectId.Value), true);
            appAsset.project = pj;
            appAsset.assetFileName = WebUtils.getFieldIfNotNull(this.txtAssetFileName.Text);
            appAsset.note = WebUtils.getFieldIfNotNull(this.txtNote.Text);
            appAsset.enabled = true;
            appAsset.creationDate = DateTime.Now;
            appAsset.lastUpdate = DateTime.Now;
            appAssetDAO.create(appAsset);

            long rowPerPage = long.Parse(this.txtRowPerPage.Text);
            WebUtils.ClearControls(this);
            this.txtRowPerPage.Text = rowPerPage.ToString();
            bindApplicationAsset();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
            this.infoMessages.Add(HttpContext.GetGlobalResourceObject("GlobalResource", "successfully_savedRc", culture).ToString());

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Page.Validate("vsSearchGroup");
            if (!Page.IsValid)
            {
                return;
            }
            bindApplicationAsset();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void appAssetDataGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            appAssetDataGridView.PageIndex = e.NewPageIndex;
            bindApplicationAsset();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void appAssetDataGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            appAssetDataGridView.EditIndex = e.NewEditIndex;
            bindApplicationAsset();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void appAssetDataGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Page.Validate("vsEditGrid");
            if (!Page.IsValid)
            {
                return;
            }

            GridViewRow row = this.appAssetDataGridView.Rows[e.RowIndex];
            Label lblAppAssetGrid_Id = row.FindControl("lblAppAssetGrid_Id") as Label;
            TextBox txtGrid_AssetFileName = row.FindControl("txtGrid_AssetFileName") as TextBox;
            TextBox txtGrid_Note = row.FindControl("txtGrid_Note") as TextBox;
            CheckBox chkGrid_Enable = row.FindControl("chkGrid_Enable") as CheckBox;

            long idToUpdate = long.Parse(lblAppAssetGrid_Id.Text);

            ApplicationAsset objUpdate = appAssetDAO.findById(idToUpdate, true);
            objUpdate.assetFileName = txtGrid_AssetFileName.Text;
            objUpdate.note = txtGrid_Note.Text;
            objUpdate.enabled = chkGrid_Enable.Checked;

            appAssetDAO.update(objUpdate);
            appAssetDataGridView.EditIndex = -1;
            bindApplicationAsset();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
            this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource", "successfully_savedRc", culture).ToString());
        }

        protected void appAssetDataGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            appAssetDataGridView.EditIndex = -1;
            bindApplicationAsset();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void appAssetDataGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }

            ApplicationAsset obj = e.Row.DataItem as ApplicationAsset;

            Label lblAppAssetGrid_Id = e.Row.FindControl("lblAppAssetGrid_Id") as Label;
            Label lblGrid_CreationDate = e.Row.FindControl("lblGrid_CreationDate") as Label;
            Label lblGrid_LastUpdate = e.Row.FindControl("lblGrid_LastUpdate") as Label;

            lblAppAssetGrid_Id.Text = obj.id.ToString();
            lblGrid_CreationDate.Text = string.Format(obj.creationDate.ToString("dd/MM/yyyy HH:mm", new CultureInfo("en-Us")));
            lblGrid_LastUpdate.Text = string.Format(obj.lastUpdate.ToString("dd/MM/yyyy HH:mm", new CultureInfo("en-Us")));

            if ((e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                TextBox txtGrid_AssetFileName = e.Row.FindControl("txtGrid_AssetFileName") as TextBox;
                TextBox txtGrid_Note = e.Row.FindControl("txtGrid_Note") as TextBox;
                CheckBox chkGrid_Enable = e.Row.FindControl("chkGrid_Enable") as CheckBox;

                txtGrid_Note.Text = obj.note;
                txtGrid_AssetFileName.Text = obj.assetFileName;
                chkGrid_Enable.Checked = obj.enabled;
            }
            else
            {
                Label lblGrid_Note = e.Row.FindControl("lblGrid_Note") as Label;
                Label lblGrid_AssetFileName = e.Row.FindControl("lblGrid_AssetFileName") as Label;
                CheckBox chkGrid_Enable = e.Row.FindControl("chkGrid_Enable") as CheckBox;

                lblGrid_AssetFileName.Text = obj.assetFileName;
                lblGrid_Note.Text = obj.note;
                chkGrid_Enable.Checked = obj.enabled;
            }
        }

        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            long idToDelete = long.Parse(e.CommandArgument.ToString());

            ApplicationAsset objDelete = appAssetDAO.findById(idToDelete, true);

            try
            {
                appAssetDAO.delete(objDelete);
                bindApplicationAsset();
                this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource", "successfully_savedRc", culture).ToString());
            }
            catch(Exception ex)
            {
                this.errorMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource", "dataIsUse", culture).ToString());
            }
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("F004.Project.aspx", true);
        }
    }
}