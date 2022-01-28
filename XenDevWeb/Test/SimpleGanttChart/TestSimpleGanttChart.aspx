<%@ Page Language="C#" AutoEventWireup="true"
     CodeBehind="TestSimpleGanttChart.aspx.cs"
     Inherits="XenDevWeb.Test.SimpleGanttChart.TestSimpleGanttChart" %>

<%@ Import Namespace="XenDevWeb.Utils" %>

<!DOCTYPE html>

<html runat="server">
<head >
    <title></title>
    <style>
		body {
			font-family: sans-serif;
			background: #ccc;
		}
		.container {
			width: 80%;
			margin: 0 auto;
		}
		/* custom class */
		.gantt .bar-milestone .bar {
			fill: tomato;
		}
	</style>
	<link rel="stylesheet" href="<%= WebUtils.getAppServerPath() %>/include/simpleGanttChart/frappe-gantt.css" />
	<script src="<%= WebUtils.getAppServerPath() %>/include/simpleGanttChart/frappe-gantt.js"></script>
</head>
<body>
    <form id="form1" runat="server">
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
                    <div class="row" style="padding:10px;">
                        <button onclick="saveJson()" 
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
                                        transition: all .2s cubic-bezier(.05,.03,.35,1);">Save</button>
                        <asp:LinkButton ID="btnShow" runat="server" OnClick="btnShow_Click" Text="Show"
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
                                                transition: all .2s cubic-bezier(.05,.03,.35,1);"> </asp:LinkButton>
                    </div>
                    <asp:HiddenField ID="hndJson" runat="server" OnValueChanged="hndJson_ValueChanged" />
                </ContentTemplate>
            </asp:UpdatePanel>
        <div class="container">
            <h2>Interactive Gantt </h2>
            <div class="gantt-target"></div>
        </div>
        <script>
            var tasks = [];

            function saveJson() {
                //tasks = tasks;
                 var data = "";
               
                document.getElementById("<%= hndJson.ClientID %>").value = data;
                 __doPostBack("<%= hndJson.ClientID %>");
            }

            function showGraph(dataJson) {
                tasks = dataJson;
                var gantt_chart = new Gantt(".gantt-target", tasks, {
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
                console.log(gantt_chart);
            }
		
		
	</script>
    </form>
</body>
</html>

