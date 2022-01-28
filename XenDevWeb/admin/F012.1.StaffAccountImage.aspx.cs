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

namespace XenDevWeb.admin
{
    public partial class F012__1_StaffAccountImage : CRUDPageControler
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            if (ValidationUtil.isEmpty(Request.QueryString["saId"]))
            {
                Response.Redirect("F012.StaffAccount.aspx", true);
                return;
            }

            this.hndSAId.Value = QueryStringModule.Decrypt(HttpUtility.UrlDecode(Request.QueryString["saId"]));
            initForm();
        }

        private void initForm()
        {
            StaffAccount ua = this.saDAO.findById(long.Parse(this.hndSAId.Value), false);

            if (ua != null && !ValidationUtil.isEmpty(ua.imageUserFileName))
            {
                this.imgProject.ImageUrl = WebUtils.getImageUserBase64(ua.imageUserFileName);
            }
        }

        protected void lnkUpload_ServerClick(object sender, EventArgs e)
        {
            HttpPostedFile file = Request.Files["myFile"];
            if (file == null)
            {
                this.errorMessages.Add(HttpContext.GetLocalResourceObject("~/admin/F004.1.ProjectImage.aspx",
                                                                                   "pls_upload_image",
                                                                                    culture).ToString());
                return;
            }
            else if (!file.FileName.ToLower().EndsWith(".jpg"))
            {
                this.errorMessages.Add(HttpContext.GetLocalResourceObject("~/admin/F004.1.ProjectImage.aspx",
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
            string fullPath = string.Format("{0}\\{1}", Constants.USERACCOUNT_IMG_FOLDER
                                                      , fileName);
            bmp.Save(fullPath);

            StaffAccount sa = saDAO.findById(long.Parse(this.hndSAId.Value), false);

            if (!ValidationUtil.isEmpty(sa.imageUserFileName))
            {
                string oldFullPath = string.Format("{0}\\{1}", Constants.USERACCOUNT_IMG_FOLDER
                                                         , sa.imageUserFileName);
                File.Delete(oldFullPath);
            }
            sa.imageUserFileName = fileName;
            sa.lastUpdate = DateTime.Now;
            saDAO.update(sa);
            bmp.Dispose();
            initForm();

            this.infoMessages.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                     "successfully_savedRc",
                                                                     culture).ToString());
        }

        protected void btnGoBack_Command(object sender, CommandEventArgs e)
        {
            Response.Redirect("F012.StaffAccount.aspx", true);
        }
    }
}