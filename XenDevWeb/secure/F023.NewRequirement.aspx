<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="F023.NewRequirement.aspx.cs" 
    Inherits="XenDevWeb.secure.F023_NewRequirement" 
    MaintainScrollPositionOnPostback="true"
    MasterPageFile="~/include/master.Master" %>

<%@ Import Namespace="XenDevWeb.Utils" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentMainPlaceHolder" runat="Server">
    <head runat="server">
        <style>
            .ajax__html_editor_extender_texteditor
            {
                background-color:#FAF4AB;
                color:#0094ff;
            }
        </style>
       
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
                                    <asp:Label ID="lblNewRequirements" runat="server" meta:resourcekey="lblNewRequirementsRc" />
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
                                            <%= WebUtils.getErrorMessage(this.errorMessagesForCreate) %>
                                            <%= WebUtils.getInfoMessage(this.infoMessagesForCreate) %>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b>
                                                        <asp:Label ID="lblNewRequirementsHeader" runat="server" meta:resourcekey="lblNewRequirementsRc" />
                                                    </b>
                                                </header>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="">
                                                    <div class="row">
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProjectRc" AssociatedControlID="selProject" />
                                                                <asp:DropDownList CssClass="form-control"
                                                                                    ID="selProject"
                                                                                    Style="color: #0094ff"
                                                                                    AutoPostBack="true"
                                                                                    OnSelectedIndexChanged="selProject_SelectedIndexChanged"
                                                                                    runat="server">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblMeetingNote" runat="server" meta:resourcekey="lblMeetingNoteRc" AssociatedControlID="selMeetingNote" />
                                                                <asp:DropDownList CssClass="form-control"
                                                                                    ID="selMeetingNote"
                                                                                    Style="color: #0094ff"
                                                                                    AutoPostBack="false"
                                                                                    runat="server">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblTitle" runat="server" meta:resourcekey="lblTitleRc" AssociatedControlID="txtTitle" />
                                                                <asp:TextBox ID="txtTitle"
                                                                            Width="98.5%"
                                                                            runat="server"
                                                                            ForeColor="#0094ff"
                                                                            BackColor="#FAF4AB"
                                                                            CssClass="form-control"
                                                                            meta:resourcekey="txtTitleRc" />
                                                                <asp:RequiredFieldValidator ID="rfvTitle"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsAddRequirmentGroup"
                                                                                            ControlToValidate="txtTitle"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtTitleRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblCode" runat="server" meta:resourcekey="lblCodeRc" AssociatedControlID="txtCode" />
                                                                <asp:TextBox ID="txtCode"
                                                                            Width="98.5%"
                                                                            runat="server"
                                                                            ForeColor="#0094ff"
                                                                            BackColor="#FAF4AB"
                                                                            CssClass="form-control"
                                                                            meta:resourcekey="txtCodeRc"
                                                                            AutoPostBack="true"
                                                                            OnTextChanged="txtCode_TextChanged" />
                                                                <asp:RequiredFieldValidator ID="rfvCode"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsAddRequirmentGroup"
                                                                                            ControlToValidate="txtCode"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtCodeRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblManday" runat="server" meta:resourcekey="lblMandayRc" AssociatedControlID="txtManday" />
                                                                <asp:TextBox ID="txtManday"
                                                                            Width="98.5%"
                                                                            runat="server"
                                                                            ForeColor="#0094ff"
                                                                            BackColor="#FAF4AB"
                                                                            CssClass="form-control"
                                                                            meta:resourcekey="txtMandayRc" />
                                                                <asp:RequiredFieldValidator ID="rfvManday"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsAddRequirmentGroup"
                                                                                            ControlToValidate="txtManday"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtMandayRc" />
                                                                <asp:RegularExpressionValidator ID="revManday" 
                                                                                                runat="server" 
                                                                                                ControlToValidate="txtManday"
                                                                                                ValidationGroup="vsAddRequirmentGroup"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtMandayInNumericRc"
                                                                                                ValidationExpression="[0-9]*\.?[0-9]*" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblRevision" runat="server" meta:resourcekey="lblRevisionRc" AssociatedControlID="txtRevision" />
                                                                <asp:TextBox ID="txtRevision"
                                                                            Width="98.5%"
                                                                            runat="server"
                                                                            ForeColor="#0094ff"
                                                                            BackColor="#FAF4AB"
                                                                            CssClass="form-control"
                                                                            meta:resourcekey="txtRevisionRc" />
                                                                <asp:RequiredFieldValidator ID="rfvRevision"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsAddRequirmentGroup"
                                                                                            ControlToValidate="txtRevision"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtRevisionRc" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <ajaxToolkit:HtmlEditorExtender ID="txtDescriptionExtender" runat="server" TargetControlID="txtDescription">
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
                                                                <asp:Label ID="lblDescription" runat="server" meta:resourcekey="lblDescriptionRc" AssociatedControlID="txtDescription" />
                                                                <asp:TextBox ID="txtDescription"
                                                                                Width="98.5%"
                                                                                Height="200px"
                                                                                runat="server"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtDescriptionRc" />
                                                                <asp:RequiredFieldValidator ID="rfvDescription"
                                                                                runat="server"
                                                                                ValidationGroup="vsAddRequirmentGroup"
                                                                                ControlToValidate="txtDescription"
                                                                                ForeColor="Red"
                                                                                Display="Dynamic"
                                                                                meta:resourcekey="txtDescriptionRc" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
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
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px; float: right">
                                                            <div class="form-group" style="width: 100%; margin-top: 22px; float: left">
                                                                <asp:LinkButton ID="btnCreate"
                                                                                type="button"
                                                                                class="btn btn-success btn-block"
                                                                                runat="server"
                                                                                OnClick="btnCreate_Click">
                                                                    <asp:Label ID="lblCreate" runat="server" meta:resourcekey="lblBtnCreateRc"></asp:Label>
                                                                </asp:LinkButton>
                                                                <ajaxToolkit:ConfirmButtonExtender runat="server"
                                                                                                                TargetControlID="btnCreate"
                                                                                                                DisplayModalPopupID="mpe" />
                                                                            <ajaxToolkit:ModalPopupExtender ID="mpe"
                                                                                                            runat="server"
                                                                                                            PopupControlID="pnlPopup"
                                                                                                            TargetControlID="btnCreate"
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
