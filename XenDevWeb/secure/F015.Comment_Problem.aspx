<%@ Page Language="C#"
    AutoEventWireup="true"
    CodeBehind="F015.Comment_Problem.aspx.cs"
    Inherits="XenDevWeb.secure.F015_Comment_Problem"
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
                                <strong>
                                    <asp:Label ID="lblProblem" runat="server" meta:resourcekey="lblProblemRc" />
                                    <asp:Label ID="lblTicketNumber" runat="server"></asp:Label>
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
                                            <%= WebUtils.getErrorMessage(this.errorMessages) %>
                                            <%= WebUtils.getInfoMessage(this.infoMessages) %>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b>
                                                        <asp:Label ID="lblAddProblem" runat="server" meta:resourcekey="lblAddProblemRc" /></b>
                                                </header>
                                                <asp:Panel runat="server" class="panel-body" Style="padding-bottom: 0px" DefaultButton="">
                                                    <div class="col-lg-2 col-md-2 col-xs-12" id="divSelCompany" runat="server" style="padding: 5px;">
                                                        <asp:Label ID="lblProjectCode" runat="server" meta:resourcekey="lblProjectCodeRc" AssociatedControlID="txtProjectCode" />
                                                        <asp:TextBox ID="txtProjectCode"
                                                                        Width="98.5%"
                                                                        runat="server"
                                                                        ForeColor="#0094ff"
                                                                        BackColor="#FCF3CF"
                                                                        CssClass="form-control"
                                                                        meta:resourcekey="txtProjectCodeRc" />
                                                        <div id="divProjectCodeList" style="height: 100px; overflow-y: scroll;"></div>
                                                        <ajaxToolkit:AutoCompleteExtender ID="projectCode"
                                                                                            TargetControlID="txtProjectCode"
                                                                                            CompletionSetCount="999"
                                                                                            ServiceMethod="GetProjectCode"
                                                                                            ServicePath="~/WebServices/Lookup.asmx"
                                                                                            CompletionInterval="100"
                                                                                            OnClientPopulating="onExtenderLoading"
                                                                                            OnClientPopulated="onExtenderLoaded"
                                                                                            UseContextKey="true"
                                                                                            CompletionListElementID="divProjectCodeList"
                                                                                            runat="server"
                                                                                            BehaviorID="projectCode"
                                                                                            DelimiterCharacters="" />
                                                        <asp:RequiredFieldValidator ID="rfvtxtProjectCode"
                                                                                    runat="server"
                                                                                    ValidationGroup="vsAdditionGroup"
                                                                                    ControlToValidate="txtProjectCode"
                                                                                    ForeColor="Red"
                                                                                    Display="Dynamic"
                                                                                    meta:resourcekey="txtProjectCodeRc" />
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 col-xs-12" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <asp:Label ID="lblSubject" runat="server" meta:resourcekey="lblSubjectRc" AssociatedControlID="txtSubject" />
                                                            <asp:TextBox ID="txtSubject"
                                                                            Width="98.5%"
                                                                            runat="server"
                                                                            ForeColor="#0094ff"
                                                                            BackColor="#FCF3CF"
                                                                            CssClass="form-control"
                                                                            meta:resourcekey="txtSubjectRc" />
                                                            <asp:RequiredFieldValidator ID="rfvtxtSubject"
                                                                                        runat="server"
                                                                                        ValidationGroup="vsAdditionGroup"
                                                                                        ControlToValidate="txtSubject"
                                                                                        ForeColor="Red"
                                                                                        Display="Dynamic"
                                                                                        meta:resourcekey="txtSubjectRc" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; float: left">
                                                            <asp:Label ID="lblRequester" runat="server" meta:resourcekey="lblRequesterRc" AssociatedControlID="txtRequester" />
                                                            <asp:TextBox ID="txtRequester"
                                                                        Width="98.5%"
                                                                        runat="server"
                                                                        ForeColor="#0094ff"
                                                                        BackColor="#FCF3CF"
                                                                        CssClass="form-control"
                                                                        meta:resourcekey="txtRequesterRc" />
                                                            <asp:RequiredFieldValidator ID="rfvtxtRequester"
                                                                                        runat="server"
                                                                                        ValidationGroup="vsAdditionGroup"
                                                                                        ControlToValidate="txtRequester"
                                                                                        ForeColor="Red"
                                                                                        Display="Dynamic"
                                                                                        meta:resourcekey="txtRequesterRc" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px;">
                                                        <div class="form-group" style="width: 100%; margin-left: 10px; float: left">
                                                            <b>
                                                                <asp:Label ID="lblProblemDetailheader" runat="server" meta:resourcekey="lblProblemDetailRc" />
                                                            </b>
                                                            <asp:Label ID="lblProblemDetail"
                                                                        Width="98.5%"
                                                                        Height="200px"
                                                                        runat="server"
                                                                        ForeColor="#0094ff"
                                                                        BackColor="#ffff00"
                                                                        CssClass="form-control" />
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </section>
                                            <asp:HiddenField ID="hndProblemId" runat="server" />
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b>
                                                        <asp:Label ID="lblUploadnewdocument" runat="server" meta:resourcekey="lblUploadnewdocumentRc" /></b>
                                                </header>
                                                <%= WebUtils.getErrorMessage(this.errorMessagesForUpload) %>
                                                <%= WebUtils.getInfoMessage(this.infoMessagesForUpload) %>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="">
                                                    <% if (this.hasComment)
                                                        { %>
                                                    <div class="row">
                                                        <div class="panel-body">
                                                            <div class="fileupload fileupload-new" data-provides="fileupload">
                                                                <div class="form-group" style="float: left;">
                                                                    <div class="fileupload-preview fileupload-exists thumbnail"
                                                                        style="max-width: 100%; max-height: 150px; line-height: 20px; height: 35px; margin-top: 5px">
                                                                    </div>
                                                                    <span class="btn btn-white btn-file">
                                                                        <span class="fileupload-new"><i class="fa fa-paper-clip"></i>Select file</span>
                                                                        <span class="fileupload-exists"><i class="fa fa-undo"></i>Change</span>
                                                                        <input type="file" class="default" id="myFile" name="myFile" />
                                                                    </span>
                                                                    <a href="#" class="btn btn-danger fileupload-exists" data-dismiss="fileupload">
                                                                        <i class="fa fa-trash"></i>Remove
                                                                    </a>
                                                                </div>
                                                                <div class="form-group" style="width: 15%; float: left; margin-left: 10px; margin-top: 5px">
                                                                    <a href="#" class="btn btn-success fileupload-exists"
                                                                        runat="server" id="lnkUpload" onserverclick="lnkUpload_ServerClick">
                                                                        <i class="fa fa-eye"></i><%= (string)GetGlobalResourceObject("GlobalResource", "upload") %>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <% } %>
                                                    <div class="row">
                                                        <asp:Panel runat="server" class="panel-body" DefaultButton="">
                                                            <asp:GridView ID="uploadDatabaseGridView"
                                                                            runat="server"
                                                                            AutoGenerateColumns="false"
                                                                            CssClass="table table-striped table-advance  table-hover"
                                                                            Width="100%"
                                                                            GridLines="None"
                                                                            AllowPaging="true"
                                                                            ShowHeaderWhenEmpty="true"
                                                                            OnRowDataBound="uploadDatabaseGridView_RowDataBound"
                                                                            OnRowCommand="uploadDatabaseGridView_RowCommand">
                                                                <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                                <Columns>
                                                                    <asp:TemplateField ItemStyle-Width="5%" HeaderText="">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblguiKeyFileUpload" runat="server" Visible="false" />
                                                                            <asp:Label runat="server"
                                                                                Text='<%# Container.DataItemIndex + 1 %>' />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <%-- Filename Column --%>
                                                                    <asp:TemplateField ItemStyle-Width="80%" meta:resourcekey="gridFilenameRc">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton ID="lbtGridUploadedDocumentsFilename"
                                                                                            CommandArgument='<%# Eval("id") %>'
                                                                                            runat="server" 
                                                                                            CommandName="Download" Text='<%# Eval("originalFileName") %>'/>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <%-- Uploaded Documents Date --%>
                                                                    <asp:TemplateField ItemStyle-Width="20%" meta:resourcekey="gridUploadedDocumentsDateRc">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblGridUploadedDocumentsDate"
                                                                                        runat="server" 
                                                                                        Text='<%# Eval("creationDate", "{0:dd/MM/yyyy HH:mm}") %>'/>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <%-- Delete Upload document Column --%>
                                                                    <asp:TemplateField ItemStyle-Width="3%" HeaderText="">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton ID="btnDelete_document"
                                                                                            runat="server"
                                                                                            CssClass="btn btn-danger btn-xs"
                                                                                            CommandName="itemRowDelete"
                                                                                            CommandArgument='<%# Eval("id") %>'
                                                                                            OnCommand="btnDelete_document_Command">
                                                                            <asp:PlaceHolder runat="server">
                                                                                <i class="fa fa fa-trash-o"></i>
                                                                            </asp:PlaceHolder>
                                                                            </asp:LinkButton>
                                                                            <ajaxToolkit:ConfirmButtonExtender runat="server"
                                                                                                                TargetControlID="btnDelete_document"
                                                                                                                DisplayModalPopupID="mpe" />
                                                                            <ajaxToolkit:ModalPopupExtender ID="mpe"
                                                                                                            runat="server"
                                                                                                            PopupControlID="pnlPopup"
                                                                                                            TargetControlID="btnDelete_document"
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
                                                        </asp:Panel>
                                                    </div>
                                                </asp:Panel>
                                            </section>
                                            <div style="padding-bottom: 15px;">
                                                <asp:Repeater ID="ticketComment" OnItemDataBound="ticketComment_ItemDataBound" runat="server">
                                                    <ItemTemplate>
                                                        <div class="room-box">
                                                            <div class="row" style="color: #00a9b4">
                                                                <div class="col-lg-6">
                                                                    <h5>
                                                                        <u>
                                                                            <asp:Label ID="lblCommentby" runat="server" />
                                                                        </u>
                                                                    </h5>
                                                                </div>
                                                                <div class="col-lg-6" style="text-align: right">
                                                                    <u>
                                                                        <asp:Label ID="lblCreationDate" runat="server" />
                                                                    </u>
                                                                </div>
                                                            </div>
                                                            <div class="row" style="padding-left: 25px;">
                                                                <asp:Label ID="lblCommentText" runat="server" />
                                                            </div>
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </div>
                                            <asp:panel runat="server" ID="pnlComment">
                                                <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b>
                                                        <asp:Label ID="lblProgramerComment" runat="server" meta:resourcekey="lblProgramerCommentRc" /></b>
                                                </header>
                                                <%= WebUtils.getErrorMessage(this.errorMessages) %>
                                                <%= WebUtils.getInfoMessage(this.infoMessages) %>
                                                <asp:Panel runat="server" class="panel-body">
                                                    <div class="row">
                                                        <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px;">
                                                            <ajaxToolkit:HtmlEditorExtender ID="HtmlEditorExtender1" runat="server" TargetControlID="txtComment">
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
                                                                <asp:Label ID="lblComment" runat="server" meta:resourcekey="lblCommentRc" AssociatedControlID="txtComment" />
                                                                <asp:TextBox ID="txtComment"
                                                                                Width="98.5%"
                                                                                Height="100px"
                                                                                runat="server"
                                                                                ForeColor="#0094ff"
                                                                                BackColor="#ffff00"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtCommentRc" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-lg-12 col-md-12 col-xs-12" style="padding-top: 20px; float: right">
                                                            <div class="form-group" style="width: 15%; margin-left: 10px; margin-top: 22px; float: left">
                                                                <asp:LinkButton ID="btnAddComment"
                                                                                type="button"
                                                                                class="btn btn-success btn-block"
                                                                                runat="server"
                                                                                OnClick="btnAddComment_Click">
                                                                    <asp:PlaceHolder runat="server">
                                                                        <i class="fa fa-plus-square"></i>
                                                                        <asp:Label ID="lblAddComment" runat="server" meta:resourcekey="lblAddCommentRc" />
                                                                    </asp:PlaceHolder>
                                                                </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </section>
                                            </asp:panel>
                                            <div class="row">
                                                <div class="col-lg-12 col-md-12 col-xs-12" style="padding:5px;" >
                                                    <div class="form-group" style="width: 15%; margin-left: 10px; margin-top: 22px; float: left">
                                                        <asp:LinkButton ID="btnGoback"
                                                                        type="button"
                                                                        class="btn btn-warning"
                                                                        runat="server"
                                                                        OnClick="btnGoback_Click">
                                                            <asp:PlaceHolder runat="server">
                                                                <i class="fa fa-reply-all"></i>
                                                                <asp:Label ID="lblGoBack" runat="server" meta:resourcekey="lblGoBackRc" />
                                                            </asp:PlaceHolder>
                                                        </asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:PostBackTrigger ControlID="lnkUpload" />
                                            <asp:PostBackTrigger ControlID="uploadDatabaseGridView" />
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
    <script src="<%= WebUtils.getAppServerPath() %>/include/js/jquery.BlockUI.js"></script>
    <script type="text/javascript">
        $(function () {
            $('#<%= btnAddComment.ClientID %>').click(function () {
                $.blockUI({ message: '<%= (string)GetGlobalResourceObject("GlobalResource",
                "processing_pls_wait") %>' });
                console.log("btnEdit")
            });
        });

        $(function () {
            $('#<%= lnkUpload.ClientID %>').click(function () {
                $.blockUI({ message: '<%= (string)GetGlobalResourceObject("GlobalResource",
                "processing_pls_wait") %>' });
            });
        });

        function dismissBlockUI() {
            $.unblockUI();
            console.log("UnBlock")
        }
    </script>
</asp:Content>
