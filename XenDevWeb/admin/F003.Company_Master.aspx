<%@ Page Language="C#" 
         AutoEventWireup="true" 
         CodeBehind="F003.Company_Master.aspx.cs" 
         Inherits="XenDevWeb.admin.F003_Company_Master" 
         meta:resourcekey="PageResource1" 
         MaintainScrollPositionOnPostback="true"
         MasterPageFile="~/include/master.Master"  %>

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
                                <strong><asp:Label ID="lblNewUser" runat="server" meta:resourcekey="lblCompanyMasterRc" /></strong>
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

                                    <section class="panel" style="border: solid 1px #d0efde">
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>
                                                <%= WebUtils.getErrorMessage(this.errorMessages) %>
                                                <%= WebUtils.getInfoMessage(this.infoMessages) %>
                                                <header class="panel-heading">
                                                    <b><asp:Label ID="lblAddCompanyHeader" runat="server" meta:resourcekey="lblCompanyInfoRc" /></b>
                                                </header>
                                                <asp:panel runat="server" class="panel-body" style="padding-bottom: 0px"  DefaultButton="btnAddCompany">
                                                    <div class="col-lg-2 col-md-3 col-xs-6" style="padding:5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <asp:Label ID="lblCompanyCode" runat="server"  meta:resourcekey="lblCompanyCodeRc" AssociatedControlID="txtCompanyCode" />
                                                            <asp:TextBox ID="txtCompanyCode"
                                                                         Width="98.5%"
                                                                         runat="server"
                                                                         ForeColor="#0094ff"
                                                                         BackColor="#FAF4AB"
                                                                         CssClass="form-control"
                                                                         meta:resourcekey="txtCompanyCodeRc" />
                                                            <asp:RequiredFieldValidator ID="rfvCompanyCode" 
                                                                                        runat="server"  
                                                                                        ValidationGroup="vsCompanyAdditionGroup"
                                                                                        ControlToValidate="txtCompanyCode"
                                                                                        ForeColor="Red"
                                                                                        Display="Dynamic"
                                                                                        meta:resourcekey="txtCompanyCodeRc" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-3 col-xs-6" style="padding:5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <asp:Label ID="lblTitle" runat="server" meta:resourcekey="lblTitleRc" AssociatedControlID="selTitle" />
                                                            <asp:DropDownList CssClass="form-control"
                                                                            ID="selTitle"
                                                                            Style="color: #0094ff"
                                                                            AutoPostBack="false"
                                                                            runat="server">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-3 col-xs-12" style="padding:5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblCompanyName" runat="server"  meta:resourcekey="lblCompanyNameRc" AssociatedControlID="txtCompanyName" />
                                                                <asp:TextBox ID="txtCompanyName"
                                                                             Width="98.5%"
                                                                             runat="server"
                                                                             ForeColor="#0094ff"
                                                                             BackColor="#FAF4AB"
                                                                             CssClass="form-control"
                                                                             meta:resourcekey="txtCompanyNameRc" />
                                                                <asp:RequiredFieldValidator ID="rfvCompanyName" 
                                                                                            runat="server"  
                                                                                            ValidationGroup="vsCompanyAdditionGroup"
                                                                                            ControlToValidate="txtCompanyName"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtCompanyNameRc" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-3 col-xs-12" style="padding:5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblCompanyNameEng" runat="server"  meta:resourcekey="lblCompanyNameEngRc" AssociatedControlID="txtCompanyNameEng" />
                                                                <asp:TextBox ID="txtCompanyNameEng"
                                                                             Width="98.5%"
                                                                             runat="server"
                                                                             ForeColor="#0094ff"
                                                                             BackColor="#FAF4AB"
                                                                             CssClass="form-control"
                                                                             meta:resourcekey="txtCompanyNameRc" />
                                                                <asp:RequiredFieldValidator ID="rfvtxtCompanyNameEng" 
                                                                                            runat="server"  
                                                                                            ValidationGroup="vsCompanyAdditionGroup"
                                                                                            ControlToValidate="txtCompanyNameEng"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtCompanyNameEngRc" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-3 col-xs-12" style="padding:5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblTaxId" runat="server"  meta:resourcekey="lblTaxIdRc" AssociatedControlID="txtTaxId" />
                                                                <asp:TextBox ID="txtTaxId"
                                                                             Width="98.5%"
                                                                             runat="server"
                                                                             ForeColor="#0094ff"
                                                                             BackColor="#FAF4AB"
                                                                             CssClass="form-control"
                                                                             meta:resourcekey="txtTaxIdRc" />
                                                                <asp:RequiredFieldValidator ID="rfvTaxId" 
                                                                                            runat="server"  
                                                                                            ValidationGroup="vsCompanyAdditionGroup"
                                                                                            ControlToValidate="txtTaxId"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtTaxIdRc" />
                                                        </div>
                                                    </div>
                                                    <%--<div class="col-lg-2 col-xs-6" style="padding:5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblBranchCode" runat="server"  meta:resourcekey="lblBranchCodeRc" AssociatedControlID="txtBranchCode" />
                                                                <asp:TextBox ID="txtBranchCode"
                                                                             Width="98.5%"
                                                                             runat="server"
                                                                             ForeColor="#0094ff"
                                                                             CssClass="form-control"
                                                                             meta:resourcekey="txtBranchCodeRc"
                                                                             ReadOnly="true" />
                                                                <asp:RequiredFieldValidator ID="rfvBranchCode" 
                                                                                            runat="server"  
                                                                                            ValidationGroup="vsCompanyAdditionGroup"
                                                                                            ControlToValidate="txtBranchCode"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtBranchCodeRc" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-3 col-xs-6" style="padding:5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblBranchName" runat="server"  meta:resourcekey="lblBranchNameRc" AssociatedControlID="txtBranchName" />
                                                                <asp:TextBox ID="txtBranchName"
                                                                             Width="98.5%"
                                                                             runat="server"
                                                                             ForeColor="#0094ff"
                                                                             CssClass="form-control"
                                                                             meta:resourcekey="txtBranchNameRc"
                                                                             ReadOnly="true" />
                                                                <asp:RequiredFieldValidator ID="rfvBranchName" 
                                                                                            runat="server"  
                                                                                            ValidationGroup="vsCompanyAdditionGroup"
                                                                                            ControlToValidate="txtBranchName"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtBranchNameRc" />
                                                        </div>
                                                    </div>--%>
                                                    <div class="col-lg-1 col-md-3 col-xs-6" style="padding:5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <asp:Label ID="lblEnable" runat="server" meta:resourcekey="lblEnableRc" AssociatedControlID="chkEnable" />
                                                            <div class="checkbox" style="margin: 0">
                                                                <asp:CheckBox ID="chkEnable" runat="server" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-1 col-md-2 col-xs-6" style="padding: 5px;">
                                                        <div class="form-group" style="margin-right: 0.5%; margin-left: 10px; float: left; margin-top: 23px">
                                                            <asp:LinkButton ID="btnAddCompany"
                                                                            type="button"
                                                                            class="btn btn-success"
                                                                            runat="server"
                                                                            OnClick="btnAddCompany_Click">
                                                                <i class="fa fa-save"></i>
                                                                <asp:Label ID="lblBtnAdd" runat="server" meta:resourcekey="lblBtnAddRc"></asp:Label>
                                                            </asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </asp:panel>
                                            </ContentTemplate>
                                           <Triggers>
                                            
                                           </Triggers>
                                        </asp:UpdatePanel>
                                    </section>

                                    <section class="panel" style="border: solid 1px #d0efde">
                                        <header class="panel-heading">
                                            <b><asp:Label ID="lblDBComs" runat="server"  meta:resourcekey="lblComsInDbRc" /></b>
                                        </header>
                                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                            <ContentTemplate>
                                                <%= WebUtils.getErrorMessage(this.errorMessagesForGrid) %>
                                                <%= WebUtils.getInfoMessage(this.infoMessagesForGrid) %>
                                                <asp:panel runat="server" class="panel-body" style="padding-bottom: 0px" DefaultButton="btnSearch">
                                                    <div class="col-lg-2 col-md-3 col-xs-12" style="padding:5px;">
                                                       <div class="form-group" style="width: 100%; float: left">
                                                            <b><asp:Label ID="lblSearchGridBy" runat="server"  meta:resourcekey="lblSearchGridByRc" /></b>
                                                            <asp:DropDownList CssClass="form-control"
                                                                              ID="selGridSearchType"
                                                                              Style="color: #0094ff;  margin-top: 5px;"
                                                                              AutoPostBack="false"
                                                                              runat="server">
                                                            </asp:DropDownList>
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
                                                        <div class="form-group" style="width: 15%; margin-top: 22px; float: left">
                                                            <asp:LinkButton id="btnSearch" 
                                                                            type="button" 
                                                                            class="btn btn-success" 
                                                                            runat="server"
                                                                            OnClick="btnSearch_Click">
                                                                 <i class="fa fa-search"></i> <asp:Label ID="lblBtnCompanyFilter" runat="server"  meta:resourcekey="lblBtnCompanyFilterRc" ></asp:Label>
                                                             </asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </asp:panel>
                                                <div class="panel-body">
                                                    <div class="panel-body" style="overflow-x: auto; width: 100%">
                                                        <asp:GridView ID="companyGridView"
                                                                      runat="server"
                                                                      AutoGenerateColumns="false"
                                                                      CssClass="table table-advance table-hover"
                                                                      Width="100%"
                                                                      GridLines="None"
                                                                      AllowPaging="true"
                                                                      OnPageIndexChanging="companyGridView_PageIndexChanging"
                                                                      OnRowEditing="companyGridView_RowEditing"
                                                                      OnRowUpdating="companyGridView_RowUpdating"
                                                                      OnRowCancelingEdit="companyGridView_RowCancelingEdit"
                                                                      OnRowDataBound="companyGridView_RowDataBound"
                                                                      ShowHeaderWhenEmpty="true"
                                                                      PageSize="30">
                                                            <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                            <Columns>
                                                                <asp:TemplateField ItemStyle-Width="3%" HeaderText="">
                                                                    <ItemTemplate>
                                                                        <asp:Label runat="server"
                                                                                   Text='<%# Container.DataItemIndex + 1 %>' />
                                                                        <asp:Label ID="lblCompanyGrid_Id"
                                                                                   runat="server"
                                                                                   Visible="false"
                                                                                   Text='<%# Eval("id")%>' />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="companyGridView_CompCodeRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblCompanyGridView_CompCode"
                                                                                   runat="server" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtCompanyGridView_CompCode"
                                                                                     runat="server"
                                                                                     Width="98.5%"
                                                                                     CssClass="form-control"
                                                                                     ForeColor="#0094ff"
                                                                                     BackColor="#FAF4AB" />
                                                                        <asp:RequiredFieldValidator ID="rfvCompanyGridCode"
                                                                                                    runat="server"
                                                                                                    ValidationGroup="vsCompanyEditGroup"
                                                                                                    ControlToValidate="txtCompanyGridView_CompCode"
                                                                                                    ForeColor="Red"
                                                                                                    Display="Dynamic"
                                                                                                    meta:resourcekey="txtCompanyCodeRc" />
                                                                    </EditItemTemplate>
                                                                </asp:TemplateField>
                                                                 <asp:TemplateField ItemStyle-Width="20%" meta:resourcekey="companyGridView_CompTitleRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblCompanyGridView_CompTitle"
                                                                                   runat="server" />
                                                                    </ItemTemplate>
                                                                     <EditItemTemplate>
                                                                         <asp:DropDownList CssClass="form-control"
                                                                                           ID="selGrid_Title"
                                                                                           Style="color: #0094ff"
                                                                                           AutoPostBack="false"
                                                                                           runat="server">
                                                                         </asp:DropDownList>
                                                                     </EditItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField ItemStyle-Width="20%" meta:resourcekey="companyGridView_CompNameRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblCompanyGridView_CompName"
                                                                                   runat="server" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtCompanyGridView_CompName"
                                                                                     runat="server"
                                                                                     Width="98.5%"
                                                                                     CssClass="form-control"
                                                                                     meta:resourcekey="txtCompanyNameRc" 
                                                                                     ForeColor="#0094ff"
                                                                                     BackColor="#FAF4AB"/>
                                                                        <asp:RequiredFieldValidator ID="rfvCompanyGridName"
                                                                                                    runat="server"
                                                                                                    ValidationGroup="vsCompanyEditGroup"
                                                                                                    ControlToValidate="txtCompanyGridView_CompName"
                                                                                                    ForeColor="Red"
                                                                                                    Display="Dynamic"
                                                                                                    meta:resourcekey="txtCompanyNameRc" />
                                                                    </EditItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField ItemStyle-Width="20%" meta:resourcekey="companyGridView_CompNameEngRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblCompanyGridView_CompNameEng"
                                                                                   runat="server" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtCompanyGridView_CompNameEng"
                                                                                     runat="server"
                                                                                     Width="98.5%"
                                                                                     CssClass="form-control"
                                                                                     meta:resourcekey="txtCompanyNameEngRc" 
                                                                                     ForeColor="#0094ff"
                                                                                     BackColor="#FAF4AB"/>
                                                                        <asp:RequiredFieldValidator ID="rfvtxtCompanyGridView_CompNameEng"
                                                                                                    runat="server"
                                                                                                    ValidationGroup="vsCompanyEditGroup"
                                                                                                    ControlToValidate="txtCompanyGridView_CompNameEng"
                                                                                                    ForeColor="Red"
                                                                                                    Display="Dynamic"
                                                                                                    meta:resourcekey="txtCompanyNameEngRc" />
                                                                    </EditItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField ItemStyle-Width="15%" meta:resourcekey="companyGridView_TaxIdRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblCompanyGridView_TaxId"
                                                                                   runat="server" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtCompanyGridView_TaxId"
                                                                                     runat="server"
                                                                                     Width="98.5%" 
                                                                                     CssClass="form-control"
                                                                                     meta:resourcekey="txtTaxIdRc"
                                                                                     ForeColor="#0094ff"
                                                                                     BackColor="#FAF4AB"/>
                                                                        <asp:RequiredFieldValidator ID="rfvCompanyGridTaxId"
                                                                                                    runat="server"
                                                                                                    ValidationGroup="vsCompanyEditGroup"
                                                                                                    ControlToValidate="txtCompanyGridView_TaxId"
                                                                                                    ForeColor="Red"
                                                                                                    Display="Dynamic"
                                                                                                    meta:resourcekey="txtTaxIdRc" />
                                                                    </EditItemTemplate>
                                                                </asp:TemplateField>
                                                                <%--<asp:TemplateField ItemStyle-Width="20%" meta:resourcekey="companyGridView_EditBranchRc">
                                                                    <ItemTemplate>
                                                                        <asp:DropDownList CssClass="form-control"
                                                                                            ID="selCompanyGridView_Branches"
                                                                                            Style="color: #0094ff"
                                                                                            AutoPostBack="true"
                                                                                            OnSelectedIndexChanged="selCompanyGridView_Branches_SelectedIndexChanged"
                                                                                            runat="server">
                                                                        </asp:DropDownList>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>--%>
                                                                <asp:TemplateField ItemStyle-Width="5%" meta:resourcekey="companyGridView_ChkIsEnabledRc">
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkCompanyGrid_IsEnabled"
                                                                                      runat="server"
                                                                                      Enabled="false" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <div class="checkbox" style="margin: 0">
                                                                            <asp:CheckBox ID="chkCompanyGrid_IsEnabled" 
                                                                                          runat="server" />
                                                                        </div>
                                                                    </EditItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="companyGridView_LastUpdateRc">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblCompanyGridView_LastUpdate"
                                                                                   runat="server" />
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
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </section>
                                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                        <ContentTemplate>
                                            <asp:HiddenField ID="hndBranchIdToUpdate" runat="server" />
                                            <asp:HiddenField ID="hndCompanyIdToAddBranch" runat="server" />
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
