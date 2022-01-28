<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="F017.StaffTicketGanntChart.aspx.cs" 
    Inherits="XenDevWeb.staff.F017_StaffTicketGanntChart" 
    MaintainScrollPositionOnPostback="true"
    MasterPageFile="~/include/master.Master"
    meta:resourcekey="PageResource1" %>

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
                                <strong><asp:Label ID="lblCreateStaffAssignment" runat="server" meta:resourcekey="lblCreateStaffAssignmentRc" /></strong>
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
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="">
                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                        <ContentTemplate>
                                                    <div class="row">
                                                         <div class="col-lg-2 col-md-3 col-xs-6" style="padding:5px;">
                                                            <div class="form-group" style="width: 100%; float: left">
                                                                <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusRc" AssociatedControlID="selStatus" />
                                                                <asp:DropDownList CssClass="form-control"
                                                                                ID="selStatus"
                                                                                Style="color: #0094ff"
                                                                                AutoPostBack="false"
                                                                                runat="server">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                         <!-- Date From -->
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
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
                                                                                            ValidationGroup="vsQueryGroup"
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
                                                        <!-- Date To -->
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding:5px;">                                                        
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
                                                                                            ValidationGroup="vsQueryGroup"
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
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                            <div class="form-group" style="margin-right: 0.5%; margin-left: 10px; float: left; margin-top: 23px">
                                                                    <asp:LinkButton ID="btnQuery"
                                                                                    type="button"
                                                                                    class="btn btn-success"
                                                                                    runat="server"
                                                                                    OnClick="btnQuery_Click">
                                                                        <i class="fa fa-save"></i>
                                                                        <asp:Label ID="lblBtnQuery" runat="server" meta:resourcekey="lblBtnQueryRc"></asp:Label>
                                                                    </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </div>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                     <div class="row" id="divNiceScroll">
                                                         <div id="divGantttChart" class="gantttChart"></div>
                                                     </div>
                                                </asp:Panel>
                                            </section>
                                       
                                    <link rel="stylesheet" href="<%= WebUtils.getAppServerPath() %>/include/simpleGanttChart/frappe-gantt.css" />
	                                <script src="<%= WebUtils.getAppServerPath() %>/include/simpleGanttChart/frappe-gantt.js"></script>
                                    <script>
                                        function showGraph(dataJson) {
                                            tasks = dataJson;
                                            console.log(tasks);
                                            try {
                                                var gantt_chart = new Gantt(".gantttChart", tasks, {
                                                    on_click: function (task) {
                                                        console.log(task);
                                                    },
                                                    on_date_change: function (task, start, end) {
                                                        console.log(task, start, end);
                                                    },
                                                    on_progress_change: function (task, progress) {
                                                        console.log(task, progress);
                                                    },
                                                    on_view_change: function (mode) {
                                                        console.log(mode);
                                                    },
                                                    view_mode: 'Day',
                                                    language: 'en',
                                                });
                                            }
                                            catch (err) {
                                                document.getElementById("divGantttChart").innerHTML = "";
                                            }
                                        }
                                    </script>
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
