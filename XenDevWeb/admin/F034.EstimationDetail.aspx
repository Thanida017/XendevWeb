<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="F034.EstimationDetail.aspx.cs" 
    Inherits="XenDevWeb.admin.F034_EstimationDetail" 
    MaintainScrollPositionOnPostback="true"
    MasterPageFile="~/include/master.Master"
    meta:resourcekey="PageResource1" %>

<%@ Import Namespace="XenDevWeb.Utils" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentMainPlaceHolder" runat="Server">
    <head runat="server">
        <style>
            .ajax__html_editor_extender_texteditor {
                background-color: #FAF4AB;
                color: #0094ff;
            }
            .chkLabel{
                display: inline-block;
            }
            .chkTextBox{
                border: none;
                border-bottom: 1px solid #e2e2e4;
                display: inline-block;
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
                                    <asp:Label ID="lblProjectDetail" runat="server" meta:resourcekey="lblProjectDetailRc" />
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
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b>
                                                        <asp:Label ID="lblProjectDetailHeader" runat="server" meta:resourcekey="lblProjectDetailRc" />
                                                    </b>
                                                </header>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="">
                                                    <div class="row">
                                                        <div class="col-lg-6 col-md-6 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblCompanyName" runat="server" meta:resourcekey="lblCompanyNameRc" AssociatedControlID="txtCompanyName" />
                                                                <asp:TextBox ID="txtCompanyName"
                                                                                Width="98.5%"
                                                                                runat="server"
                                                                                ForeColor="#0094ff"
                                                                                BackColor="#FAF4AB"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtCompanyNameRc" />
                                                                <asp:RequiredFieldValidator ID="rfvCompanyName"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsAdditionProjectGroup"
                                                                                            ControlToValidate="txtCompanyName"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtCompanyNameRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-6 col-md-6 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblContactPersonName" runat="server" meta:resourcekey="lblContactPersonNameRc" AssociatedControlID="txtContactPersonName" />
                                                                <asp:TextBox ID="txtContactPersonName"
                                                                                Width="98.5%"
                                                                                runat="server"
                                                                                ForeColor="#0094ff"
                                                                                BackColor="#FAF4AB"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtContactPersonNameRc" />
                                                                <asp:RequiredFieldValidator ID="rfvContactPersonName"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsAdditionProjectGroup"
                                                                                            ControlToValidate="txtContactPersonName"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtContactPersonNameRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-6 col-md-6 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblContactEmail" runat="server" meta:resourcekey="lblContactEmailRc" AssociatedControlID="txtContactEmail" />
                                                                <asp:TextBox ID="txtContactEmail"
                                                                                Width="98.5%"
                                                                                runat="server"
                                                                                ForeColor="#0094ff"
                                                                                BackColor="#FAF4AB"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtContactEmailRc" />
                                                                <asp:RequiredFieldValidator ID="rfvContactEmail"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsAdditionProjectGroup"
                                                                                            ControlToValidate="txtContactEmail"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtContactEmailRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-6 col-md-6 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblContactPhoneNumber" runat="server" meta:resourcekey="lblContactPhoneNumberRc" AssociatedControlID="txtContactPhoneNumber" />
                                                                <asp:TextBox ID="txtContactPhoneNumber"
                                                                                Width="98.5%"
                                                                                runat="server"
                                                                                ForeColor="#0094ff"
                                                                                BackColor="#FAF4AB"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtContactPhoneNumberRc" />
                                                                <asp:RequiredFieldValidator ID="rfvContactPhoneNumber"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsAdditionProjectGroup"
                                                                                            ControlToValidate="txtContactPhoneNumber"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtContactPhoneNumberRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblProjectName" runat="server" meta:resourcekey="lblProjectNameRc" AssociatedControlID="txtProjectName" />
                                                                <asp:TextBox ID="txtProjectName"
                                                                                Width="98.5%"
                                                                                runat="server"
                                                                                ForeColor="#0094ff"
                                                                                BackColor="#FAF4AB"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtProjectNameRc" />
                                                                <asp:RequiredFieldValidator ID="rfvProjectName"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsAdditionProjectGroup"
                                                                                            ControlToValidate="txtProjectName"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtProjectNameRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblDescription" runat="server" meta:resourcekey="lblDescriptionRc" />
                                                                <div id="descriptionTextDiv" runat="server" style="width: 100%; float: left"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </section>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b>
                                                        <asp:Label ID="lblStyleHeader" runat="server" meta:resourcekey="lblStyleHeaderRc" />
                                                    </b>
                                                </header>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="">
                                                    <div class="col-lg-4 col-md-4 col-xs-4" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <div class="checkbox" style="margin: 0">
                                                                <asp:CheckBox ID="chkIsWeb" runat="server" />
                                                                <asp:Label ID="lblIsWeb" CssClass="chkLabel" runat="server" meta:resourcekey="lblIsWebRc" AssociatedControlID="chkIsWeb" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4 col-md-4 col-xs-4" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <div class="checkbox" style="margin: 0">
                                                                <asp:CheckBox ID="chkIsMobile" runat="server" />
                                                                <asp:Label ID="lblIsMobile" CssClass="chkLabel" runat="server" meta:resourcekey="lblIsMobileRc" AssociatedControlID="chkIsMobile" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4 col-md-4 col-xs-4" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <div class="checkbox" style="margin: 0">
                                                                <asp:CheckBox ID="chkIsDesktop" runat="server" />
                                                                <asp:Label ID="lblIsDesktop" CssClass="chkLabel" runat="server" meta:resourcekey="lblIsDesktopRc" AssociatedControlID="chkIsDesktop" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </section>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b>
                                                        <asp:Label ID="lblInputHeader" runat="server" meta:resourcekey="lblInputHeaderRc" />
                                                    </b>
                                                </header>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="">
                                                    <div class="col-lg-6 col-md-6 col-xs-6" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <div class="checkbox" style="margin: 0">
                                                                <asp:CheckBox ID="chkIsExcelUpload" runat="server" />
                                                                <asp:Label ID="lblIsExcelUpload" CssClass="chkLabel" runat="server" meta:resourcekey="lblIsExcelUploadRc" AssociatedControlID="chkIsExcelUpload" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6 col-md-6 col-xs-6" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <div class="checkbox" style="margin: 0">
                                                                <asp:CheckBox ID="chkIsFormEntry" runat="server" />
                                                                <asp:Label ID="lblIsFormEntry" CssClass="chkLabel" runat="server" meta:resourcekey="lblIsFormEntryRc" AssociatedControlID="chkIsFormEntry" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6 col-md-6 col-xs-6" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <div class="checkbox" style="margin: 0">
                                                                <asp:CheckBox ID="chkIsFileUpload" runat="server" />
                                                                <asp:Label ID="lblIsFileUpload" CssClass="chkLabel" runat="server" meta:resourcekey="lblIsFileUploadRc" AssociatedControlID="chkIsFileUpload" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6 col-md-6 col-xs-6" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <div class="checkbox" style="margin: 0">
                                                                <asp:CheckBox ID="chkIsOther" runat="server" />
                                                                <asp:Label ID="lblIsOther" CssClass="chkLabel" runat="server" meta:resourcekey="lblIsOtherRc" AssociatedControlID="chkIsOther" />
                                                                <asp:TextBox ID="txtIsOther"
                                                                                Width="60%"
                                                                                runat="server"
                                                                                ForeColor="#0094ff"
                                                                                CssClass="chkTextBox"
                                                                                meta:resourcekey="txtIsOtherRc" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </section>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b>
                                                        <asp:Label ID="lblDataOption" runat="server" meta:resourcekey="lblDataOptionRc" />
                                                    </b>
                                                </header>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="">
                                                    <div class="col-lg-6 col-md-6 col-xs-6" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <div class="checkbox" style="margin: 0">
                                                                <asp:CheckBox ID="chkIsMigrateFromOldDatabase" runat="server" />
                                                                <asp:Label ID="lblIsMigrateFromOldDatabase" CssClass="chkLabel" runat="server" meta:resourcekey="lblIsMigrateFromOldDatabaseRc" AssociatedControlID="chkIsMigrateFromOldDatabase" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6 col-md-6 col-xs-6" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <div class="checkbox" style="margin: 0">
                                                                <asp:CheckBox ID="chkIsMigrateFromExcel" runat="server" />
                                                                <asp:Label ID="lblIsMigrateFromExcel" CssClass="chkLabel" runat="server" meta:resourcekey="lblIsMigrateFromExcelRc" AssociatedControlID="chkIsMigrateFromExcel" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6 col-md-6 col-xs-6" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <div class="checkbox" style="margin: 0">
                                                                <asp:CheckBox ID="chkIsMigrateFromOther" runat="server" />
                                                                <asp:Label ID="lblIsMigrateFromOther" CssClass="chkLabel" runat="server" meta:resourcekey="lblIsMigrateFromOtherRc" AssociatedControlID="chkIsMigrateFromOther" />
                                                                <asp:TextBox ID="txtIsMigrateFromOther"
                                                                                Width="60%"
                                                                                runat="server"
                                                                                ForeColor="#0094ff"
                                                                                CssClass="chkTextBox"
                                                                                meta:resourcekey="txtIsMigrateFromOtherRc" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6 col-md-6 col-xs-6" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <div class="checkbox" style="margin: 0">
                                                                <asp:CheckBox ID="chkIsMustIntegrateToExistingSoftware" runat="server" />
                                                                <asp:Label ID="lblIsMustIntegrateToExistingSoftware" CssClass="chkLabel" runat="server" meta:resourcekey="lblIsMustIntegrateToExistingSoftwareRc" AssociatedControlID="chkIsMustIntegrateToExistingSoftware" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </section>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b>
                                                        <asp:Label ID="lblReportHeader" runat="server" meta:resourcekey="lblReportHeaderRc" />
                                                    </b>
                                                </header>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="">
                                                    <div class="panel-body" style="overflow-x: auto; width: 100%">
                                                        <asp:GridView ID="reportInDatabaseGridView"
                                                                        runat="server"
                                                                        AutoGenerateColumns="false"
                                                                        CssClass="table table-striped table-advance table-hover"
                                                                        Width="100%"
                                                                        GridLines="None"
                                                                        AllowPaging="true"
                                                                        ShowHeaderWhenEmpty="true"
                                                                        OnPageIndexChanging="reportInDatabaseGridView_PageIndexChanging"
                                                                        OnRowDataBound="reportInDatabaseGridView_RowDataBound">
                                                            <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                            <Columns>
                                                                <asp:TemplateField ItemStyle-Width="10%" HeaderText="">
                                                                    <ItemTemplate>
                                                                        <asp:Label runat="server"
                                                                                    Text='<%# Container.DataItemIndex + 1 %>' />
                                                                        <asp:Label ID="lblReportId"
                                                                                    runat="server"
                                                                                    Visible="false"
                                                                                    Text='<%# Eval("id")%>' />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField ItemStyle-Width="40%" meta:resourcekey="gridReportNameRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblGridReport_Name"
                                                                                    runat="server" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField ItemStyle-Width="50%" meta:resourcekey="gridReportDescriptionRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblGridReport_Description"
                                                                                    runat="server" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </asp:Panel>
                                            </section>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b>
                                                        <asp:Label ID="lblComment" runat="server" meta:resourcekey="lblCommentRc" />
                                                    </b>
                                                </header>
                                                <%= WebUtils.getErrorMessage(this.errorMessagesForUpdate) %>
                                                <%= WebUtils.getInfoMessage(this.infoMessagesForUpdate) %>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="">
                                                    <div class="row">
                                                        <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <ajaxToolkit:HtmlEditorExtender ID="txtCommentExtender" runat="server" TargetControlID="txtComment">
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
                                                                <asp:TextBox ID="txtComment"
                                                                                Width="98.5%"
                                                                                runat="server"
                                                                                Height="200px"
                                                                                ForeColor="#0094ff"
                                                                                BackColor="#FAF4AB"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtCommentRc" />
                                                                <asp:RequiredFieldValidator ID="rfvDescription"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsAdditionCommentGroup"
                                                                                            ControlToValidate="txtComment"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtCommentRc" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusRc" AssociatedControlID="selStatus" />
                                                                <asp:DropDownList CssClass="form-control"
                                                                                    ID="selStatus"
                                                                                    Style="color: #0094ff"
                                                                                    AutoPostBack="false"
                                                                                    runat="server">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="margin-right: 0.5%; margin-left: 10px; float: left; margin-top: 23px">
                                                                <asp:LinkButton ID="btnSave"
                                                                                type="button"
                                                                                class="btn btn-success"
                                                                                runat="server"
                                                                                OnClick="btnSave_Click">
                                                                    <i class="fa fa-save"></i>
                                                                    <asp:Label ID="lblBtnSave" runat="server" meta:resourcekey="lblBtnSaveRc" />
                                                                </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </section>
                                            <div class="col-lg-2 col-md-2 col-xs-6" style="padding: 5px;">
                                                <div class="form-group" style="width: 100%; margin-top: 22px; float: left">
                                                    <asp:LinkButton ID="btnBack"
                                                                    type="button"
                                                                    class="btn btn-warning btn-block"
                                                                    runat="server"
                                                                    OnClick="btnBack_Click">
                                                        <i class="fa fa-mail-reply-all"></i>
                                                        <asp:Label ID="lblBtnBack" runat="server" meta:resourcekey="lblBtnBackRc"></asp:Label>
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                            <asp:HiddenField ID="hndEstimationId" runat="server" />
                                        </ContentTemplate>
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
