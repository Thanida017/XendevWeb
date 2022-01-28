using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using XenDevWeb.dao;
using XenDevWeb.domain;

namespace XenDevWeb.include
{
    public class CRUDPageControler : System.Web.UI.Page
    {
        protected CultureInfo culture;
        protected List<string> errorMessages;
        protected List<string> infoMessages;
        protected List<string> errorMessagesForGrid;
        protected List<string> infoMessagesForGrid;

        public XenDevWebDbContext ctx;
        public StaffAccountDAO saDAO;
        public UserAccountDAO uaDAO;

        protected StaffAccount currentStaff;
        protected UserAccount currentUser;

        public CRUDPageControler() : base()
        {
            culture = CultureInfo.CreateSpecificCulture(Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName);
            errorMessages = new List<string>();
            infoMessages = new List<string>();
            errorMessagesForGrid = new List<string>();
            infoMessagesForGrid = new List<string>();

            ctx = new XenDevWebDbContext();
            saDAO = new StaffAccountDAO(ctx);
            uaDAO = new UserAccountDAO(ctx);

            string username = System.Web.HttpContext.Current.User.Identity.Name;

            this.currentStaff = saDAO.findByUsername(username, false);
            this.currentUser = uaDAO.findByUsername(username, false);
        }

        protected override void InitializeCulture()
        {
            if (this.currentStaff != null)
            {
                String selectedLanguage = this.currentStaff.language;
                UICulture = selectedLanguage;
                Culture = selectedLanguage;

                Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(selectedLanguage);
                Thread.CurrentThread.CurrentUICulture = new CultureInfo(selectedLanguage);

                culture = CultureInfo.CreateSpecificCulture(Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName);
            }

            if (this.currentUser != null)
            {
                String selectedLanguage = this.currentUser.language;
                UICulture = selectedLanguage;
                Culture = selectedLanguage;

                Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(selectedLanguage);
                Thread.CurrentThread.CurrentUICulture = new CultureInfo(selectedLanguage);

                culture = CultureInfo.CreateSpecificCulture(Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName);
            }

            base.InitializeCulture();
        }
    }
}