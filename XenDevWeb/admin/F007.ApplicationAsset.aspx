<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="F007.ApplicationAsset.aspx.cs" 
    Inherits="XenDevWeb.admin.F007_ApplicationAsset" 
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
                                <strong><asp:Label ID="lblApplicationAsset" runat="server" meta:resourcekey="lblApplicationAssetRc" /></strong>
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
                                                    <b><asp:Label ID="lblAddApplicationAsset" runat="server" meta:resourcekey="lblAddApplicationAssetRc" /></b>
                                                </header>
                                                <asp:panel runat="server" class="panel-body" DefaultButton="btnAddAppAsset">
                                                    <div class="row">
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblAssetFileName" runat="server"  meta:resourcekey="lblAssetFileNameRc" AssociatedControlID="txtAssetFileName" />
                                                                <asp:TextBox ID="txtAssetFileName"
                                                                             Width="98.5%"
			                                                                 runat="server"
			                                                                 ForeColor="#0094ff"
                                                                             BackColor="#FAF4AB"
			                                                                 CssClass="form-control"
                                                                             meta:resourcekey="txtAssetFileNameRc" />
                                                                <asp:RequiredFieldValidator ID="rfvAssetFileName"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsAddGroup"
                                                                                            ControlToValidate="txtAssetFileName"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtAssetFileNameRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblNote" runat="server"  meta:resourcekey="lblNoteRc" AssociatedControlID="txtNote" />
                                                                <asp:TextBox ID="txtNote"
                                                                             Width="98.5%"
			                                                                 runat="server"
			                                                                 ForeColor="#0094ff"
			                                                                 CssClass="form-control"
                                                                             meta:resourcekey="txtNoteRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-2 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; margin-top: 22px; float: left">
                                                                <asp:LinkButton ID="btnAddAppAsset"
                                                                    type="button"
                                                                    class="btn btn-success"
                                                                    runat="server"
                                                                    OnClick="btnAddAppAsset_Click">
                                                                    <i class="fa fa-save"></i>
                                                                    <asp:Label ID="lblBtnAddAppAsset" runat="server" meta:resourcekey="lblBtnAddAppAssetRc"></asp:Label>
                                                                </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </section>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b><asp:Label ID="lblDBApplicationAsset" runat="server"  meta:resourcekey="lblDBApplicationAssetRc" /></b>
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
                                                    <asp:GridView ID="appAssetDataGridView"
                                                                  runat="server"
                                                                  AutoGenerateColumns="false"
                                                                  CssClass="table table-striped table-advance table-hover"
                                                                  Width="100%"
                                                                  GridLines="None"
                                                                  AllowPaging="true"
                                                                  ShowHeaderWhenEmpty="true"
                                                                  OnPageIndexChanging="appAssetDataGridView_PageIndexChanging"
                                                                  OnRowEditing="appAssetDataGridView_RowEditing"
                                                                  OnRowUpdating="appAssetDataGridView_RowUpdating"
                                                                  OnRowCancelingEdit="appAssetDataGridView_RowCancelingEdit"
                                                                  OnRowDataBound="appAssetDataGridView_RowDataBound"
                                                                  PageSize="30">
                                                    <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                        <Columns>
                                                            <asp:TemplateField ItemStyle-Width="3%" HeaderText="">
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server"
                                                                        Text='<%# Container.DataItemIndex + 1 %>' />
                                                                    <asp:Label ID="lblAppAssetGrid_Id"
                                                                        runat="server"
                                                                        Visible="false" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="25%" meta:resourcekey="gridView_AssetFileNameRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_AssetFileName"
                                                                                runat="server" />
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="txtGrid_AssetFileName"
                                                                                    runat="server"
                                                                                    Width="98.5%"
                                                                                    ForeColor="#0094ff"
                                                                                    BackColor="#FEF887"
                                                                                    CssClass="form-control"
                                                                                    meta:resourcekey="txtAssetFileNameRc" />
                                                                    <asp:RequiredFieldValidator ID="rfvGridView_AssetFileName"
                                                                                                runat="server"
                                                                                                ValidationGroup="vsEditGrid"
                                                                                                ControlToValidate="txtGrid_AssetFileName"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtAssetFileNameRc" />
                                                                </EditItemTemplate>
                                                            </asp:TemplateField>
                                                             <asp:TemplateField ItemStyle-Width="25%" meta:resourcekey="gridView_NoteRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_Note"
                                                                                runat="server" />
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="txtGrid_Note"
                                                                                    runat="server"
                                                                                    Width="98.5%"
                                                                                    CssClass="form-control"
                                                                                    ForeColor="#0094ff"
                                                                                    BackColor="#FEF887"
                                                                                    meta:resourcekey="txtNoteRc" />
                                                                    <asp:RequiredFieldValidator ID="rfvGridView_Note"
                                                                                                runat="server"
                                                                                                ValidationGroup="vsEditGrid"
                                                                                                ControlToValidate="txtGrid_Note"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtNoteRc" />
                                                                </EditItemTemplate>
                                                             </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="15%" meta:resourcekey="grid_EnableRc">
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="chkGrid_Enable"
                                                                        runat="server"
                                                                        Enabled="false" />
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                       <asp:CheckBox ID="chkGrid_Enable"
                                                                        runat="server" />
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
                                                     <div class="col-lg-2 col-md-2 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; margin-top: 22px; float: left">
                                                                <asp:LinkButton ID="btnBack"
                                                                    type="button"
                                                                    class="btn btn-warning"
                                                                    runat="server"
                                                                    OnClick="btnBack_Click">
                                                                    <i class="fa fa-mail-reply-all"></i>
                                                                    <asp:Label ID="lblBack" runat="server" meta:resourcekey="lblBackRc"></asp:Label>
                                                                </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                </div>
                                            </section>
                                           <asp:HiddenField ID="hndProjectId" runat="server" />
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