<%@ Page Language="C#"
         AutoEventWireup="true" 
         CodeBehind="F006.AddMeetingNote.aspx.cs" 
         Inherits="XenDevWeb.admin.F006_AddMeetingNote" 
         MaintainScrollPositionOnPostback="true"
         MasterPageFile="~/include/master.Master"
         %>

<%@ Import Namespace="XenDevWeb.Utils" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentMainPlaceHolder" runat="Server">
    <head runat="server">
        <meta http-equiv="Content-Language" content="th">
        <meta http-equiv="content-Type" content="text/html; charset=window-874">
        <meta http-equiv="content-Type" content="text/html; charset=tis-620">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300">
        <link rel="stylesheet" href="https://yui-s.yahooapis.com/pure/0.5.0/pure-min.css">
        <style>
            body {
                margin: 0;
                padding: 0;
                border: 0;
                min-width: 320px;
                color: #777;
            }

            html, button, input, select, textarea, .pure-g [class *= "pure-u"] {
                font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
                font-size: 1.02em;
            }

            p, td {
                line-height: 1.5;
            }

            ul {
                padding: 0 0 0 20px;
            }

            th {
                background: #eee;
                white-space: nowrap;
            }

            th, td {
                padding: 10px;
                text-align: left;
                vertical-align: top;
                font-size: .9em;
                font-weight: normal;
                border-right: 1px solid #fff;
            }

                td:first-child {
                    white-space: nowrap;
                    color: #008000;
                    width: 1%;
                    font-style: italic;
                }

            h1, h2, h3 {
                color: #4b4b4b;
                font-family: "Source Sans Pro", sans-serif;
                font-weight: 300;
                margin: 0 0 1.2em;
            }

            h1 {
                font-size: 4.5em;
                color: #1f8dd6;
                margin: 0 0 .4em;
            }

            h2 {
                font-size: 2em;
                color: #636363;
            }

            h3 {
                font-size: 1.8em;
                color: #4b4b4b;
                margin: 1.8em 0 .8em;
            }

            h4 {
                font: bold 1em sans-serif;
                color: #636363;
                margin: 4em 0 1em;
            }

            a {
                color: #4e99c7;
                text-decoration: none;
            }

                a:hover {
                    text-decoration: underline;
                }

            p, pre {
                margin: 0 0 1.2em;
            }

            ::selection {
                color: #fff;
                background: #328efd;
            }

            ::-moz-selection {
                color: #fff;
                background: #328efd;
            }

            @media (max-width:480px) {
                h1 {
                    font-size: 3em;
                }

                h2 {
                    font-size: 1.8em;
                }

                h3 {
                    font-size: 1.5em;
                }

                td:first-child {
                    white-space: normal;
                }
            }

            .inline-code {
                padding: 1px 5px;
                background: #eee;
                border-radius: 2px;
                -moz-border-radius: 2px;
                -webkit-border-radius: 2px;
            }

            pre {
                padding: 15px 10px;
                font-size: .9em;
                color: #555;
                background: #edf3f8;
            }

                pre i {
                    color: #aaa;
                }
                /* comments */
                pre b {
                    font-weight: normal;
                    color: #cf4b25;
                }
                /* strings */
                pre em {
                    color: #0c59e9;
                }
            /* strings */

            /* Pure CSS */
            .pure-button {
                margin: 5px 0;
                text-decoration: none !important;
            }

            .button-xlarge {
                margin: 5px 0;
                padding: .65em 1.6em;
                font-size: 105%;
            }

            .button-small {
                font-size: 85%;
            }

            textarea {
                width: 100%;
                height: 29px;
                padding: .3em .5em;
                border: 1px solid #ddd;
                font-size: .9em;
                -webkit-box-sizing: border-box;
                -moz-box-sizing: border-box;
                box-sizing: border-box;
                margin: 0 0 20px;
            }

                textarea[readonly] {
                    color: #aaa;
                    background: #f7f7f7;
                }

            #response {
                margin: 0 0 1.2em;
                padding: 10px;
                background: #f3f3f3;
                color: #777;
                font-size: .9em;
                max-height: 150px;
                overflow: hidden;
                overflow-y: auto;
            }

                #response i {
                    font-style: normal;
                    color: #cf4b25;
                }

                #response hr {
                    margin: 2px 0;
                    border: 0;
                    border-top: 1px solid #eee;
                    border-bottom: 1px solid #fdfdfd;
                }

            /* overwrite default CSS for tiny, dark tags in demo5 */
            #demo5 + .tag-editor {
                background: #fafafa;
                font-size: 12px;
            }

                #demo5 + .tag-editor .tag-editor-tag {
                    color: #fff;
                    background: #555;
                    border-radius: 2px;
                    -moz-border-radius: 2px;
                    -webkit-border-radius: 2px;
                }

                #demo5 + .tag-editor .tag-editor-spacer {
                    width: 7px;
                }

                #demo5 + .tag-editor .tag-editor-delete {
                    display: none;
                }

            /* color tags */
            .tag-editor .red-tag .tag-editor-tag {
                color: #c65353;
                background: #ffd7d7;
            }

            .tag-editor .red-tag .tag-editor-delete {
                background-color: #ffd7d7;
            }

            .tag-editor .green-tag .tag-editor-tag {
                color: #45872c;
                background: #e1f3da;
            }

            .tag-editor .green-tag .tag-editor-delete {
                background-color: #e1f3da;
            }

            .ui-sortable > li {
                padding: unset !important;
                position: relative;
                background: #f5f6f8;
                margin-bottom: 2px;
                border-bottom: none !important;
            }
        </style>
            <%--tag-editor--%>
    <link rel="stylesheet" href="../include/tagEditor/jquery.tag-editor.css">
    </head>
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-xs-12">
                    <section class="panel">
                        <header class="panel-heading tab-bg-dark-navy-blue tab-right ">
                            <span class="hidden-sm wht-color">
                                <strong><asp:Label ID="lblAddMeetingNotes" runat="server" meta:resourcekey="lblAddMeetingNotesRc" /></strong>
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
                                                <asp:UpdatePanel ID="pnlMeetingDetail" runat="server" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <%= WebUtils.getErrorMessage(this.errorMessages) %>
                                                        <%= WebUtils.getInfoMessage(this.infoMessages) %>
                                                        <section class="panel" style="border: solid 1px #d0efde">
                                                            <header class="panel-heading">
                                                                <b><asp:Label ID="lblMeetingDetailHeader" runat="server" meta:resourcekey="lblMeetingDetailHeaderRc" /></b>
                                                            </header>
                                                            <asp:Panel runat="server" class="panel-body" Style="padding-bottom: 0px" DefaultButton="">
                                                                <div class="row">
                                                                    <div class="col-lg-4 col-md-4 col-xs-6" style="padding: 5px;">
                                                                        <!-- Date  -->
                                                                        <div class="form-group" style="width: 90%; margin-left: 10px; float: left">
                                                                            <asp:Label ID="lblMeetingDate" runat="server" meta:resourcekey="lblMeetingDateRc" AssociatedControlID="txtMeetingDate" />
                                                                            <asp:TextBox ID="txtMeetingDate"
                                                                                        Width="98.5%"
                                                                                        runat="server"
                                                                                        ForeColor="#0094FF"
                                                                                        BackColor="#FCF5D8"
                                                                                        CssClass="form-control"
                                                                                        meta:resourcekey="txtMeetingDateRc" />
                                                                            <span class="input-group-btn add-on">
                                                                                <button id="btnMeetingDateCal"
                                                                                        runat="server"
                                                                                        class="btn btn-danger"
                                                                                        style="margin-left: -15px; height: 35px"
                                                                                        type="button">
                                                                                    <i class="fa fa-calendar"></i>
                                                                                </button>
                                                                            </span>
                                                                            <asp:RequiredFieldValidator ID="rfvMeetingDate"
                                                                                                        runat="server"
                                                                                                        ValidationGroup="vsAddMeetingGroup"
                                                                                                        ControlToValidate="txtMeetingDate"
                                                                                                        ForeColor="Red"
                                                                                                        Display="Dynamic"
                                                                                                        meta:resourcekey="txtMeetingDateRc"
                                                                                                        Enabled="false" />
                                                                            <ajaxToolkit:CalendarExtender
                                                                                                        runat="server"
                                                                                                        TargetControlID="txtMeetingDate"
                                                                                                        PopupButtonID="btnMeetingDateCal"
                                                                                                        Format="d/MM/yyyy" BehaviorID="" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-3 col-md-4 col-xs-6" style="padding: 5px;">
                                                                        <div class="form-group" style="width: 100%;">
                                                                            <asp:Label ID="lblMeetingTime" runat="server" meta:resourcekey="lblMeetingTimeRc" AssociatedControlID="txtMeetingTime" />
                                                                            <asp:TextBox ID="txtMeetingTime"
                                                                                            TextMode="Time"
                                                                                            Width="98.5%"
                                                                                            runat="server"
                                                                                            ForeColor="#0094FF"
                                                                                            Style="padding-left: 5px"
                                                                                            CssClass="form-control"
                                                                                            meta:resourcekey="txtMeetingTimeRc" />
                                                                            <asp:RequiredFieldValidator ID="rfvTime"
                                                                                                        runat="server"
                                                                                                        ValidationGroup="vsAddMeetingGroup"
                                                                                                        ControlToValidate="txtMeetingTime"
                                                                                                        ForeColor="Red"
                                                                                                        Display="Dynamic"
                                                                                                        meta:resourcekey="txtMeetingTimeRc" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-5 col-md-4 col-xs-6" style="padding: 5px;">
                                                                        <div class="form-group" style="width: 100%;">
                                                                            <asp:Label ID="lblTopic" runat="server" meta:resourcekey="lblTopicRc" AssociatedControlID="txtTopic" />
                                                                            <asp:TextBox ID="txtTopic"
                                                                                Width="98.5%"
                                                                                runat="server"
                                                                                ForeColor="#0094FF"
                                                                                BackColor="#FCF5D8"
                                                                                Style="padding-left: 5px"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtTopicRc" />
                                                                            <asp:RequiredFieldValidator ID="rfvtxtTopic"
                                                                                runat="server"
                                                                                ValidationGroup="vsAddMeetingGroup"
                                                                                ControlToValidate="txtTopic"
                                                                                ForeColor="Red"
                                                                                Display="Dynamic"
                                                                                meta:resourcekey="txtTopicRc" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-lg-12 form-group" style="width: 100%;">
                                                                        <asp:Label ID="lblAttendNames" runat="server" meta:resourcekey="lblAttendNamesRc" AssociatedControlID="txtAttendNames" />
                                                                        <textarea id="txtAttendNames" CssClass="form-control" runat="server"></textarea>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-lg-12 form-group" style="width: 100%;">
                                                                        <asp:Label ID="lblCCTO" runat="server" meta:resourcekey="lblCCTORc" AssociatedControlID="txtCCTO" />
                                                                        <textarea id="txtCCTO" CssClass="form-control" runat="server"></textarea>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <ajaxToolkit:HtmlEditorExtender ID="html" runat="server" TargetControlID="txtWYSIWYG">
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
                                                                    <div class="form-group" style="width: 100%; margin-left: 10px; float: left">
                                                                        <asp:Label ID="lblWYSIWYG" runat="server" meta:resourcekey="lblWYSIWYGRc" AssociatedControlID="txtWYSIWYG" />
                                                                        <asp:TextBox ID="txtWYSIWYG"
                                                                                    Width="98.5%"
                                                                                    Height="200px"
                                                                                    runat="server"
                                                                                    ForeColor="#0094ff"
                                                                                    BackColor="#ffff00"
                                                                                    CssClass="form-control"
                                                                                    meta:resourcekey="txtWYSIWYGRc" />
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-lg-2 col-md-1 col-xs-6" style="padding: 5px;">
                                                                        <div class="form-group" style="width: 15%; margin-top: 22px; float: left">
                                                                            <asp:LinkButton ID="btnSave"
                                                                                            type="button"
                                                                                            class="btn btn-success"
                                                                                            runat="server"
                                                                                            OnClick="btnSave_Click">
                                                                                <i class="fa fa-save"></i>
                                                                                <asp:Label ID="lblBtnSave" runat="server" meta:resourcekey="lblBtnSaveRc"></asp:Label>
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </asp:Panel>

                                                        </section>
                                                        <asp:HiddenField ID="hndMeetingNoteId" runat="server" />
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:PostBackTrigger ControlID="txtAttendNames" />
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                            </div>
                                            <div class="col-lg-4 col-md-4 col-xs-12">
                                                <asp:UpdatePanel ID="pnlUpLoadImage" runat="server" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <section class="panel" style="border: solid 1px #d0efde">
                                                            <header class="panel-heading">
                                                                <b><asp:Label ID="lblUpLoadImageNew" runat="server" meta:resourcekey="lblUpLoadImageNewRc" /></b>
                                                            </header>
                                                            <%= WebUtils.getErrorMessage(this.errorMessagesForUpload) %>
                                                            <%= WebUtils.getInfoMessage(this.infoMessagesForUpload) %>
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
                                                        </section>
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:PostBackTrigger ControlID="lnkUpload" />
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                            </div>
                                        </div>
                                        <div class="row col-lg-12">
                                            <asp:UpdatePanel ID="pnlImage" runat="server" UpdateMode="Conditional">
                                                <ContentTemplate>
                                                    <section class="panel" style="border: solid 1px #d0efde">
                                                        <header class="panel-heading">
                                                            <b><asp:Label ID="lblImage" runat="server" meta:resourcekey="lblImageRc" /></b>
                                                        </header>
                                                        <%= WebUtils.getErrorMessage(this.errorMessagesForRepeater) %>
                                                        <%= WebUtils.getInfoMessage(this.infoMessagesForRepeater) %>
                                                        <asp:Panel runat="server" class="panel-body" Style="padding-bottom: 0px" DefaultButton="">
                                                            <div class="row" style="height: 320px; overflow-x: hidden">
                                                                <asp:Repeater ID="imageRepeater" OnItemDataBound="imageRepeater_ItemDataBound" runat="server">
                                                                    <ItemTemplate>
                                                                        <div class="col-lg-2 col-sm-12 col-xs-12" style="padding: 10px;">
                                                                            <div class="ovContainer" style="display: block;">
                                                                                <asp:Label ID="lblMeetingID" runat="server" Visible="false"></asp:Label>
                                                                                <asp:Image ID="imageMeeting"
                                                                                            ImageUrl="../include/img/sample/01.jpg"
                                                                                            runat="server"
                                                                                            Style="padding: 0px; width: 100%; height: 200px;" class="image" />
                                                                                <div class="ovBottom-left" style="background-color: rgba(25, 30, 58, 0.6); width: 100%; text-align: left; padding-left: 10px;">
                                                                                    <asp:Label ID="lblOverylay" Font-Bold="true" meta:resourcekey="lblOverylayRc" runat="server">
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
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; margin-top: 22px; float: left">
                                                                <asp:LinkButton ID="btnBack"
                                                                    type="button"
                                                                    class="btn btn-warning btn-block"
                                                                    runat="server"
                                                                    OnClick="btnBack_Click">
                                                                    <asp:Label ID="lblBack" runat="server" meta:resourcekey="lblBtnBackRc"></asp:Label>
                                                                </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </section>
                                                </ContentTemplate>
                                                <Triggers>

                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </div>
                                    </section>
                                    <script src="https://code.jquery.com/ui/1.10.2/jquery-ui.min.js"></script>
                                     <script src="<%= WebUtils.getAppServerPath() %>/include/tagEditor/jquery.tag-editor.js"></script>
                                    <script>

                                        function endRequestHandler(sender, args) {

                                            var proto = $.ui.autocomplete.prototype, initSource = proto._initSource; function filter(array, term) { var matcher = new RegExp($.ui.autocomplete.escapeRegex(term), "i"); return $.grep(array, function (value) { return matcher.test($("<div>").html(value.label || value.value || value).text()); }); } $.extend(proto, { _initSource: function () { if (this.options.html && $.isArray(this.options.source)) { this.source = function (request, response) { response(filter(this.options.source, request.term)); }; } else { initSource.call(this); } }, _renderItem: function (ul, item) { return $("<li></li>").data("item.autocomplete", item).append($("<a></a>")[this.options.html ? "html" : "text"](item.label)).appendTo(ul); } });

                                            var cache = {};
                                            function googleSuggest(request, response) {
                                                var term = request.term;
                                                if (term in cache) { response(cache[term]); return; }
                                                $.ajax({
                                                    url: 'http://query.yahooapis.com/v1/public/yql',
                                                    dataType: 'JSONP',
                                                    data: { format: 'json', q: 'select * from xml where url="http://google.com/complete/search?output=toolbar&q=' + term + '"' },
                                                    success: function (data) {
                                                        var suggestions = [];
                                                        try { var results = data.query.results.toplevel.CompleteSuggestion; } catch (e) { var results = []; }
                                                        $.each(results, function () {
                                                            try {
                                                                var s = this.suggestion.data.toLowerCase();
                                                                suggestions.push({ label: s.replace(term, '<b>' + term + '</b>'), value: s });
                                                            } catch (e) { }
                                                        });
                                                        cache[term] = suggestions;
                                                        response(suggestions);
                                                    }
                                                });
                                            }

                                            $('#<%=txtAttendNames.ClientID%>').tagEditor({
                                                placeholder: 'Enter tags ...',
                                                onChange: function (field, editor, tags) { $('#response').prepend('Tags changed to: <i>' + (tags.length ? tags.join(', ') : '----') + '</i><hr>'); },
                                                beforeTagSave: function (field, editor, tags, tag, val) { $('#response').prepend('Tag <i>' + val + '</i> saved' + (tag ? ' over <i>' + tag + '</i>' : '') + '.<hr>'); },
                                                beforeTagDelete: function (field, editor, tags, val) {
                                                    var q = confirm('Remove tag "' + val + '"?');
                                                    if (q) $('#response').prepend('Tag <i>' + val + '</i> deleted.<hr>');
                                                    else $('#response').prepend('Removal of <i>' + val + '</i> discarded.<hr>');
                                                    return q;
                                                }
                                            });

                                             $('#<%=txtCCTO.ClientID%>').tagEditor({
                                                 placeholder: 'Enter tags ...',
                                                 onChange: function (field, editor, tags) { $('#response').prepend('Tags changed to: <i>' + (tags.length ? tags.join(', ') : '----') + '</i><hr>'); },
                                                 beforeTagSave: function (field, editor, tags, tag, val) { $('#response').prepend('Tag <i>' + val + '</i> saved' + (tag ? ' over <i>' + tag + '</i>' : '') + '.<hr>'); },
                                                 beforeTagDelete: function (field, editor, tags, val) {
                                                     var q = confirm('Remove tag "' + val + '"?');
                                                     if (q) $('#response').prepend('Tag <i>' + val + '</i> deleted.<hr>');
                                                     else $('#response').prepend('Removal of <i>' + val + '</i> discarded.<hr>');
                                                     return q;
                                                 }
                                             });

                                        }


                                        $(document).ready(function () {

                                            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(endRequestHandler);

                                        });
                                        // jQuery UI autocomplete extension - suggest labels may contain HTML tags
                                        // github.com/scottgonzalez/jquery-ui-extensions/blob/master/src/autocomplete/jquery.ui.autocomplete.html.js
                                        (function ($) { var proto = $.ui.autocomplete.prototype, initSource = proto._initSource; function filter(array, term) { var matcher = new RegExp($.ui.autocomplete.escapeRegex(term), "i"); return $.grep(array, function (value) { return matcher.test($("<div>").html(value.label || value.value || value).text()); }); } $.extend(proto, { _initSource: function () { if (this.options.html && $.isArray(this.options.source)) { this.source = function (request, response) { response(filter(this.options.source, request.term)); }; } else { initSource.call(this); } }, _renderItem: function (ul, item) { return $("<li></li>").data("item.autocomplete", item).append($("<a></a>")[this.options.html ? "html" : "text"](item.label)).appendTo(ul); } }); })(jQuery);

                                        var cache = {};
                                        function googleSuggest(request, response) {
                                            var term = request.term;
                                            if (term in cache) { response(cache[term]); return; }
                                            $.ajax({
                                                url: 'http://query.yahooapis.com/v1/public/yql',
                                                dataType: 'JSONP',
                                                data: { format: 'json', q: 'select * from xml where url="http://google.com/complete/search?output=toolbar&q=' + term + '"' },
                                                success: function (data) {
                                                    var suggestions = [];
                                                    try { var results = data.query.results.toplevel.CompleteSuggestion; } catch (e) { var results = []; }
                                                    $.each(results, function () {
                                                        try {
                                                            var s = this.suggestion.data.toLowerCase();
                                                            suggestions.push({ label: s.replace(term, '<b>' + term + '</b>'), value: s });
                                                        } catch (e) { }
                                                    });
                                                    cache[term] = suggestions;
                                                    response(suggestions);
                                                }
                                            });
                                        }

                                        $(function () {
                                            $('#<%=txtAttendNames.ClientID%>').tagEditor({
                                                placeholder: 'Enter tags ...',
                                                onChange: function (field, editor, tags) { $('#response').prepend('Tags changed to: <i>' + (tags.length ? tags.join(', ') : '----') + '</i><hr>'); },
                                                beforeTagSave: function (field, editor, tags, tag, val) { $('#response').prepend('Tag <i>' + val + '</i> saved' + (tag ? ' over <i>' + tag + '</i>' : '') + '.<hr>'); },
                                                beforeTagDelete: function (field, editor, tags, val) {
                                                    var q = confirm('Remove tag "' + val + '"?');
                                                    if (q) $('#response').prepend('Tag <i>' + val + '</i> deleted.<hr>');
                                                    else $('#response').prepend('Removal of <i>' + val + '</i> discarded.<hr>');
                                                    return q;
                                                }
                                                //placeholder: 'Enter tags ...',
                                                //autocomplete: { source: googleSuggest, minLength: 3, delay: 250, html: true, position: { collision: 'flip' } }
                                            });

                                            $('#<%=txtCCTO.ClientID%>').tagEditor({
                                                placeholder: 'Enter tags ...',
                                                onChange: function (field, editor, tags) { $('#response').prepend('Tags changed to: <i>' + (tags.length ? tags.join(', ') : '----') + '</i><hr>'); },
                                                beforeTagSave: function (field, editor, tags, tag, val) { $('#response').prepend('Tag <i>' + val + '</i> saved' + (tag ? ' over <i>' + tag + '</i>' : '') + '.<hr>'); },
                                                beforeTagDelete: function (field, editor, tags, val) {
                                                    var q = confirm('Remove tag "' + val + '"?');
                                                    if (q) $('#response').prepend('Tag <i>' + val + '</i> deleted.<hr>');
                                                    else $('#response').prepend('Removal of <i>' + val + '</i> discarded.<hr>');
                                                    return q;
                                                }
                                            });

                                            //$('#demo1').tagEditor({ initialTags: ['Hello', 'World', 'Example', 'Tags'], delimiter: ', ', placeholder: 'Enter tags ...' }).css('display', 'block').attr('readonly', true);

                                            //$('#demo2').tagEditor({
                                            //    autocomplete: { delay: 0, position: { collision: 'flip' }, source: ['ActionScript', 'AppleScript', 'Asp', 'BASIC', 'C', 'C++', 'CSS', 'Clojure', 'COBOL', 'ColdFusion', 'Erlang', 'Fortran', 'Groovy', 'Haskell', 'HTML', 'Java', 'JavaScript', 'Lisp', 'Perl', 'PHP', 'Python', 'Ruby', 'Scala', 'Scheme'] },
                                            //    forceLowercase: false,
                                            //    placeholder: 'Programming languages ...'
                                            //});

                                            //$('#demo3').tagEditor({ initialTags: ['Hello', 'World'], placeholder: 'Enter tags ...' });
                                            //$('#remove_all_tags').click(function () {
                                            //    var tags = $('#demo3').tagEditor('getTags')[0].tags;
                                            //    for (i = 0; i < tags.length; i++) { $('#demo3').tagEditor('removeTag', tags[i]); }
                                            //});

                                            //$('#demo4').tagEditor({
                                            //    initialTags: ['Hello', 'World'],
                                            //    placeholder: 'Enter tags ...',
                                            //    onChange: function (field, editor, tags) { $('#response').prepend('Tags changed to: <i>' + (tags.length ? tags.join(', ') : '----') + '</i><hr>'); },
                                            //    beforeTagSave: function (field, editor, tags, tag, val) { $('#response').prepend('Tag <i>' + val + '</i> saved' + (tag ? ' over <i>' + tag + '</i>' : '') + '.<hr>'); },
                                            //    beforeTagDelete: function (field, editor, tags, val) {
                                            //        var q = confirm('Remove tag "' + val + '"?');
                                            //        if (q) $('#response').prepend('Tag <i>' + val + '</i> deleted.<hr>');
                                            //        else $('#response').prepend('Removal of <i>' + val + '</i> discarded.<hr>');
                                            //        return q;
                                            //    }
                                            //});

                                            //$('#demo5').tagEditor({ clickDelete: true, initialTags: ['custom style', 'dark tags', 'delete on click', 'no delete icon', 'hello', 'world'], placeholder: 'Enter tags ...' });

                                            //function tag_classes(field, editor, tags) {
                                            //    $('li', editor).each(function () {
                                            //        var li = $(this);
                                            //        if (li.find('.tag-editor-tag').html() == 'red') li.addClass('red-tag');
                                            //        else if (li.find('.tag-editor-tag').html() == 'green') li.addClass('green-tag')
                                            //        else li.removeClass('red-tag green-tag');
                                            //    });
                                            //}
                                            //$('#demo6').tagEditor({ initialTags: ['custom', 'class', 'red', 'green', 'demo'], onChange: tag_classes });
                                            //tag_classes(null, $('#demo6').tagEditor('getTags')[0].editor); // or editor == $('#demo6').next()
                                        });
                                    </script>
                                </form>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </section>
    </section>    
    <!--main content end-->
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
