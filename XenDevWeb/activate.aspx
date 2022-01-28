<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="activate.aspx.cs" 
    Inherits="XenDevWeb.activate" %>

<%@ Import Namespace="XenDevWeb.Utils" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no">
    <title>XenDev</title>
     <link rel="icon" type="image/x-icon" href="<%= WebUtils.getAppServerPath() %>/include/img/logo.png" />
    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <link href="https://fonts.googleapis.com/css?family=Nunito:400,600,700" rel="stylesheet">
    <link href="<%= WebUtils.getAppServerPath() %>/include/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="<%= WebUtils.getAppServerPath() %>/include/assets/css/plugins.css" rel="stylesheet" type="text/css">
    <link href="<%= WebUtils.getAppServerPath() %>/include/assets/css/pages/error/style-400.css" rel="stylesheet" type="text/css">
    <!-- END GLOBAL MANDATORY STYLES -->


</head>
<body class="error404 text-center" style="background-image:none; background: #060818;">
    
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-4 mr-auto mt-5 text-md-left text-center">
                <a href="index.html" class="ml-md-5">
                    <%--<img alt="image-404" src="<%= MobilityWeb.Utils.WebUtils.getAppServerPath() %>/include/img/logo.png" class="theme-logo">--%>
                </a>
            </div>
        </div>
    </div>
    <form id="myForm" role="form" runat="server">
        <asp:ScriptManager ID="scriptManager" runat="server"></asp:ScriptManager>
        <asp:UpdateProgress ID="updProgress"
            runat="server">
            <ProgressTemplate>
                <img alt="progress"
                    style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 100;"
                    src="<%= WebUtils.getAppServerPath() %>/include/img/loading.gif" />
            </ProgressTemplate>
        </asp:UpdateProgress>
        <div class="container-fluid error-content">
            <div class="">
                <h1 class="error-number"><asp:Label ID="lblHeaderMessage" runat="server"></asp:Label></h1>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <p class="mini-text">Ooops!</p>
                        <p class="error-text mb-4 mt-1">
                            <asp:Label  ID="lblMessage" runat="server"></asp:Label>
                        </p>
                        <asp:HiddenField ID="hndResetParam" runat="server" />
                    </ContentTemplate>
                </asp:UpdatePanel>
               
                <a href="<%= WebUtils.getAppServerPath() %>/login.aspx" class="btn btn-primary mt-5">Log in</a>
            </div>
        </div>
     </form>
    <!-- BEGIN GLOBAL MANDATORY SCRIPTS -->
    <script src="<%= WebUtils.getAppServerPath() %>/include/assets/js/libs/jquery-3.1.1.min.js"></script>
    <script src="<%= WebUtils.getAppServerPath() %>/include/bootstrap/js/popper.min.js"></script>
    <script src="<%= WebUtils.getAppServerPath() %>/include/bootstrap/js/bootstrap.min.js"></script>
    <!-- END GLOBAL MANDATORY SCRIPTS -->

</body></html>