<%@ Page Language="C#"
    AutoEventWireup="true"
    CodeBehind="test_draw_domain.aspx.cs"
    Inherits="XenDevWeb.Test.draw2d.test_draw_domain" %>

<%@ Import Namespace="XenDevWeb.Utils" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="<%= WebUtils.getAppServerPath() %>/include/draw2d-master/docs/examples/shape_db/lib/jquery.js"></script>
    <script src="<%= WebUtils.getAppServerPath() %>/include/draw2d-master/docs/examples/shape_db/lib/jquery-ui.js"></script>
    <script src="<%= WebUtils.getAppServerPath() %>/include/draw2d-master/docs/examples/shape_db/lib/jquery.browser.js"></script>

    <script src="<%= WebUtils.getAppServerPath() %>/include/draw2d-master/docs/draw2d.js"></script>

    <script src="<%= WebUtils.getAppServerPath() %>/include/draw2d-master/docs/examples/shape_db/app/Application.js"></script>
    <script src="<%= WebUtils.getAppServerPath() %>/include/draw2d-master/docs/examples/shape_db/app/View.js"></script>
    <script src="<%= WebUtils.getAppServerPath() %>/include/draw2d-master/docs/examples/shape_db/app/Toolbar.js"></script>
    <script src="<%= WebUtils.getAppServerPath() %>/include/draw2d-master/docs/examples/shape_db/app/TableShape.js"></script>

    <!--<script src="document.js"></script>-->

    <style>
        .draw2d_InputPort {
            fill: #F7F7F7;
            stroke: #d7d7d7;
        }

        .draw2d_OutputPort {
            fill: #F7F7F7;
            stroke: #d7d7d7;
        }
    </style>
    <script type="text/javascript">

        var jsonDocument =
        [
         {
             "type": "TableShape",
             "id": "company_db_id_1",
             "x": 80,
             "y": 59,
             "width": 99,
             "height": 107,
             "userData": {},
             "cssClass": "TableShape",
             "bgColor": "#DBDDDE",
             "color": "#D7D7D7",
             "stroke": 1,
             "alpha": 1,
             "radius": 3,
             "name": "Company",
             "entities": [
               {
                   "text": "id",
                   "id": "49be7d78-4dcf-38ab-3733-b4108701f1"
               },
               {
                   "text": "title"
               },
               {
                   "text": "code"
               },
               {
                   "text": "name"
               },
               {
                   "text": "nameEng"
               },
               {
                   "text": "taxId"
               },
               {
                   "text": "enabled"
               },
               {
                   "text": "logoImage"
               },
               {
                   "text": "creationDate"
               },
               {
                   "text": "lastUpdate"
               },

             ]
         },
         {
             "type": "TableShape",
             "id": "project_db_id_1",
             "x": 255,
             "y": 246,
             "width": 99,
             "height": 155,
             "userData": {},
             "cssClass": "TableShape",
             "bgColor": "#DBDDDE",
             "color": "#D7D7D7",
             "stroke": 1,
             "alpha": 1,
             "radius": 3,
             "name": "Project",
             "entities": [
               {
                   "text": "id",
                   "id": "e97f6f8a-4306-0667-3a95-0a5310a2c15c"
               },
               {
                   "text": "code"
               },
               {
                   "text": "name"
               },
               {
                   "text": "description"
               },
               {
                   "text": "bannerImageFileName"
               },
               {
                   "text": "company_fk",
                   "id": "8d410fef-5c6e-286d-c9c3-c152d5bd9c52"
               },
               {
                   "text": "creationDate"
               },
               {
                   "text": "lastUpdate"
               }

             ]
         },
         {
             "type": "TableShape",
             "id": "userAccount_da_id_1",
             "x": 460,
             "y": 79,
             "width": 99,
             "height": 83,
             "userData": {},
             "cssClass": "TableShape",
             "bgColor": "#DBDDDE",
             "color": "#D7D7D7",
             "stroke": 1,
             "alpha": 1,
             "radius": 3,
             "name": "UserAccount",
             "entities": [
               {
                   "text": "id",
                   "id": "e04ebb27-43c9-1afa-a7d0-e55bf2aa62d5"
               },
               {
                   "text": "empNo"
               },
               {
                   "text": "title"
               },
               {
                   "text": "firstName"
               },
               {
                   "text": "lastName"
               },
               {
                   "text": "username"
               },
               {
                   "text": "password"
               },
               {
                   "text": "enabled"
               },
               {
                   "text": "email"
               },
               {
                   "text": "language"
               },
               {
                   "text": "mobilePhoneNumber"
               },
               {
                   "text": "company_fk",
                   "id": "49be7d78-4dcf-38ab-3733-b4108701fce4"
               },
               {
                   "text": "isAdmin"
               },
               {
                   "text": "token"
               },
               {
                   "text": "imageUserFileName"
               },
               {
                   "text": "creationDate"
               },
               {
                   "text": "lastUpdate"
               }

             ]
         },
         //{
         //    "type": "draw2d.Connection",
         //    "id": "19acf411-a02f-557a-7451-f3a741676c7b",
         //    "userData": {},
         //    "cssClass": "draw2d_Connection",
         //    "stroke": 2,
         //    "color": "#4caf50",
         //    "outlineStroke": 1,
         //    "outlineColor": "#ffffff",
         //    "policy": "draw2d.policy.line.LineSelectionFeedbackPolicy",
         //    "router": "draw2d.layout.connection.InteractiveManhattanConnectionRouter",
         //    "radius": 2,
         //    "source": {
         //        "node": "company_db_id_1",
         //        "port": "output_49be7d78-4dcf-38ab-3733-b4108701f1"
         //    },
         //    "target": {
         //        "node": "project_db_id_1",
         //        "port": "input_8d410fef-5c6e-286d-c9c3-c152d5bd9c52"
         //    }
         //},
         //{
         //    "type": "draw2d.Connection",
         //    "id": "81cb3b59-66d1-ffc4-3cb7-0bad52ace43b",
         //    "userData": {},
         //    "cssClass": "draw2d_Connection",
         //    "stroke": 2,
         //    "color": "#4caf50",
         //    "outlineStroke": 1,
         //    "outlineColor": "#ffffff",
         //    "policy": "draw2d.policy.line.LineSelectionFeedbackPolicy",
         //    "router": "draw2d.layout.connection.InteractiveManhattanConnectionRouter",
         //    "radius": 2,
         //    "source": {
         //        "node": "company_db_id_1",
         //        "port": "output_49be7d78-4dcf-38ab-3733-b4108701f1"
         //    },
         //    "target": {
         //        "node": "userAccount_da_id_1",
         //        "port": "input_49be7d78-4dcf-38ab-3733-b4108701fce4"
         //    }
         //}
        ];

        /**
         * @method
         * Factory method to provide a default connection for all drag&drop connections. You
         * can override this method and customize this for your personal purpose.
         *
         * @param {draw2d.Port} sourcePort port of the source of the connection
         * @param {draw2d.Port} targetPort port of the target of the connection
         * @template
         * @returns {draw2d.Connection}
         */

        document.addEventListener("DOMContentLoaded", function () {

            var routerToUse = new draw2d.layout.connection.InteractiveManhattanConnectionRouter();
            var app = new example.Application();
            app.view.installEditPolicy(new draw2d.policy.connection.DragConnectionCreatePolicy({
                createConnection: function () {
                    var connection = new draw2d.Connection({
                        stroke: 3,
                        outlineStroke: 1,
                        outlineColor: "#303030",
                        color: "91B93E",
                        router: routerToUse
                    });
                    return connection;
                }
            }));


            // unmarshal the JSON document into the canvas
            // (load)
            var reader = new draw2d.io.json.Reader();
            reader.unmarshal(app.view, jsonDocument);

        });
</script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="canvas">
        </div>
    </form>
</body>
</html>
