
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.Security;
using XenDevWeb.dao;
using XenDevWeb.domain;

namespace XenDevWeb.WebServices
{
    /// <summary>
    /// Summary description for Signout
    /// </summary>
    public class Signout : IHttpHandler
    {
        private XenDevWebDbContext ctx;
        private StaffAccountDAO saDAO;
        protected bool hasAdminRole;
        protected bool hasMemberRole;

        public void ProcessRequest(HttpContext context)
        {
            this.ctx = new XenDevWebDbContext();
            this.saDAO = new StaffAccountDAO(ctx);
            string username = System.Web.HttpContext.Current.User.Identity.Name;
            HttpCookie authCookie = HttpContext.Current.Request.Cookies[FormsAuthentication.FormsCookieName];
            FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);

            string pvToken = authTicket.UserData;
            this.hasAdminRole = (pvToken != null && pvToken.IndexOf("admin") >= 0);
            this.hasMemberRole = (pvToken != null && (pvToken.IndexOf("member") >= 0));


            FormsAuthentication.SignOut();

            StaffAccount sa = this.saDAO.findByUsername(username, false);
            if (sa != null && this.hasAdminRole)
            {
                context.Response.Redirect("~/login_staff.aspx");
            }
            else
            {
                context.Response.Redirect("~/login.aspx");
            }       
           
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}