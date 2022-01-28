using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.dao;
using XenDevWeb.domain;
using XenDevWeb.Utils;

namespace XenDevWeb
{
    public partial class login_staff : System.Web.UI.Page
    {
        protected CultureInfo culture;
        protected List<string> errorMessage;

        private XenDevWebDbContext ctx;
        private StaffAccountDAO saDAO;

        protected void Page_Load(object sender, EventArgs e)
        {
            culture = CultureInfo.CreateSpecificCulture(Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName);
            errorMessage = new List<string>();

            ctx = new XenDevWebDbContext();
            saDAO = new StaffAccountDAO(ctx);

            if (this.IsPostBack || this.scriptManager.IsInAsyncPostBack)
            {
                return;
            }

            //Redirect if already checked in
            if (this.Page.User.Identity.IsAuthenticated)
            {
                string username = System.Web.HttpContext.Current.User.Identity.Name;
                if (username == null)
                {
                    return;
                }

                StaffAccount sa = saDAO.findByUsername(username, false);
                if (sa == null)
                {
                    return;
                }

                string pvToken = this.getPrivilegeToken(sa);
                string redirectURL = getRedirectURL(pvToken);
                if (redirectURL == null)
                {
                    this.errorMessage.Add(HttpContext.GetLocalResourceObject("~/login_staff.aspx", "user_no_pv", culture).ToString());
                }
                else
                {
                    Response.Redirect(WebUtils.getAppServerPath() + redirectURL, true);
                }
            }
        }

        private string getPrivilegeToken(StaffAccount staff)
        {
            return staff.isAdmin ? "admin" : "member";
        }

        private string getRedirectURL(string pvToken)
        {
            if (pvToken.Contains("admin"))
            {                
                return "/staff/F021.StaffTicket.aspx";
            }
            else if (pvToken.Contains("member"))
            {
                return "/staff/F021.StaffTicket.aspx";
            }

            return null;
        }

        private void appAuthen()
        {
            StaffAccount staff = saDAO.findByCredential(this.txtUn.Text, Encryption.encrypt(this.txtPd.Text, true));
            if (staff == null)
            {
                this.errorMessage.Add(HttpContext.GetLocalResourceObject("~/login_staff.aspx", "inv_un_pwd", culture).ToString());
                return;
            }

            if (!staff.enabled)
            {
                this.errorMessage.Add(HttpContext.GetLocalResourceObject("~/login_staff.aspx", "user_disabled", culture).ToString());
                return;
            }

            privilegeControl(staff);
        }

        private void privilegeControl(StaffAccount user)
        {
            string pvToken = this.getPrivilegeToken(user);
            bool rememberMe = true;
            FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(1,
                                                                             this.txtUn.Text,
                                                                             DateTime.Now,
                                                                             DateTime.Now.AddMinutes(2880),
                                                                             rememberMe,
                                                                             pvToken,
                                                                             FormsAuthentication.FormsCookiePath);
            string hash = FormsAuthentication.Encrypt(ticket);
            HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, hash);

            if (ticket.IsPersistent)
            {
                cookie.Expires = ticket.Expiration;
            }


            Response.Cookies.Add(cookie);
            //Response.Redirect(FormsAuthentication.GetRedirectUrl(this.txtUsername.Text, this.chkRememberMe.Checked));

            string redirectURL = getRedirectURL(pvToken);
            if (redirectURL == null)
            {
                this.errorMessage.Add(HttpContext.GetLocalResourceObject("~/login_staff.aspx", "user_no_pv", culture).ToString());
            }
            else
            {
                Response.Redirect(WebUtils.getAppServerPath() + redirectURL, true);
            }
        }

        protected void loginBtn_Click(object sender, EventArgs e)
        {
            Page.Validate("vsLoginGroup");
            if (!Page.IsValid)
            {
                return;
            }

            appAuthen();
        }
    }
}