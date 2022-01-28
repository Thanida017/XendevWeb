<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="F029.ProjectMandays.aspx.cs" 
    Inherits="XenDevWeb.admin.F029_ProjectMandays" 
    MaintainScrollPositionOnPostback="true"
    MasterPageFile="~/include/master.Master" 
    meta:resourcekey="PageResource1"%>

<%@ Import Namespace="XenDevWeb.Utils" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentMainPlaceHolder" runat="Server">
    <head runat="server">
    </head>
    <section id="main-content">
        <section class="wrapper">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-xs-12">
                    <section class="panel">
                        <header class="panel-heading tab-bg-dark-navy-blue tab-right ">
                            <span class="hidden-sm wht-color">
                                <strong><asp:Label ID="lblProjectName" runat="server" meta:resourcekey="lblProjectNameRc" /></strong>
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
                                                    <b><asp:Label ID="lblAddNewMandays" runat="server" meta:resourcekey="lblAddNewMandaysRc" /></b>
                                                </header>
                                                <asp:panel runat="server" class="panel-body" DefaultButton="btnAdd">
                                                    <div class="row">
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblPONumber" runat="server" meta:resourcekey="lblPONumberRc" AssociatedControlID="txtPONumber" />
                                                                <asp:TextBox ID="txtPONumber"
                                                                    Width="98.5%"
                                                                    runat="server"
                                                                    ForeColor="#0094ff"
                                                                    BackColor="#FAF4AB"
                                                                    CssClass="form-control"
                                                                    meta:resourcekey="txtPONumberRc" />
                                                                <asp:RequiredFieldValidator ID="rfvPONumber"
                                                                    runat="server"
                                                                    ValidationGroup="vsAddMandaysGroup"
                                                                    ControlToValidate="txtPONumber"
                                                                    ForeColor="Red"
                                                                    Display="Dynamic"
                                                                    meta:resourcekey="txtPONumberRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblMandays" runat="server" meta:resourcekey="lblMandaysRc" AssociatedControlID="txtMandays" />
                                                                <asp:TextBox ID="txtMandays"
                                                                    Width="98.5%"
                                                                    runat="server"
                                                                    ForeColor="#0094ff"
                                                                    BackColor="#FAF4AB"
                                                                    CssClass="form-control"
                                                                    meta:resourcekey="txtMandaysRc" />
                                                                <asp:RequiredFieldValidator ID="rfvMandays"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsAddMandaysGroup"
                                                                                            ControlToValidate="txtMandays"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtMandaysRc" />
                                                                <asp:RegularExpressionValidator ID="revMandays" 
                                                                                                runat="server" 
                                                                                                ControlToValidate="txtMandays"
                                                                                                ValidationGroup="vsAddMandaysGroup"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtMandaysInNumericRc"
                                                                                                ValidationExpression="[0-9]*\.?[0-9]*" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-1 col-md-1 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; margin-top: 22px; float: left">
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
                                                    </div>
                                                </asp:panel>
                                            </section>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b><asp:Label ID="lblMandaysInDB" runat="server"  meta:resourcekey="lblMandaysInDBRc" /></b>
                                                </header>
                                                <%= WebUtils.getErrorMessage(this.errorMessagesForGrid) %>
                                                <%= WebUtils.getInfoMessage(this.infoMessagesForGrid) %>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="btnSearch">
                                                    <div class="col-lg-2 col-md-4 col-xs-12" style="padding:5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <asp:Label ID="lblSearchText" runat="server"  meta:resourcekey="lblSearchTextRc" AssociatedControlID="txtSearchText" />
                                                            <asp:TextBox ID="txtSearchText"
                                                                         Width="98.5%"
                                                                         runat="server"
                                                                         ForeColor="#0094ff"
                                                                         CssClass="form-control"
                                                                         meta:resourcekey="txtSearchGridTextRc" />
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
                                                                 <i class="fa fa-search"></i> <asp:Label ID="lblBtnSearch" runat="server"  meta:resourcekey="lblBtnSearchRc" ></asp:Label>
                                                             </asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </asp:panel>
                                                <div class="panel-body" style="overflow-x: auto; width: 100%">
                                                    <asp:GridView ID="mandaysDataGridView"
                                                              runat="server"
                                                              AutoGenerateColumns="false"
                                                              CssClass="table table-striped table-advance table-hover"
                                                              Width="100%"
                                                              GridLines="None"
                                                              AllowPaging="true"
                                                              ShowHeaderWhenEmpty="true"
                                                              OnPageIndexChanging="mandaysDataGridView_PageIndexChanging"
                                                              OnRowEditing="mandaysDataGridView_RowEditing"
                                                              OnRowUpdating="mandaysDataGridView_RowUpdating"
                                                              OnRowCancelingEdit="mandaysDataGridView_RowCancelingEdit"
                                                              OnRowDataBound="mandaysDataGridView_RowDataBound"
                                                              PageSize="15">
                                                        <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                        <Columns>
                                                            <asp:TemplateField ItemStyle-Width="5%" HeaderText="">
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server"
                                                                                Text='<%# Container.DataItemIndex + 1 %>' />
                                                                    <asp:Label ID="lblprojectMandaysGrid_Id"
                                                                                runat="server"
                                                                                Visible="false"
                                                                                Text='<%# Eval("id")%>' />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="20%" meta:resourcekey="mandaysDataGridView_PONumberRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblMandaysGridView_PoNumber"
                                                                                runat="server" />
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="txtMandaysGridView_PoNumber"
                                                                                runat="server"
                                                                                Width="98.5%"
                                                                                ForeColor="#0094ff"
                                                                                BackColor="#FEF887"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtMandaysGridView_PoNumberRc" />
                                                                    <asp:RequiredFieldValidator ID="rfvMandaysGridView_PoNumber"
                                                                                                runat="server"
                                                                                                ValidationGroup="vsMandaysEditGrid"
                                                                                                ControlToValidate="txtMandaysGridView_PoNumber"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtMandaysGridView_PoNumberRc" />
                                                                </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="20%" meta:resourcekey="mandaysDataGridView_mandaysRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblMandaysGridView_mandays"
                                                                                runat="server" />
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="txtMandaysGridView_mandays"
                                                                                runat="server"
                                                                                Width="98.5%"
                                                                                ForeColor="#0094ff"
                                                                                BackColor="#FEF887"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtMandaysGridView_mandaysRc" />
                                                                    <asp:RequiredFieldValidator ID="rfvMandaysGridView_mandays"
                                                                                                runat="server"
                                                                                                ValidationGroup="vsMandaysEditGrid"
                                                                                                ControlToValidate="txtMandaysGridView_mandays"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtMandaysGridView_mandaysRc" />
                                                                    <asp:RegularExpressionValidator ID="revMandaysGridView_mandays" 
                                                                                                runat="server" 
                                                                                                ControlToValidate="txtMandaysGridView_mandays"
                                                                                                ValidationGroup="vsMandaysEditGrid"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtMandaysGridView_mandaysInNumericRc"
                                                                                                ValidationExpression="[0-9]*\.?[0-9]*" />
                                                                </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="18%" meta:resourcekey="mandaysDataGridView_CreationDateRc">
	                                                            <ItemTemplate>
		                                                            <asp:Label ID="lblMandaysDataGridView_CreationDate"
			                                                            runat="server"/>
	                                                            </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="18%" meta:resourcekey="mandaysDataGridView_LastUpdateRc">
	                                                            <ItemTemplate>
		                                                            <asp:Label ID="lblMandaysDataGridView_LastUpdate"
			                                                            runat="server"/>
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
                                                            <asp:TemplateField ItemStyle-Width="5%" HeaderText="">
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
                                            <asp:HiddenField ID="hndProjectId" runat="server" />
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