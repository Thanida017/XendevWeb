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
using XenDevWeb.include;
using XenDevWeb.Utils;

namespace XenDevWeb.admin
{
    public partial class F013_Admin_EmailServerSetup : CRUDPageControler
    {
        private EmailServerDAO emailServerDAO;
        private List<EmailServer> emailServers;

        protected void Page_Load(object sender, EventArgs e)
        {
            emailServerDAO = new EmailServerDAO(ctx);
            culture = CultureInfo.CreateSpecificCulture(Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName);

            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            initForm();
        }

        private void initForm()
        {
            EmailServer obj = this.emailServerDAO.getRecentRecord(false);

            if (obj != null)
            {
                txtSenderAddress.Text = obj.senderAddress;
                txtSmtpAddress.Text = obj.stmpAddress;
                txtPort.Text = obj.port;
                txtUsername.Text = obj.username;
                txtPassword.Text = obj.password;
            }
        }

        protected void btnSaveChange_Click(object sender, EventArgs e)
        {
            Page.Validate("vsSaveSettingGroup");
            if (!Page.IsValid)
            {
                return;
            }

            EmailServer obj = this.emailServerDAO.getRecentRecord(true);

            if (obj != null)
            {
                obj.senderAddress = this.txtSenderAddress.Text;
                obj.stmpAddress = this.txtSmtpAddress.Text;
                obj.port = this.txtPort.Text;
                obj.username = this.txtUsername.Text;
                obj.password = this.txtPassword.Text;

                this.emailServerDAO.update(obj);
            }
            else
            {
                EmailServer new_obj = new EmailServer();

                new_obj.senderAddress = this.txtSenderAddress.Text;
                new_obj.stmpAddress = this.txtSmtpAddress.Text;
                new_obj.port = this.txtPort.Text;
                new_obj.username = this.txtUsername.Text;
                new_obj.password = this.txtPassword.Text;

                this.emailServerDAO.create(new_obj);
            }

            //this.initForm();

            this.infoMessages.Add(HttpContext.GetGlobalResourceObject("GlobalResource", "successfully_savedRc",
                                  culture).ToString());
        }

        protected void btnSendTestEmail_Click(object sender, EventArgs e)
        {
            Page.Validate("vsSendTestEmailGroup");
            if (!Page.IsValid)
            {
                return;
            }

            EmailServer emailServer = emailServerDAO.getRecentRecord(false);

            bool sendSuccess = false;
            try
            {
                sendSuccess = EmailUtil.sendEMail(emailServer.stmpAddress,
                                               int.Parse(emailServer.port),
                                               emailServer.username,
                                               emailServer.password,
                                               emailServer.senderAddress,
                                               this.txtReceiverEmailAddress.Text,
                                               null,
                                               "Panus Web App - Test Sending",
                                               "<h1>Hello Test EMail</h1>");
            }
            catch (Exception ioe)
            {
                sendSuccess = false;
                this.errorMessages.Add(ioe.ToString());
            }

            if (sendSuccess)
            {
                this.infoMessages.Add(string.Format(HttpContext.GetGlobalResourceObject("GlobalResource", "email_sended_success",
                                                        culture).ToString(),
                                                        this.txtReceiverEmailAddress.Text));
            }
            else
            {
                this.errorMessages.Add(string.Format(HttpContext.GetGlobalResourceObject("GlobalResource", "email_sended_failed",
                                                        culture).ToString(),
                                                        this.txtReceiverEmailAddress.Text));
            }
        }
    }
}