<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="F009.ChangeRequest.aspx.cs" 
    Inherits="XenDevWeb.secure.F009_ChangeRequest" 
     MasterPageFile="~/include/master.Master" 
    meta:resourcekey="PageResource1"
    MaintainScrollPositionOnPostback="true"
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
                                <strong><asp:Label ID="lblChangeRequest" runat="server" meta:resourcekey="lblChangeRequestRc" /></strong>
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
                                                <%= WebUtils.getErrorMessage(this.errorMessages) %>
                                                <%= WebUtils.getInfoMessage(this.infoMessages) %>
                                                <header class="panel-heading">
                                                    <b><asp:Label ID="lblAddChangeRequest" runat="server" meta:resourcekey="lblAddChangeRequestRc" /></b>
                                                </header>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="btnAdd">
                                                    <%--<div class="row">--%>
                                                        <div class="col-lg-2 col-md-2 col-xs-12" id="divSelCompany" runat="server" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <b><asp:Label ID="lblSelCompany" runat="server" meta:resourcekey="lblSelCompanyRc" /></b>
                                                                <asp:DropDownList CssClass="form-control"
                                                                                    ID="selCompany"
                                                                                    OnSelectedIndexChanged="selCompany_SelectedIndexChanged"
                                                                                    Style="color: #0094ff; margin-top: 5px;"
                                                                                    AutoPostBack="true"
                                                                                    runat="server">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
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
                                                         <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblAppAsset" runat="server" meta:resourcekey="lblAppAssetRc" AssociatedControlID="selAppAsset" />
                                                                <asp:DropDownList CssClass="form-control"
                                                                                    ID="selAppAsset"
                                                                                    Style="color: #0094ff"
                                                                                    AutoPostBack="false"
                                                                                    runat="server">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                         <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblChangeType" runat="server" meta:resourcekey="lblChangeTypeRc" AssociatedControlID="selChangeType" />
                                                                <asp:DropDownList CssClass="form-control"
                                                                                    ID="selChangeType"
                                                                                    Style="color: #0094ff"
                                                                                    AutoPostBack="false"
                                                                                    runat="server">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblChangeCode" runat="server" meta:resourcekey="lblChangeCodeRc" AssociatedControlID="txtChangeCode" />
                                                                <asp:TextBox ID="txtChangeCode"
                                                                                Width="98.5%"
                                                                                runat="server"
                                                                                ForeColor="#0094ff"
                                                                                BackColor="#FAF4AB"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtChangeCodeRc" />
                                                                <asp:RequiredFieldValidator ID="rfvChangeCode"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsAdditionGroup"
                                                                                            ControlToValidate="txtChangeCode"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtChangeCodeRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                            <!-- RequestDate -->
                                                            <div class="form-group" style="width: 85%; margin-left: 10px; float: left">
                                                                <asp:Label ID="lblRequestDate" runat="server" meta:resourcekey="lblRequestDateRc" AssociatedControlID="txtRequestDate" />
                                                                <asp:TextBox ID="txtRequestDate"
                                                                            Width="98.5%"
                                                                            runat="server"
                                                                            ForeColor="#0094FF"
                                                                            BackColor="#FCF5D8"
                                                                            CssClass="form-control"
                                                                            meta:resourcekey="txtRequestDateRc" />
                                                                <span class="input-group-btn add-on">
                                                                    <button id="btnRequestDateCal"
                                                                            runat="server"
                                                                            class="btn btn-danger"
                                                                            style="margin-left: -15px; height: 35px"
                                                                            type="button">
                                                                            <i class="fa fa-calendar"></i>
                                                                    </button>
                                                                </span>
                                                                <asp:RequiredFieldValidator ID="rfvRequestDate"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsAdditionGroup"
                                                                                            ControlToValidate="txtRequestDate"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtRequestDateRc"
                                                                                            Enabled="false" />
                                                                <ajaxToolkit:CalendarExtender
                                                                                                runat="server"
                                                                                                TargetControlID="txtRequestDate"
                                                                                                PopupButtonID="btnRequestDateCal"
                                                                                                Format="d/MM/yyyy" BehaviorID="" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
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
                                                                                            ValidationGroup="vsAdditionGroup"
                                                                                            ControlToValidate="txtManday"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtMandayRc" />
                                                                <asp:RegularExpressionValidator ID="revManday" 
                                                                                                runat="server" 
                                                                                                ControlToValidate="txtManday"
                                                                                                ValidationGroup="vsAdditionGroup"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtMandayInNumericRc"
                                                                                                ValidationExpression="[0-9]*\.?[0-9]*" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding:5px;">
                                                            <div class="form-group" style="width: 100%; margin-top: 22px; float: left"">
                                                                    <asp:LinkButton ID="btnAdd"
                                                                                    type="button"
                                                                                    class="btn btn-success"
                                                                                    runat="server"
                                                                                    OnClick="btnAdd_Click">
                                                                        <i class="fa fa-save"></i>
                                                                        <asp:Label ID="lblBtnAdd" runat="server" meta:resourcekey="lblBtnAddRc"></asp:Label>
                                                                    </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    <%--</div>--%>
                                                </asp:Panel>
                                            </section>
                                              <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b><asp:Label ID="lblDBChangeRequest" runat="server"  meta:resourcekey="lblDBChangeRequestRc" /></b>
                                                </header>
                                                <%= WebUtils.getErrorMessage(this.errorMessagesForGrid) %>
                                                <%= WebUtils.getInfoMessage(this.infoMessagesForGrid) %>
                                                <asp:panel runat="server" class="panel-body" DefaultButton="btnSearch">
                                                    <div class="col-lg-2 col-md-2 col-xs-12" id="divSelSearchCompany" runat="server" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <b><asp:Label ID="Label1" runat="server" meta:resourcekey="lblSelCompanyRc" /></b>
                                                            <asp:DropDownList CssClass="form-control"
                                                                                ID="selSearchCompany"
                                                                                OnSelectedIndexChanged="SelSearchCompany_SelectedIndexChanged"
                                                                                Style="color: #0094ff; margin-top: 5px;"
                                                                                AutoPostBack="true"
                                                                                runat="server">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-3 col-xs-12" style="padding:5px;">
                                                       <div class="form-group" style="width: 100%; float: left">
                                                            <b><asp:Label ID="lblSearchProject" runat="server"  meta:resourcekey="lblSearchProjectRc" /></b>
                                                            <asp:DropDownList CssClass="form-control"
                                                                              ID="selSearchProject"
                                                                              Style="color: #0094ff;  margin-top: 5px;"
                                                                              AutoPostBack="false"
                                                                              runat="server">
                                                            </asp:DropDownList>
                                                       </div>
                                                    </div>
                                                     <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                            <!-- SearchRequestDate -->
                                                            <div class="form-group" style="width: 85%; margin-left: 10px; float: left">
                                                                <asp:Label ID="lblSearchRequestDate" runat="server" meta:resourcekey="lblRequestDateRc" AssociatedControlID="txtSearchRequestDate" />
                                                                <asp:TextBox ID="txtSearchRequestDate"
                                                                            Width="98.5%"
                                                                            runat="server"
                                                                            ForeColor="#0094FF"
                                                                            BackColor="#FCF5D8"
                                                                            CssClass="form-control"
                                                                            meta:resourcekey="txtSearchRequestDateRc" />
                                                                <span class="input-group-btn add-on">
                                                                    <button id="btnSearchRequestDateCal"
                                                                            runat="server"
                                                                            class="btn btn-danger"
                                                                            style="margin-left: -15px; height: 35px"
                                                                            type="button">
                                                                            <i class="fa fa-calendar"></i>
                                                                    </button>
                                                                </span>
                                                                <asp:RequiredFieldValidator ID="rfvSearchRequestDate"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsEditGroup"
                                                                                            ControlToValidate="txtSearchRequestDate"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtSearchRequestDateRc"
                                                                                            Enabled="false" />
                                                                <ajaxToolkit:CalendarExtender
                                                                                                runat="server"
                                                                                                TargetControlID="txtSearchRequestDate"
                                                                                                PopupButtonID="btnSearchRequestDateCal"
                                                                                                Format="d/MM/yyyy" BehaviorID="" />
                                                            </div>
                                                        </div>
                                                    <div class="col-lg-2 col-md-3 col-xs-12" style="padding:5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <asp:Label ID="lblSearchGridText" runat="server"  meta:resourcekey="lblSearchGridTextRc" AssociatedControlID="txtSearchGridText" />
                                                            <asp:TextBox ID="txtSearchGridText"
                                                                         Width="98.5%"
                                                                         runat="server"
                                                                         ForeColor="#0094ff"
                                                                         CssClass="form-control"
                                                                         meta:resourcekey="txtSearchGridTextRc" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-xs-6" style="padding:5px;">
                                                     <!-- Row Per Page -->
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblRowPerPage" runat="server"  meta:resourcekey="lblRowPerPageRc" AssociatedControlID="txtRowPerPage" />
                                                                <asp:TextBox ID="txtRowPerPage"
                                                                             Width="98.5%"
                                                                             runat="server"
                                                                             ForeColor="#0094ff"
                                                                             BackColor="#FEF887"
                                                                             CssClass="form-control"
                                                                             meta:resourcekey="txtRowPerPageRc" />
                                                                <asp:RequiredFieldValidator ID="rfvRowPerPage" 
                                                                                            runat="server"  
                                                                                            ValidationGroup="vsSearchGroup"
                                                                                            ControlToValidate="txtRowPerPage"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtRowPerPageRc" />
                                                                <asp:RegularExpressionValidator ID="revRowPerPage" 
                                                                                            runat="server" 
                                                                                            ControlToValidate="txtRowPerPage"
                                                                                            ValidationGroup="vsSearchGroup"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtRowPerPageNumericRc"
                                                                                            ValidationExpression="[0-9]*\.?[0-9]*" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-3 col-xs-6" style="padding:5px;">
                                                        <div class="form-group" style="width: 100%; margin-left: 10px; margin-top: 22px; float: left">
                                                            <asp:LinkButton id="btnSearch" 
                                                                            type="button" 
                                                                            class="btn btn-success" 
                                                                            runat="server"
                                                                            OnClick="btnSearch_Click">
                                                                 <i class="fa fa-search"></i> <asp:Label ID="lblBtnSearch" runat="server"  meta:resourcekey="lblBtnSearchRc" ></asp:Label>
                                                             </asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </asp:panel>
                                                <div class="panel-body" style="overflow-x: auto; width: 100%">
                                                    <asp:GridView ID="changReqGridView"
                                                                  runat="server"
                                                                  AutoGenerateColumns="false"
                                                                  CssClass="table table-striped table-advance table-hover"
                                                                  Width="100%"
                                                                  GridLines="None"
                                                                  AllowPaging="true"
                                                                  ShowHeaderWhenEmpty="true"
                                                                  OnPageIndexChanging="changReqGridView_PageIndexChanging"
                                                                  OnRowEditing="changReqGridView_RowEditing"
                                                                  OnRowUpdating="changReqGridView_RowUpdating"
                                                                  OnRowCancelingEdit="changReqGridView_RowCancelingEdit"
                                                                  OnRowDataBound="changReqGridView_RowDataBound">
                                                        <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                        <Columns>
                                                            <asp:TemplateField ItemStyle-Width = "5%" HeaderText="">
                                                                    <ItemTemplate>
                                                                        <asp:Label runat="server"
                                                                                   Text='<%# Container.DataItemIndex + 1 %>' />
                                                                        <asp:Label ID="lblChangReq_Id" 
                                                                                   runat="server"
                                                                                   Visible="false" />
                                                                    </ItemTemplate>
                                                            </asp:TemplateField>
                                                             <asp:TemplateField ItemStyle-Width = "15%"  meta:resourcekey="grid_AppAssetRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblGrid_AppAsset" 
                                                                                   runat="server" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:DropDownList CssClass="form-control"
                                                                                          ID="selGrid_AppAsset"
                                                                                          Style="color: #0094ff"
                                                                                          AutoPostBack="false"
                                                                                          runat="server">
                                                                        </asp:DropDownList>
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                             <asp:TemplateField ItemStyle-Width = "15%"  meta:resourcekey="grid_ChangeTypeRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblGrid_ChangeType" 
                                                                                   runat="server" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:DropDownList CssClass="form-control"
                                                                                          ID="selGrid_ChangeType"
                                                                                          Style="color: #0094ff"
                                                                                          AutoPostBack="false"
                                                                                          runat="server">
                                                                        </asp:DropDownList>
                                                                    </EditItemTemplate>
                                                             </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="15%" meta:resourcekey="grid_ChangeCodeRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblGrid_ChangeCode" 
                                                                                   runat="server" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtGrid_ChangeCode"
                                                                                Width="98.5%"
                                                                                runat="server"
                                                                                ForeColor="#0094ff"
                                                                                BackColor="#FAF4AB"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtChangeCodeRc" />
                                                                <asp:RequiredFieldValidator ID="rfvChangeCode"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsEditGroup"
                                                                                            ControlToValidate="txtGrid_ChangeCode"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtChangeCodeRc" />
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="15%" meta:resourcekey="grid_RequestDateRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblGrid_RequestDate" 
                                                                                   runat="server" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtGrid_RequestDate"
                                                                            Width="98.5%"
                                                                            runat="server"
                                                                            ForeColor="#0094FF"
                                                                            BackColor="#FCF5D8"
                                                                            CssClass="form-control"
                                                                            meta:resourcekey="txtRequestDateRc" />
                                                                        <span class="input-group-btn add-on">
                                                                            <button id="btnRequestDateCal"
                                                                                    runat="server"
                                                                                    class="btn btn-danger"
                                                                                    style="margin-left: -15px; height: 35px"
                                                                                    type="button">
                                                                                    <i class="fa fa-calendar"></i>
                                                                            </button>
                                                                        </span>
                                                                        <asp:RequiredFieldValidator ID="rfvRequestDate"
                                                                                                    runat="server"
                                                                                                    ValidationGroup="vsEditGroup"
                                                                                                    ControlToValidate="txtGrid_RequestDate"
                                                                                                    ForeColor="Red"
                                                                                                    Display="Dynamic"
                                                                                                    meta:resourcekey="txtRequestDateRc"
                                                                                                    Enabled="false" />
                                                                        <ajaxToolkit:CalendarExtender
                                                                                                        runat="server"
                                                                                                        TargetControlID="txtGrid_RequestDate"
                                                                                                        PopupButtonID="btnRequestDateCal"
                                                                                                        Format="d/MM/yyyy" BehaviorID="" />
                                                                    </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="grid_mandaysRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid__mandays"
                                                                                runat="server" />
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="txtGrid_mandays"
                                                                                runat="server"
                                                                                Width="98.5%"
                                                                                ForeColor="#0094ff"
                                                                                BackColor="#FEF887"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtGrid_mandaysRc" />
                                                                    <asp:RequiredFieldValidator ID="rfvGrid_mandays"
                                                                                                runat="server"
                                                                                                ValidationGroup="vsEditGroup"
                                                                                                ControlToValidate="txtGrid_mandays"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtGrid_mandaysRc" />
                                                                    <asp:RegularExpressionValidator ID="revGrid_mandays" 
                                                                                                runat="server" 
                                                                                                ControlToValidate="txtGrid_mandays"
                                                                                                ValidationGroup="vsEditGroup"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtGrid_mandaysInNumericRc"
                                                                                                ValidationExpression="[0-9]*\.?[0-9]*" />
                                                                </EditItemTemplate>
                                                            </asp:TemplateField>
                                                             <asp:TemplateField ItemStyle-Width = "7%"  meta:resourcekey="grid_LastUpdateRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblGrid_LastUpdate" 
                                                                                   runat="server" />
                                                                    </ItemTemplate>
                                                             </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="12%" meta:resourcekey="grid_ChangeTrxRc">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="btnChangeTrx"
                                                                        runat="server"
                                                                        CssClass="btn btn-info btn-xs"
                                                                        CommandArgument='<%# Eval("id") %>'
                                                                        OnCommand="btnChangeTrx_Command">
                                                                            <asp:PlaceHolder runat="server">
                                                                                <i class="fa fa-external-link"></i>
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
