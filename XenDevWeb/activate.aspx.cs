using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.dao;
using XenDevWeb.domain;
using XenDevWeb.Utils;

namespace XenDevWeb
{
    public partial class activate : System.Web.UI.Page
    {
        private XenDevWebDbContext ctx;
        private UserAccountDAO uaDAO;
        protected void Page_Load(object sender, EventArgs e)
        {
            ctx = new XenDevWebDbContext();
            this.uaDAO = new UserAccountDAO(ctx);

            if (this.IsPostBack || this.scriptManager.IsInAsyncPostBack)
            {
                return;
            }

            if (ValidationUtil.isEmpty(Request.QueryString["activationCode"]))
            {
                Response.Redirect("/Login.aspx", true);
                return;
            }

            this.hndResetParam.Value = Request.QueryString["activationCode"];
            initForm();
        }

        public void initForm()
        {
            UserAccount ua = uaDAO.findByActivationCode(this.hndResetParam.Value, true);

            if (ua != null)
            {
                ua.company.enabled = true;
                ua.enabled = true;
                ua.activationCode = string.Empty;
                uaDAO.update(ua);
                lblHeaderMessage.Text = "Success";
                lblMessage.Text = string.Format("User Account {0} registered successfully", ua.username);
            }
            else
            {
                lblHeaderMessage.Text = "Error";
                lblMessage.Text = string.Format("Activation code is invalid");
            }
        }
    }
}