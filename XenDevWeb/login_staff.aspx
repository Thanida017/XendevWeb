<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="login_staff.aspx.cs" 
    Inherits="XenDevWeb.login_staff"
     %>

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
      .background {
        background-image: url('<%= WebUtils.getAppServerPath() %>/include/img/bg-3.jpg');
        background-size: cover;
        background-position: center bottom;
        background-repeat: no-repeat;
        background-attachment: fixed;
      }
    </style>
</head>

  <body class="background">
    <div class="container">

        <form class="form-signin" role="form" runat="server">
            <h2 class="form-signin-heading" style="background-color:#3699ff">XenDevWeb</h2>          
            <div class="login-wrap" style="border-style: solid; border-width: 0.5px; border-color: #eaeaea;border-radius: 5px;">
                <asp:ScriptManager ID="scriptManager" runat="server"></asp:ScriptManager>
                <asp:UpdateProgress ID="updProgress"
                    runat="server">
                    <ProgressTemplate>
                        <img alt="progress"
                            style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 100;"
                            src="<%= WebUtils.getAppServerPath() %>/include/img/loading.gif" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>                     
                        <%= WebUtils.getErrorMessage(this.errorMessage) %>
                        <img  src="<%= WebUtils.getAppServerPath() %>/include/img/logo.png"  style="width:100%" >
                           <div style="margin-bottom: 5rem!important; text-align:center">
                               <h3 style="font-size: 1.5rem; margin-bottom: .5rem; font-weight: 500; line-height: 1.2;color: #3f4254;font-weight: bold;">Sign In To Admin</h3>
                            <div class="text-muted font-weight-bold">Enter your details to login to your account:</div>
                        </div>
                        <asp:Panel runat="server" class="panel-body" DefaultButton="loginBtn" style="padding: 0px">
                            <asp:TextBox CssClass="form-control"
                                        ID="txtUn"
                                        Style="color: #0094ff"
                                        placeholder=""
                                        runat="server" meta:resourcekey="txtUnRc" />
                            <asp:RequiredFieldValidator ID="rfvUserName"
                                                        runat="server"
                                                        ValidationGroup="vsLoginGroup"
                                                        ControlToValidate="txtUn"
                                                        ForeColor="Red"
                                                        Display="Dynamic"
                                                        meta:resourcekey="txtUnRc" />


                            <asp:TextBox CssClass="form-control"
                                        ID="txtPd"
                                        Style="color: #0094ff"
                                        placeholder=""
                                        TextMode="Password"
                                        runat="server" meta:resourcekey="txtPdRc" />
                            <asp:RequiredFieldValidator ID="rfvPwd"
                                                        runat="server"
                                                        ValidationGroup="vsLoginGroup"
                                                        ControlToValidate="txtPd"
                                                        ForeColor="Red"
                                                        Display="Dynamic"
                                                        meta:resourcekey="txtPdRc" />
                            <asp:LinkButton id="loginBtn" 
                                            class="btn btn-lg btn-login btn-block" 
                                            style="background-color:#3699ff; box-shadow: 0 4px #3699ff;"
                                            runat="server" 
                                            OnClick="loginBtn_Click">
                                         <i class="fa fa-key"></i>Log in
                            </asp:LinkButton>
                        </asp:Panel>
                    </ContentTemplate>
                    <Triggers>
                    </Triggers>
                </asp:UpdatePanel>
            </div>

        </form>
    </div>



    <!-- js placed at the end of the document so the pages load faster -->
    <script src="<%= WebUtils.getAppServerPath() %>/include/js/jquery.js"></script>
    <script src="<%= WebUtils.getAppServerPath() %>/include/js/bootstrap.min.js"></script>

      <script type="text/javascript">

          $("form").submit(function () {
              var form = $(this);
              form.find("input[type=submit]").attr("disabled", "disabled")
              form.find("input[type=submit]").attr("value", "Processing...");
              form.find("input").attr("readonly", true);
              //document.body.style.cursor = "wait";
          });

    </script>

  </body>
</html>