using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.dao;
using XenDevWeb.domain;

namespace XenDevWeb.include
{
    public partial class master : System.Web.UI.MasterPage
    {
        private XenDevWebDbContext ctx;
        private StaffAccountDAO saDAO;
        private UserAccountDAO uaDAO;

        protected bool hasAdminRole;
        protected bool hasMemberRole;
        protected string language;
        protected UserAccount user;

        protected void Page_Load(object sender, EventArgs e)
        {
            /*
             * 20201012 ปิดไว้ชั่วคราว ยังไม่มีข้อมูล
            ctx = new XenDevWebDbContext();
            this.uaDAO = new UserAccountDAO(ctx);

            string username = System.Web.HttpContext.Current.User.Identity.Name;
            this.user = uaDAO.findByUserName(username, false);

            if (this.user == null)
            {
                FormsAuthentication.SignOut();
                FormsAuthentication.RedirectToLoginPage();

                this.hasAdminRole = false;
                this.hasMemberRole = false;

                return;
            }

            this.hasAdminRole = user.isCheckAdmin();
            this.hasMemberRole = user.hasMemberRole();
            */
            checkAuthorization();

        }

        private bool checkAuthorization()
        {
            using (XenDevWebDbContext ctx = new XenDevWebDbContext())
            {
                StaffAccountDAO saDAO = new StaffAccountDAO(ctx);
                UserAccountDAO uaDAO = new UserAccountDAO(ctx);

                string username = System.Web.HttpContext.Current.User.Identity.Name;
                StaffAccount cusAcc = saDAO.findByUsername(username, false);
                UserAccount userAcc = uaDAO.findByUsername(username, false);
                if (cusAcc != null)
                {
                    language = cusAcc.language;
                    lblCustomerName.Text = cusAcc.username;
                    this.hasAdminRole = true;
                    this.hasMemberRole = true;
                }
                else if (userAcc != null)
                {
                    language = userAcc.language;
                    lblCustomerName.Text = userAcc.username;
                    this.hasAdminRole = false;
                    this.hasMemberRole = true;
                }
            }

            return true;
        }
    }
 }
