<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="TestSVGFlowChart.aspx.cs"
     Inherits="XenDevWeb.Test.SVGFlowChart.TestSVGFlowChart" %>

<%@ Import Namespace="XenDevWeb.Utils" %>

<!DOCTYPE html>

<html>
<head>

    <title></title>
    <script src="<%= WebUtils.getAppServerPath() %>/include/SVGFlowChart/jquery.min.js"></script>
    <link href="<%= WebUtils.getAppServerPath() %>/include/SVGFlowChart/jquerysctipttop.css" rel="stylesheet" type="text/css">
    <script src="<%= WebUtils.getAppServerPath() %>/include/SVGFlowChart/svg.min.js"></script>
    <script src="<%= WebUtils.getAppServerPath() %>/include/SVGFlowChart/dist/flowsvg.min.js"></script>
    <script src="<%= WebUtils.getAppServerPath() %>/include/SVGFlowChart/jquery.scrollTo.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
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
     <div id="drawing"></div>
    </div>
        <script>
            function saveJson() {
                var data = "";
               
                document.getElementById("<%= hndJson.ClientID %>").value = data;
                 __doPostBack("<%= hndJson.ClientID %>");
            }

            function showGraph(dataJson) {
                flowSVG.draw(SVG('drawing').size(900, 1100));
                flowSVG.config({
                    interactive: true,
                    showButtons: true,
                    connectorLength: 60,
                    scrollto: true
                });

                flowSVG.shapes(dataJson);

                console.log(flowSVG);

                var _gaq = _gaq || [];
                _gaq.push(['_setAccount', 'UA-36251023-1']);
                _gaq.push(['_setDomainName', 'jqueryscript.net']);
                _gaq.push(['_trackPageview']);

                (function () {
                    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
                    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
                })();
            }


        </script>
    </form>
</body>
</html>
