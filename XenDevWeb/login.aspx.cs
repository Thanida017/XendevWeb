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

namespace CounterService
{
    public partial class login : System.Web.UI.Page
    {
        protected CultureInfo culture;
        protected List<string> errorMessage;

        private XenDevWebDbContext ctx;
        private UserAccountDAO uaDAO;

        protected void Page_Load(object sender, EventArgs e)
        {
            culture = CultureInfo.CreateSpecificCulture(Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName);
            errorMessage = new List<string>();

            ctx = new XenDevWebDbContext();
            uaDAO = new UserAccountDAO(ctx);

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

                UserAccount sa = uaDAO.findByUsername(username, false);
                if (sa == null)
                {
                    return;
                }

                string pvToken = this.getPrivilegeToken(sa);
                string redirectURL = getRedirectURL(pvToken);
                if (redirectURL == null)
                {
                    this.errorMessage.Add(HttpContext.GetLocalResourceObject("~/login.aspx", "user_no_pv", culture).ToString());
                }
                else
                {
                    Response.Redirect(WebUtils.getAppServerPath() + redirectURL, true);
                }
            }
        }

        private string getPrivilegeToken(UserAccount user)
        {
            return "member";
        }

        private string getRedirectURL(string pvToken)
        {
            if (pvToken.Contains("member"))
            {
                return "/secure/F005.MeetingNote.aspx";
            }

            return null;
        }

        private void appAuthen()
        {
            UserAccount user = uaDAO.findByCredential(this.txtUn.Text, Encryption.encrypt(this.txtPd.Text, true));
            if (user == null)
            {
                this.errorMessage.Add(HttpContext.GetLocalResourceObject("~/login.aspx", "inv_un_pwd", culture).ToString());
                return;
            }
            
            if (!user.enabled)
            {
                this.errorMessage.Add(HttpContext.GetLocalResourceObject("~/login.aspx", "user_disabled", culture).ToString());
                return;
            }

            privilegeControl(user);
        }

        private void privilegeControl(UserAccount user)
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
                this.errorMessage.Add(HttpContext.GetLocalResourceObject("~/login.aspx", "user_no_pv", culture).ToString());
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
            //Response.Redirect("F001.Project.aspx", true);
            appAuthen();
        }
    }
}