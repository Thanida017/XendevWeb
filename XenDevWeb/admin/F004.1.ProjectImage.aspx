<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="F004.1.ProjectImage.aspx.cs" 
    Inherits="XenDevWeb.admin.F004__1_ProjectImage" 
     MaintainScrollPositionOnPostback="true"
    MasterPageFile="~/include/master.Master" 
    meta:resourcekey="PageResource1"
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
                                <strong><asp:Label ID="lblImageProject" runat="server" meta:resourcekey="lblImageProjectRc" /></strong>
                            </span>
                        </header>
                        <div class="panel-body">
                            <div class="tab-content">
                                <form id="myForm" role="form" runat="server" enctype="multipart/form-data">
                                    <asp:ScriptManager ID="scriptManager" runat="server" EnableScriptGlobalization="true"></asp:ScriptManager>
                                    <asp:UpdateProgress ID="updProgress" runat="server">
                                        <ProgressTemplate>
                                            <img alt="progress"
                                                style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 100;"
                                                src="<%= WebUtils.getAppServerPath() %>/include/img/loading.gif" />
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                             <div class="row">
                                                <div class="col-xs-4">
                                                    <section class="panel" style="border: solid 1px #d0efde">
                                                    <header class="panel-heading">
                                                        <b><asp:Label ID="lblUploadImage" runat="server" meta:resourcekey="lblUploadImageRc" /></b>
                                                    </header>
                                                    <asp:panel runat="server" CssClass="panel-body" >
                                                        <%= WebUtils.getErrorMessage(this.errorMessages) %>
                                                        <%= WebUtils.getInfoMessage(this.infoMessages) %>
                                                        <div class="row">
                                                            <asp:panel runat="server" class="panel-body" style="padding-top: 0px; text-align:center" DefaultButton="">
                                                                    <div class="fileupload fileupload-new" data-provides="fileupload" style="margin: 10px">
                                                                    <div class="fileupload-new thumbnail">
                                                                        <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image"
                                                                            alt=""
                                                                            id="imgView"
                                                                            runat="server"
                                                                            width="400"
                                                                            height="400" />
                                                                    </div>
                                                                    <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 100%; max-height: 350px; line-height: 20px;"></div>
                                                                    <div>
                                                                        <span class="btn btn-white btn-file">
                                                                            <span class="fileupload-new"><i class="fa fa-picture-o text-muted"></i><%= (string)GetGlobalResourceObject("GlobalResource", "select_image") %></span>
                                                                            <span class="fileupload-exists"><i class="fa fa-undo"></i><%= (string)GetGlobalResourceObject("GlobalResource", "change") %></span>
                                                                            <input type="file" class="default" id="myFile" name="myFile" />
                                                                        </span>
                                                                        <a href="#" class="btn btn-danger fileupload-exists" data-dismiss="fileupload"><i class="fa fa-trash-o"></i><%= (string)GetGlobalResourceObject("GlobalResource", "remove") %></a>
                                                                        <a href="#" class="btn btn-success fileupload-exists"
                                                                                    runat="server"
                                                                                    onserverclick="lnkUpload_ServerClick"
                                                                                    id="lnkUpload"><i class="fa fa-eye"></i><%= (string)GetGlobalResourceObject("GlobalResource", "upload") %></a>
                                                                    </div>
                                                                    </div>
                                                                </asp:panel>
                                                        </div>
                                                    </asp:panel>
                                                </section>
                                                </div>
                                                <div class="col-xs-8">
                                                    <section class="panel" style="border: solid 1px #d0efde;">
                                                        <header class="panel-heading">
                                                            <b><asp:Label ID="lblImages" runat="server" meta:resourcekey="lblImagesRc" /></b>
                                                        </header>
                                                        <asp:panel runat="server" CssClass="panel-body" >
                                                        <%= WebUtils.getErrorMessage(this.errorMessagesForGrid) %>
                                                        <%= WebUtils.getInfoMessage(this.infoMessagesForGrid) %>
                                                        <div class="row"> 
                                                            <asp:Image ID="imgProject" 
                                                                       runat="server" 
                                                                       Style="width: 300px; height: auto; margin-left:10px; border: 0px !important;" />                                     
                                                            </div>
                                                        </asp:panel>
                                                    </section>
                                                    <div class="row">
                                                        <div class="form-group" style="margin-right: 20px; float: right; margin-top: 20px">
                                                            <asp:LinkButton ID="btnGoBack"
                                                                type="button"
                                                                class="btn btn-success"
                                                                runat="server"
                                                                CommandArgument='<%# Eval("id") %>'
                                                                OnCommand="btnGoBack_Command">
                                                                <asp:PlaceHolder runat="server">
                                                                    <i class="fa fa-reply"></i>                                                                
                                                                    <asp:Label ID="lblGoBack" runat="server" meta:resourcekey="lblBtnGoBackRc" />
                                                                </asp:PlaceHolder>
                                                            </asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <asp:HiddenField ID="hndProjectId" runat="server" />
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:PostBackTrigger ControlID="lnkUpload" />
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

