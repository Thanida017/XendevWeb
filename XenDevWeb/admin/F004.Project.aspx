<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="F004.Project.aspx.cs" 
    Inherits="XenDevWeb.admin.F004_Project" 
    MaintainScrollPositionOnPostback="true"
    MasterPageFile="~/include/master.Master" 
    meta:resourcekey="PageResource1"%>

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
                                <strong><asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProjectRc" /></strong>
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
                                                    <b><asp:Label ID="lblAddNewProject" runat="server" meta:resourcekey="lblAddNewProjectRc" /></b>
                                                </header>
                                                <asp:panel runat="server" class="panel-body" DefaultButton="btnAddProject">
                                                    <div class="row">
                                                      <div class="col-lg-2 col-md-3 col-xs-6" style="padding:5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblCompany" runat="server" meta:resourcekey="lblCompanyRc" AssociatedControlID="selCompany" />
                                                                <asp:DropDownList CssClass="form-control"
                                                                                ID="selCompany"
                                                                                Style="color: #0094ff"
                                                                                AutoPostBack="false"
                                                                                runat="server">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                         <div class="col-lg-2 col-md-3 col-xs-6" style="padding:5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblApprovalType" runat="server" meta:resourcekey="lblApprovalTypeRc" AssociatedControlID="selApprovalType" />
                                                                <asp:DropDownList CssClass="form-control"
                                                                                ID="selApprovalType"
                                                                                Style="color: #0094ff"
                                                                                AutoPostBack="false"
                                                                                runat="server">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-1 col-md-2 col-xs-12" style="padding:5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                    <asp:Label ID="lblProjectCode" runat="server"  meta:resourcekey="lblProjectCodeRc" AssociatedControlID="txtProjectCode" />
                                                                    <asp:TextBox ID="txtProjectCode"
                                                                                 Width="98.5%"
			                                                                     runat="server"
			                                                                     ForeColor="#0094ff"
                                                                                 BackColor="#FAF4AB"
			                                                                     CssClass="form-control"
                                                                                 meta:resourcekey="txtProjectCodeRc" />
                                                                    <asp:RequiredFieldValidator ID="rfvCustomerCode" 
                                                                                                runat="server"  
                                                                                                ValidationGroup="vsAddProjectGroup"
                                                                                                ControlToValidate="txtProjectCode"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtProjectCodeRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-4 col-xs-12" style="padding:5px;">
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
			                                                                                ValidationGroup="vsAddProjectGroup"
			                                                                                ControlToValidate="txtProjectName"
			                                                                                ForeColor="Red"
			                                                                                Display="Dynamic"
			                                                                                meta:resourcekey="txtProjectNameRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-3 col-md-3 col-xs-12" style="padding:5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
	                                                            <asp:Label ID="lblDecription" runat="server" meta:resourcekey="lblDescriptionRc" AssociatedControlID="txtDescription" />
	                                                            <asp:TextBox ID="txtDescription"
			                                                                 Width="98.5%"
			                                                                 runat="server"
			                                                                 ForeColor="#0094ff"
			                                                                 CssClass="form-control"
			                                                                 meta:resourcekey="txtDescriptionRc" />
                                                            </div>
                                                        </div>
                                                         <div class="col-lg-1 col-md-1 col-xs-12" style="padding:5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
	                                                            <asp:Label ID="lblProjectColor" runat="server" meta:resourcekey="lblProjectColorRc" AssociatedControlID="txtProjectColor" />
	                                                            <asp:TextBox ID="txtProjectColor"
			                                                                 Width="98.5%"
                                                                             TextMode="Color"
			                                                                 runat="server"
			                                                                 ForeColor="#0094ff"
			                                                                 CssClass="form-control"
			                                                                 meta:resourcekey="txtProjectColorRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-1 col-md-1 col-xs-12" style="padding:5px;">
                                                            <div class="form-group" style="width: 100%; margin-top: 22px; float: left">
                                                                <asp:LinkButton id="btnAddProject" 
                                                                                type="button" 
                                                                                class="btn btn-success" 
                                                                                runat="server"
                                                                                OnClick="btnAddProject_Click">
                                                                     <i class="fa fa-save"></i> <asp:Label ID="lblBtnProjectAdd" runat="server"  meta:resourcekey="lblBtnProjectAddRc" ></asp:Label>
                                                                 </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    
                                                </asp:panel>
                                            </section>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b><asp:Label ID="lblDBProject" runat="server"  meta:resourcekey="lblDBProjectRc" /></b>
                                                </header>
                                                <%= WebUtils.getErrorMessage(this.errorMessagesForGrid) %>
                                                <%= WebUtils.getInfoMessage(this.infoMessagesForGrid) %>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="btnSearch">
                                                    <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <asp:Label ID="lblSearchCompany" runat="server" meta:resourcekey="lblCompanyRc" AssociatedControlID="selSearchCompany" />
                                                            <asp:DropDownList CssClass="form-control"
                                                                                ID="selSearchCompany"
                                                                                Style="color: #0094ff"
                                                                                AutoPostBack="false"
                                                                                runat="server">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
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
                                                    <asp:GridView ID="projectDataGridView"
                                                              runat="server"
                                                              AutoGenerateColumns="false"
                                                              CssClass="table table-striped table-advance table-hover"
                                                              Width="100%"
                                                              GridLines="None"
                                                              AllowPaging="true"
                                                              ShowHeaderWhenEmpty="true"
                                                              OnPageIndexChanging="projectDataGridView_PageIndexChanging"
                                                              OnRowEditing="projectDataGridView_RowEditing"
                                                              OnRowUpdating="projectDataGridView_RowUpdating"
                                                              OnRowCancelingEdit="projectDataGridView_RowCancelingEdit"
                                                              OnRowDataBound="projectDataGridView_RowDataBound"
                                                              PageSize="30">
                                                    <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                    <Columns>
                                                        <asp:TemplateField ItemStyle-Width = "3%" HeaderText="">
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server"
                                                                               Text='<%# Container.DataItemIndex + 1 %>' />
                                                                    <asp:Label ID="lblprojectGrid_Id" 
                                                                               runat="server"
                                                                               Visible="false"
                                                                               Text='<%# Eval("id")%>' />
                                                                </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width="15%" meta:resourcekey="appUserGridView_CompanyRc">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblAppUserGrid_Company"
                                                                    runat="server" />
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:DropDownList CssClass="form-control"
                                                                                ID="selAppUserGrid_Company"
                                                                                Style="color: #0094ff"
                                                                                AutoPostBack="false"
                                                                                runat="server">
                                                                </asp:DropDownList>
                                                            </EditItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="appGridView_ApprovalTypeRc">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblAppUserGrid_ApprovalType"
                                                                    runat="server" />
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:DropDownList CssClass="form-control"
                                                                                ID="selGridApprovalType"
                                                                                Style="color: #0094ff"
                                                                                AutoPostBack="false"
                                                                                runat="server">
                                                                </asp:DropDownList>
                                                            </EditItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width="8%" meta:resourcekey="projectDataGridView_CodeRc">
	                                                        <ItemTemplate>
		                                                        <asp:Label ID="lblProjectDataGridView_Code"
			                                                                runat="server" />
	                                                        </ItemTemplate>
	                                                        <EditItemTemplate>
		                                                        <asp:TextBox ID="txtProjectDataGridView_Code"
			                                                                runat="server"
			                                                                Width="98.5%"
                                                                            ForeColor="#0094ff"
                                                                            BackColor="#FEF887"
                                                                            CssClass="form-control"
                                                                            meta:resourcekey="txtProjectDataGridView_CodeRc"/>
		                                                        <asp:RequiredFieldValidator ID="rfvProjectDataGridView_Code"
			                                                                runat="server"
			                                                                ValidationGroup="vsProjectEditGrid"
			                                                                ControlToValidate="txtProjectDataGridView_Code"
			                                                                ForeColor="Red"
			                                                                Display="Dynamic"
			                                                                meta:resourcekey="txtProjectDataGridView_CodeRc" />
	                                                        </EditItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width="15%" meta:resourcekey="projectDataGridView_FirstNameRc">
	                                                        <ItemTemplate>
		                                                        <asp:Label ID="lblProjectDataGridView_Name"
			                                                        runat="server" />
	                                                        </ItemTemplate>
	                                                        <EditItemTemplate>
		                                                        <asp:TextBox ID="txtProjectDataGridView_Name"
			                                                                runat="server"
			                                                                Width="98.5%"
                                                                            ForeColor="#0094ff"
                                                                            BackColor="#FEF887"
                                                                            CssClass="form-control"
                                                                            meta:resourcekey="txtProjectDataGridView_NameRc" />
		                                                        <asp:RequiredFieldValidator ID="rfvProjectDataGridView_Name"
			                                                                                runat="server"
			                                                                                ValidationGroup="vsProjectEditGrid"
			                                                                                ControlToValidate="txtProjectDataGridView_Name"
			                                                                                ForeColor="Red"
			                                                                                Display="Dynamic"
			                                                                                meta:resourcekey="txtProjectDataGridView_NameRc" />
	                                                        </EditItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width="15%" meta:resourcekey="projectDataGridView_DescriptionRc">
	                                                        <ItemTemplate>
		                                                        <asp:Label ID="lblProjectDataGridView_Description"
			                                                        runat="server" />
	                                                        </ItemTemplate>
	                                                        <EditItemTemplate>
		                                                        <asp:TextBox ID="txtProjectDataGridView_Description"
			                                                                    runat="server"
			                                                                    Width="98.5%"
                                                                                ForeColor="#0094ff"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtProjectDataGridView_DescriptionRc" />
	                                                        </EditItemTemplate>
                                                        </asp:TemplateField>
                                                           <asp:TemplateField ItemStyle-Width="7%" meta:resourcekey="projectDataGridView_ProjectColorRc">
	                                                        <ItemTemplate>
		                                                       <asp:TextBox ID="txtProjectDataGridView_ProjectColor"
                                                                                Enabled="false"
			                                                                    runat="server"
                                                                                TextMode="Color"
			                                                                    Width="98.5%"
                                                                                ForeColor="#0094ff"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtProjectDataGridView_ProjectColorc" />
	                                                        </ItemTemplate>
	                                                        <EditItemTemplate>
		                                                        <asp:TextBox ID="txtProjectDataGridView_ProjectColor"
			                                                                    runat="server"
			                                                                    Width="98.5%"
                                                                                ForeColor="#0094ff"
                                                                                TextMode="Color"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtProjectDataGridView_ProjectColorc" />
	                                                        </EditItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width="9%" meta:resourcekey="grid_AssetsRc">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="btnAssets"
                                                                    runat="server"
                                                                    CssClass="btn btn-info btn-xs"
                                                                    CommandArgument='<%# Eval("id") %>'
                                                                    OnCommand="btnAssets_Command">
                                                                            <asp:PlaceHolder runat="server">
                                                                                <i class="fa fa-external-link"></i>
                                                                            </asp:PlaceHolder>
                                                                </asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                         <asp:TemplateField ItemStyle-Width="6%" meta:resourcekey="grid_BannerImageRc">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="btnBannerImage"
                                                                    runat="server"
                                                                    CssClass="btn btn-primary btn-xs"
                                                                    CommandArgument='<%# Eval("id") %>'
                                                                    OnCommand="btnBannerImage_Command">
                                                                            <asp:PlaceHolder runat="server">
                                                                                <i class="fa fa-picture-o"></i>
                                                                            </asp:PlaceHolder>
                                                                </asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="projectDataGridView_ManDaysRc">
	                                                        <ItemTemplate>
		                                                        <asp:Label ID="lblProjectGridView_ManDays"
			                                                        runat="server"/>
	                                                        </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width="9%" meta:resourcekey="grid_PoRc">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="btnPo"
                                                                    runat="server"
                                                                    CssClass="btn btn-warning btn-xs"
                                                                    CommandArgument='<%# Eval("id") %>'
                                                                    OnCommand="btnPo_Command">
                                                                            <asp:PlaceHolder runat="server">
                                                                                <i class="fa fa-calendar"></i>
                                                                            </asp:PlaceHolder>
                                                                </asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="projectDataGridView_LastUpdateRc">
	                                                        <ItemTemplate>
		                                                        <asp:Label ID="lblProjectGridView_LastUpdate"
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
