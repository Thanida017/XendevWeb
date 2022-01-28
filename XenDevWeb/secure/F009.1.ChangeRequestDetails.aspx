<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="F009.1.ChangeRequestDetails.aspx.cs" 
    Inherits="XenDevWeb.secure.F009__1_ChangeRequestDetails"
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
                                <strong>
                                    <asp:Label ID="lblProjectName" runat="server" />
                                    <asp:Label ID="lblAssetFileName" runat="server"  />
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
                                                    <b><asp:Label ID="lblDBChangeRequestDetails" runat="server" meta:resourcekey="lblDBChangeRequestDetailsRc" /></b>
                                                </header>
                                                <%= WebUtils.getErrorMessage(this.errorMessagesForGrid) %>
                                                <%= WebUtils.getInfoMessage(this.infoMessagesForGrid) %>
                                                <div class="panel-body" style="overflow-x: auto; width: 100%">
                                                    <asp:GridView ID="changReqDetailGridView"
                                                        runat="server"
                                                        AutoGenerateColumns="false"
                                                        CssClass="table table-striped table-advance table-hover"
                                                        Width="100%"
                                                        GridLines="None"
                                                        AllowPaging="true"
                                                        ShowHeaderWhenEmpty="true"
                                                        OnPageIndexChanging="changReqDetailGridView_PageIndexChanging"
                                                        OnRowDataBound="changReqDetailGridView_RowDataBound">
                                                        <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                        <Columns>
                                                            <asp:TemplateField ItemStyle-Width="5%" HeaderText="">
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server"
                                                                        Text='<%# Container.DataItemIndex + 1 %>' />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="15%" meta:resourcekey="grid_OrdinalRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_Ordinal"
                                                                        runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                             <asp:TemplateField ItemStyle-Width="15%" meta:resourcekey="grid_StatusRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_Status"
                                                                        runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                             <asp:TemplateField ItemStyle-Width="15%" meta:resourcekey="grid_ChangeCompleteDateRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_ChangeCompleteDate"
                                                                        runat="server" />
                                                                </ItemTemplate>
                                                             </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="15%" meta:resourcekey="grid_ChangeRejectDateRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_ChangeRejectDate"
                                                                        runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="15%" meta:resourcekey="grid_RejectReasonRc">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGrid_RejectReason"
                                                                        runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-Width="6%" meta:resourcekey="grid_EditRc">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="btnEdit"
                                                                        runat="server"
                                                                        CssClass="btn btn-info btn-xs"
                                                                        CommandArgument='<%# Eval("id") %>'
                                                                        OnCommand="btnEdit_Command">
                                                                            <asp:PlaceHolder runat="server">
                                                                                <i class="fa  fa-gear"></i>
                                                                            </asp:PlaceHolder>
                                                                    </asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                              <asp:TemplateField ItemStyle-Width="3%" meta:resourcekey="grid_DeleteRc">
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
                                                    <div class="row">
                                                        <div class="col-lg-2 col-md-2 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; margin-top: 22px; float: left">
                                                                <asp:LinkButton ID="btnBack"
                                                                    type="button"
                                                                    class="btn btn-warning btn-block"
                                                                    runat="server"
                                                                    OnClick="btnBack_Click">
                                                                    <i class="fa fa-mail-reply-all"></i>
                                                                    <asp:Label ID="lblBack" runat="server" meta:resourcekey="lblBackRc"></asp:Label>
                                                                </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-2 col-xs-12" style="padding: 5px; float: right">
                                                            <div class="form-group" style="width: 100%; margin-top: 22px;">
                                                                <asp:LinkButton ID="btnAdd"
                                                                    type="button"
                                                                    class="btn btn-success btn-block"
                                                                    runat="server"
                                                                    OnClick="btnAdd_Click">
                                                                    <i class="fa fa-plus"></i>
                                                                    <asp:Label ID="lblAddChange" runat="server" meta:resourcekey="lblAddChangeRc"></asp:Label>
                                                                </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </div>                                                      
                                                </div>
                                            </section>
                                            <asp:HiddenField ID="hndAppChangeId" runat="server" />
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
