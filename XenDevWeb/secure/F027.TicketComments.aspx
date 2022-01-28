<%@ Page Language="C#"
    AutoEventWireup="true"
    CodeBehind="F027.TicketComments.aspx.cs"
    Inherits="XenDevWeb.secure.F027_TicketComments"
    MaintainScrollPositionOnPostback="true"
    MasterPageFile="~/include/master.Master" %>

<%@ Import Namespace="XenDevWeb.Utils" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentMainPlaceHolder" runat="Server">
    <head runat="server">
        <style>
            #ContentMainPlaceHolder_txtReplyCommentExtender_ExtenderContentEditable{
                background-color: #FAF4AB;
                color: #0094ff;
            }
           
        </style>
    </head>
    <section id="main-content">
        <section class="wrapper">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-xs-12">
                    <section class="panel">
                        <header class="panel-heading tab-bg-dark-navy-blue tab-right ">
                            <span class="hidden-sm wht-color">
                                <strong>
                                    <asp:Label ID="lblTicketComments" runat="server" meta:resourcekey="lblTicketCommentsRc" />
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
                                    <asp:UpdatePanel ID="pnlAddComment" runat="server">
                                        <ContentTemplate>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b>
                                                        <asp:Label ID="lblTicketTitle" runat="server" meta:resourcekey="lblTicketTitleRc" />
                                                    </b>
                                                </header>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="">
                                                    <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <div id="detailTextDiv" runat="server" style="width: 100%; float: left"></div>
                                                        </div>
                                                    </div>
                                                    
                                                </asp:Panel>
                                                <asp:Panel runat="server" class="panel-footer" DefaultButton="">
                                                    <asp:Label ID="lblAssignDateTitle" runat="server" meta:resourcekey="lblAssignDateTitleRc" />
                                                    <asp:Label ID="lblAssignDate" runat="server" meta:resourcekey="lblAssignDateRc" />
                                                    <div style="float: right">
                                                        <asp:Label ID="lblDeliveryDateTitle" runat="server" meta:resourcekey="lblDeliveryDateTitleRc" />
                                                        <asp:Label ID="lblDeliveryDate" runat="server" meta:resourcekey="lblDeliveryDateRc" />
                                                    </div>
                                                </asp:Panel>
                                            </section>
                                            <asp:HiddenField ID="hndTicketId" runat="server" />
                                            <asp:Repeater ID="commentRepeater" OnItemDataBound="commentRepeater_ItemDataBound" runat="server">
                                                <ItemTemplate>
                                                    <section class="panel" style="border: solid 1px #d0efde">
                                                        <header class="panel-heading">
                                                            <b>
                                                                <asp:Label ID="lblCommentByTitle" runat="server" meta:resourcekey="lblCommentByTitleRc" />
                                                                <asp:Label ID="lblCommentBy" runat="server" meta:resourcekey="lblCommentByRc" />
                                                            </b>
                                                        </header>
                                                        <asp:Panel runat="server" class="panel-body" DefaultButton="">
                                                            <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px;">
                                                                <div class="form-group" style="width: 100%; float: left">
                                                                    <div id="commentTextDiv" runat="server" style="width: 100%; float: left"></div>
                                                                </div>
                                                            </div>
                                                            <div class="row" overflow-x: hidden">
                                                                <asp:Repeater ID="imageRepeater" OnItemDataBound="imageRepeater_ItemDataBound" runat="server">
                                                                    <ItemTemplate>
                                                                        <div class="col-lg-2 col-sm-12 col-xs-12" style="padding: 10px;">
                                                                                <div class="ovContainer" style="display: block;">
                                                                                <asp:Image ID="images"
                                                                                    ImageUrl="../include/img/sample/01.jpg"
                                                                                    runat="server"
                                                                                    Style="padding: 0px; width: 100%; height: 200px;" class="image" />
                                                                                <div class="ovBottom-left" style="background-color: rgba(25, 30, 58, 0.6); width: 100%; text-align: left; padding-left: 10px;">
                                                                                    <asp:Label ID="lblDescriptionComment" Font-Bold="true" meta:resourcekey="lblDescriptionCommentRc" runat="server">
                                                                                    </asp:Label>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </ItemTemplate>
                                                                </asp:Repeater>
                                                            </div>
                                                        </asp:Panel>
                                                        <asp:Panel runat="server" class="panel-footer" DefaultButton="">
                                                                <asp:Label ID="lblCommentCreationDateTitle" runat="server" meta:resourcekey="lblCommentCreationDateTitleRc" />
                                                                <asp:Label ID="lblCommentCreationDate" runat="server" meta:resourcekey="lblCommentCreationDateRc" />
                                                        </asp:Panel>
                                                    </section>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b>
                                                        <asp:Label ID="lblReply" runat="server" meta:resourcekey="lblReplyRc" />
                                                    </b>
                                                </header>
                                                <%= WebUtils.getErrorMessage(this.errorMessagesForAddComment) %>
                                                <%= WebUtils.getInfoMessage(this.infoMessagesForAddComment) %>
                                                <asp:Panel runat="server" class="panel-body" Style="padding-bottom: 0px" DefaultButton="">
                                                    <div class="col-lg-8 col-md-8 col-xs-12">
                                                        <section class="panel" style="border: solid 1px #d0efde">
                                                            <header class="panel-heading">
                                                                <b>
                                                                    <asp:Label ID="lblReplyCommentHeader" runat="server" meta:resourcekey="lblReplyCommentRc" /></b>
                                                            </header>
                                                            <asp:Panel runat="server" class="panel-body" Style="padding-bottom: 0px" DefaultButton="">
                                                                <div class="row">
                                                                    <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px;">
                                                                        <div class="form-group" style="width: 100%; float: left">
                                                                            <ajaxToolkit:HtmlEditorExtender ID="txtReplyCommentExtender" runat="server" TargetControlID="txtReplyComment">
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
                                                                                    <ajaxToolkit:FontNameSelector />
                                                                                    <ajaxToolkit:FontSizeSelector />
                                                                                    <ajaxToolkit:Indent />
                                                                                    <ajaxToolkit:Outdent />
                                                                                    <ajaxToolkit:InsertHorizontalRule />
                                                                                    <ajaxToolkit:HorizontalSeparator />
                                                                                    <ajaxToolkit:InsertImage />
                                                                                </Toolbar>
                                                                            </ajaxToolkit:HtmlEditorExtender>
                                                                            <asp:TextBox ID="txtReplyComment"
                                                                                Width="98.5%"
                                                                                Height="200px"
                                                                                runat="server"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtReplyCommentRc" />
                                                                            <asp:RequiredFieldValidator ID="rfvReplyComment"
                                                                                runat="server"
                                                                                ValidationGroup="vsAddReplyCommentGroup"
                                                                                ControlToValidate="txtReplyComment"
                                                                                ForeColor="Red"
                                                                                Display="Dynamic"
                                                                                meta:resourcekey="txtReplyCommentRc" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </asp:Panel>
                                                        </section>
                                                        <%--</div>--%>
                                                    </div>
                                                    <div class="col-lg-4 col-md-4 col-xs-12">
                                                        <section class="panel" style="border: solid 1px #d0efde">
                                                            <header class="panel-heading">
                                                                <b>
                                                                    <asp:Label ID="lblAddImage" runat="server" meta:resourcekey="lblAddImageRc" /></b>
                                                            </header>
                                                            <%= WebUtils.getErrorMessage(this.errorMessagesForUpload) %>
                                                            <%= WebUtils.getInfoMessage(this.infoMessagesForUpload) %>
                                                            <asp:Panel runat="server" class="panel-body" Style="padding-bottom: 0px" DefaultButton="">
                                                                <div class="row panel-body" style="padding-bottom: 0">
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
                                                                <div class="row" style="padding-top: 0">
                                                                    <asp:Panel runat="server" class="panel-body" Style="padding-top: 0px; text-align: center" DefaultButton="">
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
                                                                                    <span class="fileupload-new"><i class="fa fa-paper-clip"></i>Select image</span>
                                                                                    <span class="fileupload-exists"><i class="fa fa-undo"></i>Change</span>
                                                                                    <input type="file" class="default" id="myFile" name="myFile" />
                                                                                </span>
                                                                                <a href="#" class="btn btn-danger fileupload-exists" data-dismiss="fileupload"><i class="fa fa-trash"></i>Remove</a>
                                                                                <a href="#" class="btn btn-success fileupload-exists"
                                                                                    runat="server"
                                                                                    onserverclick="lnkUpload_ServerClick"
                                                                                    id="lnkUpload">
                                                                                    <i class="fa fa-eye"></i><%= (string)GetGlobalResourceObject("GlobalResource", "upload") %>
                                                                                </a>
                                                                            </div>
                                                                        </div>
                                                                    </asp:Panel>
                                                                </div>
                                                            </asp:Panel>
                                                        </section>
                                                    </div>
                                                    <div class="col-lg-12 col-md-12 col-xs-12">
                                                        <section class="panel" style="border: solid 1px #d0efde">
                                                            <header class="panel-heading">
                                                                <b>
                                                                    <asp:Label ID="lblItemImage" runat="server" meta:resourcekey="lblItemImageRc" /></b>
                                                            </header>
                                                            <asp:Panel runat="server" class="panel-body" Style="padding-bottom: 0px" DefaultButton="">
                                                                <div class="row" style="height: 320px; overflow-x: hidden">
                                                                    <asp:Repeater ID="imageReplyRepeater" OnItemDataBound="imageReplyRepeater_ItemDataBound" runat="server">
                                                                        <ItemTemplate>
                                                                            <div class="col-lg-2 col-md-4 col-xs-12" style="padding: 10px;">
                                                                                <div class="ovContainer" style="display: block;">
                                                                                    <asp:Image ID="imagesReply"
                                                                                        ImageUrl="../include/img/sample/01.jpg"
                                                                                        runat="server"
                                                                                        Style="padding: 0px; width: 100%; height: 200px;" class="image" />
                                                                                    <div class="ovBottom-left" style="background-color: rgba(25, 30, 58, 0.6); width: 100%; text-align: left; padding-left: 10px;">
                                                                                        <asp:Label ID="lblDescriptionReply" Font-Bold="true" meta:resourcekey="lblDescriptionReplyRc" runat="server">
                                                                                        </asp:Label>
                                                                                    </div>
                                                                                    <div class="ovContainer" style="display: block; float: left; width: 100%;">
                                                                                        <asp:LinkButton ID="btnDelete"
                                                                                                        CssClass="btn btn-danger btn-sm btn-block"
                                                                                                        runat="server"
                                                                                                        CommandArgument='<%# Eval("serverImageFileName")%>'
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
                                                                                                <asp:LinkButton ID="btnYes"
                                                                                                                runat="server"
                                                                                                                CssClass="btn btn-danger btn-xs">
                                                                                                    <asp:PlaceHolder runat="server">
                                                                                                        <i class="fa fa fa-trash-o"></i> <%= (string)GetGlobalResourceObject("GlobalResource", "yes") %>
                                                                                                    </asp:PlaceHolder>
                                                                                                </asp:LinkButton>
                                                                                                <asp:LinkButton ID="btnNo"
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
                                                            </asp:Panel>
                                                        </section>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-lg-2 col-md-2 col-xs-6" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; margin-top: 22px; float: left">
                                                                <asp:LinkButton ID="btnAddComment"
                                                                                type="button"
                                                                                class="btn btn-success btn-block"
                                                                                runat="server"
                                                                                OnClick="btnAddComment_Click">
                                                                    <i class="fa fa-floppy-o"></i>
                                                                    <asp:Label ID="lblBtnAddComment" runat="server" meta:resourcekey="lblBtnAddCommentRc"></asp:Label>
                                                                </asp:LinkButton>
                                                                <ajaxToolkit:ConfirmButtonExtender runat="server"
                                                                                                    TargetControlID="btnAddComment"
                                                                                                    DisplayModalPopupID="mpe" />
                                                                <ajaxToolkit:ModalPopupExtender ID="mpe"
                                                                                                runat="server"
                                                                                                PopupControlID="pnlPopup"
                                                                                                TargetControlID="btnAddComment"
                                                                                                OkControlID="btnYes"
                                                                                                CancelControlID="btnNo"
                                                                                                BackgroundCssClass="modalBackground">
                                                                </ajaxToolkit:ModalPopupExtender>
                                                                <asp:Panel ID="pnlPopup"
                                                                            runat="server"
                                                                            CssClass="modalPopup"
                                                                            Style="display: none">
                                                                    <div class="body">
                                                                        <%= (string)GetGlobalResourceObject("GlobalResource", "confirm_saved") %>
                                                                    </div>
                                                                    <div class="footer">
                                                                        <asp:LinkButton ID="btnYes"
                                                                                        runat="server"
                                                                                        CssClass="btn btn-success btn-xs">
                                                                            <asp:PlaceHolder runat="server">
                                                                                <i class="fa fa-check"></i> <%= (string)GetGlobalResourceObject("GlobalResource", "yes") %>
                                                                            </asp:PlaceHolder>
                                                                        </asp:LinkButton>
                                                                        <asp:LinkButton ID="btnNo"
                                                                                        runat="server"
                                                                                        CssClass="btn btn-danger btn-xs">
                                                                            <asp:PlaceHolder runat="server">
                                                                                <i class="fa fa fa-trash-o"></i> <%= (string)GetGlobalResourceObject("GlobalResource", "no") %>
                                                                            </asp:PlaceHolder>
                                                                        </asp:LinkButton>
                                                                    </div>
                                                                </asp:Panel>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </section>
                                            <section class="panel" style="border: solid 1px #d0efde" id="tkCompletion" runat="server">
                                                <header class="panel-heading">
                                                    <b>
                                                        <asp:Label ID="lblTicketCompletion" runat="server" meta:resourcekey="lblTicketCompletionRc" />
                                                    </b>
                                                </header>
                                                <%= WebUtils.getErrorMessage(this.errorMessagesForAddTicketComplete) %>
                                                <%= WebUtils.getInfoMessage(this.infoMessagesForAddTicketComplete) %>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="">
                                                    <div class="col-lg-2 col-md-4 col-xs-12" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusRc" AssociatedControlID="selStatus" />
                                                            <asp:DropDownList CssClass="form-control"
                                                                                ID="selStatus"
                                                                                Style="color: #0094ff"
                                                                                AutoPostBack="true"
                                                                                runat="server">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4 col-md-4 col-xs-6" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <asp:Label ID="lblNote" runat="server" meta:resourcekey="lblNoteRc" AssociatedControlID="txtNote" />
                                                            <asp:TextBox ID="txtNote"
                                                                            Width="98.5%"
                                                                            runat="server"
                                                                            ForeColor="#0094ff"
                                                                            CssClass="form-control"
                                                                            meta:resourcekey="txtNoteRc" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-xs-6" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; margin-top: 22px; float: left">
                                                            <asp:LinkButton ID="btnSave"
                                                                            type="button"
                                                                            class="btn btn-success btn-block"
                                                                            runat="server"
                                                                            OnClick="btnSave_Click">
                                                                <i class="fa fa-floppy-o"></i>
                                                                <asp:Label ID="lblBtnSave" runat="server" meta:resourcekey="lblBtnSaveRc"></asp:Label>
                                                            </asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </section>
                                            <div class="row">
                                                <div class="col-lg-2 col-md-2 col-xs-6" style="padding: 5px;">
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
