<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="F033.EstimationList.aspx.cs" 
    Inherits="XenDevWeb.admin.F033_EstimationList" 
MaintainScrollPositionOnPostback="true"
    MasterPageFile="~/include/master.Master"%>

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
                                    <asp:Label ID="lblEstimationList" runat="server" meta:resourcekey="lblEstimationListRc" />
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
                                                        <asp:Label ID="lblEstimationListHeader" runat="server" meta:resourcekey="lblEstimationListRc" />
                                                    </b>
                                                </header>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="btnQuery">
                                                    <div class="row">
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
                                                                <asp:LinkButton ID="btnQuery"
                                                                                type="button"
                                                                                class="btn btn-success"
                                                                                runat="server"
                                                                                OnClick="btnQuery_Click">
                                                                    <i class="fa fa-search"></i>
                                                                    <asp:Label ID="lblBtnQuery" runat="server" meta:resourcekey="lblBtnQueryRc" />
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
                                                <%--<%= WebUtils.getErrorMessage(this.errorMessagesForGrid) %>
                                                <%= WebUtils.getInfoMessage(this.infoMessagesForGrid) %>--%>
                                                <div class="panel-body" style="overflow-x: auto; width: 100%">
                                                    <asp:GridView ID="estimationInDatabaseGridView"
                                                                    runat="server"
                                                                    AutoGenerateColumns="false"
                                                                    CssClass="table table-striped table-advance table-hover"
                                                                    Width="100%"
                                                                    GridLines="None"
                                                                    AllowPaging="true"
                                                                    ShowHeaderWhenEmpty="true"
                                                                    OnPageIndexChanging="estimationInDatabaseGridView_PageIndexChanging"
                                                                    OnRowDataBound="estimationInDatabaseGridView_RowDataBound">
                                                        <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                        <Columns>
                                                            <asp:TemplateField ItemStyle-Width="2%" HeaderText="">
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server"
                                                                                Text='<%# Container.DataItemIndex + 1 %>' />
                                                                    <asp:Label ID="lblEstimationId"
                                                                                runat="server"
                                                                                Visible="false" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="12%" meta:resourcekey="gridEstimation_CompanyNameRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_CompanyName"
                                                                                runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="13%" meta:resourcekey="gridEstimation_ProjectNameRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_ProjectName"
                                                                                runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="15%" meta:resourcekey="gridEstimation_CreationDateRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_CreationDate"
                                                                                runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="12%" meta:resourcekey="gridEstimation__DatailRc">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="btnDatail"
                                                                                    runat="server"
                                                                                    CssClass="btn btn-primary btn-xs"
                                                                                    CommandArgument='<%# Eval("id") %>'
                                                                                    OnCommand="btnDatail_Command">
                                                                            <asp:PlaceHolder runat="server">
                                                                                <i class="fa fa-pencil-square-o"></i>
                                                                            </asp:PlaceHolder>
                                                                    </asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
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

