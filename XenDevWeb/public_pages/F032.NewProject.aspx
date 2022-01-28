<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="F032.NewProject.aspx.cs" 
    Inherits="XenDevWeb.public_pages.F032_NewProject" 
    MaintainScrollPositionOnPostback="true"
    MasterPageFile="~/include/master_publicPages.Master"
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
                                    <asp:Label ID="lblAddNewProject" runat="server" meta:resourcekey="lblAddNewProjectRc" />
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
                                    <asp:UpdatePanel ID="UpdatePanelNewProject" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b>
                                                        <asp:Label ID="lblAddNewProjectHeader" runat="server" meta:resourcekey="lblAddNewProjectRc" />
                                                    </b>
                                                </header>
                                                <%= WebUtils.getErrorMessage(this.errorMessages) %>
                                                <%= WebUtils.getInfoMessage(this.infoMessages) %>
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
                                                                                runat="server"
                                                                                Height="200px"
                                                                                ForeColor="#0094ff"
                                                                                BackColor="#FAF4AB"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtDescriptionRc" />
                                                                <asp:RequiredFieldValidator ID="rfvDescription"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsAdditionProjectGroup"
                                                                                            ControlToValidate="txtDescription"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtDescriptionRc" />
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
                                                                <%--<asp:RequiredFieldValidator ID="rfvIsOther"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsAdditionProjectGroup"
                                                                                            ControlToValidate="txtIsOther"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtIsOtherRc" />--%>
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
                                                                <%--<asp:RequiredFieldValidator ID="rfvIsMigrateFromOther"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsAdditionProjectGroup"
                                                                                            ControlToValidate="txtIsMigrateFromOther"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtIsMigrateFromOtherRc" />--%>
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
                                                <%= WebUtils.getErrorMessage(this.errorMessagesForAddReport) %>
                                                <%= WebUtils.getInfoMessage(this.infoMessagesForForAddReport) %>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="">
                                                    <div class="col-lg-2 col-md-2 col-xs-6" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <asp:Label ID="lblReportName" runat="server" meta:resourcekey="lblReportNameRc" AssociatedControlID="txtReportName" />
                                                            <asp:TextBox ID="txtReportName"
                                                                                Width="98.5%"
                                                                                runat="server"
                                                                                ForeColor="#0094ff"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtReportNameRc" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4 col-md-4 col-xs-6" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <asp:Label ID="lblReportDescription" runat="server" meta:resourcekey="lblReportDescriptionRc" AssociatedControlID="txtReportDescription" />
                                                            <asp:TextBox ID="txtReportDescription"
                                                                                Width="98.5%"
                                                                                runat="server"
                                                                                ForeColor="#0094ff"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtReportDescriptionRc" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-xs-6" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; margin-left: 10px; margin-top: 22px; float: left">
                                                            <asp:LinkButton ID="btnAddReport"
                                                                        type="button"
                                                                        class="btn btn-info"
                                                                        runat="server"
                                                                        OnClick="btnAddReport_Click">
                                                            <i class="fa fa-plus"></i>
                                                            <asp:Label ID="lblAddReport" runat="server" meta:resourcekey="lblAddReportRc" />
                                                        </asp:LinkButton>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="panel-body" style="overflow-x: auto; width: 100%">
                                                        <%= WebUtils.getErrorMessage(this.errorMessagesForGrid) %>
                                                        <%= WebUtils.getInfoMessage(this.infoMessagesForGrid) %>
                                                        <asp:GridView ID="reportInDatabaseGridView"
                                                                        runat="server"
                                                                        AutoGenerateColumns="false"
                                                                        CssClass="table table-striped table-advance table-hover"
                                                                        Width="100%"
                                                                        GridLines="None"
                                                                        AllowPaging="true"
                                                                        ShowHeaderWhenEmpty="true"
                                                                        OnPageIndexChanging="reportInDatabaseGridView_PageIndexChanging"
                                                                        OnRowDataBound="reportInDatabaseGridView_RowDataBound"
                                                                        OnRowEditing="reportInDatabaseGridView_RowEditing"
                                                                        OnRowCancelingEdit="reportInDatabaseGridView_RowCancelingEdit"
                                                                        OnRowUpdating="reportInDatabaseGridView_RowUpdating">
                                                            <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                            <Columns>
                                                                <asp:TemplateField ItemStyle-Width="5%" HeaderText="">
                                                                    <ItemTemplate>
                                                                        <asp:Label runat="server"
                                                                                    ID="lblId"
                                                                                    Text='<%# Container.DataItemIndex + 1 %>' />
                                                                        <asp:Label ID="lblReportId"
                                                                                    runat="server"
                                                                                    Visible="false"
                                                                                    Text='<%# Eval("id")%>' />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField ItemStyle-Width="30%" meta:resourcekey="gridReportNameRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblGridReport_Name"
                                                                            runat="server" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtGridReport_Name" 
                                                                                     runat="server"
                                                                                     ForeColor="#0094ff"
                                                                                     BackColor="#FAF4AB"
                                                                                     CssClass="form-control"
																				     Width="98.5%" />
                                                                        <asp:RequiredFieldValidator ID="rfvGridReport_Name" 
                                                                                                    runat="server"  
                                                                                                    ValidationGroup="vsReportEditedGroup"
                                                                                                    ControlToValidate="txtGridReport_Name"
                                                                                                    ForeColor="Red"
                                                                                                    Display="Dynamic"
                                                                                                    meta:resourcekey="txtReportNameRc" />
                                                                    </EditItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField ItemStyle-Width="50%" meta:resourcekey="gridReportDescriptionRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblGridReport_Description"
                                                                            runat="server" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtGridReport_Description" 
                                                                                     runat="server"
                                                                                     ForeColor="#0094ff"
                                                                                     BackColor="#FAF4AB"
                                                                                     CssClass="form-control"
																				     Width="98.5%" />
                                                                        <asp:RequiredFieldValidator ID="rfvGridReport_Description" 
                                                                                                    runat="server"  
                                                                                                    ValidationGroup="vsReportEditedGroup"
                                                                                                    ControlToValidate="txtGridReport_Description"
                                                                                                    ForeColor="Red"
                                                                                                    Display="Dynamic"
                                                                                                    meta:resourcekey="txtReportDescriptionRc" />
                                                                    </EditItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:CommandField ItemStyle-Width="100px"  
                                                                                  ShowEditButton="True"
                                                                                  ButtonType="Image"
                                                                                  ControlStyle-CssClass="UsersGridViewButton"
                                                                                  CancelImageUrl="~/include/img/cancel.png"   
                                                                                  UpdateImageUrl="~/include/img/save.png"  
                                                                                  EditImageUrl="~/include/img/edit.png"
                                                                                  UpdateText="Update" 
                                                                                  CancelText="Cancel" />
                                                                <asp:TemplateField ItemStyle-Width="10%" HeaderText="">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="btnDelete"
                                                                                        CssClass="btn btn-danger btn-sm btn-block"
                                                                                        runat="server"
                                                                                        CommandArgument='<%# Eval("name")%>'
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
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </asp:Panel>
                                            </section>
                                            <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px; text-align: center;">
                                                <div class="form-group" style="width: 100%; margin-top: 22px; float: left">
                                                    <asp:LinkButton ID="btnSubmit"
                                                                    type="button"
                                                                    class="btn btn-success"
                                                                    runat="server"
                                                                    OnClick="btnSubmit_Click">
                                                        <i class="fa fa-plus"></i>
                                                        <asp:Label ID="lblBtnSubmit" runat="server" meta:resourcekey="lblBtnSubmitRc" />
                                                    </asp:LinkButton>
                                                    <ajaxToolkit:ConfirmButtonExtender runat="server"
                                                                                        TargetControlID="btnSubmit"
                                                                                        DisplayModalPopupID="mpe" />
                                                    <ajaxToolkit:ModalPopupExtender ID="mpe"
                                                                                    runat="server"
                                                                                    PopupControlID="pnlPopup"
                                                                                    TargetControlID="btnSubmit"
                                                                                    OkControlID="btnYes"
                                                                                    CancelControlID="btnNo"
                                                                                    BackgroundCssClass="modalBackground">
                                                    </ajaxToolkit:ModalPopupExtender>
                                                    <asp:Panel ID="pnlPopup"
                                                                runat="server"
                                                                CssClass="modalPopup"
                                                                Style="display: none">
                                                        <div class="body">
                                                            <%= (string)GetGlobalResourceObject("GlobalResource", "confirm_send_estimation_request") %>
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
                                            <asp:HiddenField ID="hndLanguage" runat="server" />
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
