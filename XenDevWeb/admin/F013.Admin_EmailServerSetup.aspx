<%@ Page Language="C#"
    AutoEventWireup="true"
    CodeBehind="F013.Admin_EmailServerSetup.aspx.cs"
    Inherits="XenDevWeb.admin.F013_Admin_EmailServerSetup"
    MaintainScrollPositionOnPostback="true"
    MasterPageFile="~/include/master.Master"
    meta:resourcekey="PageResource1" %>

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
                                <strong>
                                    <asp:Label ID="lblAdminEmailServerSetup" runat="server" meta:resourcekey="lblAdminEmailServerSetupRc" />
                                </strong>
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
                                                    <b><asp:Label ID="lblOffspecSenderEmailSetup" runat="server" meta:resourcekey="lblOffspecSenderEmailSetupRc" /></b>
                                                </header>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="btnSaveChange">
                                                    <div class="row">
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblSenderAddress" runat="server" meta:resourcekey="lblSenderAddressRc" AssociatedControlID="txtSenderAddress" />
                                                                <asp:TextBox ID="txtSenderAddress"
                                                                            Width="98.5%"
                                                                            runat="server"
                                                                            ForeColor="#0094ff"
                                                                            BackColor="#FAF4AB"
                                                                            CssClass="form-control"
                                                                            meta:resourcekey="txtSenderAddressRc" />
                                                                <asp:RequiredFieldValidator ID="rfvSenderAddress"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsSaveSettingGroup"
                                                                                            ControlToValidate="txtSenderAddress"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtSenderAddressRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblSmtpAddress" runat="server" meta:resourcekey="lblSmtpAddressRc" AssociatedControlID="txtSmtpAddress" />
                                                                <asp:TextBox ID="txtSmtpAddress"
                                                                            Width="98.5%"
                                                                            runat="server"
                                                                            ForeColor="#0094ff"
                                                                            BackColor="#FAF4AB"
                                                                            CssClass="form-control"
                                                                            meta:resourcekey="txtSmtpAddressRc" />
                                                                <asp:RequiredFieldValidator ID="rfvSmtpAddress"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsSaveSettingGroup"
                                                                                            ControlToValidate="txtSmtpAddress"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtSmtpAddressRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-4 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblPort" runat="server"  meta:resourcekey="lblPortRc" AssociatedControlID="txtPort" />
                                                                <asp:TextBox ID="txtPort"
                                                                             Width="98.5%"
                                                                             runat="server"
                                                                             ForeColor="#0094ff"
																		     BackColor="#FAF4AB"
                                                                             CssClass="form-control"
                                                                             meta:resourcekey="txtPortRc" />
                                                                <asp:RequiredFieldValidator ID="rfvPort" 
                                                                                            runat="server"  
                                                                                            ValidationGroup="vsSaveSettingGroup" 
                                                                                            ControlToValidate="txtPort"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtPortRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-3 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblUsername" runat="server"  meta:resourcekey="lblUsernameRc" AssociatedControlID="txtUsername" />
                                                                <asp:TextBox ID="txtUsername"
                                                                             Width="98.5%"
                                                                             runat="server"
                                                                             ForeColor="#0094ff"
																		     BackColor="#FAF4AB"
                                                                             CssClass="form-control"
                                                                             meta:resourcekey="txtUsernameRc" />
                                                                <asp:RequiredFieldValidator ID="rfvUsername" 
                                                                                            runat="server"  
                                                                                            ValidationGroup="vsSaveSettingGroup" 
                                                                                            ControlToValidate="txtUsername"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtUsernameRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-3 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblPassword" runat="server"  meta:resourcekey="lblPasswordRc" AssociatedControlID="txtPassword" />
                                                                <asp:TextBox ID="txtPassword"
                                                                            Width="98.5%"
                                                                            runat="server"
                                                                            ForeColor="#0094ff"
																		     BackColor="#FAF4AB"
                                                                            CssClass="form-control"
                                                                            meta:resourcekey="txtPasswordRc" />
                                                               <asp:RequiredFieldValidator ID="rfvPassword" 
                                                                                           runat="server"  
                                                                                           ValidationGroup="vsSaveSettingGroup"
                                                                                           ControlToValidate="txtPassword"
                                                                                           ForeColor="Red"
                                                                                           Display="Dynamic"
                                                                                           meta:resourcekey="txtPasswordRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-2 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; margin-top: 22px; float: left">
                                                                <asp:LinkButton id="btnSaveChange" 
                                                                                type="button" 
                                                                                class="btn btn-success" 
                                                                                runat="server"
                                                                                OnClick="btnSaveChange_Click">
                                                                    <i class="fa fa-save (alias)"></i>
                                                                    <asp:Label ID="lblSaveChange" runat="server" meta:resourcekey="lblSaveChangeRc" />
                                                                </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </div>


                                                </asp:Panel>
                                            </section>
                                            <asp:Panel runat="server" class="panel-body" DefaultButton="btnSendTestEmail">
                                                <%= WebUtils.getErrorMessage(this.errorMessages) %>
                                                <%= WebUtils.getInfoMessage(this.infoMessages) %>
                                                <div class="row">
                                                    <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px; float: right">
                                                        <div class="form-group" style="width: 100%; margin-left: 10px; float: left">
                                                            <asp:Label ID="lblReceiverEmailAddress" runat="server" meta:resourcekey="lblReceiverEmailAddressRc" AssociatedControlID="txtReceiverEmailAddress" />
                                                            <asp:TextBox ID="txtReceiverEmailAddress"
                                                                        Width="98.5%"
                                                                        runat="server"
                                                                        ForeColor="#0094ff"
                                                                        CssClass="form-control"
                                                                        BackColor="#FAF4AB"
                                                                        meta:resourcekey="txtReceiverEmailAddressRc" />
                                                            <asp:RequiredFieldValidator ID="rfvReceiverEmailAddress"
                                                                                        runat="server"
                                                                                        ValidationGroup="vsSendTestEmailGroup"
                                                                                        ControlToValidate="txtReceiverEmailAddress"
                                                                                        ForeColor="Red"
                                                                                        Display="Dynamic"
                                                                                        meta:resourcekey="txtReceiverEmailAddressRc" />
                                                        </div>
                                                    </div>
                                                    <%--Send Test Email  --%>
                                                    <div class="col-lg-2 col-md-2 col-xs-12" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; margin-top: 22px; float: left">
                                                            <asp:LinkButton ID="btnSendTestEmail"
                                                                            type="button"
                                                                            class="btn btn-success"
                                                                            runat="server"
                                                                            OnClick="btnSendTestEmail_Click">   
                                                                <asp:PlaceHolder runat="server">
                                                                    <i class="fa  fa-location-arrow"></i>
                                                                    <asp:Label ID="lblSendTestEmail" runat="server" meta:resourcekey="lblSendTestEmailRc" />
                                                                </asp:PlaceHolder>
                                                            </asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>
                                            </asp:Panel>
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
</asp:Content>
