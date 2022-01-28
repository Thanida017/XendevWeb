<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="F016.StaffGanntChart.aspx.cs" 
    Inherits="XenDevWeb.admin.F016_StaffGanntChart"
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
                                <strong><asp:Label ID="Label1" runat="server" meta:resourcekey="lblStaffGanntChartRc" /></strong>
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
                                                                <asp:Label ID="lblStaff" runat="server" meta:resourcekey="lblStaffRc" AssociatedControlID="selStaff" />
                                                                <asp:DropDownList CssClass="form-control"
                                                                                ID="selStaff"
                                                                                Style="color: #0094ff"
                                                                                AutoPostBack="false"
                                                                                runat="server">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
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
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding:5px;">
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
                                                     <div class="row">
                                                         <div id="divGantttChart" class="gantttChart"></div>
                                                     </div>
                                                </asp:Panel>
                                            </section>
                                       
                                    <link rel="stylesheet" href="<%= WebUtils.getAppServerPath() %>/include/simpleGanttChart/frappe-gantt.css" />
	                                <script src="<%= WebUtils.getAppServerPath() %>/include/simpleGanttChart/frappe-gantt.js"></script>
                                    <script>
                                        function showGraph(dataJson) {
                                            tasks = dataJson;
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
                                                    view_mode: 'Week',
                                                    language: 'en'
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

