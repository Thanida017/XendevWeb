<%@ Page Language="C#" 
        AutoEventWireup="true" 
        CodeBehind="TestApprovalHierachyGenChart.aspx.cs" 
        Inherits="XenDevWeb.Test.flowchart.TestApprovalHierachyGenChart" %>

<%@ Import Namespace="XenDevWeb.Utils" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <script src="<%= WebUtils.getAppServerPath() %>/include/flowchart/jquery.min.js"></script>
	<script src="<%= WebUtils.getAppServerPath() %>/include/flowchart/jquery-ui.min.js"></script>

	<!-- Flowchart CSS and JS -->
	<link rel="stylesheet" href="<%= WebUtils.getAppServerPath() %>/include/flowchart/jquery.flowchart.css">
	<script src="<%= WebUtils.getAppServerPath() %>/include/flowchart/jquery.flowchart.js"></script>
    <style>
		.flowchart-example-container {
			width: 100%;
			height: 400px;
			background: white;
			border: 1px solid #BBB;
			margin-bottom: 10px;
		}
	</style>
</head>
    
<body>
    <form id="form1" runat="server">
    <div >
        <div class="flowchart-example-container" id="flowchartworkspace"></div>
    </div>
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
		                outputs: {}
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

		function showGraph(dataJson) {
		    console.log(dataJson)
	        $flowchart.flowchart('setData', dataJson);
		}

		
		if (false) console.log('remove lint unused warning', defaultFlowchartData);
	</script>
</body>
</html>
