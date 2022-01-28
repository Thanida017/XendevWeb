<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="F011.ApplicationChangeTrxEdit.aspx.cs" 
    Inherits="XenDevWeb.secure.F011_ApplicationChangeTrxEdit" 
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
                                <strong><asp:Label ID="lblApplicationChangeTrx" runat="server" meta:resourcekey="lblApplicationChangeTrxRc" /></strong>
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
                                    <section class="panel">
                                        <div class="row">
                                            <div class="col-lg-8 col-md-8 col-xs-12">
                                                 <asp:UpdatePanel ID="pnlAppChangeTrx" runat="server" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                          <%= WebUtils.getErrorMessage(this.errorMessages) %>
                                                          <%= WebUtils.getInfoMessage(this.infoMessages) %>
                                                        <section class="panel" style="border: solid 1px #d0efde">
                                                            <header class="panel-heading">
                                                                <b><asp:Label ID="lblApplicationChangeTrxDetail" runat="server" meta:resourcekey="lblApplicationChangeTrxDetailRc" /></b>
                                                            </header>
                                                             <asp:Panel runat="server" class="panel-body" Style="padding-bottom: 0px" DefaultButton="">
                                                                 <div class="row">
                                                                      <ajaxToolkit:HtmlEditorExtender ID="html" runat="server" TargetControlID="txtChangeDetails">
                                                                        <Toolbar>
                                                                            <ajaxToolkit:Undo />
                                                                            <ajaxToolkit:Redo />
                                                                            <ajaxToolkit:Bold />
                                                                            <ajaxToolkit:Italic />
                                                                            <ajaxToolkit:Underline />
                                                                            <ajaxToolkit:StrikeThrough />
                                                                            <ajaxToolkit:Subscript />
                                                                            <ajaxToolkit:Superscript />
                                                                            <ajaxToolkit:JustifyLeft />
                                                                            <ajaxToolkit:JustifyCenter />
                                                                            <ajaxToolkit:JustifyRight />
                                                                            <ajaxToolkit:JustifyFull />
                                                                            <ajaxToolkit:InsertOrderedList />
                                                                            <ajaxToolkit:InsertUnorderedList />
                                                                            <ajaxToolkit:CreateLink />
                                                                            <ajaxToolkit:UnLink />
                                                                            <ajaxToolkit:RemoveFormat />
                                                                            <ajaxToolkit:SelectAll />
                                                                            <ajaxToolkit:UnSelect />
                                                                            <ajaxToolkit:Delete />
                                                                            <ajaxToolkit:Cut />
                                                                            <ajaxToolkit:Copy />
                                                                            <ajaxToolkit:Paste />
                                                                            <ajaxToolkit:BackgroundColorSelector />
                                                                            <ajaxToolkit:ForeColorSelector />
                                                                            <%--<ajaxToolkit:FontNameSelector />--%>
                                                                            <ajaxToolkit:FontSizeSelector />
                                                                            <ajaxToolkit:Indent />
                                                                            <ajaxToolkit:Outdent />
                                                                            <ajaxToolkit:InsertHorizontalRule />
                                                                            <ajaxToolkit:HorizontalSeparator />
                                                                            <ajaxToolkit:InsertImage />
                                                                        </Toolbar>
                                                                    </ajaxToolkit:HtmlEditorExtender>
                                                                    <div class="form-group" style="width: 100%; margin-left: 10px;float: left">
                                                                        <asp:Label ID="lblChangeDetails" runat="server"  meta:resourcekey="lblChangeDetailsRc" AssociatedControlID="txtChangeDetails" />
                                                                        <asp:TextBox ID="txtChangeDetails"
                                                                                     Width="98.5%"
                                                                                     Height="200px"
                                                                                     runat="server"
                                                                                     ForeColor="#0094ff"
                                                                                     BackColor="#ffff00"
                                                                                     CssClass="form-control"
                                                                                     meta:resourcekey="txtChangeDetailsRc" />
                                                                        <asp:RequiredFieldValidator ID="rfvtxtChangeDetails" 
                                                                                                    runat="server"  
                                                                                                    ValidationGroup="vsAddGroup" 
                                                                                                    ControlToValidate="txtChangeDetails"
                                                                                                    ForeColor="Red"
                                                                                                    Display="Dynamic"
                                                                                                    meta:resourcekey="txtChangeDetailsRc" />
                                                                    </div>
                                                                 </div>
                                                                  <div class="row">
                                                                    <div class="col-lg-2 col-md-1 col-xs-6" style="padding: 5px;">
                                                                        <div class="form-group" style="width: 15%; margin-top: 22px; float: left">
                                                                            <asp:LinkButton ID="btnUpdate"
                                                                                type="button"
                                                                                class="btn btn-success"
                                                                                runat="server"
                                                                                OnClick="btnUpdate_Click">
                                                                                <i class="fa fa-cloud-upload"></i>
                                                                                <asp:Label ID="lblBtnUpdate" runat="server" meta:resourcekey="lblBtnUpdateRc"></asp:Label>
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                             </asp:Panel>
                                                        </section>
                                                        <asp:HiddenField ID="hndACId" runat="server" />
                                                        <asp:HiddenField ID="hndACTrxId" runat="server" />
                                                    </ContentTemplate>
                                                 </asp:UpdatePanel>
                                            </div>
                                            <div class="col-lg-4 col-md-4 col-xs-12">
                                                 <asp:UpdatePanel ID="pnlImage" runat="server" UpdateMode="Conditional">
                                                     <ContentTemplate>
                                                         <section class="panel" style="border: solid 1px #d0efde">
                                                             <header class="panel-heading">
                                                                 <b><asp:Label ID="lblAddImage" runat="server" meta:resourcekey="lblAddImageRc" /></b>
                                                             </header>
                                                             <asp:Panel runat="server" class="panel-body" Style="padding-bottom: 0px" DefaultButton="">
                                                                <%= WebUtils.getErrorMessage(this.errorMessagesForUpload) %>
                                                                <%= WebUtils.getInfoMessage(this.infoMessagesForUpload) %>
                                                                <div class="row panel-body" style="padding-bottom:0">
                                                                    <div class="col-lg-6 col-md-6 col-xs-6" style="padding: 5px;">
                                                                        <div class="form-group" style="width: 100%;">
                                                                            <asp:Label ID="lblDescription" runat="server" meta:resourcekey="lblDescriptionRc" AssociatedControlID="txtDescription" />
                                                                            <asp:TextBox ID="txtDescription"
                                                                                        Width="98.5%"
                                                                                        ForeColor="#0094FF"
                                                                                        runat="server"
                                                                                        Style="padding-left: 5px"
                                                                                        CssClass="form-control"
                                                                                        meta:resourcekey="txtDescriptionRc" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row" style="padding-top:0">                                                           
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
                                                                 </asp:Panel>
                                                                </div>                                                       
                                                             </asp:Panel>
                                                         </section>
                                                     </ContentTemplate>
                                                      <Triggers>
                                                         <asp:PostBackTrigger ControlID="lnkUpload" />
                                                     </Triggers>
                                                 </asp:UpdatePanel>
                                            </div>
                                        </div>
                                        <div class="row col-lg-12">
                                            <asp:UpdatePanel ID="pnlItemImage" runat="server" UpdateMode="Conditional" >
                                                <ContentTemplate>
                                                    <section class="panel" style="border: solid 1px #d0efde">
                                                        <header class="panel-heading">
                                                            <b><asp:Label ID="lblItemImage" runat="server" meta:resourcekey="lblItemImageRc" /></b>
                                                        </header>
                                                         <%= WebUtils.getErrorMessage(this.errorMessagesForDetail) %>
                                                            <%= WebUtils.getInfoMessage(this.infoMessagesForDetail) %>
                                                            <asp:Panel runat="server" class="panel-body" Style="padding-bottom: 0px" DefaultButton="">
                                                                <div class="row" style="height:320px; overflow-x:hidden">
                                                                <asp:Repeater ID="imageRepeater" OnItemDataBound="imageRepeater_ItemDataBound" runat="server">
                                                                    <ItemTemplate>
                                                                        <div class="col-lg-2 col-sm-12 col-xs-12" style="padding: 10px;">
                                                                            <div class="ovContainer" style="display: block;">
                                                                                <asp:Label ID="lblImageID" runat="server" Visible="false"></asp:Label>
                                                                                <asp:Image ID="images"
                                                                                    ImageUrl="../include/img/sample/01.jpg"
                                                                                    runat="server"
                                                                                    Style="padding: 0px; width: 100%; height: 200px;" class="image" />
                                                                                <div class="ovBottom-left" style="background-color: rgba(25, 30, 58, 0.6); width: 100%; text-align: left; padding-left: 10px;">
                                                                                    <asp:Label ID="lblDescription" Font-Bold="true" meta:resourcekey="lblDescriptionRc" runat="server">
                                                                                    </asp:Label>
                                                                                </div>
                                                                                <div class="ovContainer" style="display: block; float: left; width: 100%;">
                                                                                    <asp:LinkButton ID="btnDelete"
                                                                                        CssClass="btn btn-danger btn-sm btn-block"
                                                                                        runat="server"
                                                                                        CommandArgument='<%# Eval("id")%>'
                                                                                        OnCommand="btnDelete_Command">
                                                                                        <i class="fa fa-trash-o"></i>
                                                                                        <asp:Label ID="lblDelete" runat="server" meta:resourcekey="lblDeleteRc" />
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
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </ItemTemplate>
                                                                </asp:Repeater>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-lg-2 col-md-2 col-xs-12" style="padding: 5px;">
                                                                    <div class="form-group" style="width: 100%; margin-top: 22px; float: left">
                                                                        <asp:LinkButton ID="btnBack"
                                                                            type="button"
                                                                            class="btn btn-warning btn-block"
                                                                            runat="server"
                                                                            OnClick="btnBack_Click">
                                                                            <i class="fa fa-mail-reply-all"></i>
                                                                            <asp:Label ID="lblBack" runat="server" meta:resourcekey="lblBackRc"></asp:Label>
                                                                        </asp:LinkButton>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            </asp:Panel>
                                                    </section>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                    </section>
                                </form>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </section>
    </section>
     <style>
       .ovContainer {
            position: relative;
            text-align: center;
            color: #25d5e4;
        }
        .ovBottom-left {
            position: absolute;
            bottom: 0px;
            left: 0px;
        }
    </style>
</asp:Content>

