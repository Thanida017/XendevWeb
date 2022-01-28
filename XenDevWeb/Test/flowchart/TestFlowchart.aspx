<%@ Page Language="C#" 
    AutoEventWireup="true"
    CodeBehind="TestFlowchart.aspx.cs" 
    Inherits="XenDevWeb.Test.flowchart.TestFlowchart" %>

<%@ Import Namespace="XenDevWeb.Utils" %>

<html lang="en">

<head>
	<title>Home</title>
	<meta charset="utf-8">

	<meta name="viewport" content="width=device-width, initial-scale=1">

	<!-- jQuery & jQuery UI are required -->
	<script src="<%= WebUtils.getAppServerPath() %>/include/flowchart/jquery.min.js"></script>
	<script src="<%= WebUtils.getAppServerPath() %>/include/flowchart/jquery-ui.min.js"></script>

	<!-- Flowchart CSS and JS -->
	<link rel="stylesheet" href="<%= WebUtils.getAppServerPath() %>/include/flowchart/jquery.flowchart.css">
	<script src="<%= WebUtils.getAppServerPath() %>/include/flowchart/jquery.flowchart.js"></script>

	<style>
		.flowchart-example-container {
			width: 800px;
			height: 400px;
			background: white;
			border: 1px solid #BBB;
			margin-bottom: 10px;
		}
	</style>
</head>

<body>	
	<h4>Flowchart</h4>
	<div id="chart_container">
		<div class="flowchart-example-container" id="flowchartworkspace"></div>
	</div>	
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
                    <label>ASPX  กดบันทึกไปแล้วเวลาShowจะแสดงที่บันทึกไว้ ลองลากเปลี่ยนตำแหน่ง</label>
                    <div class="row" style="">
                       <button type="button" onclick="saveJson()">Save</button>
                       <asp:LinkButton ID="btnShow" runat="server" OnClick="btnShow_Click" Text="Show"> </asp:LinkButton>
                   </div>
                   <asp:HiddenField ID ="hndJson" runat="server" OnValueChanged="hndJson_ValueChanged" />
               </ContentTemplate>
           </asp:UpdatePanel>
     </form>
	<script type="text/javascript">
	    /* global $ */
	    var $flowchart = null;
	    var $container = null;
		$(document).ready(function() {
			$flowchart = $('#flowchartworkspace');

			// Apply the plugin on a standard, empty div...
			$flowchart.flowchart({
				data: defaultFlowchartData,
				defaultSelectedLinkColor: '#000055',
				grid: 10,
				multipleLinksOnInput: true,
				multipleLinksOnOutput: true
			});
		});

		var defaultFlowchartData = {
		    operators: {
		        operator1: {
		            top: 20,
		            left: 20,
		            properties: {
		                title: 'Operator 1',
		                inputs: {},
		                outputs: {
		                    output_1: {
		                        label: 'Output 1',
		                    }
		                }
		            }
		        },
		        operator2: {
		            top: 80,
		            left: 300,
		            properties: {
		                title: 'Operator 2',
		                inputs: {
		                    input_1: {
		                        label: 'Input 1',
		                    },
		                    input_2: {
		                        label: 'Input 2',
		                    },
		                },
		                outputs: {
		                    output_1: {
		                        label: 'Output 1',
		                    }
		                }
		            }
		        },
		    },
		    links: {
		        link_1: {
		            fromOperator: 'operator1',
		            fromConnector: 'output_1',
		            toOperator: 'operator2',
		            toConnector: 'input_2',
		        },
		    }
		};

		function saveJson() {
		    var data = $flowchart.flowchart('getData');
		    document.getElementById("<%= hndJson.ClientID %>").value = JSON.stringify(data)
             __doPostBack("<%= hndJson.ClientID %>");
		}

	    function showGraph(dataJson) {
	        $flowchart.flowchart('setData', dataJson);
		}

		
		if (false) console.log('remove lint unused warning', defaultFlowchartData);
	</script>
</body>

</html>
