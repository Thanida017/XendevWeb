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
    public partial class F033_EstimationList : CRUDPageControler
    {
        private EstimationRequestDAO erDAO;

        private List<EstimationRequest> allEstimations;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.erDAO = new EstimationRequestDAO(ctx);

            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            initForm();
            bindEstimation();
        }

        private void initForm()
        {
            populateStatus(selSearchStatus);
        }

        public void bindEstimation()
        {
            this.allEstimations = this.erDAO.getAllEstimations(false).OrderByDescending(o => o.lastUpdate).ToList();

            if (this.allEstimations != null)
            {

                switch (selSearchStatus.SelectedValue)
                {
                    case "NEW":
                        this.allEstimations = this.allEstimations.Where(i => i.status == ESTIMATION_STATUS.NEW).ToList();
                        break;
                    case "ACCEPTED":
                        this.allEstimations = this.allEstimations.Where(i => i.status == ESTIMATION_STATUS.ACCEPTED).ToList();
                        break;
                    case "REJECTED":
                        this.allEstimations = this.allEstimations.Where(i => i.status == ESTIMATION_STATUS.REJECTED).ToList();
                        break;
                }
            }

            estimationInDatabaseGridView.DataSource = this.allEstimations;
            estimationInDatabaseGridView.DataBind();

        }

        public void populateStatus(DropDownList sel)
        {
            sel.Items.Clear();

            ListItem lstAll = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F033.EstimationList.aspx",
                                                                                "all", culture)
                                                                                .ToString(), "All");
            sel.Items.Add(lstAll);

            ListItem liNew = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F033.EstimationList.aspx",
                                                                             "New", culture).ToString()
                                                                             , ESTIMATION_STATUS.NEW.ToString());
            sel.Items.Add(liNew);

            ListItem liAccepted = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F033.EstimationList.aspx",
                                                                         "Accepted", culture).ToString()
                                                                         , ESTIMATION_STATUS.ACCEPTED.ToString());
            sel.Items.Add(liAccepted);

            ListItem liRejected = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F033.EstimationList.aspx",
                                                                             "Rejected", culture).ToString()
                                                                             , ESTIMATION_STATUS.REJECTED.ToString());

            sel.Items.Add(liRejected);
            
        }

        protected void btnQuery_Click(object sender, EventArgs e)
        {
            bindEstimation();
        }

        protected void estimationInDatabaseGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            estimationInDatabaseGridView.PageIndex = e.NewPageIndex;
            bindEstimation();
        }

        protected void estimationInDatabaseGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }

            Label lblEstimationId = e.Row.FindControl("lblEstimationId") as Label;
            Label lblGrid_CompanyName = e.Row.FindControl("lblGrid_CompanyName") as Label;
            Label lblGrid_ProjectName = e.Row.FindControl("lblGrid_ProjectName") as Label;
            Label lblGrid_CreationDate = e.Row.FindControl("lblGrid_CreationDate") as Label;

            EstimationRequest er = e.Row.DataItem as EstimationRequest;

            lblEstimationId.Text = er.id.ToString();
            lblGrid_CompanyName.Text = er.companyName;
            lblGrid_ProjectName.Text = er.projectName;
            lblGrid_CreationDate.Text = er.creationDate.ToString("dd/MM/yyyy hh:mm", culture);
        }

        protected void btnDatail_Command(object sender, CommandEventArgs e)
        {
            string estimationId = e.CommandArgument.ToString();

            Response.Redirect(WebUtils.getAppServerPath() + "/admin/F034.EstimationDetail.aspx?estimationId=" + HttpUtility.UrlEncode(QueryStringModule.Encrypt(estimationId)), true);
        }
    }
}