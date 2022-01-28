<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="TestFlowy.aspx.cs" 
    ValidateRequest="false"
    Inherits="XenDevWeb.Test.flowy.TestFlowy" %>

<%@ Import Namespace="XenDevWeb.Utils" %>

<html>
    <head>
        <link href="https://fonts.googleapis.com/css?family=Roboto:400,500,700&display=swap" rel="stylesheet">
        <link href='<%= WebUtils.getAppServerPath() %>/include/flowy/demo/styles.css' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="<%= WebUtils.getAppServerPath() %>/include/flowy/demo/flowy.min.css"> 
        <script src="<%= WebUtils.getAppServerPath() %>/include/flowy/demo/flowy.min.js"></script>
        <script src="<%= WebUtils.getAppServerPath() %>/include/js/jquery-1.8.3.min.js"></script>

    </head>
<body>
    <form runat="server">
        <div id="navigation">
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
                    <div id="buttonsright" style="">
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
        </div>
        <div id="leftcard">
            <div class="blockelem create-flowy noselect" >
                <input type="hidden" name="blockelemtype" class="blockelemtype" value="0"><div class="blockyleft">
                    <img src="<%= WebUtils.getAppServerPath() %>/include/flowy/demo/assets/eyeblue.svg">
                    <p class="blockyname">New visitor</p>
                </div>
                <div class="blockyright"></div>
                <div class="blockydiv"></div>
                <div class="blockyinfo">When a <span>new visitor</span> goes to <span>Site 1</span></div>
                <div class="indicator invisible" style="left: 154px; top: 120px;"></div>
            </div>
            <div class="blockelem create-flowy noselect">
                <input type="hidden" name='blockelemtype' class="blockelemtype" value="1">
                <div class="blockin">
                    <div class="blockico">
                        <span></span>
                        <img src="<%= WebUtils.getAppServerPath() %>/include/flowy/demo/assets/eye.svg">
                    </div>
                    <div class="blocktext">
                        <p class="blocktitle">New visitor</p>
                        <p class="blockdesc">Triggers when somebody visits a specified page</p>
                    </div>
                </div>
            </div>
        </div>
        
        <div id="canvas"></div>

        <script>
            var spacing_x = 40;
            var spacing_y = 100;
            // Initialize Flowy
            flowy(document.getElementById("canvas"), onGrab, onRelease, onSnap, onRearrange, spacing_x, spacing_y);
            function onGrab(block) {
                // เมื่อผู้ใช้คว้าบล็อค
                // When the user grabs a block
            }
            function onRelease() {
                // เมื่อผู้ใช้ปล่อยบล็อค
                // When the user releases a block
            }
            function onSnap(block, first, parent) {
                // เมื่อบล็อคไปชนกับอีกอันหนึ่ง
                // When a block snaps with another one
                return true;
            }
            function onRearrange(block, parent) {
                // เมื่อบล็อกถูกจัดเรียงใหม่
                // When a block is rearranged
                return true;
            }

            function saveJson() {
                var data = JSON.stringify(flowy.output());
               
                document.getElementById("<%= hndJson.ClientID %>").value = data;
                 __doPostBack("<%= hndJson.ClientID %>");
            }

            function showGraph(dataJson) {
                flowy.deleteBlocks();
                flowy.import(dataJson);
            }
        </script>
    </form>
    </body>
</html>