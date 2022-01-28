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
    public partial class F004__1_ProjectImage : CRUDPageControler
    {
        private ProjectDAO pDAO;

        protected void Page_Load(object sender, EventArgs e)
        {
            pDAO = new ProjectDAO(ctx);
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
            initForm();
        }

        private void initForm()
        {
            Project pj = pDAO.findByProjectId(long.Parse(this.hndProjectId.Value), false);

            if (pj != null && pj.bannerImageFileName != null)
            {
                this.imgProject.ImageUrl = WebUtils.getImageProjectBase64(pj.bannerImageFileName);
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
            string fullPath = string.Format("{0}\\{1}", Constants.PROJECT_IMG_FOLDER
                                                      , fileName);
            bmp.Save(fullPath);

            Project pj = pDAO.findByProjectId(long.Parse(this.hndProjectId.Value), false);

            if (!ValidationUtil.isEmpty(pj.bannerImageFileName))
            {
                string oldFullPath = string.Format("{0}\\{1}", Constants.PROJECT_IMG_FOLDER
                                                         , pj.bannerImageFileName);
                File.Delete(oldFullPath);
            }
            pj.bannerImageFileName = fileName;
            pj.lastUpdate = DateTime.Now;
            pDAO.update(pj);
            bmp.Dispose();
            initForm();

            this.infoMessages.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                     "successfully_savedRc",
                                                                     culture).ToString());
        }

        protected void btnGoBack_Command(object sender, CommandEventArgs e)
        {
            Response.Redirect("F004.Project.aspx", true);
        }
    }
}