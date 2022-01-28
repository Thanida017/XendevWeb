using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.Http;
using System.Web.UI;
using System.Security.Principal;

namespace XenDevWeb
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            GlobalConfiguration.Configure(WebApiConfig.Register);

            ScriptManager.ScriptResourceMapping.AddDefinition(
               "jquery",
               new ScriptResourceDefinition
               {
                   Path = "~/include/js/jquery-1.8.3.min.js",
                   DebugPath = "~/include/js/jquery-1.8.3.min.js",
                   CdnPath = "http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js",
                   CdnDebugPath = "http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js",
                   CdnSupportsSecureConnection = true,
                   LoadSuccessExpression = "jQuery"
               });

        }

        //ASP always create new session ID workaround.
        //Ref: https://stackoverflow.com/questions/2874078/asp-net-session-sessionid-changes-between-requests
        protected void Session_Start(Object sender, EventArgs e)
        {
            Session["init"] = 0;
        }

        protected void Application_AuthenticateRequest(Object sender, EventArgs e)
        {
            if (HttpContext.Current.User != null)
            {
                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    if (HttpContext.Current.User.Identity is FormsIdentity)
                    {
                        FormsIdentity id = (FormsIdentity)HttpContext.Current.User.Identity;
                        FormsAuthenticationTicket ticket = id.Ticket;
                        string userData = ticket.UserData;
                        string[] roles = userData.Split(';');
                        HttpContext.Current.User = new GenericPrincipal(id, roles);
                    }
                }
            }
        }
    }
}