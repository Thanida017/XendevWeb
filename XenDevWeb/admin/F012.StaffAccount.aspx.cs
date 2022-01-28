using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.dao;
using XenDevWeb.domain;
using XenDevWeb.include;
using XenDevWeb.Utils;

namespace XenDevWeb.admin
{
    public partial class F012_StaffAccount : CRUDPageControler
    {
        public List<StaffAccount> allStaffAccount;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }
           
            initForm();
        }

        private void initForm()
        {
            this.txtRowPerPage.Text = Constants.DEFAULT_ROW_PER_PAGE.ToString();
            populateTitle(this.selTitle);
            populateSearchType();
            bindStffAccount();
        }

        private void populateSearchType()
        {
            this.selGridSearchType.Items.Clear();

            ListItem liEmp = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F012.StaffAccount.aspx",
                                                                                   "lblEmpNumberRc.text",
                                                                                    culture).ToString(), "0");
            this.selGridSearchType.Items.Add(liEmp);
            ListItem liUserName = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F012.StaffAccount.aspx",
                                                                                  "lblUserNameRc.text",
                                                                                   culture).ToString(), "1");
            this.selGridSearchType.Items.Add(liUserName);
            ListItem liFirstName = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F012.StaffAccount.aspx",
                                                                                  "lblFirstNameRc.text",
                                                                                   culture).ToString(), "2");
            this.selGridSearchType.Items.Add(liFirstName);
            ListItem liLastName = new ListItem(HttpContext.GetLocalResourceObject("~/admin/F012.StaffAccount.aspx",
                                                                                  "lblLastNameRc.text",
                                                                                   culture).ToString(), "3");
            this.selGridSearchType.Items.Add(liLastName);

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

        private void bindStffAccount()
        {
            this.allStaffAccount = this.saDAO.getAllEnableStaffAccount(false);

            if (!ValidationUtil.isEmpty(this.txtSearchGridText.Text))
            {
                switch (this.selGridSearchType.SelectedIndex)
                {
                    case 0:
                        this.allStaffAccount = this.allStaffAccount.Where(u => u.empNo.ToLower().IndexOf(this.txtSearchGridText.Text.ToLower()) >= 0).ToList();                        
                        break;
                    case 1:
                        this.allStaffAccount = this.allStaffAccount.Where(u => u.username.ToLower().IndexOf(this.txtSearchGridText.Text.ToLower()) >= 0).ToList();
                        break;
                    case 2:
                        this.allStaffAccount = this.allStaffAccount.Where(u => u.firstName.ToLower().IndexOf(this.txtSearchGridText.Text.ToLower()) >= 0).ToList();
                        break;
                    case 3:
                        this.allStaffAccount = this.allStaffAccount.Where(u => u.lastName.ToLower().IndexOf(this.txtSearchGridText.Text.ToLower()) >= 0).ToList();
                        break;
                }
            }

            this.appStaffGridView.PageSize = int.Parse(this.txtRowPerPage.Text);
            this.appStaffGridView.DataSource = allStaffAccount;
            this.appStaffGridView.DataBind();
        }

        protected void btnAddStaff_Click(object sender, EventArgs e)
        {
            Page.Validate("vsStaffAdditionGroup");
            if (!Page.IsValid)
            {
                return;
            }

            StaffAccount check = this.saDAO.findByEmpNo(this.txtEmpNumber.Text, false);
            if (check != null)
            {
                errorMessages.Add(string.Format(HttpContext.GetLocalResourceObject("~/admin/F012.StaffAccount.aspx",
                                                                     "empNoExists",
                                                                     culture).ToString(),
                                                this.txtEmpNumber.Text));
                return;
            }

            //Check existing username
            check = this.saDAO.findByUsername(this.txtUsername.Text, false);
            if (check != null)
            {
                errorMessages.Add(string.Format(HttpContext.GetLocalResourceObject("~/admin/F012.StaffAccount.aspx",
                                                                     "userNameExists",
                                                                     culture).ToString(),
                                                this.txtUsername.Text));
                return;
            }

            UserAccount uaCheck = uaDAO.findByUsername(this.txtUsername.Text, false);
            if (uaCheck != null)
            {
                errorMessages.Add(string.Format(HttpContext.GetLocalResourceObject("~/admin/F012.StaffAccount.aspx",
                                                                     "userNameExists",
                                                                     culture).ToString(),
                                                this.txtUsername.Text));
                return;
            }

            //Lets go create
            StaffAccount sa = new StaffAccount();
            sa.empNo = this.txtEmpNumber.Text;

            switch (this.selTitle.SelectedIndex)
            {
                case 0:
                    sa.title = PERSON_TITLE.MR;
                    break;
                case 1:
                    sa.title = PERSON_TITLE.MISS;
                    break;
                case 2:
                    sa.title = PERSON_TITLE.MS;
                    break;
                case 3:
                    sa.title = PERSON_TITLE.KHUN;
                    break;
            }

            sa.firstName = WebUtils.getFieldIfNotNull(this.txtFirstName.Text);
            sa.lastName = WebUtils.getFieldIfNotNull(this.txtLastName.Text);
            sa.username = WebUtils.getFieldIfNotNull(this.txtUsername.Text);
            sa.password = Encryption.encrypt(this.txtPassword.Text, true);
            sa.enabled = true;
            sa.email = WebUtils.getFieldIfNotNull(this.txtEmail.Text);
            sa.mobilePhoneNumber = WebUtils.getFieldIfNotNull(this.txtMobile.Text);
            sa.language = Constants.LANGUAGE_EN;
            sa.creationDate = DateTime.Now;
            sa.lastUpdate = DateTime.Now;
            sa.isAdmin = this.chkIsAdmin.Checked;

            this.saDAO.create(sa);

            //Clear form
            WebUtils.ClearControls(this);
            initForm();
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
            this.bindStffAccount();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void appStaffGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.appStaffGridView.PageIndex = e.NewPageIndex;
            this.bindStffAccount();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void appStaffGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            this.appStaffGridView.EditIndex = e.NewEditIndex;
            bindStffAccount();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void appStaffGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Page.Validate("vsUserEditGroup");
            if (!Page.IsValid)
            {
                return;
            }
            GridViewRow row = this.appStaffGridView.Rows[e.RowIndex];
            Label lblAppStaffGrid_Id = row.FindControl("lblAppStaffGrid_Id") as Label;
            TextBox empNumberGrid = row.FindControl("txtGrid_EmpNo") as TextBox;
            DropDownList titleGrid = row.FindControl("selGrid_Title") as DropDownList;
            DropDownList selGrid_Company = row.FindControl("selGrid_Company") as DropDownList;
            TextBox firstNameGrid = row.FindControl("txtGrid_FirstName") as TextBox;
            TextBox lastNameGrid = row.FindControl("txtGrid_LastName") as TextBox;
            TextBox usernameGrid = row.FindControl("txtGrid_UserName") as TextBox;
            TextBox passwordGrid = row.FindControl("txtGrid_Password") as TextBox;
            TextBox email = row.FindControl("txtGrid_EMail") as TextBox;
            TextBox mobileNumber = row.FindControl("txtGrid_Mobile") as TextBox;

            CheckBox chkEnabledGrid = row.FindControl("chkGrid_IsEnabled") as CheckBox;
            CheckBox chkIsAdminGrid = row.FindControl("chkGrid_IsAdmin") as CheckBox;

            long userToUpdateId = long.Parse(lblAppStaffGrid_Id.Text);

            StaffAccount staff = this.saDAO.findById(userToUpdateId, true);

            //Check existing empno
            StaffAccount someone = this.saDAO.findByEmpNo(empNumberGrid.Text, false);
            if (someone != null && someone.id != staff.id)
            {
                errorMessagesForGrid.Add(string.Format(HttpContext.GetLocalResourceObject("~/admin/F012.StaffAccount.aspx",
                                                                     "empNoExists",
                                                                     culture).ToString(),
                                                empNumberGrid.Text));
                return;
            }

            //Check existing username
            someone = this.saDAO.findByUsername(usernameGrid.Text, false);
            if (someone != null && someone.id != staff.id)
            {
                errorMessagesForGrid.Add(string.Format(HttpContext.GetLocalResourceObject("~/admin/F012.StaffAccount.aspx",
                                                                     "userNameExists",
                                                                     culture).ToString(),
                                                usernameGrid.Text));
                return;
            }

            UserAccount uaCheck = uaDAO.findByUsername(usernameGrid.Text, false);
            if (uaCheck != null && uaCheck.id != staff.id)
            {
                errorMessages.Add(string.Format(HttpContext.GetLocalResourceObject("~/admin/F012.StaffAccount.aspx",
                                                                     "userNameExists",
                                                                     culture).ToString(),
                                                this.txtUsername.Text));
                return;
            }

            //Every thing is ok, lets update
            staff.empNo = empNumberGrid.Text;
            switch (titleGrid.SelectedIndex)
            {
                case 0:
                    staff.title = PERSON_TITLE.MR;
                    break;
                case 1:
                    staff.title = PERSON_TITLE.MISS;
                    break;
                case 2:
                    staff.title = PERSON_TITLE.MS;
                    break;
                case 3:
                    staff.title = PERSON_TITLE.KHUN;
                    break;
            }

            staff.firstName = firstNameGrid.Text;
            staff.lastName = lastNameGrid.Text;
            staff.username = usernameGrid.Text;

            //Update password if and only if defined
            if (!ValidationUtil.isEmpty(passwordGrid.Text))
            {
                string pwdEncrypt = Encryption.encrypt(passwordGrid.Text, true);
                if (staff.password.CompareTo(pwdEncrypt) != 0)
                {
                    staff.password = pwdEncrypt;
                }
            }
            staff.enabled = chkEnabledGrid.Checked;
            staff.email = email.Text;
            staff.mobilePhoneNumber = WebUtils.getFieldIfNotNull(mobileNumber.Text);

            staff.lastUpdate = DateTime.Now;
            staff.isAdmin = chkIsAdminGrid.Checked;
            this.saDAO.update(staff);

            //Refresh grid
            appStaffGridView.EditIndex = -1;
            bindStffAccount();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
            //Notify user
            this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                             "successfully_savedRc",
                                                                             culture).ToString());
        }
        
        protected void appStaffGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }
            
            StaffAccount staff = e.Row.DataItem as StaffAccount;

            //Enabled
            CheckBox chkEnabled = e.Row.FindControl("chkGrid_IsEnabled") as CheckBox;
            chkEnabled.Checked = staff.enabled;

            CheckBox chkIsAdmin = e.Row.FindControl("chkGrid_IsAdmin") as CheckBox;
            chkIsAdmin.Checked = staff.isAdmin;

            if ((e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                //Title
                DropDownList list = e.Row.FindControl("selGrid_Title") as DropDownList;
                TextBox txtGrid_EmpNo = e.Row.FindControl("txtGrid_EmpNo") as TextBox;
                TextBox txtGrid_FirstName = e.Row.FindControl("txtGrid_FirstName") as TextBox;
                TextBox txtGrid_LastName = e.Row.FindControl("txtGrid_LastName") as TextBox;
                TextBox txtGrid_UserName = e.Row.FindControl("txtGrid_UserName") as TextBox;
                TextBox txtGrid_EMail = e.Row.FindControl("txtGrid_EMail") as TextBox;
                TextBox txtGrid_Mobile = e.Row.FindControl("txtGrid_Mobile") as TextBox;

                txtGrid_EmpNo.Text = staff.empNo;
                txtGrid_FirstName.Text = staff.firstName;
                txtGrid_LastName.Text = staff.lastName;
                txtGrid_UserName.Text = staff.username;
                txtGrid_EMail.Text = staff.email;
                txtGrid_Mobile.Text = staff.mobilePhoneNumber;
                populateTitle(list);
                switch (staff.title)
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

            }
            else
            {
                //Title
                Label lbl = e.Row.FindControl("lblGrid_title") as Label;
                Label lblGrid_EmpNo = e.Row.FindControl("lblGrid_EmpNo") as Label;
                Label lblGrid_FirstName = e.Row.FindControl("lblGrid_FirstName") as Label;
                Label lblGrid_LastName = e.Row.FindControl("lblGrid_LastName") as Label;
                Label lblGrid_UserName = e.Row.FindControl("lblGrid_UserName") as Label;
                Label lblGrid_Email = e.Row.FindControl("lblGrid_Email") as Label;
                Label lblGrid_Mobile = e.Row.FindControl("lblGrid_Mobile") as Label;

                lblGrid_EmpNo.Text = staff.empNo;
                lblGrid_FirstName.Text = staff.firstName;
                lblGrid_LastName.Text = staff.lastName;
                lblGrid_UserName.Text = staff.username;
                lblGrid_Email.Text = staff.email;
                lblGrid_Mobile.Text = staff.mobilePhoneNumber;
                switch (staff.title)
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
                
            }
        }

        protected void appStaffGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            this.appStaffGridView.EditIndex = -1;
            this.bindStffAccount();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void btnImage_Command(object sender, CommandEventArgs e)
        {
            string saId = e.CommandArgument.ToString();
            Response.Redirect("F012.1.StaffAccountImage.aspx?saId=" + HttpUtility.UrlEncode(QueryStringModule.Encrypt(saId)), true);
        }

        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            long idToDelete = long.Parse(e.CommandArgument.ToString());

            try
            {
                StaffAccount saDelte = saDAO.findById(idToDelete, true);

                saDAO.delete(saDelte);
                bindStffAccount();
                this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource", "successfully_savedRc", culture).ToString());
            }
            catch (Exception ex)
            {
                this.errorMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource", "dataIsUse", culture).ToString());
            }
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }
    }
}