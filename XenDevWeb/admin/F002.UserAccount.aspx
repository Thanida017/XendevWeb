<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="F002.UserAccount.aspx.cs" 
    Inherits="XenDevWeb.admin.F002_UserAccount" 
    MasterPageFile="~/include/master.Master" 
    meta:resourcekey="PageResource1"
    MaintainScrollPositionOnPostback="true" %>

<%@ Import Namespace="XenDevWeb.Utils" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentMainPlaceHolder" runat="Server">
    <head runat="server">
    </head>
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-xs-12">
                    <section class="panel">
                        <header class="panel-heading tab-bg-dark-navy-blue tab-right ">
                            <span class="hidden-sm wht-color">
                                <strong><asp:Label ID="lblNewUser" runat="server" meta:resourcekey="lblNewUserRc" /></strong>
                            </span>
                        </header>
                        <div class="panel-body">
                            <div class="tab-content">
                                <form id="myForm" role="form" runat="server">
                                    <asp:ScriptManager ID="scriptManager" runat="server" EnableScriptGlobalization="true"></asp:ScriptManager>
                                    <asp:UpdateProgress ID="updProgress" runat="server">
                                        <ProgressTemplate>
                                            <img alt="progress"
                                                style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 100;"
                                                src="<%= WebUtils.getAppServerPath() %>/include/img/loading.gif" />
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                   <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <%= WebUtils.getErrorMessage(this.errorMessages) %>
                                            <%= WebUtils.getInfoMessage(this.infoMessages) %>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b><asp:Label ID="lblAddUserHeader" runat="server" meta:resourcekey="lblNewUserRc" /></b>
                                                </header>
                                                <asp:panel runat="server" class="panel-body" DefaultButton="btnAddUser">
                                                    <div class="row">
                                                         <div class="col-lg-2 col-md-3 col-xs-6" style="padding:5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblCompany" runat="server" meta:resourcekey="lblCompanyRc" AssociatedControlID="selCompany" />
                                                                <asp:DropDownList CssClass="form-control"
                                                                                ID="selCompany"
                                                                                Style="color: #0094ff"
                                                                                AutoPostBack="false"
                                                                                runat="server">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-1 col-md-3 col-xs-6" style="padding:5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblEmpNumber" runat="server"  meta:resourcekey="lblEmpNumberRc" AssociatedControlID="txtEmpNumber" />
                                                                <asp:TextBox ID="txtEmpNumber"
                                                                             Width="98.5%"
                                                                             runat="server"
                                                                             ForeColor="#0094ff"
                                                                             BackColor="#FAF4AB"
                                                                             CssClass="form-control"
                                                                             meta:resourcekey="txtEmpNumberRc" />
                                                                <asp:RequiredFieldValidator ID="rfvEmpNumber" 
                                                                                            runat="server"  
                                                                                            ValidationGroup="vsUserAdditionGroup"
                                                                                            ControlToValidate="txtEmpNumber"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtEmpNumberRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-1 col-md-3 col-xs-6" style="padding:5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblTitle" runat="server" meta:resourcekey="lblTitleRc" AssociatedControlID="selTitle" />
                                                                <asp:DropDownList CssClass="form-control"
                                                                                ID="selTitle"
                                                                                Style="color: #0094ff"
                                                                                AutoPostBack="false"
                                                                                runat="server">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding:5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                    <asp:Label ID="lblFirstName" runat="server"  meta:resourcekey="lblFirstNameRc" AssociatedControlID="txtFirstName" />
                                                                    <asp:TextBox ID="txtFirstName"
                                                                                 Width="98.5%"
                                                                                 runat="server"
                                                                                 ForeColor="#0094ff"
                                                                                 BackColor="#FAF4AB"
                                                                                 CssClass="form-control"
                                                                                 meta:resourcekey="txtFirstNameRc" />
                                                                    <asp:RequiredFieldValidator ID="rfvFirstName" 
                                                                                                runat="server"  
                                                                                                ValidationGroup="vsUserAdditionGroup"
                                                                                                ControlToValidate="txtFirstName"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtFirstNameRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding:5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                    <asp:Label ID="lblLastName" runat="server"  meta:resourcekey="lblLastNameRc" AssociatedControlID="txtLastName" />
                                                                    <asp:TextBox ID="txtLastName"
                                                                                 Width="98.5%"
                                                                                 runat="server"
                                                                                 ForeColor="#0094ff"
                                                                                 BackColor="#FAF4AB"
                                                                                 CssClass="form-control"
                                                                                 meta:resourcekey="txtLastNameRc" />
                                                                    <asp:RequiredFieldValidator ID="rfvLastName" 
                                                                                                runat="server"  
                                                                                                ValidationGroup="vsUserAdditionGroup"
                                                                                                ControlToValidate="txtLastName"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtLastNameRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding:5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                    <asp:Label ID="lblEMail" runat="server"  meta:resourcekey="lblEMailRc" AssociatedControlID="txtEmail" />
                                                                    <asp:TextBox ID="txtEmail"
                                                                                 Width="98.5%"
                                                                                 runat="server"
                                                                                 ForeColor="#0094ff"
                                                                                 BackColor="#FAF4AB"
                                                                                 CssClass="form-control"
                                                                                 meta:resourcekey="txtEmailRc" />
                                                                    <asp:RequiredFieldValidator ID="rfvEmail" 
                                                                                                runat="server"  
                                                                                                ValidationGroup="vsUserAdditionGroup"
                                                                                                ControlToValidate="txtEmail"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtEmailRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding:5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                    <asp:Label ID="lblUsername" runat="server"  meta:resourcekey="lblUserNameRc" AssociatedControlID="txtUsername" />
                                                                    <asp:TextBox ID="txtUsername"
                                                                                 Width="98.5%"
                                                                                 runat="server"
                                                                                 ForeColor="#0094ff"
                                                                                 BackColor="#FAF4AB"
                                                                                 CssClass="form-control"
                                                                                 meta:resourcekey="txtUserNameRc" />
                                                                    <asp:RequiredFieldValidator ID="rfvUsername" 
                                                                                                runat="server"  
                                                                                                ValidationGroup="vsUserAdditionGroup"
                                                                                                ControlToValidate="txtUserName"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtUserNameRc" />
                                                            </div>
                                                        </div>
                                                        
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding:5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                    <asp:Label ID="lblPassword" runat="server"  meta:resourcekey="lblPasswordRc" AssociatedControlID="txtPassword" />
                                                                    <asp:TextBox ID="txtPassword"
                                                                                 TextMode="password"
                                                                                 Width="98.5%"
                                                                                 runat="server"
                                                                                 ForeColor="#0094ff"
                                                                                 BackColor="#FAF4AB"
                                                                                 CssClass="form-control"
                                                                                 meta:resourcekey="txtPasswordRc" />
                                                                    <asp:RequiredFieldValidator ID="rfvPassword" 
                                                                                                runat="server"  
                                                                                                ValidationGroup="vsUserAdditionGroup"
                                                                                                ControlToValidate="txtPassword"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtPasswordRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding:5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                    <asp:Label ID="lblRetypePassword" runat="server"  meta:resourcekey="lblRetypeRc" AssociatedControlID="txtRetypePassword" />
                                                                    <asp:TextBox ID="txtRetypePassword"
                                                                                 TextMode="password"
                                                                                 Width="98.5%"
                                                                                 runat="server"
                                                                                 ForeColor="#0094ff"
                                                                                 BackColor="#FAF4AB"
                                                                                 CssClass="form-control"
                                                                                 meta:resourcekey="txtRetypePasswordRc" />
                                                                    <asp:CompareValidator runat="server" 
                                                                                          ID="cmpPassword" 
                                                                                          ControlToValidate="txtPassword" 
                                                                                          ControlToCompare="txtRetypePassword" 
                                                                                          ValidationGroup="vsUserAdditionGroup"
                                                                                          Operator="Equal" 
                                                                                          Type="String"
                                                                                          ForeColor="Red"
                                                                                          Display="Dynamic"
                                                                                          meta:resourcekey="pwdDoesNotMatchRc"  />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding:5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                    <asp:Label ID="lblMobile" runat="server"  meta:resourcekey="lblMobileRc" AssociatedControlID="txtMobile" />
                                                                    <asp:TextBox ID="txtMobile"
                                                                                 Width="98.5%"
                                                                                 runat="server"
                                                                                 ForeColor="#0094ff"
                                                                                 CssClass="form-control"
                                                                                 meta:resourcekey="txtMobileRc" />
                                                                    <%--<asp:RequiredFieldValidator ID="rfvMobile" 
                                                                                                runat="server"  
                                                                                                ValidationGroup="vsUserAdditionGroup"
                                                                                                ControlToValidate="txtMobile"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtMobileRc" />--%>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding:5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                               <asp:Label ID="lblIsAdmin" runat="server"  meta:resourcekey="lblIsAdminRc" AssociatedControlID="chkIsAdmin" />
                                                               <div class="checkbox" style="margin: 0">
                                                                   <asp:CheckBox ID="chkIsAdmin" runat="server" />
                                                               </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding:5px;">
                                                            <div class="form-group" style="margin-right: 0.5%; margin-left: 10px; float: left; margin-top: 23px">
                                                                    <asp:LinkButton ID="btnAddUser"
                                                                                    type="button"
                                                                                    class="btn btn-success"
                                                                                    runat="server"
                                                                                    OnClick="btnAddUser_Click">
                                                                        <i class="fa fa-save"></i>
                                                                        <asp:Label ID="lblBtnAdd" runat="server" meta:resourcekey="lblBtnAddRc"></asp:Label>
                                                                    </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:panel>
                                            </section>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b><asp:Label ID="lblDBUsers" runat="server"  meta:resourcekey="lblDBUsersRc" /></b>
                                                </header>
                                                <%= WebUtils.getErrorMessage(this.errorMessagesForGrid) %>
                                                <%= WebUtils.getInfoMessage(this.infoMessagesForGrid) %>
                                                <asp:panel runat="server" class="panel-body" DefaultButton="btnSearch">
                                                    <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <asp:Label ID="lblSearchCompany" runat="server" meta:resourcekey="lblCompanyRc" AssociatedControlID="selSearchCompany" />
                                                            <asp:DropDownList CssClass="form-control"
                                                                                ID="selSearchCompany"
                                                                                Style="color: #0094ff"
                                                                                AutoPostBack="false"
                                                                                runat="server">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                       <div class="form-group" style="width: 100%; float: left">
                                                            <b><asp:Label ID="lblSearchGridBy" runat="server"  meta:resourcekey="lblSearchGridByRc" /></b>
                                                            <asp:DropDownList CssClass="form-control"
                                                                              ID="selAppUserGridSearchType"
                                                                              Style="color: #0094ff;  margin-top: 5px;"
                                                                              AutoPostBack="false"
                                                                              runat="server">
                                                            </asp:DropDownList>
                                                       </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-3 col-xs-12" style="padding:5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <asp:Label ID="lblSearchGridText" runat="server"  meta:resourcekey="lblSearchGridTextRc" AssociatedControlID="txtSearchGridText" />
                                                            <asp:TextBox ID="txtSearchGridText"
                                                                         Width="98.5%"
                                                                         runat="server"
                                                                         ForeColor="#0094ff"
                                                                         CssClass="form-control"
                                                                         meta:resourcekey="txtSearchGridTextRc" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-xs-6" style="padding:5px;">
                                                     <!-- Row Per Page -->
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblRowPerPage" runat="server"  meta:resourcekey="lblRowPerPageRc" AssociatedControlID="txtRowPerPage" />
                                                                <asp:TextBox ID="txtRowPerPage"
                                                                             Width="98.5%"
                                                                             runat="server"
                                                                             ForeColor="#0094ff"
                                                                             BackColor="#FEF887"
                                                                             CssClass="form-control"
                                                                             meta:resourcekey="txtRowPerPageRc" />
                                                                <asp:RequiredFieldValidator ID="rfvRowPerPage" 
                                                                                            runat="server"  
                                                                                            ValidationGroup="vsSearchGroup"
                                                                                            ControlToValidate="txtRowPerPage"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtRowPerPageRc" />
                                                                <asp:RegularExpressionValidator ID="revRowPerPage" 
                                                                                            runat="server" 
                                                                                            ControlToValidate="txtRowPerPage"
                                                                                            ValidationGroup="vsSearchGroup"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtRowPerPageNumericRc"
                                                                                            ValidationExpression="[0-9]*\.?[0-9]*" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-3 col-xs-6" style="padding:5px;">
                                                        <div class="form-group" style="width: 100%; margin-left: 10px; margin-top: 22px; float: left">
                                                            <asp:LinkButton id="btnSearch" 
                                                                            type="button" 
                                                                            class="btn btn-success" 
                                                                            runat="server"
                                                                            OnClick="btnSearch_Click">
                                                                 <i class="fa fa-search"></i> <asp:Label ID="lblBtnUserFilter" runat="server"  meta:resourcekey="lblBtnUserFilterRc" ></asp:Label>
                                                             </asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </asp:panel>
                                                <div class="panel-body" style="overflow-x: auto; width: 100%">
                                                    <asp:GridView ID="appUserGridView"
                                                                  runat="server"
                                                                  AutoGenerateColumns="false"
                                                                  CssClass="table table-striped table-advance table-hover"
                                                                  Width="100%"
                                                                  GridLines="None"
                                                                  AllowPaging="true"
                                                                  ShowHeaderWhenEmpty="true"
                                                                  OnPageIndexChanging="appUserGridView_PageIndexChanging"
                                                                  OnRowEditing="appUserGridView_RowEditing"
                                                                  OnRowUpdating="appUserGridView_RowUpdating"
                                                                  OnRowCancelingEdit="appUserGridView_RowCancelingEdit"
                                                                  OnRowDataBound="appUserGridView_RowDataBound"
                                                                  OnRowCommand="appUserGridView_RowCommand">
                                                        <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                        <Columns>
                                                            <asp:TemplateField ItemStyle-Width = "2%" HeaderText="">
                                                                    <ItemTemplate>
                                                                        <asp:Label runat="server"
                                                                                   Text='<%# Container.DataItemIndex + 1 %>' />
                                                                        <asp:Label ID="lblAppUserGrid_Id" 
                                                                                   runat="server"
                                                                                   Visible="false"
                                                                                   Text='<%# Eval("id")%>' />
                                                                    </ItemTemplate>
                                                            </asp:TemplateField>
                                                             <asp:TemplateField ItemStyle-Width = "7%"  meta:resourcekey="appUserGridView_CompanyRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblAppUserGrid_Company" 
                                                                                   runat="server"/>
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:DropDownList CssClass="form-control"
                                                                                          ID="selAppUserGrid_Company"
                                                                                          Style="color: #0094ff"
                                                                                          AutoPostBack="false"
                                                                                          runat="server">
                                                                        </asp:DropDownList>
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "8%"  meta:resourcekey="appUserGridView_EmpNoRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblAppUserGrid_EmpNo" 
                                                                                   runat="server" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtAppUserGrid_EmpNo" 
                                                                                     runat="server"
                                                                                     ForeColor="#0094ff"
                                                                                     BackColor="#FAF4AB"
                                                                                     CssClass="form-control"
																				     Width="98.5%" />
                                                                        <asp:RequiredFieldValidator ID="rfvAppUserGridEmpNumber" 
                                                                                                    runat="server"  
                                                                                                    ValidationGroup="vsUserEditGroup"
                                                                                                    ControlToValidate="txtAppUserGrid_EmpNo"
                                                                                                    ForeColor="Red"
                                                                                                    Display="Dynamic"
                                                                                                    meta:resourcekey="txtEmpNumberRc" />
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "7%"  meta:resourcekey="appUserGridView_titleRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblAppUserGrid_title" 
                                                                                   runat="server" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:DropDownList CssClass="form-control"
                                                                                          ID="selAppUserGrid_Title"
                                                                                          Style="color: #0094ff"
                                                                                          AutoPostBack="false"
                                                                                          runat="server">
                                                                        </asp:DropDownList>
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "10%"  meta:resourcekey="appUserGridView_FirstNameRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblAppUserGrid_FirstName" 
                                                                                   runat="server"/>
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtAppUserGrid_FirstName" 
                                                                                     runat="server"
                                                                                     ForeColor="#0094ff"
                                                                                     BackColor="#FAF4AB"
                                                                                     CssClass="form-control"
																				     Width="98.5%" />
                                                                        <asp:RequiredFieldValidator ID="rfvAppUserGridFirstName" 
                                                                                                    runat="server"  
                                                                                                    ValidationGroup="vsUserEditGroup"
                                                                                                    ControlToValidate="txtAppUserGrid_FirstName"
                                                                                                    ForeColor="Red"
                                                                                                    Display="Dynamic"                                                                                                
                                                                                                    meta:resourcekey="txtFirstNameRc" />
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "10%"  meta:resourcekey="appUserGridView_LastNameRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblAppUserGrid_LastName" 
                                                                                   runat="server" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtAppUserGrid_LastName" 
                                                                                     runat="server"
                                                                                     ForeColor="#0094ff"
                                                                                     BackColor="#FAF4AB"
                                                                                     CssClass="form-control"
																				     Width="98.5%" />
                                                                        <asp:RequiredFieldValidator ID="rfvAppUserGridLastName" 
                                                                                                    runat="server"  
                                                                                                    ValidationGroup="vsUserEditGroup"
                                                                                                    ControlToValidate="txtAppUserGrid_LastName"
                                                                                                    ForeColor="Red"
                                                                                                    Display="Dynamic"
                                                                                                    meta:resourcekey="txtLastNameRc" />
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "10%"  meta:resourcekey="appUserGridView_UsernameRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblAppUserGrid_UserName" 
                                                                                   runat="server"/>
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtAppUserGrid_UserName" 
                                                                                     runat="server"
                                                                                     ForeColor="#0094ff"
                                                                                     BackColor="#FAF4AB"
                                                                                     CssClass="form-control"
																				     Width="98.5%" />
                                                                        <asp:RequiredFieldValidator ID="rfvAppUserGridUserName" 
                                                                                                    runat="server"  
                                                                                                    ValidationGroup="vsUserEditGroup"
                                                                                                    ControlToValidate="txtAppUserGrid_UserName"
                                                                                                    ForeColor="Red"
                                                                                                    Display="Dynamic"
                                                                                                    meta:resourcekey="txtUserNameRc" />
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "10%"  meta:resourcekey="appUserGridView_PasswordRc">
                                                                    <ItemTemplate>
                                                                   
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtAppUserGrid_Password" 
                                                                                     runat="server"
                                                                                     ForeColor="#0094ff"
                                                                                     CssClass="form-control"
																				     Width="98.5%"
                                                                                     TextMode="password"
                                                                                     meta:resourcekey="txtPasswordRc" />
                                                                        <%--<asp:RequiredFieldValidator ID="rfvAppUserGridPassword" 
                                                                                                    runat="server"  
                                                                                                    ValidationGroup="vsUserEditGroup"
                                                                                                    ControlToValidate="txtAppUserGrid_Password"
                                                                                                    ForeColor="Red"
                                                                                                    Display="Dynamic"
                                                                                                    meta:resourcekey="txtPasswordRc" />--%>
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "10%"  meta:resourcekey="appUserGridView_RetypePwdRc">
                                                                    <ItemTemplate>
                                                                    
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtAppUserGrid_RetypePwd" 
                                                                                    runat="server"
                                                                                     ForeColor="#0094ff"
                                                                                     CssClass="form-control"
																				     Width="98.5%"
                                                                                     TextMode="password"
                                                                                     meta:resourcekey="txtRetypePasswordRc" />
                                                                        <asp:CompareValidator runat="server" 
                                                                                              ID="cmpPasswordGrid" 
                                                                                              ControlToValidate="txtAppUserGrid_Password" 
                                                                                              ControlToCompare="txtAppUserGrid_RetypePwd" 
                                                                                              ValidationGroup="vsUserEditGroup"
                                                                                              Operator="Equal" 
                                                                                              Type="String"
                                                                                              ForeColor="Red"
                                                                                              Display="Dynamic"
                                                                                              meta:resourcekey="pwdDoesNotMatchRc"  />
                                                                        <asp:CompareValidator runat="server" 
                                                                                              ID="cmpPasswordGrid2" 
                                                                                              ControlToValidate="txtAppUserGrid_RetypePwd" 
                                                                                              ControlToCompare="txtAppUserGrid_Password" 
                                                                                              ValidationGroup="vsUserEditGroup"
                                                                                              Operator="Equal" 
                                                                                              Type="String"
                                                                                              ForeColor="Red"
                                                                                              Display="Dynamic"
                                                                                              meta:resourcekey="pwdDoesNotMatchRc"  />
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "10%"  meta:resourcekey="appUserGridView_EMailRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblAppUserGrid_Email" 
                                                                                   runat="server" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtAppUserGrid_EMail" 
                                                                                     runat="server"
                                                                                     ForeColor="#0094ff"
                                                                                     BackColor="#FAF4AB"
                                                                                     CssClass="form-control"
																				     Width="98.5%" />
                                                                        <asp:RequiredFieldValidator ID="rfvAppUserGridEmail" 
                                                                                                    runat="server"  
                                                                                                    ValidationGroup="vsUserEditGroup"
                                                                                                    ControlToValidate="txtAppUserGrid_Email"
                                                                                                    ForeColor="Red"
                                                                                                    Display="Dynamic"
                                                                                                    meta:resourcekey="txtEmailRc" />
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "10%"  meta:resourcekey="appUserGridView_MobileRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblAppUserGrid_Mobile" 
                                                                                   runat="server" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtAppUserGrid_Mobile" 
                                                                                     runat="server"
                                                                                     ForeColor="#0094ff"
                                                                                     CssClass="form-control"
																				     Width="98.5%" 
                                                                                     meta:resourcekey="txtMobileRc"/>
                                                                        <%--<asp:RequiredFieldValidator ID="rfvAppUserGridMobile" 
                                                                                                    runat="server"  
                                                                                                    ValidationGroup="vsUserEditGroup"
                                                                                                    ControlToValidate="txtAppUserGrid_Mobile"
                                                                                                    ForeColor="Red"
                                                                                                    Display="Dynamic"
                                                                                                    meta:resourcekey="txtMobileRc" />--%>
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "5%"  meta:resourcekey="appUserGridView_ChkIsEnabledRc">
                                                                    <ItemTemplate>
                                                                            <asp:CheckBox ID="chkAppUserGrid_IsEnabled"
                                                                                          runat="server"
                                                                                          Enabled="false" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <div class="checkbox" style="margin: 0">
                                                                            <asp:CheckBox ID="chkAppUserGrid_IsEnabled" runat="server" />
                                                                        </div>
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "5%"  meta:resourcekey="appUserGridView_ChkIsAdminRc">
                                                                    <ItemTemplate>
                                                                            <asp:CheckBox ID="chkAppUserGrid_IsAdmin"
                                                                                          runat="server"
                                                                                          Enabled="false" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <div class="checkbox" style="margin: 0">
                                                                            <asp:CheckBox ID="chkAppUserGrid_IsAdmin" runat="server" />
                                                                        </div>
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="6%" meta:resourcekey="grid_ImageRc">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="btnImage"
                                                                        runat="server"
                                                                        CssClass="btn btn-primary btn-xs"
                                                                        CommandArgument='<%# Eval("id") %>'
                                                                        OnCommand="btnImage_Command">
                                                                            <asp:PlaceHolder runat="server">
                                                                                <i class="fa fa-picture-o"></i>
                                                                            </asp:PlaceHolder>
                                                                    </asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:CommandField ItemStyle-Width="100px"  
                                                                                  ShowEditButton="True"
                                                                                  ButtonType="Image"
                                                                                  ControlStyle-CssClass="UsersGridViewButton"
                                                                                  CancelImageUrl="~/include/img/cancel.png"   
                                                                                  UpdateImageUrl="~/include/img/save.png"  
                                                                                  EditImageUrl="~/include/img/edit.png"
                                                                                  UpdateText="Update" 
                                                                                  CancelText="Cancel" />
                                                            <asp:TemplateField ItemStyle-Width="3%" HeaderText="">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="btnDelete" 
                                                                                        runat="server"
                                                                                        CssClass="btn btn-danger btn-xs"
                                                                                        CommandName="itemRowDelete"
                                                                                        OnClientClick="return confirmDelete()"
                                                                                        CommandArgument='<%# Eval("id")%>'
                                                                                        OnLoad="btnDelete_Load">
																		    <asp:PlaceHolder runat="server">
																			    <i class="fa fa fa-trash-o"></i>
																		    </asp:PlaceHolder>
                                                                        </asp:LinkButton>
                                                                        <ajaxToolkit:ConfirmButtonExtender runat="server"
                                                                                                           TargetControlID="btnDelete"
                                                                                                           DisplayModalPopupID="mpe" />
                                                                        <ajaxToolkit:ModalPopupExtender ID="mpe" 
                                                                                                        runat="server" 
                                                                                                        PopupControlID="pnlPopup" 
                                                                                                        TargetControlID="btnDelete" 
                                                                                                        OkControlID="btnYes"
                                                                                                        CancelControlID="btnNo" 
                                                                                                        BackgroundCssClass="modalBackground">
                                                                        </ajaxToolkit:ModalPopupExtender>
                                                                        <asp:Panel ID="pnlPopup" 
                                                                                   runat="server" 
                                                                                   CssClass="modalPopup" 
                                                                                   Style="display: none">
                                                                            <div class="body">
                                                                                <%= (string)GetGlobalResourceObject("GlobalResource", "confirm_delete") %>
                                                                            </div>
                                                                            <div class="footer">
                                                                                <asp:LinkButton id="btnYes"
                                                                                                runat="server"
                                                                                                CssClass="btn btn-danger btn-xs">
																				    <asp:PlaceHolder runat="server">
																					    <i class="fa fa fa-trash-o"></i> <%= (string)GetGlobalResourceObject("GlobalResource", "yes") %>
																				    </asp:PlaceHolder>
                                                                                </asp:LinkButton>
                                                                                <asp:LinkButton id="btnNo"
                                                                                                runat="server"
                                                                                                CssClass="btn btn-success btn-xs">
																				    <asp:PlaceHolder runat="server">
																					    <i class="fa fa-check"></i> <%= (string)GetGlobalResourceObject("GlobalResource", "no") %>
																				    </asp:PlaceHolder>
                                                                                </asp:LinkButton>
                                                                            </div>
                                                                        </asp:Panel>
                                                                    </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </section>
                                        </ContentTemplate>
                                       <Triggers>
                                            
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </form>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </section>
    </section>
    <!--main content end-->
    
</asp:Content>
