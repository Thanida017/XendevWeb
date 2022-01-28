using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.dao;
using XenDevWeb.domain;
using XenDevWeb.Utils;

namespace XenDevWeb
{
    public partial class register : System.Web.UI.Page
    {
        protected CultureInfo culture;
        protected List<string> errorMessage;
        protected List<string> infoMessages;

        private XenDevWebDbContext ctx;
        public CompanyDAO cDAO;
        private UserAccountDAO uaDAO;
        private EmailServerDAO emailDAO;
        protected void Page_Load(object sender, EventArgs e)
        {
            culture = CultureInfo.CreateSpecificCulture(Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName);
            errorMessage = new List<string>();
            infoMessages = new List<string>();

            ctx = new XenDevWebDbContext();
            uaDAO = new UserAccountDAO(ctx);
            emailDAO = new EmailServerDAO(ctx);
            cDAO = new CompanyDAO(ctx);

            if (this.IsPostBack || this.scriptManager.IsInAsyncPostBack)
            {
                return;
            }
        }

        protected void btnRegis_Click(object sender, EventArgs e)
        {
            Page.Validate("vsRegisterGroup");
            if (!Page.IsValid)
            {
                return;
            }

            if (!chk_IsAgree.Checked)
            {
                string err = string.Format(HttpContext.GetLocalResourceObject("~/register.aspx",
                                                                    "please_agree",
                                                                    culture).ToString());
                errorMessage.Add(err);
                return;
            }

            Company comCheck = cDAO.findByName(this.txtCompanyName.Text, false);
            if (comCheck != null)
            {
                string err = string.Format(HttpContext.GetLocalResourceObject("~/register.aspx",
                                                                     "company_name_in_use",
                                                                     culture).ToString(),
                                                        this.txtCompanyName.Text);
                errorMessage.Add(err);
                return;
            }

            comCheck = cDAO.findByTaxId(this.txtTaxID.Text, false);
            if (comCheck != null)
            {
                string err = string.Format(HttpContext.GetLocalResourceObject("~/register.aspx",
                                                                    "taxid_in_use",
                                                                    culture).ToString(),
                                                       this.txtTaxID.Text);
                errorMessage.Add(err);
                return;
            }

            UserAccount uaCheck = uaDAO.findByUsername(this.txtUserName.Text, false);
            if (uaCheck != null)
            {
                string err = string.Format(HttpContext.GetLocalResourceObject("~/register.aspx",
                                                                   "username_in_use",
                                                                   culture).ToString(),
                                                      this.txtUserName.Text);
                errorMessage.Add(err);
                return;
            }

            Company com = new Company();
            com.name = WebUtils.getFieldIfNotNull(this.txtCompanyName.Text);
            com.taxId = WebUtils.getFieldIfNotNull(this.txtTaxID.Text);
            com.enabled = false;
            com.creationDate = DateTime.Now;
            com.lastUpdate = DateTime.Now;

            UserAccount ua = new UserAccount();
            ua.username = WebUtils.getFieldIfNotNull(this.txtUserName.Text);
            ua.language = Constants.LANGUAGE_EN;
            ua.email = WebUtils.getFieldIfNotNull(this.txtEmail.Text);
            ua.password = Encryption.encrypt(this.txtPassWord.Text, true);
            ua.enabled = false;
            ua.company = com;
            ua.creationDate = DateTime.Now;
            ua.lastUpdate = DateTime.Now;
            string newActivationCode = string.Format("{0}{1}", DateTime.Now.Ticks
                                                      , Guid.NewGuid());
            ua.activationCode = Encryption.encrypt(newActivationCode, true).Replace("+", "_");
            uaDAO.create(ua);

            Company objUpdate = cDAO.findById(ua.company.id, true);
            objUpdate.code = string.Format("C{0:yy}{1:00000}", DateTime.Now, ua.company.id);
            objUpdate.lastUpdate = DateTime.Now;
            cDAO.update(objUpdate);

            string resetLink = WebUtils.getAppServerPath() + "/activate.aspx?activationCode=" + ua.activationCode;
            string emailSubject = HttpContext.GetLocalResourceObject("~/register.aspx",
                                                                           "email_title",
                                                                           culture).ToString();
            string emailBody = EmailUtil.getEmailActivationCodeBodyHTML(resetLink, ua.username);

            EmailServer emailServer = emailDAO.getRecentRecord(false);
            bool sendSuccess = EmailUtil.sendEMail(emailServer.stmpAddress,
                                                   int.Parse(emailServer.port),
                                                   emailServer.username,
                                                   emailServer.password,
                                                   emailServer.senderAddress,
                                                   ua.email,
                                                   null,
                                                   emailSubject,
                                                   emailBody);

            if (sendSuccess)
            {
                this.infoMessages.Add(string.Format(HttpContext.GetLocalResourceObject("~/register.aspx",
                                                                        "email_send_successfilly",
                                                                        culture).ToString()
                                                   , this.txtEmail.Text));
                WebUtils.ClearControls(this);
            }
            else
            {
                Response.Redirect(WebUtils.getAppServerPath() + "/activate.aspx?activationCode=" + ua.activationCode);
                //this.errorMessage.Add(string.Format(HttpContext.GetLocalResourceObject("~/register.aspx",
                //                                                        "email_send_failed",
                //                                                        culture).ToString()
                //                                   , this.txtEmail.Text));
            }


            Response.Redirect(WebUtils.getAppServerPath() + "/login.aspx");
        }
    }
}