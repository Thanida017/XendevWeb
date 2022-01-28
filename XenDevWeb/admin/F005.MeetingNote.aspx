<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="F005.MeetingNote.aspx.cs" 
    Inherits="XenDevWeb.admin.F005_MeetingNote"
     meta:resourcekey="PageResource1" 
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
                                <strong><asp:Label ID="lblHeadMeetingNotes" runat="server" meta:resourcekey="lblHeadMeetingNotesRc" /></strong>
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
                                                <%= WebUtils.getErrorMessage(this.errorMessagesForGrid) %>
                                                <%= WebUtils.getInfoMessage(this.infoMessagesForGrid) %>
                                                <asp:panel runat="server" class="panel-body" style="padding-bottom: 0px" DefaultButton="btnSearch">
                                                     <div class="col-lg-2 col-md-2 col-xs-12" id="divSelCompany" runat="server"  style="padding:5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <b><asp:Label ID="lblSelCompany" runat="server"  meta:resourcekey="lblSelCompanyRc" /></b>
                                                            <asp:DropDownList CssClass="form-control"
                                                                              ID="selCompany"
                                                                              OnSelectedIndexChanged="selCompany_SelectedIndexChanged"
                                                                              Style="color: #0094ff;  margin-top: 5px;"
                                                                              AutoPostBack="true"
                                                                              runat="server">
                                                            </asp:DropDownList>
                                                       </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-xs-12" style="padding:5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <b><asp:Label ID="lblSearchGridByProjects" runat="server"  meta:resourcekey="lblSearchGridByProjectsRc" /></b>
                                                            <asp:DropDownList CssClass="form-control"
                                                                              ID="selProjects"
                                                                              Style="color: #0094ff;  margin-top: 5px;"
                                                                              AutoPostBack="false"
                                                                              runat="server">
                                                            </asp:DropDownList>
                                                       </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-3 col-xs-6" style="padding:5px;">
                                                        <!-- Date From -->
                                                        <div class="form-group" style="width: 85%; margin-left: 10px; float: left">
                                                            <asp:Label ID="lblDateFrom" runat="server" meta:resourcekey="lblDateFromRc" AssociatedControlID="txtDateFrom" />
                                                            <asp:TextBox ID="txtDateFrom"
                                                                         Width="98.5%"
                                                                         runat="server"
                                                                         ForeColor="#0094FF"
                                                                         BackColor="#FCF5D8"
                                                                         CssClass="form-control"
                                                                         meta:resourcekey="txtDateFromRc" />
                                                            <span class="input-group-btn add-on">
                                                                <button id="btnDateFromCal"
                                                                        runat="server"
                                                                        class="btn btn-danger"
                                                                        style="margin-left: -15px; height: 35px"
                                                                        type="button">
                                                                        <i class="fa fa-calendar"></i>
                                                                </button>
                                                            </span>
                                                            <asp:RequiredFieldValidator ID="rfvDateFrom"
                                                                                        runat="server"
                                                                                        ValidationGroup="vsSearchGroup"
                                                                                        ControlToValidate="txtDateFrom"
                                                                                        ForeColor="Red"
                                                                                        Display="Dynamic"
                                                                                        meta:resourcekey="txtDateFromRc"
                                                                                        Enabled="false" />
                                                            <ajaxToolkit:CalendarExtender
                                                                                        runat="server"
                                                                                        TargetControlID="txtDateFrom"
                                                                                        PopupButtonID="btnDateFromCal"
                                                                                        Format="d/MM/yyyy" BehaviorID="" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-3 col-xs-6" style="padding:5px;">
                                                        <!-- Date To -->
                                                        <div class="form-group" style="width: 85%; margin-left: 10px; float: left">
                                                            <asp:Label ID="lblDateTo" runat="server" meta:resourcekey="lblDateToRc" AssociatedControlID="txtDateTo" />
                                                            <asp:TextBox ID="txtDateTo"
                                                                         Width="98.5%"
                                                                         runat="server"
                                                                         ForeColor="#0094FF"
                                                                         BackColor="#FCF5D8"
                                                                         CssClass="form-control"
                                                                         meta:resourcekey="txtDateToRc" />
                                                            <span class="input-group-btn add-on">
                                                                <button id="btnDateToCal"
                                                                        runat="server"
                                                                        class="btn btn-danger"
                                                                        style="margin-left: -15px; height: 35px"
                                                                        type="button">
                                                                        <i class="fa fa-calendar"></i>
                                                                </button>
                                                            </span>
                                                            <asp:RequiredFieldValidator ID="rfvDateTo"
                                                                                        runat="server"
                                                                                        ValidationGroup="vsSearchGroup"
                                                                                        ControlToValidate="txtDateTo"
                                                                                        ForeColor="Red"
                                                                                        Display="Dynamic"
                                                                                        meta:resourcekey="txtDateToRc"
                                                                                        Enabled="false" />
                                                            <ajaxToolkit:CalendarExtender
                                                                                        runat="server"
                                                                                        TargetControlID="txtDateTo"
                                                                                        PopupButtonID="btnDateToCal"
                                                                                        Format="d/MM/yyyy" BehaviorID="" />
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
                                                    <div class="col-lg-2 col-md-1 col-xs-6" style="padding:5px;">
                                                        <div class="form-group" style="width: 15%; margin-top: 22px; float: left">
                                                            <asp:LinkButton id="btnSearch" 
                                                                            type="button" 
                                                                            class="btn btn-success" 
                                                                            runat="server"
                                                                            OnClick="btnSearch_Click">
                                                                 <i class="fa fa-search"></i> <asp:Label ID="lblBtnSearchProjects" runat="server"  meta:resourcekey="lblBtnSearchProjectsRc" ></asp:Label>
                                                             </asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </asp:panel>
                                                <div class="panel-body">
                                                    <div class="panel-body" style="overflow-x: auto; width: 100%">
                                                        <asp:GridView ID="meetingNotesGridView"
                                                                      runat="server"
                                                                      AutoGenerateColumns="false"
                                                                      CssClass="table table-advance table-hover"
                                                                      Width="100%"
                                                                      GridLines="None"
                                                                      AllowPaging="true"
                                                                      OnPageIndexChanging="meetingNotesGridView_PageIndexChanging"
                                                                      OnRowEditing="meetingNotesGridView_RowEditing"
                                                                      OnRowUpdating="meetingNotesGridView_RowUpdating"
                                                                      OnRowCancelingEdit="meetingNotesGridView_RowCancelingEdit"
                                                                      OnRowDataBound="meetingNotesGridView_RowDataBound"
                                                                      ShowHeaderWhenEmpty="true"
                                                                      PageSize="30">
                                                                <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                                <Columns>
                                                                    <asp:TemplateField ItemStyle-Width="5%" HeaderText="">
                                                                        <ItemTemplate>
                                                                            <asp:Label runat="server"
                                                                                       Text='<%# Container.DataItemIndex + 1 %>' />
                                                                            <asp:Label ID="lblMeetingNoteGrid_Id"
                                                                                       runat="server"
                                                                                       Visible="false"
                                                                                       Text='<%# Eval("id")%>' />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="meetingNoteGrid_DateRc">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblMeetingNoteGrid_Date"
                                                                                       runat="server"
                                                                                       Visible="false" />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField ItemStyle-Width="20%" meta:resourcekey="meetingNoteGrid_ParticipantRc">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblMeetingNoteGrid_Participant"
                                                                                       runat="server"
                                                                                       Visible="false" />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField ItemStyle-Width="6%" meta:resourcekey="meetingNoteGrid_ViewRc">
                                                                        <ItemTemplate>
                                                                              <asp:HyperLink ID="hplGridPdf" 
                                                                                       runat="server">
                                                                                  <i class="fa fa-download"></i>
                                                                              </asp:HyperLink>
                                                                                
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField ItemStyle-Width="6%" meta:resourcekey="meetingNoteGrid_DetailsRc">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton ID="btnDeteils"
                                                                                            runat="server"
                                                                                            CssClass="btn btn-info btn-xs"
                                                                                            CommandArgument='<%# Eval("id") %>'
                                                                                            OnCommand="btnDeteils_Command">
                                                                            <asp:PlaceHolder runat="server">
                                                                                <i class="fa fa-external-link"></i>
                                                                            </asp:PlaceHolder>
                                                                            </asp:LinkButton>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                      <asp:TemplateField ItemStyle-Width="6%" meta:resourcekey="meetingNoteGrid_DeleteRc">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton ID="btnDetete"
                                                                                            runat="server"
                                                                                            CssClass="btn btn-danger btn-xs"
                                                                                            CommandArgument='<%# Eval("id") %>'
                                                                                            OnCommand="btnDetete_Command">
                                                                            <asp:PlaceHolder runat="server">
                                                                                <i class="fa fa-trash-o"></i>
                                                                            </asp:PlaceHolder>
                                                                            </asp:LinkButton>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                    </div>
                                                      <div class="form-group" id="divAddMeeting" runat="server" style="margin-top: 22px; float: right">
                                                            <asp:LinkButton id="btnAddMeeting" 
                                                                            type="button" 
                                                                            class="btn btn-success" 
                                                                            runat="server"
                                                                            OnClick="btnAddMeeting_Click">
                                                                <asp:PlaceHolder runat="server">
                                                                     <i class="fa fa-plus-circle"></i> <asp:Label ID="lblbtnAddMeeting" runat="server"  meta:resourcekey="lblbtnAddMeetingRc" ></asp:Label>
                                                                </asp:PlaceHolder>                                                                
                                                             </asp:LinkButton>
                                                        </div>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </section>
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

