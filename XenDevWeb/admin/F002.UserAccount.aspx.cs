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
    public partial class F002_UserAccount : CRUDPageControler
    {
        private CompanyDAO comDAO;

        private List<UserAccount> users;

        protected void Page_Load(object sender, EventArgs e)
        {
            comDAO = new CompanyDAO(ctx);

            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            this.initForm();
        }

        private void initForm()
        {
            this.txtRowPerPage.Text = Constants.DEFAULT_ROW_PER_PAGE.ToString();
            populateTitle(this.selTitle);
            populateCompany(this.selCompany);
            populateCompany(this.selSearchCompany);
            populateSearchType();
            bindAppUserList();
        }

        private void populateSearchType()
        {
            this.selAppUserGridSearchType.Items.Clear();

            ListItem liAppUserEmp = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F002.UserAccount.aspx",
                                                                                   "lblEmpNumberRc.text",
                                                                                    culture).ToString(), "0");
            this.selAppUserGridSearchType.Items.Add(liAppUserEmp);
            ListItem liUserName = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F002.UserAccount.aspx",
                                                                                  "lblUserNameRc.text",
                                                                                   culture).ToString(), "1");
            this.selAppUserGridSearchType.Items.Add(liUserName);
            ListItem liFirstName = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F002.UserAccount.aspx",
                                                                                  "lblFirstNameRc.text",
                                                                                   culture).ToString(), "2");
            this.selAppUserGridSearchType.Items.Add(liFirstName);
            ListItem liLastName = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F002.UserAccount.aspx",
                                                                                  "lblLastNameRc.text",
                                                                                   culture).ToString(), "3");
            this.selAppUserGridSearchType.Items.Add(liLastName);

        }

        private void populateTitle(DropDownList list)
        {
            list.Items.Clear();

            string mr = HttpContext.GetGlobalResourceObject("GlobalResource", "mr", culture).ToString();
            list.Items.Add(new ListItem(mr, "0"));

            string miss = HttpContext.GetGlobalResourceObject("GlobalResource", "miss", culture).ToString();
            list.Items.Add(new ListItem(miss, "1"));

            string ms = HttpContext.GetGlobalResourceObject("GlobalResource", "ms", culture).ToString();
            list.Items.Add(new ListItem(ms, "2"));

            string khun = HttpContext.GetGlobalResourceObject("GlobalResource", "khun", culture).ToString();
            list.Items.Add(new ListItem(khun, "3"));
        }

        private void populateCompany(DropDownList sel)
        {
            sel.Items.Clear();

            List<Company> coms = comDAO.getAllEnabledCompanies(false);

            foreach(Company com in coms)
            {
                ListItem li = new ListItem(string.Format("{0} ({1})", com.name, com.code), com.id.ToString());
                sel.Items.Add(li);
            }            
        }

        private void bindAppUserList()
        {
            this.users = this.uaDAO.getCompanyUserAccount(long.Parse(this.selSearchCompany.SelectedValue));
            
            if (!ValidationUtil.isEmpty(this.txtSearchGridText.Text)) 
            {
                switch (this.selAppUserGridSearchType.SelectedIndex)
                {
                    case 0:
                        this.users = this.users.Where(u => u.empNo.ToLower().IndexOf(this.txtSearchGridText.Text.ToLower()) >= 0).ToList();
                        break;
                    case 1:
                        this.users = this.users.Where(u => u.username.ToLower().IndexOf(this.txtSearchGridText.Text.ToLower()) >= 0).ToList();
                        break;
                    case 2:
                        this.users = this.users.Where(u => u.firstName.ToLower().IndexOf(this.txtSearchGridText.Text.ToLower()) >= 0).ToList();
                        break;
                    case 3:
                        this.users = this.users.Where(u => u.lastName.ToLower().IndexOf(this.txtSearchGridText.Text.ToLower()) >= 0).ToList();
                        break;
                }
            }
            this.appUserGridView.PageSize = int.Parse(this.txtRowPerPage.Text);
            this.appUserGridView.DataSource = users;
            this.appUserGridView.DataBind();
           
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            Page.Validate("vsUserAdditionGroup");
            if (!Page.IsValid)
            {
                return;
            }

            //Check existing empno
            if (this.saDAO.findByEmpNo(this.txtEmpNumber.Text, false) != null)
            {
                errorMessages.Add(string.Format(HttpContext.GetLocalResourceObject("~/admin/F002.UserAccount.aspx",
                                                                     "empNoExists",
                                                                     culture).ToString(),
                                                this.txtEmpNumber.Text));
                return;
            }

            //Check existing username
            if (this.saDAO.findByUsername(this.txtUsername.Text, false) != null)
            {
                errorMessages.Add(string.Format(HttpContext.GetLocalResourceObject("~/admin/F002.UserAccount.aspx",
                                                                     "userNameExists",
                                                                     culture).ToString(),
                                                this.txtUsername.Text));
                return;
            }

            StaffAccount saCheck = saDAO.findByUsername(this.txtUsername.Text, false);
            if (saCheck != null)
            {
                errorMessages.Add(string.Format(HttpContext.GetLocalResourceObject("~/admin/F002.UserAccount.aspx",
                                                                     "userNameExists",
                                                                     culture).ToString(),
                                                this.txtUsername.Text));
                return;
            }

            //Lets go create
            UserAccount aUser = new UserAccount();
            aUser.empNo = this.txtEmpNumber.Text;

            switch (this.selTitle.SelectedIndex)
            {
                case 0:
                    aUser.title = PERSON_TITLE.MR;
                    break;
                case 1:
                    aUser.title = PERSON_TITLE.MISS;
                    break;
                case 2:
                    aUser.title = PERSON_TITLE.MS;
                    break;
                case 3:
                    aUser.title = PERSON_TITLE.KHUN;
                    break;
            }
            aUser.company = comDAO.findById(long.Parse(this.selCompany.SelectedValue), true);
            aUser.firstName = this.txtFirstName.Text;
            aUser.lastName = this.txtLastName.Text;
            aUser.username = this.txtUsername.Text;
            aUser.password = Encryption.encrypt(this.txtPassword.Text, true);
            aUser.enabled = true;
            aUser.email = WebUtils.getFieldIfNotNull(this.txtEmail.Text);
            aUser.mobilePhoneNumber = WebUtils.getFieldIfNotNull(this.txtMobile.Text);
            aUser.language = Constants.LANGUAGE_EN;
            aUser.creationDate = DateTime.Now;
            aUser.lastUpdate = DateTime.Now;
            aUser.isAdmin = this.chkIsAdmin.Checked;

            this.uaDAO.create(aUser);

            //Clear form
            WebUtils.ClearControls(this);
            initForm();
            bindAppUserList();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
            //Notify user
            this.infoMessages.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                             "successfully_savedRc",
                                                                             culture).ToString());
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Page.Validate("vsSearchGroup");
            if (!Page.IsValid)
            {
                return;
            }
            this.bindAppUserList();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void appUserGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.appUserGridView.PageIndex = e.NewPageIndex;
            bindAppUserList();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void appUserGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            this.appUserGridView.EditIndex = e.NewEditIndex;
            bindAppUserList();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void appUserGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Page.Validate("vsUserEditGroup");
            if (!Page.IsValid)
            {
                return;
            }
            GridViewRow row = this.appUserGridView.Rows[e.RowIndex];
            Label lblAppUserGrid_Id = row.FindControl("lblAppUserGrid_Id") as Label;
            TextBox empNumberGrid = row.FindControl("txtAppUserGrid_EmpNo") as TextBox;
            DropDownList titleGrid = row.FindControl("selAppUserGrid_Title") as DropDownList;
            DropDownList selAppUserGrid_Company = row.FindControl("selAppUserGrid_Company") as DropDownList;
            TextBox firstNameGrid = row.FindControl("txtAppUserGrid_FirstName") as TextBox;
            TextBox lastNameGrid = row.FindControl("txtAppUserGrid_LastName") as TextBox;
            TextBox usernameGrid = row.FindControl("txtAppUserGrid_UserName") as TextBox;
            TextBox passwordGrid = row.FindControl("txtAppUserGrid_Password") as TextBox;
            TextBox email = row.FindControl("txtAppUserGrid_EMail") as TextBox;
            TextBox mobileNumber = row.FindControl("txtAppUserGrid_Mobile") as TextBox;

            CheckBox chkEnabledGrid = row.FindControl("chkAppUserGrid_IsEnabled") as CheckBox;
            CheckBox chkIsAdminGrid = row.FindControl("chkAppUserGrid_IsAdmin") as CheckBox;

            long userToUpdateId = long.Parse(lblAppUserGrid_Id.Text);

            UserAccount user = this.uaDAO.findById(userToUpdateId, true);

            //Check existing empno
            UserAccount someone = this.uaDAO.findByEmpNo(empNumberGrid.Text, false);
            if (someone != null && someone.id != user.id)
            {
                errorMessagesForGrid.Add(string.Format(HttpContext.GetLocalResourceObject("~/admin/F002.UserAccount.aspx",
                                                                     "empNoExists",
                                                                     culture).ToString(),
                                                empNumberGrid.Text));
                return;
            }

            //Check existing username
            someone = this.uaDAO.findByUsername(usernameGrid.Text, false);
            if (someone != null && someone.id != user.id)
            {
                errorMessagesForGrid.Add(string.Format(HttpContext.GetLocalResourceObject("~/admin/F002.UserAccount.aspx",
                                                                     "userNameExists",
                                                                     culture).ToString(),
                                                usernameGrid.Text));
                return;
            }

            StaffAccount saCheck = saDAO.findByUsername(usernameGrid.Text, false);
            if (saCheck != null && saCheck.id != user.id)
            {
                errorMessagesForGrid.Add(string.Format(HttpContext.GetLocalResourceObject("~/admin/F002.UserAccount.aspx",
                                                                     "userNameExists",
                                                                     culture).ToString(),
                                                usernameGrid.Text));
                return;
            }

            //Every thing is ok, lets update
            user.empNo = empNumberGrid.Text;
            switch (titleGrid.SelectedIndex)
            {
                case 0:
                    user.title = PERSON_TITLE.MR;
                    break;
                case 1:
                    user.title = PERSON_TITLE.MISS;
                    break;
                case 2:
                    user.title = PERSON_TITLE.MS;
                    break;
                case 3:
                    user.title = PERSON_TITLE.KHUN;
                    break;
            }

            user.firstName = firstNameGrid.Text;
            user.lastName = lastNameGrid.Text;
            user.username = usernameGrid.Text;

            //Update password if and only if defined
            if (!ValidationUtil.isEmpty(passwordGrid.Text))
            {
                string pwdEncrypt = Encryption.encrypt(passwordGrid.Text, true);
                if (user.password.CompareTo(pwdEncrypt) != 0)
                {
                    user.password = pwdEncrypt;
                }
            }
            user.company = comDAO.findById(long.Parse(selAppUserGrid_Company.SelectedValue), true);
            user.enabled = chkEnabledGrid.Checked;
            user.email = email.Text;
            user.mobilePhoneNumber = WebUtils.getFieldIfNotNull(mobileNumber.Text);

            user.lastUpdate = DateTime.Now;
            user.isAdmin = chkIsAdminGrid.Checked;
            this.uaDAO.update(user);

            //Refresh grid
            appUserGridView.EditIndex = -1;
            bindAppUserList();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
            //Notify user
            this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                             "successfully_savedRc",
                                                                             culture).ToString());
        }

        protected void appUserGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            this.appUserGridView.EditIndex = -1;
            bindAppUserList();
        }

        protected void appUserGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }

            if (this.users == null || e.Row.RowIndex >= this.users.Count)
            {
                return;
            }

            int offset = this.appUserGridView.PageIndex * this.appUserGridView.PageSize;
            UserAccount user = this.users[offset + e.Row.RowIndex];

            //Enabled
            CheckBox chkEnabled = e.Row.FindControl("chkAppUserGrid_IsEnabled") as CheckBox;
            chkEnabled.Checked = user.enabled;

            CheckBox chkIsAdmin = e.Row.FindControl("chkAppUserGrid_IsAdmin") as CheckBox;
            chkIsAdmin.Checked = user.isAdmin;

            if ((e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                //Title
                DropDownList list = e.Row.FindControl("selAppUserGrid_Title") as DropDownList;
                DropDownList selAppUserGrid_Company = e.Row.FindControl("selAppUserGrid_Company") as DropDownList;
                TextBox txtAppUserGrid_EmpNo = e.Row.FindControl("txtAppUserGrid_EmpNo") as TextBox;
                TextBox txtAppUserGrid_FirstName = e.Row.FindControl("txtAppUserGrid_FirstName") as TextBox;
                TextBox txtAppUserGrid_LastName = e.Row.FindControl("txtAppUserGrid_LastName") as TextBox;
                TextBox txtAppUserGrid_UserName = e.Row.FindControl("txtAppUserGrid_UserName") as TextBox;
                TextBox txtAppUserGrid_EMail = e.Row.FindControl("txtAppUserGrid_EMail") as TextBox;
                TextBox txtAppUserGrid_Mobile = e.Row.FindControl("txtAppUserGrid_Mobile") as TextBox;

                txtAppUserGrid_EmpNo.Text = user.empNo;
                txtAppUserGrid_FirstName.Text = user.firstName;
                txtAppUserGrid_LastName.Text = user.lastName;
                txtAppUserGrid_UserName.Text = user.username;
                txtAppUserGrid_EMail.Text = user.email;
                txtAppUserGrid_Mobile.Text = user.mobilePhoneNumber;
                
                populateTitle(list);
                switch (user.title)
                {
                    case PERSON_TITLE.MR:
                        list.SelectedIndex = 0;
                        break;
                    case PERSON_TITLE.MISS:
                        list.SelectedIndex = 1;
                        break;
                    case PERSON_TITLE.MS:
                        list.SelectedIndex = 2;
                        break;
                    case PERSON_TITLE.KHUN:
                        list.SelectedIndex = 3;
                        break;
                }

                populateCompany(selAppUserGrid_Company);

                if (user.company != null)
                {
                    selAppUserGrid_Company.SelectedValue = user.company.id.ToString();
                }
                
            }
            else
            {
                //Title
                Label lbl = e.Row.FindControl("lblAppUserGrid_title") as Label;
                Label lblAppUserGrid_EmpNo = e.Row.FindControl("lblAppUserGrid_EmpNo") as Label;
                Label lblAppUserGrid_FirstName = e.Row.FindControl("lblAppUserGrid_FirstName") as Label;
                Label lblAppUserGrid_LastName = e.Row.FindControl("lblAppUserGrid_LastName") as Label;
                Label lblAppUserGrid_UserName = e.Row.FindControl("lblAppUserGrid_UserName") as Label;
                Label lblAppUserGrid_Email = e.Row.FindControl("lblAppUserGrid_Email") as Label;
                Label lblAppUserGrid_Mobile = e.Row.FindControl("lblAppUserGrid_Mobile") as Label;

                lblAppUserGrid_EmpNo.Text = user.empNo;
                lblAppUserGrid_FirstName.Text = user.firstName;
                lblAppUserGrid_LastName.Text = user.lastName;
                lblAppUserGrid_UserName.Text = user.username;
                lblAppUserGrid_Email.Text = user.email;
                lblAppUserGrid_Mobile.Text = user.mobilePhoneNumber;

                switch (user.title)
                {
                    case PERSON_TITLE.MR:
                        lbl.Text = HttpContext.GetGlobalResourceObject("GlobalResource", "mr", culture).ToString();
                        break;
                    case PERSON_TITLE.MISS:
                        lbl.Text = HttpContext.GetGlobalResourceObject("GlobalResource", "miss", culture).ToString();
                        break;
                    case PERSON_TITLE.MS:
                        lbl.Text = HttpContext.GetGlobalResourceObject("GlobalResource", "ms", culture).ToString();
                        break;
                    case PERSON_TITLE.KHUN:
                        lbl.Text = HttpContext.GetGlobalResourceObject("GlobalResource", "khun", culture).ToString();
                        break;
                }

                Label lblAppUserGrid_Company = e.Row.FindControl("lblAppUserGrid_Company") as Label;
                if(user.company != null)
                {
                    lblAppUserGrid_Company.Text = string.Format("{0} ({1})", user.company.name, user.company.code);
                }
                
            }
        }

        protected void appUserGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.CompareTo("itemRowDelete") == 0)
            {
                int id = int.Parse(e.CommandArgument.ToString());
                
                //Delete user
                UserAccount user = this.uaDAO.findById(id, true);
                this.uaDAO.delete(user);

                //Update GUI
                this.bindAppUserList();

                //Notify user
                this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                                 "successfully_deletedRc",
                                                                                 culture).ToString());
            }
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void btnDelete_Load(object sender, EventArgs e)
        {
            LinkButton deleteBtn = (LinkButton)sender;
            this.UpdatePanel1.Triggers.Add(new AsyncPostBackTrigger
            {
                ControlID = deleteBtn.UniqueID,
                EventName = "click"
            }
                 );
        }

        protected void btnImage_Command(object sender, CommandEventArgs e)
        {
            string uaId = e.CommandArgument.ToString();
            Response.Redirect("F002.1.UserImage.aspx?uaId=" + HttpUtility.UrlEncode(QueryStringModule.Encrypt(uaId)), true);
        }
    }
}