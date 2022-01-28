<%@ Page Language="C#"
    AutoEventWireup="true"
    CodeBehind="F022.ListRequirements.aspx.cs"
    Inherits="XenDevWeb.secure.F022_ListRequirements"
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
                                    <asp:Label ID="lblListRequirements" runat="server" meta:resourcekey="lblListRequirementsRc" />
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
                                                        <asp:Label ID="lblListRequirementsHeader" runat="server" meta:resourcekey="lblListRequirementsRc" />
                                                    </b>
                                                </header>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="btnQuery">
                                                    <div class="row">
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProjectRc" AssociatedControlID="selProject" />
                                                                <asp:DropDownList CssClass="form-control"
                                                                                    ID="selProject"
                                                                                    Style="color: #0094ff"
                                                                                    AutoPostBack="false"
                                                                                    runat="server">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblRequirmentStatus" runat="server" meta:resourcekey="lblRequirmentStatusRc" AssociatedControlID="selRequirmentStatus" />
                                                                <asp:DropDownList CssClass="form-control"
                                                                                    ID="selRequirmentStatus"
                                                                                    Style="color: #0094ff"
                                                                                    AutoPostBack="false"
                                                                                    runat="server">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblCode" runat="server" meta:resourcekey="lblCodeRc" AssociatedControlID="txtCode" />
                                                                <asp:TextBox ID="txtCode"
                                                                            Width="98.5%"
                                                                            runat="server"
                                                                            ForeColor="#0094ff"
                                                                            CssClass="form-control"
                                                                            meta:resourcekey="txtCodeRc" />
                                                                
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
                                                                    <asp:Label ID="lblQuery" runat="server" meta:resourcekey="lblQueryRc" />
                                                                </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </section>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b>
                                                        <asp:Label ID="lblListRequirementsInDB" runat="server" meta:resourcekey="lblListRequirementsInDBRc" />
                                                    </b>
                                                </header>
                                                <%= WebUtils.getErrorMessage(this.errorMessagesForGrid) %>
                                                <%= WebUtils.getInfoMessage(this.infoMessagesForGrid) %>
                                                <div class="panel-body" style="overflow-x: auto; width: 100%">
                                                    <asp:GridView ID="listRequirementsGridView"
                                                                    runat="server"
                                                                    AutoGenerateColumns="false"
                                                                    CssClass="table table-striped table-advance table-hover"
                                                                    Width="100%"
                                                                    GridLines="None"
                                                                    AllowPaging="true"
                                                                    ShowHeaderWhenEmpty="true"
                                                                    OnPageIndexChanging="listRequirementsGridView_PageIndexChanging"
                                                                    OnRowDataBound="listRequirementsGridView_RowDataBound">
                                                        <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                        <Columns>
                                                            <asp:TemplateField ItemStyle-Width="2%" HeaderText="">
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server"
                                                                        Text='<%# Container.DataItemIndex + 1 %>' />
                                                                    <asp:Label ID="lblListRequirementId"
                                                                        runat="server"
                                                                        Visible="false"
                                                                        Text='<%# Eval("id")%>' />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="15%" meta:resourcekey="gridProjectRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_Project"
                                                                        runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="gridCodeRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_Code"
                                                                        runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="gridTitleRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_Title"
                                                                        runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="gridRequirmentStatusRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_RequirmentStatus"
                                                                        runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="gridRevisionRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_Revision"
                                                                        runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="15%" meta:resourcekey="gridLastUpdateRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_LastUpdate"
                                                                        runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="12%" meta:resourcekey="gridEditRc">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="btnEdit"
                                                                                    runat="server"
                                                                                    CssClass="btn btn-warning btn-xs"
                                                                                    CommandArgument='<%# Eval("id") %>'
                                                                                    OnCommand="btnEdit_Command">
                                                                            <asp:PlaceHolder runat="server">
                                                                                <i class="fa fa-pencil-square-o"></i>
                                                                            </asp:PlaceHolder>
                                                                    </asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="12%" meta:resourcekey="gridDrawGraphRc">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="btnDrawGraph"
                                                                                    runat="server"
                                                                                    CssClass="btn btn-primary btn-xs"
                                                                                    CommandArgument='<%# Eval("id") %>'
                                                                                    OnCommand="btnDrawGraph_Command">
                                                                            <asp:PlaceHolder runat="server">
                                                                                <i class="fa fa-pencil fa-fw"></i>
                                                                            </asp:PlaceHolder>
                                                                    </asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="3%" HeaderText="">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="btnDelete"
                                                                                    runat="server"
                                                                                    CssClass="btn btn-danger btn-xs"
                                                                                    CommandName="itemRowDelete"
                                                                                    OnClientClick="return confirmDelete()"
                                                                                    CommandArgument='<%# Eval("id")%>'
                                                                                    OnCommand="btnDelete_Command">
																		    <asp:PlaceHolder runat="server">
																			    <i class="fa fa fa-trash-o"></i>
																		    </asp:PlaceHolder>
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
                                            </section>
                                            <div class="row">
                                                <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                    <div class="form-group" style="margin-right: 0.5%; margin-left: 10px; float: left; margin-top: 23px">
                                                        <asp:LinkButton ID="btnAddNew"
                                                                        type="button"
                                                                        class="btn btn-info"
                                                                        runat="server"
                                                                        OnClick="btnAddNew_Click">
                                                            <i class="fa fa-plus"></i>
                                                            <asp:Label ID="lblAddNew" runat="server" meta:resourcekey="lblAddNewRc" />
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
