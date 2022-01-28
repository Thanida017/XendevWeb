<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="F012.StaffAccount.aspx.cs" 
    Inherits="XenDevWeb.admin.F012_StaffAccount" 
    MasterPageFile="~/include/master.Master" 
    meta:resourcekey="PageResource1"
    MaintainScrollPositionOnPostback="true"
    %>

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
                                <strong><asp:Label ID="lblStaff" runat="server" meta:resourcekey="lblStaffRc" /></strong>
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
                                                    <b><asp:Label ID="lblAddStaffHeader" runat="server" meta:resourcekey="lblNewStaffHeaderRc" /></b>
                                                </header>
                                                <asp:panel runat="server" class="panel-body" DefaultButton="btnAddStaff">
                                                    <div class="row">
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
                                                                                            ValidationGroup="vsStaffAdditionGroup"
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
                                                                                                ValidationGroup="vsStaffAdditionGroup"
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
                                                                                                ValidationGroup="vsStaffAdditionGroup"
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
                                                                                                ValidationGroup="vsStaffAdditionGroup"
                                                                                                ControlToValidate="txtEmail"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtEmailRc" />
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
                                                                                                ValidationGroup="vsStaffAdditionGroup"
                                                                                                ControlToValidate="txtMobile"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtMobileRc" />--%>
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
                                                                                                ValidationGroup="vsStaffAdditionGroup"
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
                                                                                                ValidationGroup="vsStaffAdditionGroup"
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
                                                                                          ValidationGroup="vsStaffAdditionGroup"
                                                                                          Operator="Equal" 
                                                                                          Type="String"
                                                                                          ForeColor="Red"
                                                                                          Display="Dynamic"
                                                                                          meta:resourcekey="pwdDoesNotMatchRc"  />
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
                                                                    <asp:LinkButton ID="btnAddStaff"
                                                                                    type="button"
                                                                                    class="btn btn-success"
                                                                                    runat="server"
                                                                                    OnClick="btnAddStaff_Click">
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
                                                    <b><asp:Label ID="lblDBStaff" runat="server"  meta:resourcekey="lblDBStaffRc" /></b>
                                                </header>
                                                <%= WebUtils.getErrorMessage(this.errorMessagesForGrid) %>
                                                <%= WebUtils.getInfoMessage(this.infoMessagesForGrid) %>
                                                <asp:panel runat="server" class="panel-body" DefaultButton="btnSearch">
                                                    <div class="col-lg-2 col-md-3 col-xs-12" style="padding:5px;">
                                                       <div class="form-group" style="width: 100%; float: left">
                                                            <b><asp:Label ID="lblSearchGridBy" runat="server"  meta:resourcekey="lblSearchGridByRc" /></b>
                                                            <asp:DropDownList CssClass="form-control"
                                                                              ID="selGridSearchType"
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
                                                                 <i class="fa fa-search"></i> <asp:Label ID="lblBtnFilter" runat="server"  meta:resourcekey="lblBtnSearchRc" ></asp:Label>
                                                             </asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </asp:panel>
                                                <div class="panel-body" style="overflow-x: auto; width: 100%">
                                                    <asp:GridView ID="appStaffGridView"
                                                                  runat="server"
                                                                  AutoGenerateColumns="false"
                                                                  CssClass="table table-striped table-advance table-hover"
                                                                  Width="100%"
                                                                  GridLines="None"
                                                                  AllowPaging="true"
                                                                  ShowHeaderWhenEmpty="true"
                                                                  OnPageIndexChanging="appStaffGridView_PageIndexChanging"
                                                                  OnRowEditing="appStaffGridView_RowEditing"
                                                                  OnRowUpdating="appStaffGridView_RowUpdating"
                                                                  OnRowCancelingEdit="appStaffGridView_RowCancelingEdit"
                                                                  OnRowDataBound="appStaffGridView_RowDataBound">
                                                        <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                        <Columns>
                                                            <asp:TemplateField ItemStyle-Width = "2%" HeaderText="">
                                                                    <ItemTemplate>
                                                                        <asp:Label runat="server"
                                                                                   Text='<%# Container.DataItemIndex + 1 %>' />
                                                                        <asp:Label ID="lblAppStaffGrid_Id" 
                                                                                   runat="server"
                                                                                   Visible="false"
                                                                                   Text='<%# Eval("id")%>' />
                                                                    </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "8%"  meta:resourcekey="appGridView_EmpNoRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblGrid_EmpNo" 
                                                                                   runat="server" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtGrid_EmpNo" 
                                                                                     runat="server"
                                                                                     ForeColor="#0094ff"
                                                                                     BackColor="#FAF4AB"
                                                                                     CssClass="form-control"
																				     Width="98.5%" />
                                                                        <asp:RequiredFieldValidator ID="rfvGridEmpNumber" 
                                                                                                    runat="server"  
                                                                                                    ValidationGroup="vsUserEditGroup"
                                                                                                    ControlToValidate="txtGrid_EmpNo"
                                                                                                    ForeColor="Red"
                                                                                                    Display="Dynamic"
                                                                                                    meta:resourcekey="txtEmpNumberRc" />
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "7%"  meta:resourcekey="appGridView_titleRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblGrid_title" 
                                                                                   runat="server" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:DropDownList CssClass="form-control"
                                                                                          ID="selGrid_Title"
                                                                                          Style="color: #0094ff"
                                                                                          AutoPostBack="false"
                                                                                          runat="server">
                                                                        </asp:DropDownList>
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "10%"  meta:resourcekey="appGridView_FirstNameRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblGrid_FirstName" 
                                                                                   runat="server" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtGrid_FirstName" 
                                                                                     runat="server"
                                                                                     ForeColor="#0094ff"
                                                                                     BackColor="#FAF4AB"
                                                                                     CssClass="form-control"
																				     Width="98.5%" />
                                                                        <asp:RequiredFieldValidator ID="rfvGridFirstName" 
                                                                                                    runat="server"  
                                                                                                    ValidationGroup="vsUserEditGroup"
                                                                                                    ControlToValidate="txtGrid_FirstName"
                                                                                                    ForeColor="Red"
                                                                                                    Display="Dynamic"                                                                                                
                                                                                                    meta:resourcekey="txtFirstNameRc" />
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "10%"  meta:resourcekey="appGridView_LastNameRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblGrid_LastName" 
                                                                                   runat="server"/>
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtGrid_LastName" 
                                                                                     runat="server"
                                                                                     ForeColor="#0094ff"
                                                                                     BackColor="#FAF4AB"
                                                                                     CssClass="form-control"
																				     Width="98.5%"/>
                                                                        <asp:RequiredFieldValidator ID="rfvGridLastName" 
                                                                                                    runat="server"  
                                                                                                    ValidationGroup="vsUserEditGroup"
                                                                                                    ControlToValidate="txtGrid_LastName"
                                                                                                    ForeColor="Red"
                                                                                                    Display="Dynamic"
                                                                                                    meta:resourcekey="txtLastNameRc" />
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "10%"  meta:resourcekey="appGridView_UsernameRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblGrid_UserName" 
                                                                                   runat="server" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtGrid_UserName" 
                                                                                     runat="server"
                                                                                     ForeColor="#0094ff"
                                                                                     BackColor="#FAF4AB"
                                                                                     CssClass="form-control"
																				     Width="98.5%" />
                                                                        <asp:RequiredFieldValidator ID="rfvGridUserName" 
                                                                                                    runat="server"  
                                                                                                    ValidationGroup="vsUserEditGroup"
                                                                                                    ControlToValidate="txtGrid_UserName"
                                                                                                    ForeColor="Red"
                                                                                                    Display="Dynamic"
                                                                                                    meta:resourcekey="txtUserNameRc" />
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "10%"  meta:resourcekey="appGridView_PasswordRc">
                                                                    <ItemTemplate>
                                                                   
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtGrid_Password" 
                                                                                     runat="server"
                                                                                     ForeColor="#0094ff"
                                                                                     CssClass="form-control"
																				     Width="98.5%"
                                                                                     TextMode="password"
                                                                                     meta:resourcekey="txtPasswordRc" />
                                                                        <%--<asp:RequiredFieldValidator ID="rfvGridPassword" 
                                                                                                    runat="server"  
                                                                                                    ValidationGroup="vsUserEditGroup"
                                                                                                    ControlToValidate="txtGrid_Password"
                                                                                                    ForeColor="Red"
                                                                                                    Display="Dynamic"
                                                                                                    meta:resourcekey="txtPasswordRc" />--%>
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "10%"  meta:resourcekey="appGridView_RetypePwdRc">
                                                                    <ItemTemplate>
                                                                    
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtGrid_RetypePwd" 
                                                                                    runat="server"
                                                                                     ForeColor="#0094ff"
                                                                                     CssClass="form-control"
																				     Width="98.5%"
                                                                                     TextMode="password"
                                                                                     meta:resourcekey="txtRetypePasswordRc" />
                                                                        <asp:CompareValidator runat="server" 
                                                                                              ID="cmpPasswordGrid" 
                                                                                              ControlToValidate="txtGrid_Password" 
                                                                                              ControlToCompare="txtGrid_RetypePwd" 
                                                                                              ValidationGroup="vsUserEditGroup"
                                                                                              Operator="Equal" 
                                                                                              Type="String"
                                                                                              ForeColor="Red"
                                                                                              Display="Dynamic"
                                                                                              meta:resourcekey="pwdDoesNotMatchRc"  />
                                                                        <asp:CompareValidator runat="server" 
                                                                                              ID="cmpPasswordGrid2" 
                                                                                              ControlToValidate="txtGrid_RetypePwd" 
                                                                                              ControlToCompare="txtGrid_Password" 
                                                                                              ValidationGroup="vsUserEditGroup"
                                                                                              Operator="Equal" 
                                                                                              Type="String"
                                                                                              ForeColor="Red"
                                                                                              Display="Dynamic"
                                                                                              meta:resourcekey="pwdDoesNotMatchRc"  />
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "10%"  meta:resourcekey="appGridView_EMailRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblGrid_Email" 
                                                                                   runat="server"/>
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtGrid_EMail" 
                                                                                     runat="server"
                                                                                     ForeColor="#0094ff"
                                                                                     BackColor="#FAF4AB"
                                                                                     CssClass="form-control"
																				     Width="98.5%" />
                                                                        <asp:RequiredFieldValidator ID="rfvGridEmail" 
                                                                                                    runat="server"  
                                                                                                    ValidationGroup="vsUserEditGroup"
                                                                                                    ControlToValidate="txtGrid_Email"
                                                                                                    ForeColor="Red"
                                                                                                    Display="Dynamic"
                                                                                                    meta:resourcekey="txtEmailRc" />
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "10%"  meta:resourcekey="appGridView_MobileRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblGrid_Mobile" 
                                                                                   runat="server" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtGrid_Mobile" 
                                                                                     runat="server"
                                                                                     ForeColor="#0094ff"
                                                                                     CssClass="form-control"
																				     Width="98.5%" 
                                                                                     meta:resourcekey="txtMobileRc"/>
                                                                        <%--<asp:RequiredFieldValidator ID="rfvGridMobile" 
                                                                                                    runat="server"  
                                                                                                    ValidationGroup="vsUserEditGroup"
                                                                                                    ControlToValidate="txtGrid_Mobile"
                                                                                                    ForeColor="Red"
                                                                                                    Display="Dynamic"
                                                                                                    meta:resourcekey="txtMobileRc" />--%>
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "5%"  meta:resourcekey="appGridView_ChkIsEnabledRc">
                                                                    <ItemTemplate>
                                                                            <asp:CheckBox ID="chkGrid_IsEnabled"
                                                                                          runat="server"
                                                                                          Enabled="false" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <div class="checkbox" style="margin: 0">
                                                                            <asp:CheckBox ID="chkGrid_IsEnabled" runat="server" />
                                                                        </div>
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "5%"  meta:resourcekey="appGridView_ChkIsAdminRc">
                                                                    <ItemTemplate>
                                                                            <asp:CheckBox ID="chkGrid_IsAdmin"
                                                                                          runat="server"
                                                                                          Enabled="false" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <div class="checkbox" style="margin: 0">
                                                                            <asp:CheckBox ID="chkGrid_IsAdmin" runat="server" />
                                                                        </div>
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="6%" meta:resourcekey="grid_BannerImageRc">
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
                                                                                        OnCommand="btnDelete_Command">
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