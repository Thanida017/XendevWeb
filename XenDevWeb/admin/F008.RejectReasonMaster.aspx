<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="F008.RejectReasonMaster.aspx.cs" 
    Inherits="XenDevWeb.admin.F008_RejectReasonMaster"
    MaintainScrollPositionOnPostback="true"
    MasterPageFile="~/include/master.Master" 
    meta:resourcekey="PageResource1"
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
                                <strong><asp:Label ID="lblRejectReason" runat="server" meta:resourcekey="lblRejectReasonRc" /></strong>
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
                                             <%= WebUtils.getErrorMessage(this.errorMessages) %>
                                            <%= WebUtils.getInfoMessage(this.infoMessages) %>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b><asp:Label ID="lblAddRejectReason" runat="server" meta:resourcekey="lblAddRejectReasonRc" /></b>
                                                </header>
                                                <asp:panel runat="server" class="panel-body" DefaultButton="btnAddReason">
                                                    <div class="row">
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblCode" runat="server"  meta:resourcekey="lblCodeRc" AssociatedControlID="txtCode" />
                                                                <asp:TextBox ID="txtCode"
                                                                             Width="98.5%"
			                                                                 runat="server"
			                                                                 ForeColor="#0094ff"
                                                                             BackColor="#FAF4AB"
			                                                                 CssClass="form-control"
                                                                             meta:resourcekey="txtCodeRc" />
                                                                <asp:RequiredFieldValidator ID="rfvCode"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsAddGroup"
                                                                                            ControlToValidate="txtCode"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtCodeRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblName" runat="server"  meta:resourcekey="lblNameRc" AssociatedControlID="txtName" />
                                                                <asp:TextBox ID="txtName"
                                                                             Width="98.5%"
			                                                                 runat="server"
			                                                                 ForeColor="#0094ff"
                                                                             BackColor="#FAF4AB"
			                                                                 CssClass="form-control"
                                                                             meta:resourcekey="txtNameRc" />
                                                                <asp:RequiredFieldValidator ID="rfvName"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsAddGroup"
                                                                                            ControlToValidate="txtName"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtNameRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-2 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; margin-top: 22px; float: left">
                                                                <asp:LinkButton ID="btnAddReason"
                                                                    type="button"
                                                                    class="btn btn-success"
                                                                    runat="server"
                                                                    OnClick="btnAddReason_Click">
                                                                    <i class="fa fa-save"></i>
                                                                    <asp:Label ID="lblBtnAddReason" runat="server" meta:resourcekey="lblBtnAddReasonRc"></asp:Label>
                                                                </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </section>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b><asp:Label ID="lblDBRejectReason" runat="server"  meta:resourcekey="lblDBRejectReasonRc" /></b>
                                                </header>
                                                <%= WebUtils.getErrorMessage(this.errorMessagesForGrid) %>
                                                <%= WebUtils.getInfoMessage(this.infoMessagesForGrid) %>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="btnSearch">
                                                    <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <asp:Label ID="lblSearchBy" runat="server" meta:resourcekey="lblSearchByRc" AssociatedControlID="selSearchBy" />
                                                            <asp:DropDownList CssClass="form-control"
                                                                              ID="selSearchBy"
                                                                              Style="color: #0094ff"
                                                                              AutoPostBack="false"
                                                                              runat="server">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-4 col-xs-12" style="padding:5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <asp:Label ID="lblSearchText" runat="server"  meta:resourcekey="lblSearchTextRc" AssociatedControlID="txtSearchText" />
                                                            <asp:TextBox ID="txtSearchText"
                                                                         Width="98.5%"
                                                                         runat="server"
                                                                         ForeColor="#0094ff"
                                                                         CssClass="form-control"
                                                                         meta:resourcekey="txtSearchGridTextRc" />
                                                            <asp:RequiredFieldValidator ID="rfvSearchText"
                                                                                        runat="server"
                                                                                        ValidationGroup="vsSearchGroup"
                                                                                        ControlToValidate="txtSearchText"
                                                                                        ForeColor="Red"
                                                                                        Display="Dynamic"
                                                                                        meta:resourcekey="txtSearchTextRc"
                                                                                        Enabled="false" />
                                                        </div>
                                                    </div>
                                                    <div class ="col-lg-2 col-md-2 col-xs-6" style="padding:5px;">
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
                                                    <div class="col-lg-2 col-md-2 col-xs-6" style="padding:5px;">
                                                        <div class="form-group" style="width: 15%; margin-left: 10px; margin-top: 22px; float: left">
                                                            <asp:LinkButton id="btnSearch" 
                                                                            type="button" 
                                                                            class="btn btn-success" 
                                                                            runat="server"
                                                                            OnClick="btnSearch_Click">
                                                                 <i class="fa fa-search"></i> <asp:Label ID="lblBtnSearch" runat="server"  meta:resourcekey="lblBtnGridSearchRc" ></asp:Label>
                                                             </asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </asp:panel>
                                                <div class="panel-body" style="overflow-x: auto; width: 100%">
                                                    <asp:GridView ID="rejectReasonDataGridView"
                                                                  runat="server"
                                                                  AutoGenerateColumns="false"
                                                                  CssClass="table table-striped table-advance table-hover"
                                                                  Width="100%"
                                                                  GridLines="None"
                                                                  AllowPaging="true"
                                                                  ShowHeaderWhenEmpty="true"
                                                                  OnPageIndexChanging="rejectReasonDataGridView_PageIndexChanging"
                                                                  OnRowEditing="rejectReasonDataGridView_RowEditing"
                                                                  OnRowUpdating="rejectReasonDataGridView_RowUpdating"
                                                                  OnRowCancelingEdit="rejectReasonDataGridView_RowCancelingEdit"
                                                                  OnRowDataBound="rejectReasonDataGridView_RowDataBound"
                                                                  PageSize="30">
                                                    <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                        <Columns>
                                                            <asp:TemplateField ItemStyle-Width="3%" HeaderText="">
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server"
                                                                        Text='<%# Container.DataItemIndex + 1 %>' />
                                                                    <asp:Label ID="lblRejectGrid_Id"
                                                                        runat="server"
                                                                        Visible="false" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                              <asp:TemplateField ItemStyle-Width="25%" meta:resourcekey="gridView_CodeRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_Code"
                                                                                runat="server" />
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="txtGrid_Code"
                                                                                    runat="server"
                                                                                    Width="98.5%"
                                                                                    ForeColor="#0094ff"
                                                                                    BackColor="#FEF887"
                                                                                    CssClass="form-control"
                                                                                    meta:resourcekey="txtCodeRc" />
                                                                    <asp:RequiredFieldValidator ID="rfvGridView_Code"
                                                                                                runat="server"
                                                                                                ValidationGroup="vsEditGrid"
                                                                                                ControlToValidate="txtGrid_Code"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtCodeRc" />
                                                                </EditItemTemplate>
                                                            </asp:TemplateField>
                                                              <asp:TemplateField ItemStyle-Width="25%" meta:resourcekey="gridView_NameRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_Name"
                                                                                runat="server" />
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="txtGrid_Name"
                                                                                    runat="server"
                                                                                    Width="98.5%"
                                                                                    CssClass="form-control"
                                                                                    ForeColor="#0094ff"
                                                                                    BackColor="#FEF887"
                                                                                    meta:resourcekey="txtNameRc" />
                                                                    <asp:RequiredFieldValidator ID="rfvGridView_Name"
                                                                                                runat="server"
                                                                                                ValidationGroup="vsEditGrid"
                                                                                                ControlToValidate="txtGrid_Name"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtNameRc" />
                                                                </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="15%" meta:resourcekey="grid_CreationDateRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_CreationDate"
                                                                        runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="15%" meta:resourcekey="grid_LastUpdateRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_LastUpdate"
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
</asp:Content>
