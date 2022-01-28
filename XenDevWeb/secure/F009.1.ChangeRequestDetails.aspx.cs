using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
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
    public partial class F009__1_ChangeRequestDetails : CRUDPageControler
    {
        private ApplicationChangeTrxDAO acTrxDAO;
        private ApplicationChangeDAO acDAO;
        private ImageDAO imgDAO;
        private List<ApplicationChangeTrx> allApplicationChangeTrx;
        protected void Page_Load(object sender, EventArgs e)
        {
            acTrxDAO = new ApplicationChangeTrxDAO(ctx);
            acDAO = new ApplicationChangeDAO(ctx);
            imgDAO = new ImageDAO(ctx);
            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }
            initFrom();
            bindChangeRequestDetails();

        }

        private void initFrom()
        {
            this.btnAdd.Enabled = false;
            if (ValidationUtil.isEmpty(Request.QueryString["acId"]))
            {
                Response.Redirect("F009.ChangeRequest.aspx", true);
                return;
            }

            this.hndAppChangeId.Value = QueryStringModule.Decrypt(HttpUtility.UrlDecode(Request.QueryString["acId"]));
        }

        private void bindChangeRequestDetails()
        {
            ApplicationChange ac = acDAO.findById(long.Parse(this.hndAppChangeId.Value), false);
            this.lblProjectName.Text = ac.appAsset.project.name;
            this.lblAssetFileName.Text = "/" + ac.appAsset.assetFileName;

            if (ac != null && ac.approvalTrxes .Count > 0)
            {               
                this.allApplicationChangeTrx = ac.approvalTrxes ;
            }
            changReqDetailGridView.DataSource = this.allApplicationChangeTrx;
            changReqDetailGridView.DataBind();
        }

        protected void btnEdit_Command(object sender, CommandEventArgs e)
        {
            string trxesID = e.CommandArgument.ToString();

            Response.Redirect("F011.ApplicationChangeTrxEdit.aspx?acTrxID=" + HttpUtility.UrlEncode(QueryStringModule.Encrypt(trxesID))+ "&acID="+ HttpUtility.UrlEncode(QueryStringModule.Encrypt(this.hndAppChangeId.Value)), true);
        }

        protected void changReqDetailGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            changReqDetailGridView.PageIndex = e.NewPageIndex;
            bindChangeRequestDetails();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void changReqDetailGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }
            ApplicationChangeTrx acTrx = e.Row.DataItem as ApplicationChangeTrx;

            Label lblGrid_Ordinal = e.Row.FindControl("lblGrid_Ordinal") as Label;
            Label lblGrid_Status = e.Row.FindControl("lblGrid_Status") as Label;
            Label lblGrid_ChangeCompleteDate = e.Row.FindControl("lblGrid_ChangeCompleteDate") as Label;
            Label lblGrid_ChangeRejectDate = e.Row.FindControl("lblGrid_ChangeRejectDate") as Label;
            Label lblGrid_RejectReason = e.Row.FindControl("lblGrid_RejectReason") as Label;
            LinkButton btnEdit = e.Row.FindControl("btnEdit") as LinkButton;
            LinkButton btnDelete = e.Row.FindControl("btnDelete") as LinkButton;

            btnEdit.Enabled = false;
            btnDelete.Visible = false;

            switch (acTrx.status)
            {
                case APP_CHANGE_TRX_STATUS.NEW:
                    lblGrid_Status.Text = HttpContext.GetGlobalResourceObject("GlobalResource", "new_chang", culture).ToString();
                    break;
                case APP_CHANGE_TRX_STATUS.CUSTOMER_ACCEPT:
                    lblGrid_Status.Text = HttpContext.GetGlobalResourceObject("GlobalResource", "customer_accept", culture).ToString();
                    break;
                case APP_CHANGE_TRX_STATUS.CUSTOMER_REJECT:
                    lblGrid_Status.Text = HttpContext.GetGlobalResourceObject("GlobalResource", "customer_reject", culture).ToString();
                    break;
                case APP_CHANGE_TRX_STATUS.CODE_CHANGED:
                    lblGrid_Status.Text = HttpContext.GetGlobalResourceObject("GlobalResource", "code_changed", culture).ToString();
                    break;
                case APP_CHANGE_TRX_STATUS.DEVELOPER_CANCEL:
                    lblGrid_Status.Text = HttpContext.GetGlobalResourceObject("GlobalResource", "developer_cancel", culture).ToString();
                    break;
            }

            if (acTrx.changeCompleteDate != null)
            {
                lblGrid_ChangeCompleteDate.Text = string.Format(acTrx.changeCompleteDate.Value.ToString("dd/MM/yyyy", new CultureInfo("en-Us")));
            }
            else
            {
                lblGrid_ChangeCompleteDate.Text = "-";
            }

            if (acTrx.changeRejectDate != null)
            {
                lblGrid_ChangeRejectDate.Text = string.Format(acTrx.changeRejectDate.Value.ToString("dd/MM/yyyy", new CultureInfo("en-Us")));
            }
            else
            {
                lblGrid_ChangeRejectDate.Text = "-";
            }
            if (acTrx.rejectReason != null)
            {
                lblGrid_RejectReason.Text = acTrx.rejectReason.name;
            }
            else
            {
                lblGrid_RejectReason.Text = "-";
            }
           

        }

        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            long idToUpdate = long.Parse(e.CommandArgument.ToString());

            ApplicationChangeTrx acTrx = acTrxDAO.findById(idToUpdate, true);
            List<long> idImages = new List<long>();
            foreach(domain.Image img in acTrx.images)
            {
                idImages.Add(img.id);
            }

            try
            {
                foreach(long idImageToDelete in idImages)
                {
                    domain.Image objImage = imgDAO.findById(idImageToDelete, true);
                    if (!ValidationUtil.isEmpty(objImage.serverImageFileName))
                    {
                        string oldFullPath = string.Format("{0}\\{1}", Constants.MEETINGNOTE_IMG_FOLDER
                                                                 , objImage.serverImageFileName);
                        File.Delete(oldFullPath);
                    }

                    imgDAO.delete(objImage);
                }
               
                acTrxDAO.delete(acTrx);
                bindChangeRequestDetails();
                this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource", "successfully_savedRc", culture).ToString());
            }
            catch(Exception ex)
            {
                this.errorMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource", "dataIsUse", culture).ToString());
            }
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            long acID = long.Parse(this.hndAppChangeId.Value);
            ApplicationChange acUpdate = acDAO.findById(acID, true);

            if (acUpdate != null)
            {
                ApplicationChangeTrx acTrx = new ApplicationChangeTrx();
                acTrx.creationDate = DateTime.Now;
                acTrx.lastUpdate = DateTime.Now;
                acTrx.status = APP_CHANGE_TRX_STATUS.NEW;
                acTrx.applicationChange = acUpdate;
                acTrxDAO.create(acTrx);

                Response.Redirect("F010.ApplicationChangeTrx.aspx?acTrxID=" + HttpUtility.UrlEncode(QueryStringModule.Encrypt(acTrx.id.ToString())) + "&acID=" + HttpUtility.UrlEncode(QueryStringModule.Encrypt(this.hndAppChangeId.Value)), true);

            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("F009.ChangeRequest.aspx", true);
        }
    }
}