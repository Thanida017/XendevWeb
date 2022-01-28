<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="TestER.aspx.cs" 
    Inherits="XenDevWeb.Test.draw2d.er.TestER"
    
     %>
<%@ Import Namespace="XenDevWeb.Utils" %>
<!DOCTYPE html>

<html lang="en">
<head >
<title></title>
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="viewport" content="width=device-width, minimum-scale=1.0" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

	<link type="text/css" rel="stylesheet" href="<%= WebUtils.getAppServerPath() %>/include/er/draw2d/css/aristo/jquery-ui-1.8.16.custom.css" />
   	<link type="text/css" rel="stylesheet" href="<%= WebUtils.getAppServerPath() %>/include/er/draw2d/css/jquery.layout.css" />
   	<link type="text/css" rel="stylesheet" href="<%= WebUtils.getAppServerPath() %>/include/er/draw2d/css/application.css" />

    <link type="text/css" rel="stylesheet" href="<%= WebUtils.getAppServerPath() %>/include/er/draw2d/css/contextmenu.css" />

    <link type="text/css" rel="stylesheet" href="<%= WebUtils.getAppServerPath() %>/include/er/example/css/app.css" />

	

</head>
<body id="container">

   <div id="content">
       <form runat="server">
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
                 
                    <div class="row" style="position: absolute; border: 1px solid; top: 30px;">
                       <button type="button" onclick="saveData()">Save</button>
                       <asp:LinkButton ID="btnShow" runat="server" OnClick="btnShow_Click" Text="Show"> </asp:LinkButton>
                   </div>
                   <asp:HiddenField ID ="hndJson" runat="server" OnValueChanged="hndJson_ValueChanged" />
               </ContentTemplate>
           </asp:UpdatePanel>
           <div class="row" style="position: absolute; top: 60px;">
               <%--<div id="toolbar"></div>--%>
               <br />
               <div id="gfx_holder" class="" style="position: unset; width: 1500px; height: 1500px; -webkit-tap-highlight-color: rgba(0,0,0,0);"></div>
               <%--<pre id="json" style="overflow:auto;position:absolute; top:40px; right:15px; width:350; height:500;background:white;border:1px solid gray">--%>
           </div>
           <!-- ## Required Imports ## -->
	        <!-- jQuery -->
	        <script src="<%= WebUtils.getAppServerPath() %>/include/er/draw2d/lib/jquery-1.10.2.min.js"></script>
	        <script src="<%= WebUtils.getAppServerPath() %>/include/er/draw2d/lib/jquery.autoresize.js"></script>
	        <script src="<%= WebUtils.getAppServerPath() %>/include/er/draw2d/lib/jquery-touch_punch.js"></script>
	        <script src="<%= WebUtils.getAppServerPath() %>/include/er/draw2d/lib/jquery.contextmenu.js"></script>

	        <!-- Shifty is an excellent animation solution for scenarios -->
	        <script src="<%= WebUtils.getAppServerPath() %>/include/er/draw2d/lib/shifty.js"></script>

	        <!-- Unfortunately the latest version of raphael didn't fix some bug. In this case I did it and patch the version in the Draw2D. You can't replace the provided raphael version with the common version without lost of functionality. Grep from FREEGROUP to find all patches in the raphael.js file -->
	        <script src="<%= WebUtils.getAppServerPath() %>/include/er/draw2d/lib/raphael.js"></script>
	        <script src="<%= WebUtils.getAppServerPath() %>/include/er/draw2d/lib/rgbcolor.js"></script>
	        <script src="<%= WebUtils.getAppServerPath() %>/include/er/draw2d/lib/canvg.js"></script>

	        <!-- Simple JavaScript Inheritance by John Resig -->
	        <script src="<%= WebUtils.getAppServerPath() %>/include/er/draw2d/lib/Class.js"></script>

	        <!-- This file creates a global JSON object containing two methods: stringify and parse -->
	        <script src="<%= WebUtils.getAppServerPath() %>/include/er/draw2d/lib/json2.js"></script>

	        <!-- Connection routing -->
	        <script src="<%= WebUtils.getAppServerPath() %>/include/er/draw2d/lib/pathfinding-browser.min.js"></script>

	        <script src="<%= WebUtils.getAppServerPath() %>/include/er/draw2d/src/draw2d-all.js"></script>
    
            <script src="<%= WebUtils.getAppServerPath() %>/include/er/draw2d/lib/jquery.browser.js"></script>
            <script src="<%= WebUtils.getAppServerPath() %>/include/er/draw2d/lib/jquery-ui-1.8.23.custom.min.js"></script>
            <script src="<%= WebUtils.getAppServerPath() %>/include/er/draw2d/lib/jquery.layout.js"></script>

            <script src="<%= WebUtils.getAppServerPath() %>/include/er/dbModel/Application.js"></script>
	        <script src="<%= WebUtils.getAppServerPath() %>/include/er/dbModel/View.js"></script>
	        <script src="<%= WebUtils.getAppServerPath() %>/include/er/dbModel/Toolbar.js"></script>
	        <script src="<%= WebUtils.getAppServerPath() %>/include/er/dbModel/document.js"></script>
            <script src="<%= WebUtils.getAppServerPath() %>/include/er/dbModel/shape/CustomLabel.js"></script>
            <script src="<%= WebUtils.getAppServerPath() %>/include/er/dbModel/shape/DBTable.js"></script>
            <script src="<%= WebUtils.getAppServerPath() %>/include/er/dbModel/locator/PortLeftLocator.js"></script>
            <script src="<%= WebUtils.getAppServerPath() %>/include/er/dbModel/locator/PortRightLocator.js"></script>
            <script src="<%= WebUtils.getAppServerPath() %>/include/er/dbModel/locator/ManhattanLeftConnectionLocator.js"></script>
            <script src="<%= WebUtils.getAppServerPath() %>/include/er/dbModel/locator/ManhattanRightConnectionLocator.js"></script>
            <script src="<%= WebUtils.getAppServerPath() %>/include/er/dbModel/shape/TableConnection.js"></script>
    
	        <script type="text/javascript">
	       
	            draw2d.Connection.createConnection = function (sourcePort, targetPort) {

	                var conn = new dbModel.shape.TableConnection();//draw2d.Connection();
	                conn.setColor("#5bcaff");
	                conn.setStroke(2);
	                return conn;
	            };

	            var canvas = null;
	            var reader = null;

	            $(window).load(function () {

	                canvas = new draw2d.Canvas("gfx_holder");

	                reader = new draw2d.io.json.Reader();
	                reader.unmarshal(canvas, jsonDocument);
	                displayJSON(canvas);

	                canvas.getCommandStack().addEventListener(function (e) {
	                    if (e.isPostChangeEvent()) {
	                        displayJSON(canvas);
	                    }
	                });
	            });

	            function showGraph(data) {
	                this.canvas.clear();
	                reader.unmarshal(this.canvas, data);
	            }

	            function saveData() {
	                __doPostBack("<%= hndJson.ClientID %>");
	            }

	            function displayJSON(canvas) {
	                var writer = new draw2d.io.json.Writer();
	                writer.marshal(canvas, function (json) {
	                    //document.getElementById("<%= hndJson.ClientID %>").value = JSON.stringify(json, null, 2)
	                });
	            }

            </script>
       </form>
   	
   </div>
    
</body>
</html>
