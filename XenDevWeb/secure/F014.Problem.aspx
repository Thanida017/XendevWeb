<%@ Page Language="C#"
    AutoEventWireup="true"
    CodeBehind="F014.Problem.aspx.cs"
    Inherits="XenDevWeb.secure.F014_Problem"
    MaintainScrollPositionOnPostback="true"
    MasterPageFile="~/include/master.Master" %>

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
                                <strong>
                                    <asp:Label ID="lblProblemList" runat="server" meta:resourcekey="lblProblemListRc" />
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
                                            <%= WebUtils.getErrorMessage(this.errorMessagesForGrid) %>
                                            <%= WebUtils.getInfoMessage(this.infoMessagesForGrid) %>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b>
                                                        <asp:Label ID="lblProblemListHeader" runat="server" meta:resourcekey="lblProblemListRc" />
                                                    </b>
                                                </header>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="btnSearch">
                                                    <div class="row">
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblProjectCode" runat="server" meta:resourcekey="lblProjectCodeRc" AssociatedControlID="txtProjectCode" />
                                                                <asp:TextBox ID="txtProjectCode"
                                                                                Width="98.5%"
                                                                                runat="server"
                                                                                ForeColor="#0094ff"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtProjectCodeRc" />
                                                                <div id="divProjectCodeList" style="height: 100px; overflow-y: scroll;"></div>
                                                                <ajaxToolkit:AutoCompleteExtender ID="projectCode"
                                                                                                    TargetControlID="txtProjectCode"
                                                                                                    CompletionSetCount="999"
                                                                                                    ServiceMethod="GetProjectCode"
                                                                                                    ServicePath="~/WebServices/Lookup.asmx"
                                                                                                    CompletionInterval="100"
                                                                                                    OnClientPopulating="onExtenderLoading"
                                                                                                    OnClientPopulated="onExtenderLoaded"
                                                                                                    UseContextKey="true"
                                                                                                    CompletionListElementID="divProjectCodeList"
                                                                                                    runat="server"
                                                                                                    BehaviorID="projectCode"
                                                                                                    DelimiterCharacters="" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblDateFrom" runat="server" meta:resourcekey="lblDateFromRc" AssociatedControlID="txtDateFrom" />
                                                                <asp:TextBox ID="txtDateFrom"
                                                                                Width="98.5%"
                                                                                runat="server"
                                                                                ForeColor="#0094ff"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtDateFromRc" />
                                                                <span class="input-group-btn add-on">
                                                                    <button id="btnCreated_Date"
                                                                            runat="server"
                                                                            class="btn btn-shadow btn-primary"
                                                                            style="margin-left: -34px; height: 31px"
                                                                            type="button">
                                                                        <i class="fa  fa-calendar"></i>
                                                                    </button>
                                                                </span>
                                                                <asp:RequiredFieldValidator ID="rfvCreated_Date"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsSearchGroup"
                                                                                            ControlToValidate="txtDateFrom"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtDateFromRc" />
                                                                <ajaxToolkit:CalendarExtender
                                                                                            runat="server"
                                                                                            TargetControlID="txtDateFrom"
                                                                                            PopupButtonID="btnCreated_Date"
                                                                                            Format="d/MM/yyyy"
                                                                                            ID="calDateFrom" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblDateTo" runat="server" meta:resourcekey="lblDateToRc" AssociatedControlID="txtDateTo" />
                                                                <asp:TextBox ID="txtDateTo"
                                                                                Width="98.5%"
                                                                                runat="server"
                                                                                ForeColor="#0094ff"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtDateToRc" />
                                                                <span class="input-group-btn add-on">
                                                                    <button id="btnDateTo"
                                                                            runat="server"
                                                                            class="btn btn-shadow btn-primary"
                                                                            style="margin-left: -34px; height: 31px"
                                                                            type="button">
                                                                        <i class="fa  fa-calendar"></i>
                                                                    </button>
                                                                </span>
                                                                <asp:RequiredFieldValidator ID="rfvDateTo"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsSearchGroup"
                                                                                            ControlToValidate="txtDateTo"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtDateToRc" />
                                                                <ajaxToolkit:CalendarExtender
                                                                                            runat="server"
                                                                                            TargetControlID="txtDateTo"
                                                                                            PopupButtonID="btnDateTo"
                                                                                            Format="d/MM/yyyy" BehaviorID="" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblSearchStatus" runat="server" meta:resourcekey="lblSearchStatusRc" AssociatedControlID="selSearchStatus" />
                                                                <asp:DropDownList CssClass="form-control"
                                                                                    ID="selSearchStatus"
                                                                                    Style="color: #0094ff"
                                                                                    AutoPostBack="false"
                                                                    runat="server">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="margin-right: 0.5%; margin-left: 10px; float: left; margin-top: 23px">
                                                                <asp:LinkButton ID="btnSearch"
                                                                                type="button"
                                                                                class="btn btn-success"
                                                                                runat="server"
                                                                                OnClick="btnSearch_Click">
                                                                    <i class="fa fa-search"></i>
                                                                    <asp:Label ID="lblSearch" runat="server" meta:resourcekey="lblSearchRc" />
                                                                </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </section>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b>
                                                        <asp:Label ID="lblProblemListInDB" runat="server" meta:resourcekey="lblProblemListInDBRc" />
                                                    </b>
                                                </header>
                                                <div class="panel-body" style="overflow-x: auto; width: 100%">
                                                    <asp:GridView ID="problemInDatabaseGridView"
                                                                    runat="server"
                                                                    AutoGenerateColumns="false"
                                                                    CssClass="table table-striped table-advance table-hover"
                                                                    Width="100%"
                                                                    GridLines="None"
                                                                    AllowPaging="true"
                                                                    ShowHeaderWhenEmpty="true"
                                                                    OnPageIndexChanging="problemInDatabaseGridView_PageIndexChanging"
                                                                    OnRowDataBound="problemInDatabaseGridView_RowDataBound"
                                                                    OnRowEditing="problemInDatabaseGridView_RowEditing"
                                                                    OnRowCancelingEdit="problemInDatabaseGridView_RowCancelingEdit"
                                                                    OnRowUpdating="problemInDatabaseGridView_RowUpdating">
                                                        <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                        <Columns>
                                                            <asp:TemplateField ItemStyle-Width="2%" HeaderText="">
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server"
                                                                                Text='<%# Container.DataItemIndex + 1 %>' />
                                                                    <asp:Label ID="lblProblemId"
                                                                                runat="server"
                                                                                Visible="false"
                                                                                Text='<%# Eval("id")%>' />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="12%" meta:resourcekey="gridProjectCodeRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_ProjectCode"
                                                                                runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="13%" meta:resourcekey="gridTicketNumberRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_TicketNumber"
                                                                                runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="15%" meta:resourcekey="gridSubjectRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_Subject"
                                                                                runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="12%" meta:resourcekey="gridRequesterRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_Requester"
                                                                                runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="gridLastUpdateRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_LastUpdate"
                                                                                runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="7%" meta:resourcekey="gridStatusRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_Status"
                                                                                runat="server" />
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:DropDownList CssClass="form-control"
                                                                                        ID="selGrid_Status"
                                                                                        Style="color: #0094ff"
                                                                                        AutoPostBack="false"
                                                                                        runat="server">
                                                                    </asp:DropDownList>
                                                                </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="gridAssignToRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_AssignTo"
                                                                                runat="server" />
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:DropDownList CssClass="form-control"
                                                                                        ID="selGrid_AssignTo"
                                                                                        Style="color: #0094ff"
                                                                                        AutoPostBack="false"
                                                                                        runat="server">
                                                                    </asp:DropDownList>
                                                                </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="grid_UpdateTicketRc">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="btnUpdateTicket"
                                                                                    runat="server"
                                                                                    CssClass="btn btn-warning btn-xs"
                                                                                    CommandArgument='<%# Eval("id") %>'
                                                                                    OnCommand="btnUpdateTicket_Command">
                                                                            <asp:PlaceHolder runat="server">
                                                                                <i class="fa fa-pencil-square-o"></i>
                                                                            </asp:PlaceHolder>
                                                                    </asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="gridDetailsRc">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="btnDetails"
                                                                                    runat="server"
                                                                                    CssClass="btn btn-primary btn-xs"
                                                                                    CommandArgument='<%# Eval("id") %>'
                                                                                    OnCommand="btnDetails_Command">
                                                                        <asp:PlaceHolder runat="server">
                                                                            <i class="fa fa-comment"></i>
                                                                        </asp:PlaceHolder>
                                                                    </asp:LinkButton>
                                                                </ItemTemplate>
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
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </section>
                                            <div class="row">
                                                <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                    <div class="form-group" style="margin-right: 0.5%; margin-left: 10px; float: left; margin-top: 23px">
                                                        <asp:LinkButton ID="btnAddTicket"
                                                                        type="button"
                                                                        class="btn btn-info"
                                                                        runat="server"
                                                                        OnClick="btnAddTicket_Click">
                                                            <i class="fa fa-plus"></i>
                                                            <asp:Label ID="lblAddTicket" runat="server" meta:resourcekey="lblAddTicketRc" />
                                                        </asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
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
