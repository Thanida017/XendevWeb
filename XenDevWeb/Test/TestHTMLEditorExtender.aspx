<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="TestHTMLEditorExtender.aspx.cs" 
    Inherits="XenDevWeb.Test.TestHTMLEditorExtender" 
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
                                                                    <asp:Panel runat="server" class="panel-body" Style="padding-bottom: 0px" DefaultButton="">
                                                                        <div class="row">
                                                                            <div class="col-lg-3 col-md-6 col-xs-12" style="padding: 5px;">
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
                                                                            <div class="col-lg-3 col-md-6 col-xs-12" style="padding: 5px;">
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
                                                                            <div class="col-lg-3 col-md-6 col-xs-12" style="padding: 5px;">
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
                                                                        </div>
                                                                    </asp:Panel>
                                                                </section>
                                                            </div>
                                                            <div class="col-lg-4 col-md-4 col-xs-12">
                                                                <section class="panel" style="border: solid 1px #d0efde">
                                                                    <header class="panel-heading">
                                                                        <b><asp:Label ID="lblAssignmentTo" runat="server" meta:resourcekey="lblAssignmentToRc" /></b>
                                                                    </header>
                                                                    <asp:Panel runat="server" class="panel-body" Style="padding-bottom: 0px" DefaultButton="">
                                                                        <asp:GridView ID="assignmentToGridView"
                                                                                        runat="server"
                                                                                        AutoGenerateColumns="false"
                                                                                        CssClass="table table-striped table-advance table-hover"
                                                                                        Width="100%"
                                                                                        GridLines="None"
                                                                                        AllowPaging="true"
                                                                                        ShowHeader="false"
                                                                                        ShowHeaderWhenEmpty="false"
                                                                                        OnPageIndexChanging="assignmentToGridView_PageIndexChanging"
                                                                                        OnRowDataBound="assignmentToGridView_RowDataBound"
                                                                                        PageSize="5">
                                                                            <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                                            <Columns>
                                                                                <asp:TemplateField ItemStyle-Width="5%" meta:resourcekey="assignmentToGridView_ChkIsSelectedRc">
                                                                                    <ItemTemplate>
                                                                                        <asp:CheckBox ID="chkIsSelectedGrid"
                                                                                                        runat="server" />
                                                                                    </ItemTemplate>
                                                                                    <EditItemTemplate>
                                                                                        <div class="checkbox" style="margin: 0">
                                                                                            <asp:CheckBox ID="chkIsSelectedGrid" runat="server" />
                                                                                        </div>
                                                                                    </EditItemTemplate>
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
                                                                    </asp:Panel>
                                                                </section>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-12 col-md-12 col-xs-12">
                                                                <section class="panel" style="border: solid 1px #d0efde">
                                                                    <header class="panel-heading">
                                                                        <b><asp:Label ID="lblDetailHeader" runat="server" meta:resourcekey="lblDetailHeaderRc" /></b>
                                                                    </header>
                                                                    <asp:Panel runat="server" class="panel-body" Style="padding-bottom: 0px" DefaultButton="">
                                                                        <ajaxToolkit:HtmlEditorExtender ID="html" runat="server" TargetControlID="txtDetail" >
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
                                                                        <div class="form-group" style="width: 100%; margin-left: 10px; float: left">
                                                                            <asp:Label ID="lblDetail" runat="server"  meta:resourcekey="lblDetailRc" AssociatedControlID="txtDetail" />
                                                                            <asp:TextBox ID="txtDetail"
                                                                                         Width="98.5%"
                                                                                         Height="200px"
                                                                                         runat="server"
                                                                                         ForeColor="#0094ff"
                                                                                         BackColor="#ffff00"
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
                                                                    </asp:Panel>
                                                                </section>
                                                                <asp:HiddenField ID="hndTkCommentId" runat="server" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>

                                            <div class="col-lg-4 col-md-4 col-xs-12">
                                                <asp:UpdatePanel ID="pnlImage" runat="server" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <section class="panel" style="border: solid 1px #d0efde">
                                                            <header class="panel-heading">
                                                                <b>
                                                                    <asp:Label ID="lblAddImage" runat="server" meta:resourcekey="lblAddImageRc" /></b>
                                                            </header>
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
                                                                                    height="400" />
                                                                            </div>
                                                                            <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 100%; max-height: 350px; line-height: 20px;"></div>
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
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:PostBackTrigger ControlID="lnkUpload" />
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                            </div>
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
</asp:Content>
