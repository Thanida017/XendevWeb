<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="F018.1.ApprovalHierarchyDetail.aspx.cs" 
    Inherits="XenDevWeb.admin.F018__1_ApprovalHierarchyDetail"
    MasterPageFile="~/include/master.Master" 
    meta:resourcekey="PageResource1"
    MaintainScrollPositionOnPostback="true" %>


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
                                <strong><asp:Label ID="lblApprovalHierachyDetails" runat="server" meta:resourcekey="lblApprovalHierachyDetailsRc" /></strong>
                                   <b> :
                                    <asp:Label ID="lblCode" runat="server"></asp:Label></b>
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
                                            <div class="row">
                                                <div class="col-lg-3 col-md-3 col-xs-6">
                                                    <section class="panel" style="border: solid 1px #d0efde">
                                                        <header class="panel-heading">
                                                            <b><asp:Label ID="lblAddApproval" runat="server" meta:resourcekey="lblAddApprovalRc" /></b>
                                                        </header>
                                                        <asp:Panel runat="server" class="panel-body" DefaultButton="btnAdd">
                                                             <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px;">
                                                                  <div class="form-group" style="width: 75%;width: 100%; float: left">
                                                                    <asp:Label ID="lblUserAccount" runat="server" meta:resourcekey="lblUserAccountRc" AssociatedControlID="selUserAccount" />
                                                                    <asp:DropDownList CssClass="form-control"
                                                                                        ID="selUserAccount"
                                                                                        Style="color: #0094ff"
                                                                                        AutoPostBack="false"
                                                                                        runat="server">
                                                                    </asp:DropDownList>
                                                                </div>
                                                             </div>
                                                            <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px;">
                                                                <asp:LinkButton ID="btnAdd"
                                                                                type="button"
                                                                                class="btn btn-success"
                                                                                style="width: 100%;"
                                                                                runat="server"
                                                                                OnClick="btnAdd_Click">
                                                                    <asp:PlaceHolder runat="server">
                                                                        <i class="fa fa-plus"></i>
                                                                        <asp:Label ID="lblBtnAdd" runat="server" meta:resourcekey="lblBtnAddRc" />
                                                                    </asp:PlaceHolder>
                                                                </asp:LinkButton>
                                                            </div>                                                              
                                                        </asp:Panel>
                                                    </section>
                                                </div>
                                                <div class="col-lg-9 col-md-9 col-xs-6">
                                                    <section class="panel" style="border: solid 1px #d0efde">
                                                        <header class="panel-heading">
                                                            <b><asp:Label ID="lblApprovalHierachyDetailsInDb" runat="server" meta:resourcekey="lblApprovalHierachyDetailsInDbRc" /></b>
                                                        </header>
                                                        <%= WebUtils.getErrorMessage(this.errorMessagesForGrid) %>
                                                        <%= WebUtils.getInfoMessage(this.infoMessagesForGrid) %>
                                                        <asp:Panel runat="server" class="panel-body" DefaultButton="">
                                                             <div class="row">
                                                                <asp:GridView ID="ahDetailInDatabaseGridView"
                                                                                runat="server"
                                                                                AutoGenerateColumns="false"
                                                                                CssClass="table table-striped table-advance  table-hover"
                                                                                Width="100%"
                                                                                GridLines="None"
                                                                                AllowPaging="true"
                                                                                ShowHeaderWhenEmpty="true"
                                                                                OnRowDataBound="ahDetailInDatabaseGridView_RowDataBound"
                                                                                OnRowEditing="ahDetailInDatabaseGridView_RowEditing"
                                                                                OnRowCancelingEdit="ahDetailInDatabaseGridView_RowCancelingEdit"
                                                                                OnRowUpdating="ahDetailInDatabaseGridView_RowUpdating"
                                                                                >
                                                                    <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                                    <Columns>
                                                                        <asp:TemplateField ItemStyle-Width="5%" HeaderText="">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblApproDetailId" runat="server" Visible="false" />
                                                                                <asp:Label runat="server"
                                                                                    Text='<%# Container.DataItemIndex + 1 %>' />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField ItemStyle-Width="60%" meta:resourcekey="gridUserAccountRc">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblGrid_UserAccount"
                                                                                    runat="server" />
                                                                            </ItemTemplate>
                                                                            <EditItemTemplate>
                                                                                <asp:DropDownList CssClass="form-control"
                                                                                                    ID="selGridUserAccount"
                                                                                                    Style="color: #0094ff"
                                                                                                    AutoPostBack="false"
                                                                                                    runat="server">
                                                                                </asp:DropDownList>
                                                                            </EditItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField ItemStyle-Width="25%" meta:resourcekey="gridAuthorityRc">
                                                                            <ItemTemplate >
                                                                                <asp:Label ID="lblGrid_Authority"
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
                                                                                                <i class="fa fa fa-trash-o"></i> <%= (string)GetGlobalResourceObject("GlobalResource", "yes") %>
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
                                                </div>
                                            </div>
                                          <div class="row">
                                                <!-- Go Back Button -->
                                                <div class="form-group" style="margin-left: 10px; float: left; margin-top: 20px">
                                                    <asp:LinkButton ID="btnGoBack"
                                                        type="button"
                                                        class="btn btn-success"
                                                        runat="server"
                                                        OnClick="btnGoBack_Click">
                                                        <asp:PlaceHolder runat="server">
                                                            <i class="fa fa-reply"></i>
                                                            <asp:Label ID="lblGoBack" runat="server" meta:resourcekey="lblBtnGoBackRc" />
                                                        </asp:PlaceHolder>
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                            <asp:HiddenField ID="hndApprovalId" runat="server" />
                                            
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