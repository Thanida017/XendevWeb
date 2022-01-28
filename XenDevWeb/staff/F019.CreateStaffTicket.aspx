<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="F019.CreateStaffTicket.aspx.cs" 
    Inherits="XenDevWeb.staff.F019_CreateStaffTicket" 
    MaintainScrollPositionOnPostback="true"
    MasterPageFile="~/include/master.Master"
    meta:resourcekey="PageResource1" %>

<%@ Import Namespace="XenDevWeb.Utils" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentMainPlaceHolder" runat="Server">
    <head runat="server">
        
        <style>
            .ajax__html_editor_extender_texteditor {
                background-color: #FAF4AB;
                color: #0094ff;
            }
        </style>
    </head>
    <section id="main-content">
        <section class="wrapper">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-xs-12">
                    <section class="panel">
                        <header class="panel-heading tab-bg-dark-navy-blue tab-right ">
                            <span class="hidden-sm wht-color">
                                <strong>
                                    <asp:Label ID="lblAddTicket" runat="server" meta:resourcekey="lblAddTicketRc" /></strong>
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
                                    <section class="panel">
                                        <div class="row">
                                            <asp:UpdatePanel ID="pnlAddTicket" runat="server" UpdateMode="Conditional">
                                                <ContentTemplate>
                                                    <div class="col-lg-8 col-md-8 col-xs-12">
                                                        <div class="row">
                                                            <div class="col-lg-8 col-md-8 col-xs-12">
                                                                <section class="panel" style="border: solid 1px #d0efde">
                                                                    <asp:Panel runat="server" class="panel-body" Style="padding-bottom: 0px" DefaultButton="btnCreate">
                                                                        <div class="row">
                                                                            <div class="col-lg-4 col-md-4 col-xs-6" style="padding: 5px;">
                                                                                <div class="form-group" style="width: 100%; float: left">
                                                                                    <asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProjectRc" AssociatedControlID="selProject" />
                                                                                    <asp:DropDownList CssClass="form-control"
                                                                                        ID="selProject"
                                                                                        Style="color: #0094ff"
                                                                                        AutoPostBack="true"
                                                                                        runat="server">
                                                                                    </asp:DropDownList>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-lg-4 col-md-4 col-xs-6" style="padding: 5px;">
                                                                                <div class="form-group" style="width: 100%; float: left">
                                                                                    <asp:Label ID="lblTicketNumber" runat="server" meta:resourcekey="lblTicketNumberRc" AssociatedControlID="txtTicketNumber" />
                                                                                    <asp:TextBox ID="txtTicketNumber"
                                                                                                    Width="98.5%"
                                                                                                    runat="server"
                                                                                                    ForeColor="#0094ff"
                                                                                                    BackColor="#FAF4AB"
                                                                                                    CssClass="form-control"
                                                                                                    meta:resourcekey="txtTicketNumberRc" />
                                                                                    <asp:RequiredFieldValidator ID="rfvTicketNumber"
                                                                                                                runat="server"
                                                                                                                ValidationGroup="vsAddTicketGroup"
                                                                                                                ControlToValidate="txtTicketNumber"
                                                                                                                ForeColor="Red"
                                                                                                                Display="Dynamic"
                                                                                                                meta:resourcekey="txtTicketNumberRc" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-lg-4 col-md-4 col-xs-12" style="padding: 5px;">
                                                                                <div class="form-group" style="width: 100%; float: left">
                                                                                    <asp:Label ID="lblSubject" runat="server" meta:resourcekey="lblSubjectRc" AssociatedControlID="txtSubject" />
                                                                                    <asp:TextBox ID="txtSubject"
                                                                                                Width="98.5%"
                                                                                                runat="server"
                                                                                                ForeColor="#0094ff"
                                                                                                BackColor="#FAF4AB"
                                                                                                CssClass="form-control"
                                                                                                meta:resourcekey="txtSubjectRc" />
                                                                                    <asp:RequiredFieldValidator ID="rfvSubject"
                                                                                                                runat="server"
                                                                                                                ValidationGroup="vsAddTicketGroup"
                                                                                                                ControlToValidate="txtSubject"
                                                                                                                ForeColor="Red"
                                                                                                                Display="Dynamic"
                                                                                                                meta:resourcekey="txtSubjectRc" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-lg-4 col-md-4 col-xs-6" style="padding: 5px;">
                                                                                <div class="form-group" style="width: 100%; float: left">
                                                                                    <asp:Label ID="lblAssignDate" runat="server" meta:resourcekey="lblAssignDateRc" AssociatedControlID="txtAssignDate" />
                                                                                    <asp:TextBox ID="txtAssignDate"
                                                                                                Width="98.5%"
                                                                                                runat="server"
                                                                                                ForeColor="#0094FF"
                                                                                                BackColor="#FCF5D8"
                                                                                                CssClass="form-control"
                                                                                                meta:resourcekey="txtAssignDateRc" />
                                                                                    <span class="input-group-btn add-on">
                                                                                        <button id="btnAssignDateCal"
                                                                                                runat="server"
                                                                                                class="btn btn-danger"
                                                                                                style="margin-left: -30px; height: 35px"
                                                                                                type="button">
                                                                                            <i class="fa fa-calendar"></i>
                                                                                        </button>
                                                                                    </span>
                                                                                    <asp:RequiredFieldValidator ID="rfvAssignDate"
                                                                                                                runat="server"
                                                                                                                ValidationGroup="vsAddTicketGroup"
                                                                                                                ControlToValidate="txtAssignDate"
                                                                                                                ForeColor="Red"
                                                                                                                Display="Dynamic"
                                                                                                                meta:resourcekey="txtAssignDateRc"
                                                                                                                Enabled="false" />
                                                                                    <ajaxToolkit:CalendarExtender
                                                                                                                runat="server"
                                                                                                                TargetControlID="txtAssignDate"
                                                                                                                PopupButtonID="btnAssignDateCal"
                                                                                                                Format="d/MM/yyyy" BehaviorID="" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-lg-4 col-md-4 col-xs-6" style="padding: 5px;">
                                                                                <div class="form-group" style="width: 100%; float: left">
                                                                                    <asp:Label ID="lblDeliveryDate" runat="server" meta:resourcekey="lblDeliveryDateRc" AssociatedControlID="txtDeliveryDate" />
                                                                                    <asp:TextBox ID="txtDeliveryDate"
                                                                                                Width="98.5%"
                                                                                                runat="server"
                                                                                                ForeColor="#0094FF"
                                                                                                BackColor="#FCF5D8"
                                                                                                CssClass="form-control"
                                                                                                meta:resourcekey="txtDeliveryDateRc" />
                                                                                    <span class="input-group-btn add-on">
                                                                                        <button id="btnDeliveryDate"
                                                                                                runat="server"
                                                                                                class="btn btn-danger"
                                                                                                style="margin-left: -30px; height: 35px"
                                                                                                type="button">
                                                                                            <i class="fa fa-calendar"></i>
                                                                                        </button>
                                                                                    </span>
                                                                                    <asp:RequiredFieldValidator ID="rfvDeliveryDate"
                                                                                                                runat="server"
                                                                                                                ValidationGroup="vsAddTicketGroup"
                                                                                                                ControlToValidate="txtDeliveryDate"
                                                                                                                ForeColor="Red"
                                                                                                                Display="Dynamic"
                                                                                                                meta:resourcekey="txtDeliveryDateRc"
                                                                                                                Enabled="false" />
                                                                                    <ajaxToolkit:CalendarExtender
                                                                                                                runat="server"
                                                                                                                TargetControlID="txtDeliveryDate"
                                                                                                                PopupButtonID="btnDeliveryDate"
                                                                                                                Format="d/MM/yyyy" BehaviorID="" />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </asp:Panel>
                                                                </section>
                                                            </div>
                                                            <div class="col-lg-4 col-md-4 col-xs-12">
                                                                <section class="panel" style="border: solid 1px #d0efde">
                                                                    <header class="panel-heading">
                                                                        <b>
                                                                            <asp:Label ID="lblAssignmentTo" runat="server" meta:resourcekey="lblAssignmentToRc" /></b>
                                                                    </header>
                                                                    <asp:Panel runat="server" class="panel-body" Style="padding-bottom: 0px" DefaultButton="btnCreate">
                                                                        <div class="panel-body" style="overflow-x: auto; height: 125px;">
                                                                                <asp:GridView ID="assignmentToGridView"
                                                                                            runat="server"
                                                                                            AutoGenerateColumns="false"
                                                                                            CssClass="table table-striped table-advance table-hover"
                                                                                            Width="100%"
                                                                                            GridLines="None"
                                                                                            AllowPaging="true"
                                                                                            ShowHeader="true"
                                                                                            ShowHeaderWhenEmpty="false"
                                                                                            OnPageIndexChanging="assignmentToGridView_PageIndexChanging"
                                                                                            OnRowDataBound="assignmentToGridView_RowDataBound"
                                                                                            PageSize="5">
                                                                                <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                                                <Columns>
                                                                                    <asp:TemplateField ItemStyle-Width="2%" meta:resourcekey="assignmentToGridView_AssignToIDRc" Visible="false">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblAssignmentToGridView_AssignToID"
                                                                                                        runat="server" />
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField ItemStyle-Width="5%" meta:resourcekey="assignmentToGridView_ChkIsSelectedRc">
                                                                                        <ItemTemplate>
                                                                                            <asp:CheckBox ID="chkIsSelectedGrid"
                                                                                                            runat="server" />
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="assignmentToGridView_FirstNameRc">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblAssignmentToGridView_FirstName"
                                                                                                        runat="server" />
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="assignmentToGridView_LastNameRc">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblAssignmentToGridView_LastName"
                                                                                                        runat="server" />
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
                                                            <div class="col-lg-12 col-md-12 col-xs-12">
                                                                <section class="panel" style="border: solid 1px #d0efde">
                                                                    <header class="panel-heading">
                                                                        <b>
                                                                            <asp:Label ID="lblDetailHeader" runat="server" meta:resourcekey="lblDetailHeaderRc" /></b>
                                                                    </header>
                                                                    <asp:Panel runat="server" class="panel-body" Style="padding-bottom: 0px" DefaultButton="">
                                                                        <div class="row">
                                                                            <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px;">
                                                                                <div class="form-group" style="width: 100%; float: left">
                                                                                    <ajaxToolkit:HtmlEditorExtender ID="txtDetailExtender" runat="server" TargetControlID="txtDetail">
                                                                                        <Toolbar>
                                                                                            <ajaxToolkit:Undo />
                                                                                            <ajaxToolkit:Redo />
                                                                                            <ajaxToolkit:Bold />
                                                                                            <ajaxToolkit:Italic />
                                                                                            <ajaxToolkit:Underline />
                                                                                            <ajaxToolkit:StrikeThrough />
                                                                                            <ajaxToolkit:Subscript />
                                                                                            <ajaxToolkit:Superscript />
                                                                                            <ajaxToolkit:JustifyLeft />
                                                                                            <ajaxToolkit:JustifyCenter />
                                                                                            <ajaxToolkit:JustifyRight />
                                                                                            <ajaxToolkit:JustifyFull />
                                                                                            <ajaxToolkit:InsertOrderedList />
                                                                                            <ajaxToolkit:InsertUnorderedList />
                                                                                            <ajaxToolkit:CreateLink />
                                                                                            <ajaxToolkit:UnLink />
                                                                                            <ajaxToolkit:RemoveFormat />
                                                                                            <ajaxToolkit:SelectAll />
                                                                                            <ajaxToolkit:UnSelect />
                                                                                            <ajaxToolkit:Delete />
                                                                                            <ajaxToolkit:Cut />
                                                                                            <ajaxToolkit:Copy />
                                                                                            <ajaxToolkit:Paste />
                                                                                            <ajaxToolkit:BackgroundColorSelector />
                                                                                            <ajaxToolkit:ForeColorSelector />
                                                                                            <ajaxToolkit:FontNameSelector />
                                                                                            <ajaxToolkit:FontSizeSelector />
                                                                                            <ajaxToolkit:Indent />
                                                                                            <ajaxToolkit:Outdent />
                                                                                            <ajaxToolkit:InsertHorizontalRule />
                                                                                            <ajaxToolkit:HorizontalSeparator />
                                                                                            <ajaxToolkit:InsertImage />
                                                                                        </Toolbar>
                                                                                    </ajaxToolkit:HtmlEditorExtender>
                                                                                    <asp:Label ID="lblDetail" runat="server" meta:resourcekey="lblDetailRc" AssociatedControlID="txtDetail" />
                                                                                    <asp:TextBox ID="txtDetail"
                                                                                                Width="98.5%"
                                                                                                Height="200px"
                                                                                                runat="server"
                                                                                                CssClass="form-control"
                                                                                                meta:resourcekey="txtDetailRc" />
                                                                                    <asp:RequiredFieldValidator ID="rfvDetail"
                                                                                                                runat="server"
                                                                                                                ValidationGroup="vsAddTicketGroup"
                                                                                                                ControlToValidate="txtDetail"
                                                                                                                ForeColor="Red"
                                                                                                                Display="Dynamic"
                                                                                                                meta:resourcekey="txtDetailRc" />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </asp:Panel>
                                                                </section>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-4 col-md-4 col-xs-12">
                                                        <section class="panel" style="border: solid 1px #d0efde">
                                                            <header class="panel-heading">
                                                                <b>
                                                                    <asp:Label ID="lblAddImage" runat="server" meta:resourcekey="lblAddImageRc" /></b>
                                                            </header>
                                                            <%= WebUtils.getErrorMessage(this.errorMessagesForUpload) %>
                                                            <%= WebUtils.getInfoMessage(this.infoMessagesForUpload) %>
                                                            <asp:Panel runat="server" class="panel-body" Style="padding-bottom: 0px" DefaultButton="">
                                                                <div class="row panel-body" style="padding-bottom: 0">
                                                                    <div class="col-lg-6 col-md-6 col-xs-6" style="padding: 5px;">
                                                                        <div class="form-group" style="width: 100%;">
                                                                            <asp:Label ID="lblDescription" runat="server" meta:resourcekey="lblDescriptionRc" AssociatedControlID="txtDescription" />
                                                                            <asp:TextBox ID="txtDescription"
                                                                                        Width="98.5%"
                                                                                        ForeColor="#0094FF"
                                                                                        runat="server"
                                                                                        Style="padding-left: 5px"
                                                                                        CssClass="form-control"
                                                                                        meta:resourcekey="txtDescriptionRc" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row" style="padding-top: 0">
                                                                    <asp:Panel runat="server" class="panel-body" Style="padding-top: 0px; text-align: center" DefaultButton="">
                                                                        <div class="fileupload fileupload-new" data-provides="fileupload" style="margin: 10px">
                                                                            <div class="fileupload-new thumbnail">
                                                                                <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image"
                                                                                    alt=""
                                                                                    id="imgView"
                                                                                    runat="server"
                                                                                    width="400"
                                                                                    height="400" 
                                                                                    />
                                                                            </div>
                                                                            <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 100%; max-height: 350px; line-height: 20px;" ></div>
                                                                            <div>
                                                                                <span class="btn btn-white btn-file">
                                                                                    <span class="fileupload-new"><i class="fa fa-paper-clip"></i>Select image</span>
                                                                                    <span class="fileupload-exists"><i class="fa fa-undo"></i>Change</span>
                                                                                    <input type="file" class="default" id="myFile" name="myFile" />
                                                                                </span>
                                                                                <a href="#" class="btn btn-danger fileupload-exists" data-dismiss="fileupload"><i class="fa fa-trash"></i>Remove</a>
                                                                                <a href="#" class="btn btn-success fileupload-exists"
                                                                                    runat="server"
                                                                                    onserverclick="lnkUpload_ServerClick"
                                                                                    id="lnkUpload">
                                                                                    <i class="fa fa-eye"></i><%= (string)GetGlobalResourceObject("GlobalResource", "upload") %>
                                                                                </a>
                                                                            </div>
                                                                        </div>
                                                                    </asp:Panel>
                                                                </div>
                                                            </asp:Panel>
                                                        </section>
                                                        <asp:HiddenField ID="hndImgUploade" runat="server" />
                                                    </div>
                                                    <div class="col-lg-12 col-md-12 col-xs-12">
                                                        <section class="panel" style="border: solid 1px #d0efde">
                                                            <header class="panel-heading">
                                                                <b>
                                                                    <asp:Label ID="lblItemImage" runat="server" meta:resourcekey="lblItemImageRc" /></b>
                                                            </header>
                                                            <asp:Panel runat="server" class="panel-body" Style="padding-bottom: 0px" DefaultButton="">
                                                                <div class="row" style="height: 320px; overflow-x: hidden">
                                                                    <asp:Repeater ID="imageRepeater" OnItemDataBound="imageRepeater_ItemDataBound" runat="server">
                                                                        <ItemTemplate>
                                                                            <div class="col-lg-2 col-sm-12 col-xs-12" style="padding: 10px;">
                                                                                <div class="ovContainer" style="display: block;">
                                                                                    <asp:Image ID="images"
                                                                                                ImageUrl="../include/img/sample/01.jpg"
                                                                                                runat="server"
                                                                                                Style="padding: 0px; width: 100%; height: 200px;" class="image" />
                                                                                    <div class="ovBottom-left" style="background-color: rgba(25, 30, 58, 0.6); width: 100%; text-align: left; padding-left: 10px;">
                                                                                        <asp:Label ID="lblDescription" Font-Bold="true" meta:resourcekey="lblDescriptionRc" runat="server">
                                                                                        </asp:Label>
                                                                                    </div>
                                                                                    <div class="ovContainer" style="display: block; float: left; width: 100%;">
                                                                                        <asp:LinkButton ID="btnDelete"
                                                                                                        CssClass="btn btn-danger btn-sm btn-block"
                                                                                                        runat="server"
                                                                                                        CommandArgument='<%# Eval("serverImageFileName")%>'
                                                                                                        OnCommand="btnDelete_Command">
                                                                                            <i class="fa fa-trash-o"></i>
                                                                                            <asp:Label ID="lblDelete" runat="server" meta:resourcekey="lblDeleteRc" />
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
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </ItemTemplate>
                                                                    </asp:Repeater>
                                                                </div>
                                                                <div class="row">
                                                                    <%= WebUtils.getErrorMessage(this.errorMessagesForCreate) %>
                                                                    <%= WebUtils.getInfoMessage(this.infoMessagesForCreate) %>
                                                                    <div class="col-lg-2 col-md-2 col-xs-6" style="padding: 5px;">
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
                                                                    <div class="col-lg-2 col-md-2 col-xs-6" style="padding: 5px; float: right;">
                                                                        <div class="form-group" style="width: 100%; margin-top: 22px; float: left">
                                                                            <asp:LinkButton ID="btnCreate"
                                                                                            type="button"
                                                                                            class="btn btn-success btn-block"
                                                                                            runat="server"
                                                                                            OnClick="btnCreate_Click">
                                                                                <i class="fa fa-floppy-o"></i>
                                                                                <asp:Label ID="lblBtnCreate" runat="server" meta:resourcekey="lblBtnCreateRc"></asp:Label>
                                                                            </asp:LinkButton>
                                                                            <ajaxToolkit:ConfirmButtonExtender runat="server"
                                                                                                                TargetControlID="btnCreate"
                                                                                                                DisplayModalPopupID="mpe" />
                                                                            <ajaxToolkit:ModalPopupExtender ID="mpe"
                                                                                                            runat="server"
                                                                                                            PopupControlID="pnlPopup"
                                                                                                            TargetControlID="btnCreate"
                                                                                                            OkControlID="btnYes"
                                                                                                            CancelControlID="btnNo"
                                                                                                            BackgroundCssClass="modalBackground">
                                                                            </ajaxToolkit:ModalPopupExtender>
                                                                            <asp:Panel ID="pnlPopup"
                                                                                        runat="server"
                                                                                        CssClass="modalPopup"
                                                                                        Style="display: none">
                                                                                <div class="body">
                                                                                    <%= (string)GetGlobalResourceObject("GlobalResource", "confirm_saved") %>
                                                                                </div>
                                                                                <div class="footer">
                                                                                    <asp:LinkButton ID="btnYes"
                                                                                                    runat="server"
                                                                                                    CssClass="btn btn-success btn-xs">
																				                        <asp:PlaceHolder runat="server">
																					                        <i class="fa fa-check"></i> <%= (string)GetGlobalResourceObject("GlobalResource", "yes") %>
																				                        </asp:PlaceHolder>
                                                                                    </asp:LinkButton>
                                                                                    <asp:LinkButton ID="btnNo"
                                                                                                    runat="server"
                                                                                                    CssClass="btn btn-danger btn-xs">
                                                                                        <asp:PlaceHolder runat="server">
                                                                                            <i class="fa fa fa-trash-o"></i> <%= (string)GetGlobalResourceObject("GlobalResource", "no") %>
                                                                                        </asp:PlaceHolder>
                                                                                    </asp:LinkButton>
                                                                                </div>
                                                                            </asp:Panel>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </asp:Panel>
                                                        </section>
                                                    </div>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:PostBackTrigger ControlID="lnkUpload" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </div>
                                    </section>
                                </form>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </section>
    </section>
    <style>
        .ovContainer {
            position: relative;
            text-align: center;
            color: #25d5e4;
        }

        .ovBottom-left {
            position: absolute;
            bottom: 0px;
            left: 0px;
        }
    </style>
</asp:Content>
