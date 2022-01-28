<%@ Page Language="C#"
    AutoEventWireup="true"
    CodeBehind="register.aspx.cs"
    Inherits="XenDevWeb.register"
    meta:resourcekey="PageResource1" %>

<%@ Import Namespace="XenDevWeb.Utils" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <link rel="shortcut icon" href="<%= XenDevWeb.Utils.WebUtils.getAppServerPath() %>/include/img/logoApp.png" />

    <title>XenDevWeb</title>

    <!-- Bootstrap core CSS -->
    <link href="<%= WebUtils.getAppServerPath() %>/include/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= WebUtils.getAppServerPath() %>/include/css/bootstrap-reset.css" rel="stylesheet">
    <link href="<%= WebUtils.getAppServerPath() %>/include/css/formRegister.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%= WebUtils.getAppServerPath() %>/include/assets/css/forms/theme-checkbox-radio.css">

    <!--external css-->
    <link href="<%= WebUtils.getAppServerPath() %>/include/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />

    <!-- Custom styles for this template -->
    <link href="<%= WebUtils.getAppServerPath() %>/include/css/style.css" rel="stylesheet">
    <link href="<%= WebUtils.getAppServerPath() %>/include/css/style-responsive.css" rel="stylesheet" />

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 tooltipss and media queries -->
    <!--[if lt IE 9]>
    <script src="<%= WebUtils.getAppServerPath() %>/include/js/html5shiv.js"></script>
    <script src="<%= WebUtils.getAppServerPath() %>/include/js/respond.min.js"></script>
    <![endif]-->

    <style>
        #basic_background {
            background-image: url('<%= WebUtils.getAppServerPath() %>/include/img/bg-3.jpg');
            background-repeat: no-repeat;
            background-size: cover;
        }
    </style>
</head>

<body class="background">
    <div class="container">
        <div class="contact-form">
            <div class="form-form">
                <div class="form-form-wrap">
                    <div class="form-container">
                        <div class="form-content">
                            <h1 class="">Get started with a
                                <br />
                                free account</h1>
                            <form class="text-left" id="myForm" role="form" runat="server" enctype="multipart/form-data">
                                <asp:ScriptManager ID="scriptManager" runat="server"></asp:ScriptManager>
                                <asp:UpdateProgress ID="updProgress"
                                    runat="server">
                                    <ProgressTemplate>
                                        <img alt="progress"
                                            style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 100;"
                                            src="<%= WebUtils.getAppServerPath() %>/include/img/loading.gif" />
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <div class="form">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <%= WebUtils.getErrorMessage(this.errorMessage) %>
                                            <%= WebUtils.getInfoMessage(this.infoMessages) %>
                                            <div id="company-field" class="field-wrapper input">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M12 22s-8-4.5-8-11.8A8 8 0 0 1 12 2a8 8 0 0 1 8 8.2c0 7.3-8 11.8-8 11.8z" />
                                                    <circle cx="12" cy="10" r="3" />
                                                </svg>

                                                <asp:TextBox ID="txtCompanyName"
                                                            name="companyName"
                                                            CssClass="form-control"
                                                            runat="server"
                                                            meta:resourcekey="txtCompanyNameRc" />
                                                <asp:RequiredFieldValidator ID="rfvCompanyName"
                                                                            runat="server"
                                                                            ValidationGroup="vsRegisterGroup"
                                                                            ControlToValidate="txtCompanyName"
                                                                            ForeColor="Red"
                                                                            Display="Dynamic"
                                                                            meta:resourcekey="txtCompanyNameRc" />
                                            </div>
                                            <div id="taxID-field" class="field-wrapper input">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M20 14.66V20a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h5.34"></path><polygon points="18 2 22 6 12 16 8 16 8 12 18 2"></polygon></svg>

                                                <asp:TextBox ID="txtTaxID"
                                                                name="taxID"
                                                                CssClass="form-control"
                                                                runat="server"
                                                                meta:resourcekey="txtTaxIDRc" />
                                                <asp:RequiredFieldValidator ID="rfvTaxID"
                                                                            runat="server"
                                                                            ValidationGroup="vsRegisterGroup"
                                                                            ControlToValidate="txtTaxID"
                                                                            ForeColor="Red"
                                                                            Display="Dynamic"
                                                                            meta:resourcekey="txtTaxIDRc" />
                                            </div>
                                            <div id="username-field" class="field-wrapper input">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-user">
                                                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                                                <asp:TextBox ID="txtUserName"
                                                                name="username"
                                                                CssClass="form-control"
                                                                runat="server"
                                                                meta:resourcekey="txtUserNameRc" />
                                                <asp:RequiredFieldValidator ID="rfvUserName"
                                                                            runat="server"
                                                                            ValidationGroup="vsRegisterGroup"
                                                                            ControlToValidate="txtUserName"
                                                                            ForeColor="Red"
                                                                            Display="Dynamic"
                                                                            meta:resourcekey="txtUserNameRc" />
                                            </div>
                                            <div id="email-field" class="field-wrapper input">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-at-sign">
                                                    <circle cx="12" cy="12" r="4"></circle><path d="M16 8v5a3 3 0 0 0 6 0v-1a10 10 0 1 0-3.92 7.94"></path></svg>
                                                <asp:TextBox ID="txtEmail"
                                                            name="email"
                                                            CssClass="form-control"
                                                            runat="server"
                                                            meta:resourcekey="txtEmailRc" />
                                                <asp:RequiredFieldValidator ID="rfvEmail"
                                                                            runat="server"
                                                                            ValidationGroup="vsRegisterGroup"
                                                                            ControlToValidate="txtEmail"
                                                                            ForeColor="Red"
                                                                            Display="Dynamic"
                                                                            meta:resourcekey="txtEmailRc" />
                                            </div>
                                            <div id="password-field" class="field-wrapper input mb-2">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-lock">
                                                    <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
                                                <asp:TextBox ID="txtPassWord"
                                                            name="password"
                                                            type="password"
                                                            CssClass="form-control"
                                                            runat="server"
                                                            meta:resourcekey="txtPassWordRc" />
                                                <asp:RequiredFieldValidator ID="rfvPassWord"
                                                                            runat="server"
                                                                            ValidationGroup="vsRegisterGroup"
                                                                            ControlToValidate="txtPassWord"
                                                                            ForeColor="Red"
                                                                            Display="Dynamic"
                                                                            meta:resourcekey="txtPassWordRc" />
                                            </div>
                                            <div class="field-wrapper terms_condition">
                                                <div class="n-chk new-checkbox checkbox-outline-primary">
                                                    <label class="new-control new-checkbox checkbox-outline-primary">
                                                        <input type="checkbox" class="new-control-input" id="chk_IsAgree" runat="server">
                                                        <span class="new-control-indicator"></span><span>I agree to the <a href="javascript:void(0);">terms and conditions </a></span>
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="d-sm-flex justify-content-between">
                                                <div class="field-wrapper">
                                                    <asp:LinkButton ID="btnRegis"
                                                                    OnClick="btnRegis_Click"
                                                                    type="submit"
                                                                    Style="width: 100%"
                                                                    class="btn btn-primary"
                                                                    runat="server">
                                                        <asp:Label ID="lblBtnRegis" runat="server" meta:resourcekey="lblBtnRegisRc"></asp:Label>
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </form>
                            <p class="terms-conditions">© 2020 All Rights Reserved. <a href="#">Crest Kernel Co., Ltd.</a> is a product of Designreset. <a href="javascript:void(0);">Cookie Preferences</a>, <a href="javascript:void(0);">Privacy</a>, and <a href="javascript:void(0);">Terms</a>.</p>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <!-- js placed at the end of the document so the pages load faster -->
    <script src="<%= WebUtils.getAppServerPath() %>/include/js/jquery.js"></script>
    <script src="<%= WebUtils.getAppServerPath() %>/include/js/bootstrap.min.js"></script>

</body>
</html>
