using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.domain;
using XenDevWeb.include;

namespace XenDevWeb
{
    public partial class switchLanguage : CRUDPageControler
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();

            string language = Request.QueryString["language"];
            string username = System.Web.HttpContext.Current.User.Identity.Name;

            StaffAccount staff = this.saDAO.findByUsername(username, true);
            UserAccount user = this.uaDAO.findByUsername(username, true);
            if (staff != null)
            {
                staff.language = language;
                staff.lastUpdate = DateTime.Now;
                this.saDAO.update(staff);
                Response.Redirect("~/login_staff.aspx", true);
            }
            else if (user != null)
            {
                user.language = language;
                user.lastUpdate = DateTime.Now;
                this.uaDAO.update(user);
                Response.Redirect("~/login.aspx", true);
            }
        }
    }
}