using System;
using System.Collections.Generic;
using System.Drawing;
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
    public partial class F010_ApplicationChangeTrx : CRUDPageControler
    {
        private ApplicationChangeTrxDAO acTrxDAO;
        private ImageDAO imgDAO;
        public List<string> errorMessagesForUpload { get; set; }
        public List<string> infoMessagesForUpload { get; set; }
        public List<string> errorMessagesForDetail { get; set; }
        public List<string> infoMessagesForDetail { get; set; }

        private ApplicationChangeTrx acTrx;

        protected void Page_Load(object sender, EventArgs e)
        {
            errorMessagesForUpload = new List<string>();
            infoMessagesForUpload = new List<string>();
            errorMessagesForDetail = new List<string>();
            infoMessagesForDetail = new List<string>();

            acTrxDAO = new ApplicationChangeTrxDAO(ctx);
            imgDAO = new ImageDAO(ctx);

            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            if (ValidationUtil.isEmpty(Request.QueryString["acTrxID"]) || ValidationUtil.isEmpty(Request.QueryString["acID"]))
            {
                Response.Redirect("F009.1.ChangeRequestDetails.aspx?acId=" + Request.QueryString["acID"], true);
                return;
            }

            this.hndACTrxId.Value = QueryStringModule.Decrypt(HttpUtility.UrlDecode(Request.QueryString["acTrxID"]));
            this.hndACId.Value = QueryStringModule.Decrypt(HttpUtility.UrlDecode(Request.QueryString["acID"]));

            initForm();
            bindItemImage();
        }

        private void initForm()
        {
            acTrx = acTrxDAO.findById(long.Parse(this.hndACTrxId.Value), false);
            txtChangeDetails.Text = acTrx.changeDetails;

        }

        private void bindItemImage()
        {
            acTrx = acTrxDAO.findById(long.Parse(this.hndACTrxId.Value), false);
            imageRepeater.DataSource = acTrx.images;
            imageRepeater.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Page.Validate("vsAddGroup");
            if (!Page.IsValid)
            {
                return;
            }

            ApplicationChangeTrx acTrxUpdate = acTrxDAO.findById(long.Parse(this.hndACTrxId.Value), true);
            acTrxUpdate.changeDetails = WebUtils.getFieldIfNotNull(this.txtChangeDetails.Text);
            acTrxUpdate.lastUpdate = DateTime.Now;
            acTrxDAO.update(acTrxUpdate);

            initForm();

            this.pnlAppChangeTrx.Update();

            this.infoMessages.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                  "successfully_savedRc",
                                                                  culture).ToString());
        }

        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            long idToUpdate = long.Parse(e.CommandArgument.ToString());

            domain.Image imgDelete = imgDAO.findById(idToUpdate, true);

            if (!ValidationUtil.isEmpty(imgDelete.serverImageFileName))
            {
                string oldFullPath = string.Format("{0}\\{1}", Constants.APPLICATION_CHANGE_IMG_FOLDER
                                                         , imgDelete.serverImageFileName);
                File.Delete(oldFullPath);
            }

            imgDAO.delete(imgDelete);
            bindItemImage();

            this.pnlItemImage.Update();

            this.infoMessagesForDetail.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                                "successfully_deletedRc",
                                                                                culture).ToString());
        }

        protected void imageRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            domain.Image image = e.Item.DataItem as domain.Image;

            Label lblDescription = e.Item.FindControl("lblDescription") as Label;
            Label lblImageID = e.Item.FindControl("lblImageID") as Label;

            lblImageID.Text = image.id.ToString();
            lblDescription.Text = image.description;

            System.Web.UI.WebControls.Image images = e.Item.FindControl("images") as System.Web.UI.WebControls.Image;

            images.ImageUrl = WebUtils.getImageAppChangeBase64(image.serverImageFileName);
        }

        protected void lnkUpload_ServerClick(object sender, EventArgs e)
        {
            HttpPostedFile file = Request.Files["myFile"];
            if (file == null)
            {
                this.errorMessages.Add(HttpContext.GetLocalResourceObject("~/secure/F010.ApplicationChangeTrx.aspx",
                                                                                   "pls_upload_image",
                                                                                    culture).ToString());
                return;
            }
            else if (!file.FileName.ToLower().EndsWith(".jpg"))
            {
                this.errorMessages.Add(HttpContext.GetLocalResourceObject("~/secure/F010.ApplicationChangeTrx.aspx",
                                                                                   "only_jpeg",
                                                                                    culture).ToString());
                return;
            }

            Bitmap bmp = new Bitmap(file.InputStream);

            if (bmp.Width > Constants.MAX_MEMBER_IMAGE_WIDTH || bmp.Height > Constants.MAX_MEMBER_IMAGE_HEIGHT)
            {
                bmp = WebUtils.ResizeImage(bmp, new Size(Constants.MAX_MEMBER_IMAGE_WIDTH,
                Constants.MAX_MEMBER_IMAGE_WIDTH));
            }

            string fileName = string.Format("{0}.jpg", Guid.NewGuid());
            string fullPath = string.Format("{0}\\{1}", Constants.APPLICATION_CHANGE_IMG_FOLDER
                                                      , fileName);
            bmp.Save(fullPath);

            ApplicationChangeTrx acTrxUpdate = acTrxDAO.findById(long.Parse(this.hndACTrxId.Value), true);

            domain.Image img = new domain.Image();
            img.originalImageFileName = file.FileName;
            img.serverImageFileName = fileName;
            img.lastUpDate = DateTime.Now;
            img.creationDate = DateTime.Now;
            img.description = txtDescription.Text;
            img.appChangeTrx = acTrxUpdate;
            imgDAO.create(img);

            bmp.Dispose();
            txtDescription.Text = string.Empty;
            bindItemImage();
            this.pnlImage.Update();
            this.pnlItemImage.Update();

            this.infoMessagesForUpload.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                     "successfully_savedRc",
                                                                     culture).ToString());
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("F009.1.ChangeRequestDetails.aspx?acId=" + HttpUtility.UrlEncode(QueryStringModule.Encrypt(this.hndACId.Value)), true);
            return;
        }
    }
}