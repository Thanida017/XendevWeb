<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="TestF023.NewRequirement.aspx.cs" 
    Inherits="XenDevWeb.Test.TestF023_NewRequirement" 
    MaintainScrollPositionOnPostback="true"
    MasterPageFile="~/include/master.Master" %>

<%@ Import Namespace="XenDevWeb.Utils" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentMainPlaceHolder" runat="Server">
    <head runat="server">
        <style>
            .ajax__html_editor_extender_texteditor
            {
                background-color:#FAF4AB;
                color:#0094ff;
            }
        </style>
       
    </head>
      <link rel="stylesheet" href="<%= WebUtils.getAppServerPath() %>/include/drawflow/dist/drawflow.min.css" />
      <script src="<%= WebUtils.getAppServerPath() %>/include/drawflow/dist/drawflow.min.js"></script>
      <script src="<%= WebUtils.getAppServerPath() %>/include/drawflow/src/all.min.js" ></script>
      <link rel="stylesheet" href="<%= WebUtils.getAppServerPath() %>/include/drawflow/src/all.min.css" />
      <link rel="stylesheet" type="text/css" href="<%= WebUtils.getAppServerPath() %>/include/drawflow/src/drawflow.css" />
      <%--<link rel="stylesheet" type="text/css" href="<%= WebUtils.getAppServerPath() %>/include/drawflow/docs/beautiful.css" />--%>  
      <link href="<%= WebUtils.getAppServerPath() %>/include/drawflow/src/css2.css" rel="stylesheet">
      <script src="<%= WebUtils.getAppServerPath() %>/include/drawflow/src/sweetalert2@9.js"></script>
      <script src="<%= WebUtils.getAppServerPath() %>/include/drawflow/src/micromodal.min.js"></script>
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-xs-12">
                    <section class="panel">
                        <header class="panel-heading tab-bg-dark-navy-blue tab-right ">
                            <span class="hidden-sm wht-color">
                                <strong>
                                    <asp:Label ID="lblNewRequirements" runat="server" meta:resourcekey="lblNewRequirementsRc" />
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
                                            <%--<%= WebUtils.getErrorMessage(this.errorMessagesForGrid) %>
                                            <%= WebUtils.getInfoMessage(this.infoMessagesForGrid) %>--%>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b>
                                                        <asp:Label ID="lblNewRequirementsHeader" runat="server" meta:resourcekey="lblNewRequirementsRc" />
                                                    </b>
                                                </header>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="">
                                                    <div class="row">
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProjectRc" AssociatedControlID="selProject" />
                                                                <asp:DropDownList CssClass="form-control"
                                                                                    ID="selProject"
                                                                                    Style="color: #0094ff"
                                                                                    AutoPostBack="true"
                                                                                    OnSelectedIndexChanged="selProject_SelectedIndexChanged"
                                                                                    runat="server">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblMeetingNote" runat="server" meta:resourcekey="lblMeetingNoteRc" AssociatedControlID="selMeetingNote" />
                                                                <asp:DropDownList CssClass="form-control"
                                                                                    ID="selMeetingNote"
                                                                                    Style="color: #0094ff"
                                                                                    AutoPostBack="false"
                                                                                    runat="server">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblTitle" runat="server" meta:resourcekey="lblTitleRc" AssociatedControlID="txtTitle" />
                                                                <asp:TextBox ID="txtTitle"
                                                                            Width="98.5%"
                                                                            runat="server"
                                                                            ForeColor="#0094ff"
                                                                            BackColor="#FAF4AB"
                                                                            CssClass="form-control"
                                                                            meta:resourcekey="txtTitleRc" />
                                                                <asp:RequiredFieldValidator ID="rfvTitle"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsAddRequirmentGroup"
                                                                                            ControlToValidate="txtTitle"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtTitleRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblCode" runat="server" meta:resourcekey="lblCodeRc" AssociatedControlID="txtCode" />
                                                                <asp:TextBox ID="txtCode"
                                                                            Width="98.5%"
                                                                            runat="server"
                                                                            ForeColor="#0094ff"
                                                                            BackColor="#FAF4AB"
                                                                            CssClass="form-control"
                                                                            meta:resourcekey="txtCodeRc"
                                                                            AutoPostBack="true"
                                                                            OnTextChanged="txtCode_TextChanged" />
                                                                <asp:RequiredFieldValidator ID="rfvCode"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsAddRequirmentGroup"
                                                                                            ControlToValidate="txtCode"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtCodeRc" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblRevision" runat="server" meta:resourcekey="lblRevisionRc" AssociatedControlID="txtRevision" />
                                                                <asp:TextBox ID="txtRevision"
                                                                            Width="98.5%"
                                                                            runat="server"
                                                                            ForeColor="#0094ff"
                                                                            BackColor="#FAF4AB"
                                                                            CssClass="form-control"
                                                                            meta:resourcekey="txtRevisionRc" />
                                                                <asp:RequiredFieldValidator ID="rfvRevision"
                                                                                            runat="server"
                                                                                            ValidationGroup="vsAddRequirmentGroup"
                                                                                            ControlToValidate="txtRevision"
                                                                                            ForeColor="Red"
                                                                                            Display="Dynamic"
                                                                                            meta:resourcekey="txtRevisionRc" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <ajaxToolkit:HtmlEditorExtender ID="txtDescriptionExtender" runat="server" TargetControlID="txtDescription">
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
                                                                <asp:Label ID="lblDescription" runat="server" meta:resourcekey="lblDescriptionRc" AssociatedControlID="txtDescription" />
                                                                <asp:TextBox ID="txtDescription"
                                                                                Width="98.5%"
                                                                                Height="200px"
                                                                                runat="server"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtDescriptionRc" />
                                                                <asp:RequiredFieldValidator ID="rfvDescription"
                                                                                runat="server"
                                                                                ValidationGroup="vsAddRequirmentGroup"
                                                                                ControlToValidate="txtDescription"
                                                                                ForeColor="Red"
                                                                                Display="Dynamic"
                                                                                meta:resourcekey="txtDescriptionRc" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%--<div class="row">
                                                        <div class="col-lg-2 col-md-6 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="margin-right: 0.5%; margin-left: 10px; float: left; margin-top: 23px">
                                                                <asp:LinkButton ID="btnSave"
                                                                                type="button"
                                                                                style = "font-family: Roboto;
                                                                                            font-weight: 500;
                                                                                            font-size: 14px;
                                                                                            color: #FFF;
                                                                                            background-color: #1aca74;
                                                                                            border: 1px solid #1aca74;
                                                                                            border-radius: 5px;
                                                                                            width: 143px;
                                                                                            height: 38px;
                                                                                            margin-left: 10px;
                                                                                            display: inline-block;
                                                                                            vertical-align: top;
                                                                                            text-align: center;
                                                                                            line-height: 38px;
                                                                                            margin-right: 20px;
                                                                                            transition: all .2s cubic-bezier(.05,.03,.35,1);"
                                                                                runat="server"
                                                                                OnClick="btnSave_Click">
                                                                    <i class="fa fa-plus"></i>
                                                                    <asp:Label ID="lblBtnSave" runat="server" meta:resourcekey="lblBtnSaveRc" />
                                                                </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-6 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="margin-right: 0.5%; margin-left: 10px; float: left; margin-top: 23px">
                                                                <asp:LinkButton ID="btnShow"
                                                                                type="button"
                                                                                style = "font-family: Roboto;
                                                                                font-weight: 500;
                                                                                font-size: 14px;
                                                                                color: #FFF;
                                                                                background-color: #217CE8;
                                                                                border-radius: 5px;
                                                                                width: 143px;
                                                                                height: 38px;
                                                                                margin-left: 10px;
                                                                                display: inline-block;
                                                                                vertical-align: top;
                                                                                text-align: center;
                                                                                line-height: 38px;
                                                                                margin-right: 20px;
                                                                                transition: all .2s cubic-bezier(.05,.03,.35,1);"
                                                                                runat="server"
                                                                                OnClick="btnShow_Click">
                                                                    <i class="fa fa-plus"></i>
                                                                    <asp:Label ID="lblBtnShow" runat="server" meta:resourcekey="lblBtnShowRc" />
                                                                </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </div>--%>
                                                </asp:Panel>
                                            </section>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b>
                                                        <asp:Label ID="lblDrawFlow" runat="server" meta:resourcekey="lblDrawFlowRc" />
                                                    </b>
                                                </header>
                                                <div class="panel-body" style="overflow-x: auto; width: 100%">
                                                    <div class="row">
                                                        <div class="col-lg-3 col-md-4 col-xs-12" style="border-right: 1px solid #cacaca;">
                                                            <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px;">
                                                                <div class="form-group" style="width: 100%; float: left">
                                                                    <asp:Label ID="lblDrawFlowSelectNode" runat="server" meta:resourcekey="lblDrawFlowSelectNodeRc" />
                                                                    <%--<asp:DropDownList CssClass="form-control"
                                                                                        ID="selDrawFlowSelectNode"
                                                                                        Style="color: #0094ff"
                                                                                        AutoPostBack="false"
                                                                                        runat="server">
                                                                    </asp:DropDownList>--%>
                                                                    <select id="selDrawFlowSelectNode" style="width: 90%; margin: 10px; border-radius: 10px; padding: 10px;">
                                                                        <option value="style_header_only">Style header only</option>
                                                                        <option value="style_header_and_body_label">Style header and body label</option>
                                                                        <option value="style_with_one_text_box">Style with one text box</option>
                                                                        <option value="style_with_two_textbox">Style with two textbox</option>
                                                                        <option value="style_double_click">Style double click</option>
                                                                        <option value="style_personalized">Style personalized</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px;">
                                                                <div class="form-group" style="width: 100%; float: left">
                                                                    <asp:Label ID="lblDrawFlowTitle" runat="server" meta:resourcekey="lblDrawFlowTitleRc" AssociatedControlID="txtDrawFlowTitle" />
                                                                    <asp:TextBox ID="txtDrawFlowTitle"
                                                                                Width="98.5%"
                                                                                runat="server"
                                                                                ForeColor="#0094ff"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtDrawFlowTitleRc"/>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px;">
                                                                <div class="form-group" style="width: 100%; float: left">
                                                                    <asp:Label ID="lblDrawFlowText" runat="server" meta:resourcekey="lblDrawFlowTextRc" AssociatedControlID="txtDrawFlowText" />
                                                                    <asp:TextBox ID="txtDrawFlowText"
                                                                                Width="98.5%"
                                                                                runat="server"
                                                                                ForeColor="#0094ff"
                                                                                CssClass="form-control"
                                                                                meta:resourcekey="txtDrawFlowTextRc"/>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px;">
                                                                <div class="form-group" style="width: 100%; float: left">
                                                                    <asp:Label ID="lblDrawFlowPortLeft" runat="server" meta:resourcekey="lblDrawFlowPortLeftRc" AssociatedControlID="txtDrawFlowPortLeft" />
                                                                    <asp:TextBox ID="txtDrawFlowPortLeft"
                                                                                Width="98.5%"
                                                                                runat="server"
                                                                                ForeColor="#0094ff"
                                                                                CssClass="form-control"
                                                                                TextMode="Number"
                                                                                min="0"
                                                                                meta:resourcekey="txtDrawFlowPortLeftRc"/>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px;">
                                                                <div class="form-group" style="width: 100%; float: left">
                                                                    <asp:Label ID="lblDrawFlowPortRight" runat="server" meta:resourcekey="lblDrawFlowPortRightRc" AssociatedControlID="txtDrawFlowPortRight" />
                                                                    <asp:TextBox ID="txtDrawFlowPortRight"
                                                                                Width="98.5%"
                                                                                runat="server"
                                                                                ForeColor="#0094ff"
                                                                                CssClass="form-control"
                                                                                TextMode="Number"
                                                                                min="0"
                                                                                meta:resourcekey="txtDrawFlowPortRightRc"/>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px; margin-bottom:30px;">
                                                                <%--<div class="form-group" style="width: 100%; margin-top: 22px; float: left">
                                                                    <asp:LinkButton ID="btnSetNode"
                                                                                    type="button"
                                                                                    class="btn btn-warning btn-block"
                                                                                    runat="server"
                                                                                    OnClick="btnSetNode_Click">
                                                                        <asp:Label ID="lblBtnSetNode" runat="server" meta:resourcekey="lblBtnSetNodeRc"></asp:Label>
                                                                    </asp:LinkButton>
                                                                </div>--%>
                                                                <button onclick="setNode()"
                                                                    style="font-family: Roboto; font-weight: 500; font-size: 14px; color: #FFF; background-color: #8bc34a; border: 1px solid #8bc34a; border-radius: 5px; width: 90%; height: 38px; margin-left: 10px; display: inline-block; vertical-align: top; text-align: center; line-height: 38px; margin-right: 20px; transition: all .2s cubic-bezier(.05,.03,.35,1);">
                                                                    <asp:Label ID="lblBtnSetNode" runat="server" meta:resourcekey="lblBtnSetNodeRc"></asp:Label>
                                                                </button>
                                                            </div>
                                                            <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px;">
                                                                <div class="form-group" style="width: 100%; margin-top: 22px; float: left">
                                                                    <asp:LinkButton ID="btnCreate"
                                                                                    type="button"
                                                                                    class="btn btn-success btn-block"
                                                                                    runat="server"
                                                                                    OnClick="btnCreate_Click">
                                                                        <asp:Label ID="lblCreate" runat="server" meta:resourcekey="lblBtnCreateRc"></asp:Label>
                                                                    </asp:LinkButton>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-9 col-md-7 col-xs-12">
                                                            <%--<div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px;">
                                                                <ul class="nav nav-tabs">
                                                                    <li class="active">
                                                                        <a data-toggle="tab" href="#home">
                                                                            <asp:Label ID="lblHome" runat="server" meta:resourcekey="lblHomeRc" />
                                                                        </a>
                                                                    </li>
                                                                    <li>
                                                                        <a data-toggle="tab" href="#menu1">
                                                                            <asp:Label ID="lblOtherModule" runat="server" meta:resourcekey="lblOtherModuleRc" />
                                                                        </a>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                            <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px;">
                                                                    <div class="form-group" style="margin-right: 0.5%; margin-left: 10px; float:right;">
                                                                        <asp:LinkButton ID="btnClear"
                                                                                        type="button"
                                                                                        class="btn btn-info"
                                                                                        runat="server"
                                                                                        OnClick="btnClear_Click">
                                                                            <asp:Label ID="lblClear" runat="server" meta:resourcekey="lblClearRc" />
                                                                        </asp:LinkButton>
                                                                    </div>
                                                                </div>
                                                            <div class="col-lg-12 col-md-12 col-xs-12" id="drawflow" ondrop="drop(event)" ondragover="allowDrop(event)">
                                                                
                                                            </div>
                                                            <div class="col-lg-12 col-md-12 col-xs-12" style="padding: 5px; align-content:flex-end">
                                                                    <div class="btn-lock">
                                                                        <i id="lock" class="fas fa-lock" onclick="editor.editor_mode='fixed'; changeMode('lock');"></i>
                                                                        <i id="unlock" class="fas fa-lock-open" onclick="editor.editor_mode='edit'; changeMode('unlock');" style="display: none;"></i>
                                                                    </div>
                                                                    <div class="bar-zoom">
                                                                        <i class="fas fa-search-minus" onclick="editor.zoom_out()"></i>
                                                                        <i class="fas fa-search" onclick="editor.zoom_reset()"></i>
                                                                        <i class="fas fa-search-plus" onclick="editor.zoom_in()"></i>
                                                                    </div>
                                                                </div>--%>
                                                            <div class="menu">
                                                                <ul>
                                                                    <li onclick="editor.changeModule('Home'); changeModule(event);" class="selected">Home</li>
                                                                    <li onclick="editor.changeModule('Other'); changeModule(event);">Other Module</li>
                                                                </ul>
                                                            </div>
                                                            <div id="drawflow" ondrop="drop(event)" ondragover="allowDrop(event)">

                                                                <div class="btn-export" onclick="Swal.fire({ title: 'Export',html: '<pre><code>'+JSON.stringify(editor.export(), null,4)+'</code></pre>'})">Export</div>
                                                                <div class="btn-clear" onclick="editor.clearModuleSelected()">Clear</div>
                                                                <div class="btn-lock">
                                                                    <i id="lock" class="fas fa-lock" onclick="editor.editor_mode='fixed'; changeMode('lock');"></i>
                                                                    <i id="unlock" class="fas fa-lock-open" onclick="editor.editor_mode='edit'; changeMode('unlock');" style="display: none;"></i>
                                                                </div>
                                                                <div class="bar-zoom">
                                                                    <i class="fas fa-search-minus" onclick="editor.zoom_out()"></i>
                                                                    <i class="fas fa-search" onclick="editor.zoom_reset()"></i>
                                                                    <i class="fas fa-search-plus" onclick="editor.zoom_in()"></i>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </section>
                                            <div class="row">
                                                <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                    <%--<div class="form-group" style="margin-right: 0.5%; margin-left: 10px; float: left; margin-top: 23px">
                                                        <asp:LinkButton ID="btnAddNew"
                                                            type="button"
                                                            class="btn btn-info"
                                                            runat="server"
                                                            OnClick="btnAddNew_Click">
                                                            <i class="fa fa-plus"></i>
                                                            <asp:Label ID="lblAddNew" runat="server" meta:resourcekey="lblAddNewRc" />
                                                        </asp:LinkButton>
                                                    </div>--%>
                                                </div>
                                            </div>
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
    <script>

        var id = document.getElementById("drawflow");
        const editor = new Drawflow(id);
        editor.reroute = true;
        editor.reroute_fix_curvature = true;
        editor.force_first_input = false;

        const dataToImport = {
            "drawflow": {
                "Home": {
                    "data": {}
                },
                "Other": {
                    "data": {}
                }
            }
        };
        console.log(dataToImport)
        editor.start();
        editor.import(dataToImport);

        // Events!
        editor.on('nodeCreated', function (id) {
            console.log("Node created " + id);
        })

        editor.on('nodeRemoved', function (id) {
            console.log("Node removed " + id);
        })

        editor.on('nodeSelected', function (id) {
            console.log("Node selected " + id);
        })

        editor.on('moduleCreated', function (name) {
            console.log("Module Created " + name);
        })

        editor.on('moduleChanged', function (name) {
            console.log("Module Changed " + name);
        })

        editor.on('connectionCreated', function (connection) {
            console.log('Connection created');
            console.log(connection);
        })

        editor.on('connectionRemoved', function (connection) {
            console.log('Connection removed');
            console.log(connection);
        })
        /*
            editor.on('mouseMove', function(position) {
              console.log('Position mouse x:' + position.x + ' y:'+ position.y);
            })
        */
        editor.on('nodeMoved', function (id) {
            console.log("Node moved " + id);
        })

        editor.on('zoom', function (zoom) {
            console.log('Zoom level ' + zoom);
        })

        editor.on('translate', function (position) {
            console.log('Translate x:' + position.x + ' y:' + position.y);
        })

        editor.on('addReroute', function (id) {
            console.log("Reroute added " + id);
        })

        editor.on('removeReroute', function (id) {
            console.log("Reroute removed " + id);
        })
        /* DRAG EVENT */

        /* Mouse and Touch Actions */

        var elements = document.getElementsByClassName('drag-drawflow');
        for (var i = 0; i < elements.length; i++) {
            elements[i].addEventListener('touchend', drop, false);
            elements[i].addEventListener('touchmove', positionMobile, false);
            elements[i].addEventListener('touchstart', drag, false);
        }

        var mobile_item_selec = '';
        var mobile_last_move = null;
        function positionMobile(ev) {
            mobile_last_move = ev;
        }

        function allowDrop(ev) {
            ev.preventDefault();
        }

        function drag(ev) {
            if (ev.type === "touchstart") {
                mobile_item_selec = ev.target.closest(".drag-drawflow").getAttribute('data-node');
            } else {
                ev.dataTransfer.setData("node", ev.target.getAttribute('data-node'));
            }
        }

        function drop(ev) {
            if (ev.type === "touchend") {
                var parentdrawflow = document.elementFromPoint(mobile_last_move.touches[0].clientX, mobile_last_move.touches[0].clientY).closest("#drawflow");
                if (parentdrawflow != null) {
                    addNodeToDrawFlow(mobile_item_selec, mobile_last_move.touches[0].clientX, mobile_last_move.touches[0].clientY);
                }
                mobile_item_selec = '';
            } else {
                ev.preventDefault();
                var data = ev.dataTransfer.getData("node");
                addNodeToDrawFlow(data, ev.clientX, ev.clientY);
            }

        }

        function addNodeToDrawFlow(name, pos_x, pos_y) {
            if (editor.editor_mode === 'fixed') {
                return false;
            }
            pos_x = pos_x * (editor.precanvas.clientWidth / (editor.precanvas.clientWidth * editor.zoom)) - (editor.precanvas.getBoundingClientRect().x * (editor.precanvas.clientWidth / (editor.precanvas.clientWidth * editor.zoom)));
            pos_y = pos_y * (editor.precanvas.clientHeight / (editor.precanvas.clientHeight * editor.zoom)) - (editor.precanvas.getBoundingClientRect().y * (editor.precanvas.clientHeight / (editor.precanvas.clientHeight * editor.zoom)));


            switch (name) {
                case 'facebook':
                    var facebook = `
        <div>
          <div class="title-box"><i class="fab fa-facebook"></i> Facebook Message</div>
        </div>
        `;
                    editor.addNode('facebook', 0, 1, pos_x, pos_y, 'facebook', {}, facebook);
                    break;
                case 'slack':
                    var slackchat = `
          <div>
            <div class="title-box"><i class="fab fa-slack"></i> Slack chat message</div>
          </div>
          `
                    editor.addNode('slack', 1, 0, pos_x, pos_y, 'slack', {}, slackchat);
                    break;
                case 'github':
                    var githubtemplate = `
          <div>
            <div class="title-box"><i class="fab fa-github "></i> Github Stars</div>
            <div class="box">
              <p>Enter repository url</p>
            <input type="text" df-name>
            </div>
          </div>
          `;
                    editor.addNode('github', 0, 1, pos_x, pos_y, 'github', { "name": '' }, githubtemplate);
                    break;
                case 'telegram':
                    var telegrambot = `
          <div>
            <div class="title-box"><i class="fab fa-telegram-plane"></i> Telegram bot</div>
            <div class="box">
              <p>Send to telegram</p>
              <p>select channel</p>
              <select df-channel>
                <option value="channel_1">Channel 1</option>
                <option value="channel_2">Channel 2</option>
                <option value="channel_3">Channel 3</option>
                <option value="channel_4">Channel 4</option>
              </select>
            </div>
          </div>
          `;
                    editor.addNode('telegram', 1, 0, pos_x, pos_y, 'telegram', { "channel": 'channel_3' }, telegrambot);
                    break;
                case 'aws':
                    var aws = `
          <div>
            <div class="title-box"><i class="fab fa-aws"></i> Aws Save </div>
            <div class="box">
              <p>Save in aws</p>
              <input type="text" df-db-dbname placeholder="DB name"><br><br>
              <input type="text" df-db-key placeholder="DB key">
              <p>Output Log</p>
            </div>
          </div>
          `;
                    editor.addNode('aws', 1, 1, pos_x, pos_y, 'aws', { "db": { "dbname": '', "key": '' } }, aws);
                    break;
                case 'log':
                    var log = `
            <div>
              <div class="title-box"><i class="fas fa-file-signature"></i> Save log file </div>
            </div>
            `;
                    editor.addNode('log', 1, 0, pos_x, pos_y, 'log', {}, log);
                    break;
                case 'google':
                    var google = `
            <div>
              <div class="title-box"><i class="fab fa-google-drive"></i> Google Drive save </div>
            </div>
            `;
                    editor.addNode('google', 1, 0, pos_x, pos_y, 'google', {}, google);
                    break;
                case 'email':
                    var email = `
            <div>
              <div class="title-box"><i class="fas fa-at"></i> Send Email </div>
            </div>
            `;
                    editor.addNode('email', 1, 0, pos_x, pos_y, 'email', {}, email);
                    break;

                case 'template':
                    var template = `
            <div>
              <div class="title-box"><i class="fas fa-code"></i> Template</div>
              <div class="box">
                Ger Vars
                <textarea df-template></textarea>
                Output template with vars
              </div>
            </div>
            `;
                    editor.addNode('template', 1, 1, pos_x, pos_y, 'template', { "template": 'Write your template' }, template);
                    break;
                case 'multiple':
                    var multiple = `
            <div>
              <div class="box">
                Multiple!
              </div>
            </div>
            `;
                    editor.addNode('multiple', 3, 4, pos_x, pos_y, 'multiple', {}, multiple);
                    break;
                case 'personalized':
                    var personalized = `
            <div>
              Personalized
            </div>
            `;
                    editor.addNode('personalized', 1, 1, pos_x, pos_y, 'personalized', {}, personalized);
                    break;
                case 'dbclick':
                    var dbclick = `
            <div>
            <div class="title-box"><i class="fas fa-mouse"></i> Db Click</div>
              <div class="box dbclickbox" ondblclick="showpopup(event)">
                Db Click here
                <div class="modal" style="display:none">
                  <div class="modal-content">
                    <span class="close" onclick="closemodal(event)">&times;</span>
                    Change your variable {name} !
                    <input type="text" df-name>
                  </div>

                </div>
              </div>
            </div>
            `;
                    editor.addNode('dbclick', 1, 1, pos_x, pos_y, 'dbclick', { name: '' }, dbclick);
                    break;

                default:
            }
        }

        var transform = '';
        function showpopup(e) {
            e.target.closest(".drawflow-node").style.zIndex = "9999";
            e.target.children[0].style.display = "block";
            //document.getElementById("modalfix").style.display = "block";

            //e.target.children[0].style.transform = 'translate('+translate.x+'px, '+translate.y+'px)';
            transform = editor.precanvas.style.transform;
            editor.precanvas.style.transform = '';
            editor.precanvas.style.left = editor.canvas_x + 'px';
            editor.precanvas.style.top = editor.canvas_y + 'px';
            console.log(transform);

            //e.target.children[0].style.top  =  -editor.canvas_y - editor.container.offsetTop +'px';
            //e.target.children[0].style.left  =  -editor.canvas_x  - editor.container.offsetLeft +'px';
            editor.editor_mode = "fixed";

        }

        function closemodal(e) {
            e.target.closest(".drawflow-node").style.zIndex = "2";
            e.target.parentElement.parentElement.style.display = "none";
            //document.getElementById("modalfix").style.display = "none";
            editor.precanvas.style.transform = transform;
            editor.precanvas.style.left = '0px';
            editor.precanvas.style.top = '0px';
            editor.editor_mode = "edit";
        }

        function changeModule(event) {
            var all = document.querySelectorAll(".menu ul li");
            for (var i = 0; i < all.length; i++) {
                all[i].classList.remove('selected');
            }
            event.target.classList.add('selected');
        }

        function changeMode(option) {

            //console.log(lock.id);
            if (option == 'lock') {
                lock.style.display = 'none';
                unlock.style.display = 'block';
            } else {
                lock.style.display = 'block';
                unlock.style.display = 'none';
            }

        }

        <%--function saveJson() {
            var dataJson = JSON.stringify(editor.export());
            console.log(dataJson)
            document.getElementById("<%= hndJson.ClientID %>").value = dataJson;
        __doPostBack("<%= hndJson.ClientID %>");
    }--%>

    function showGraph(dataJson) {
        editor.clear();
        editor.import(dataJson);
    }

    function setNode() {
        var title = document.getElementById("<%= txtDrawFlowTitle.ClientID %>").value;
        var text = document.getElementById("<%= txtDrawFlowText.ClientID %>").value;
        var portLeft = document.getElementById("<%= txtDrawFlowPortLeft.ClientID %>").value;
        var portRight = document.getElementById("<%= txtDrawFlowPortRight.ClientID %>").value;
        var selNode = document.getElementById("selDrawFlowSelectNode").value;
        var x = (-1 * editor.canvas_x) + window.innerWidth / 2.5;
        var y = (-1 * editor.canvas_y) + window.innerHeight / 2.5;

        console.log("editor : " + editor.canvas_x)

        switch (selNode) {
            case 'style_header_only':
                var headerOnly = `<div>
                                      <div class ="title-box"> ${title}</div>
                                  </div>`;
                editor.addNode('headerOnly', portLeft, portRight, x, y, 'headerOnly', {}, headerOnly);
                break;
            case 'style_header_and_body_label':
                var style_header_and_body_label = `<div>
                                                      <div class ="title-box"> ${title}</div>
                                                       <div class ="box">
                                                            ${text}
                                                       </div>
                                                    </div>`;
                editor.addNode('style_header_and_body_label', portLeft, portRight, x, y, 'style_header_and_body_label', {}, style_header_and_body_label);
                break;
            case 'style_with_one_text_box':
                var style_with_one_text_box = `<div>
                                              <div class ="title-box"> ${title}</div>
                                              <div class="box">
                                                Ger Vars
                                                <textarea df-template></textarea>
                                                Output template with vars
                                              </div>
                                            </div>`;
                editor.addNode('style_with_one_text_box', portLeft, portRight, x, y, 'style_with_one_text_box', { "template": text }, style_with_one_text_box);
                break;
            case 'style_with_two_textbox':
                var style_with_two_textbox = `   <div>
                                <div class ="title-box"> ${title} </div>
                                <div class="box">
                                  <p>Save in aws</p>
                                  <input type="text" df-db-dbname placeholder="DB name"><br><br>
                                  <input type="text" df-db-key placeholder="DB key">
                                  <p>Output Log</p>
                                </div>
                              </div>
                              `;
                editor.addNode('style_with_two_textbox', portLeft, portRight, x, y, 'style_with_two_textbox', { "db": { "dbname": title, "key": text } }, style_with_two_textbox);
                break;
            case 'style_double_click':
                var style_double_click = `
                                    <div>
                                    <div class ="title-box"> ${title}</div>
                                      <div class="box dbclickbox" ondblclick="showpopup(event)">
                                        Db Click here
                                        <div class="modal" style="display:none">
                                          <div class="modal-content">
                                            <span class="close" onclick="closemodal(event)">&times;</span>
                                            Change your variable {name} !
                                            <input type="text" df-name>
                                          </div>

                                        </div>
                                      </div>
                                    </div>
                                    `;
                editor.addNode('style_double_click', portLeft, portRight, x, y, 'style_double_click', { name: text }, style_double_click);
                break;
            case 'style_personalized':
                var style_personalized = `<div>
                                      ${title}
                                    </div>
                                    `;
                editor.addNode('personalized', portLeft, portRight, x, y, 'personalized', {}, style_personalized);
                break;
        }
    }
    </script>
</asp:Content>
