<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="F018.ApprovalHierarchy.aspx.cs" 
    Inherits="XenDevWeb.admin.F018_ApprovalHierarchy"
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
                                <strong><asp:Label ID="lblApprovalHierarchy" runat="server" meta:resourcekey="lblApprovalHierarchyRc" /></strong>
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
                                                    <b><asp:Label ID="lblAddApprovalHierarchy" runat="server" meta:resourcekey="lblAddApprovalHierarchyRc" /></b>
                                                </header>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="btnAdd">
                                                    <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
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
                                                                                        ValidationGroup="vsAdditionGroup" 
                                                                                        ControlToValidate="txtCode"
                                                                                        ForeColor="Red"
                                                                                        Display="Dynamic"
                                                                                        meta:resourcekey="txtCodeRc" />

                                                        </div>
                                                     </div>
                                                     <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                         <div class="form-group" style="width: 100%; float: left">
                                                            <asp:Label ID="lblDescription" runat="server"  meta:resourcekey="lblDescriptionRc" AssociatedControlID="txtDescription" />
                                                            <asp:TextBox ID="txtDescription"
                                                                         Width="98.5%"
                                                                         runat="server"
                                                                         ForeColor="#0094ff"
                                                                         BackColor="#FAF4AB"
                                                                         CssClass="form-control"
                                                                         meta:resourcekey="txtDescriptionRc" />
                                                            <asp:RequiredFieldValidator ID="rfvDescription" 
                                                                                        runat="server"  
                                                                                        ValidationGroup="vsAdditionGroup" 
                                                                                        ControlToValidate="txtDescription"
                                                                                        ForeColor="Red"
                                                                                        Display="Dynamic"
                                                                                        meta:resourcekey="txtDescriptionRc" />

                                                        </div>
                                                     </div>
                                                    <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
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
                                                     <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                          <div class="form-group" style="width: 100%; float: left; margin-top: 22px;">
                                                            <asp:LinkButton id="btnAdd" 
                                                                            type="button" 
                                                                            class="btn btn-success" 
                                                                            runat="server"
                                                                            OnClick="btnAdd_Click">
                                                                <asp:PlaceHolder runat="server">
                                                                    <i class="fa fa-plus"></i>
                                                                    <asp:Label ID="lblBtnAdd" runat="server" meta:resourcekey="lblBtnAddRc" />
                                                                </asp:PlaceHolder>
                                                            </asp:LinkButton>
                                                        </div>
                                                     </div>
                                                </asp:Panel>
                                            </section>
                                             <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b><asp:Label ID="lblApprovalHierarchyInDatabase" runat="server" meta:resourcekey="lblApprovalHierarchyInDatabaseRc" /></b>
                                                </header>
                                                <%= WebUtils.getErrorMessage(this.errorMessagesForGrid) %>
                                                <%= WebUtils.getInfoMessage(this.infoMessagesForGrid) %>
                                                 <asp:Panel runat="server" class="panel-body" DefaultButton="btnSearch">
                                                     <div class="row">
                                                         <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                             <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblSearchType" runat="server"  meta:resourcekey="lblSearchTypeRc" AssociatedControlID="selSearchType" />
                                                                <asp:DropDownList CssClass="form-control"
                                                                                  ID="selSearchType"
                                                                                  Style="color: #0094ff"
                                                                                  AutoPostBack="false"
                                                                                  runat="server">
                                                                </asp:DropDownList>
                                                             </div>
                                                         </div>
                                                         <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                             <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblSearchText" runat="server"  meta:resourcekey="lblSearchTextRc" AssociatedControlID="txtSearchText" />
                                                                <asp:TextBox ID="txtSearchText"
                                                                             Width="98.5%"
                                                                             runat="server"
                                                                             ForeColor="#0094ff"
                                                                             CssClass="form-control"
                                                                             meta:resourcekey="txtSearchTextRc" />
                                                                <asp:RequiredFieldValidator ID="rfvSearchText" 
                                                                                            runat="server"  
                                                                                            ValidationGroup="vsSearchGroup"
                                                                                            ControlToValidate="txtSearchText"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtSearchTextRc" 
                                                                                            Enabled="false"/>
                                                             </div>
                                                         </div>
                                                         <div class="col-lg-2 col-md-2 col-xs-6" style="padding: 5px;">
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
                                                         <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                             <div class="form-group" style="width: 100%; float: left; margin-top: 22px;">
                                                                 <asp:LinkButton ID="btnSearch"
                                                                                 type="button"
                                                                                 class="btn btn-success"
                                                                                 runat="server"
                                                                                 OnClick="btnSearch_Click">
                                                                    <asp:PlaceHolder runat="server">
                                                                        <i class="fa fa-search"></i>
                                                                        <asp:Label ID="lblSearch" runat="server" meta:resourcekey="lblSearchRc" />
                                                                    </asp:PlaceHolder>
                                                                 </asp:LinkButton>
                                                             </div>
                                                         </div>
                                                     </div>
                                                      <div class="row">
                                                        <asp:GridView ID="approvalHierachyDatabaseGridView"
                                                                    runat="server"
                                                                    AutoGenerateColumns="false"
                                                                    CssClass="table table-striped table-advance  table-hover"
                                                                    Width="100%"
                                                                    GridLines="None"
                                                                    AllowPaging="true"
                                                                    ShowHeaderWhenEmpty="true"
                                                                    OnPageIndexChanging="approvalHierachyDatabaseGridView_PageIndexChanging"
                                                                    OnRowDataBound="approvalHierachyDatabaseGridView_RowDataBound"
                                                                    OnRowEditing="approvalHierachyDatabaseGridView_RowEditing"
                                                                    OnRowCancelingEdit="approvalHierachyDatabaseGridView_RowCancelingEdit"
                                                                    OnRowUpdating="approvalHierachyDatabaseGridView_RowUpdating" >
                                                        <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                        <Columns>
                                                            <asp:TemplateField ItemStyle-Width = "5%" HeaderText="">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblApprovalHierarchyId" runat="server" Visible="false" />
                                                                    <asp:Label runat="server"
                                                                               Text='<%# Container.DataItemIndex + 1 %>' />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "20%"  meta:resourcekey="gridProjectRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_Project" 
                                                                               runat="server" />
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:DropDownList CssClass="form-control"
                                                                                        ID="selGridProject"
                                                                                        Style="color: #0094ff"
                                                                                        AutoPostBack="false"
                                                                                        runat="server">
                                                                    </asp:DropDownList>
                                                                </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "20%"  meta:resourcekey="gridCodeRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_Code" 
                                                                               runat="server" />
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="txtGrid_Code" 
                                                                                 runat="server"
                                                                                 Width="98.5%" 
																				 ForeColor="#0094ff"
                                                                                 BackColor="#FAF4AB"
                                                                                 CssClass="form-control"
                                                                                 meta:resourcekey="txtCodeRc" />
                                                                    <asp:RequiredFieldValidator ID="rfvGridCode" 
                                                                                                runat="server"  
                                                                                                ValidationGroup="vsGridEditGroup"
                                                                                                ControlToValidate="txtGrid_Code"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtCodeRc" />
                                                                </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "30%"  meta:resourcekey="gridDescriptionRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_Description" 
                                                                               runat="server" />
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="txtGrid_Description" 
                                                                                 runat="server"
                                                                                 Width="98.5%" 
																				 ForeColor="#0094ff"
                                                                                 BackColor="#FAF4AB"
                                                                                 CssClass="form-control"
                                                                                 meta:resourcekey="txtDescriptionRc" />
                                                                    <asp:RequiredFieldValidator ID="rfvGridDescription" 
                                                                                                runat="server"  
                                                                                                ValidationGroup="vsGridEditGroup"
                                                                                                ControlToValidate="txtGrid_Description"
                                                                                                ForeColor="Red"
                                                                                                Display="Dynamic"
                                                                                                meta:resourcekey="txtDescriptionRc" />
                                                                </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width = "20%"  meta:resourcekey="gridApprovalTypeRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_ApprovalType" 
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
                                                            <asp:TemplateField ItemStyle-Width = "10%"  meta:resourcekey="gridEnabledRc">
                                                               <ItemTemplate>
                                                                   <asp:Label ID="lblGrid_Enabled" 
                                                                              runat="server" />
                                                                   <div class="checkbox" style="margin: 0">
                                                                        <asp:CheckBox ID="chkGrid_Enabled" runat="server"  Enabled="false"/>
                                                                   </div>
                                                               </ItemTemplate>
                                                               <EditItemTemplate>
                                                                   <div class="checkbox" style="margin:0px">
                                                                        <asp:CheckBox ID="chkGrid_Enabled" runat="server" />
                                                                   </div>
                                                               </EditItemTemplate>
                                                           </asp:TemplateField>  
                                                            <asp:TemplateField ItemStyle-Width = "8%"  meta:resourcekey="gridDetailRc">
                                                               <ItemTemplate>
                                                                   <asp:LinkButton ID="btnDetail" 
                                                                                    runat="server"
                                                                                    CssClass="btn btn-warning btn-xs"
                                                                                    CommandArgument='<%# Eval("id") %>'
                                                                                    OnCommand="btnDetail_Command">
                                                                        <asp:PlaceHolder runat="server">
                                                                            <i class="fa fa-external-link"></i>
                                                                        </asp:PlaceHolder>
                                                                    </asp:LinkButton>
                                                               </ItemTemplate>
                                                            </asp:TemplateField>        
                                                            <asp:TemplateField ItemStyle-Width="20%" meta:resourcekey="gridLastUpdateRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGridLastUpdate" runat="server" />
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
                                                            <asp:TemplateField ItemStyle-Width="3%">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="btnDelete"
                                                                                    runat="server"
                                                                                    CssClass="btn btn-danger btn-xs"
                                                                                    CommandName="itemRowDelete"
                                                                                    OnClientClick="return confirmDelete()"
                                                                                    CommandArgument='<%# Eval("id") %>'
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
                                                                                                <i class="fa fa fa-trash-o"></i> 
                                                                                                <%= (string)GetGlobalResourceObject("GlobalResource", "yes") %>
                                                                                            </asp:PlaceHolder>
                                                                            </asp:LinkButton>
                                                                            <asp:LinkButton ID="btnNo"
                                                                                runat="server"
                                                                                CssClass="btn btn-success btn-xs">
                                                                                            <asp:PlaceHolder runat="server">
                                                                                                <i class="fa fa-check"></i> 
                                                                                                <%= (string)GetGlobalResourceObject("GlobalResource", "no") %>
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
