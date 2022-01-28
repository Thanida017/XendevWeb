using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.Test.draw2d.er.view;

namespace XenDevWeb.Test.draw2d.er
{
    public partial class TestER : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnShow_Click(object sender, EventArgs e)
        {
            string json = "[{\"type\":\"dbModel.shape.DBTable\",\"id\":\"63c0f27a-716e-804c-6873-cd99b945b63f\",\"x\":505,\"y\":180,\"width\":76.017578125,\"height\":59,\"userData\":{},\"cssClass\":\"DBTable\",\"bgColor\":\"#DBDDDE\",\"color\":\"#D7D7D7\",\"stroke\":1,\"alpha\":1,\"radius\":3,\"tableName\":\"Enterprise\",\"tablePorts\":[{\"type\":\"draw2d_InputPort\",\"name\":\"input0\",\"position\":\"default\"},{\"type\":\"draw2d_OutputPort\",\"name\":\"output0\",\"position\":\"default\"},{\"type\":\"draw2d_HybridPort\",\"name\":\"hybrid0\",\"position\":\"bottom\"}],\"attributes\":[{\"text\":\"blubber\",\"id\":\"49be7d78-4dcf-38ab-3733-b4108701fce4\",\"datatype\":\"int\",\"pk\":true,\"fk\":false,\"isRequired\":true,\"isNullable\":false}]},{\"type\":\"dbModel.shape.DBTable\",\"id\":\"3253ff2a-a920-09d5-f033-ca759a778e19\",\"x\":650,\"y\":442,\"width\":96.71484375,\"height\":131,\"userData\":{},\"cssClass\":\"DBTable\",\"bgColor\":\"#DBDDDE\",\"color\":\"#D7D7D7\",\"stroke\":1,\"alpha\":1,\"radius\":3,\"tableName\":\"UsageLogiciel\",\"tablePorts\":[{\"type\":\"draw2d_InputPort\",\"name\":\"input0\",\"position\":\"default\"},{\"type\":\"draw2d_OutputPort\",\"name\":\"output0\",\"position\":\"default\"},{\"type\":\"draw2d_OutputPort\",\"name\":\"output1\",\"position\":\"default\"}],\"attributes\":[{\"text\":\"id\",\"id\":\"e97f6f8a-4306-0667-3a95-0a5310a2c15c\",\"datatype\":\"int\",\"pk\":true,\"fk\":false,\"isRequired\":true,\"isNullable\":false},{\"text\":\"firstName\",\"id\":\"357e132c-aa47-978f-a1fa-d13da6736989\",\"datatype\":\"string\",\"pk\":false,\"fk\":false,\"isRequired\":false,\"isNullable\":true},{\"text\":\"lastName\",\"id\":\"a2156a71-f868-1f8f-e9a1-b185dbdfc3de\",\"datatype\":\"string\",\"pk\":false,\"fk\":false,\"isRequired\":false,\"isNullable\":true},{\"text\":\"company_fk\",\"id\":\"8d410fef-5c6e-286d-c9c3-c152d5bd9c52\",\"datatype\":\"int\",\"pk\":false,\"fk\":true,\"isRequired\":false,\"isNullable\":true}]},{\"type\":\"dbModel.shape.DBTable\",\"id\":\"2810494b-931f-da59-fd9d-6deba4385fe0\",\"x\":860,\"y\":66,\"width\":62.02734375,\"height\":59,\"userData\":{},\"cssClass\":\"DBTable\",\"bgColor\":\"#DBDDDE\",\"color\":\"#D7D7D7\",\"stroke\":1,\"alpha\":1,\"radius\":3,\"tableName\":\"Logiciel\",\"tablePorts\":[{\"type\":\"draw2d_InputPort\",\"name\":\"input0\",\"position\":\"default\"},{\"type\":\"draw2d_OutputPort\",\"name\":\"output0\",\"position\":\"default\"}],\"attributes\":[{\"text\":\"id\",\"id\":\"e04ebb27-43c9-1afa-a7d0-e55bf2aa62d5\",\"datatype\":\"int\",\"pk\":true,\"fk\":false,\"isRequired\":true,\"isNullable\":false}]},{\"type\":\"dbModel.shape.TableConnection\",\"id\":\"f8735797-cf1d-8431-d891-c2d10f0a67be\",\"userData\":{\"isPrimary\":false,\"useDecorators\":true},\"cssClass\":\"draw2d_Connection\",\"stroke\":2,\"color\":\"#5BCAFF\",\"outlineStroke\":0,\"outlineColor\":\"none\",\"policy\":\"draw2d.policy.line.OrthogonalSelectionFeedbackPolicy\",\"router\":\"draw2d.layout.connection.InteractiveManhattanConnectionRouter\",\"radius\":2,\"vertex\":[{\"x\":746.71484375,\"y\":529.3333333333334},{\"x\":803.357421875,\"y\":529.3333333333334},{\"x\":803.357421875,\"y\":95.5},{\"x\":860,\"y\":95.5}],\"routingMetaData\":{\"routedByUserInteraction\":false,\"fromDir\":1,\"toDir\":3},\"source\":{\"node\":\"3253ff2a-a920-09d5-f033-ca759a778e19\",\"port\":\"output1\"},\"target\":{\"node\":\"2810494b-931f-da59-fd9d-6deba4385fe0\",\"port\":\"input0\"},\"name\":\"Connection Usage_Logiciel\"},{\"type\":\"dbModel.shape.TableConnection\",\"id\":\"abf0a3d6-c4d0-a4d4-569c-094083429e70\",\"userData\":{\"isPrimary\":false,\"useDecorators\":false},\"cssClass\":\"draw2d_Connection\",\"stroke\":2,\"color\":\"#5BCAFF\",\"outlineStroke\":0,\"outlineColor\":\"none\",\"policy\":\"draw2d.policy.line.OrthogonalSelectionFeedbackPolicy\",\"router\":\"draw2d.layout.connection.InteractiveManhattanConnectionRouter\",\"radius\":2,\"vertex\":[{\"x\":581.017578125,\"y\":209.5},{\"x\":615.5087890625,\"y\":209.5},{\"x\":615.5087890625,\"y\":507.5},{\"x\":650,\"y\":507.5}],\"routingMetaData\":{\"routedByUserInteraction\":false,\"fromDir\":1,\"toDir\":3},\"source\":{\"node\":\"63c0f27a-716e-804c-6873-cd99b945b63f\",\"port\":\"output0\"},\"target\":{\"node\":\"3253ff2a-a920-09d5-f033-ca759a778e19\",\"port\":\"input0\"},\"name\":\"Connection Enterprise_Usage\"},{\"type\":\"dbModel.shape.TableConnection\",\"id\":\"f8735797-cf1d-8431-d891-c2d10f0a67be\",\"userData\":{\"isPrimary\":false,\"useDecorators\":true},\"cssClass\":\"draw2d_Connection\",\"stroke\":2,\"color\":\"#5BCAFF\",\"outlineStroke\":0,\"outlineColor\":\"none\",\"policy\":\"draw2d.policy.line.OrthogonalSelectionFeedbackPolicy\",\"router\":\"draw2d.layout.connection.InteractiveManhattanConnectionRouter\",\"radius\":2,\"vertex\":[{\"x\":543.0087890625,\"y\":239},{\"x\":543.0087890625,\"y\":259},{\"x\":485,\"y\":259},{\"x\":485,\"y\":209.5},{\"x\":505,\"y\":209.5}],\"routingMetaData\":{\"routedByUserInteraction\":false,\"fromDir\":2,\"toDir\":3},\"source\":{\"node\":\"63c0f27a-716e-804c-6873-cd99b945b63f\",\"port\":\"hybrid0\"},\"target\":{\"node\":\"63c0f27a-716e-804c-6873-cd99b945b63f\",\"port\":\"input0\"},\"name\":\"Auto\"}]";
            //string json = "[{\n    \"type\": \"dbModel.shape.DBTable\",\n    \"id\": \"63c0f27a-716e-804c-6873-cd99b945b13f\",\n    \"x\": 200,\n    \"y\": 200,\n    \"width\": 98,\n    \"height\": 100,\n    \"userData\": null,\n    \"cssClass\": \"DBTable\",\n    \"bgColor\": \"#DBDDDE\",\n    \"color\": \"#D7D7D7\",\n    \"stroke\": 1,\n    \"alpha\": 1,\n    \"radius\": 3,\n    \"tableName\": \"Customer\",\n    \"tablePorts\": [{\n            \"type\": \"draw2d_InputPort\",\n            \"name\": \"input0\",\n            \"position\": \"default\"\n        }, {\n            \"type\": \"draw2d_OutputPort\",\n            \"name\": \"output0\",\n            \"position\": \"default\"\n        }, {\n            \"type\": \"draw2d_HybridPort\",\n            \"name\": \"hybrid0\",\n            \"position\": \"bottom\"\n        }\n    ],\n    \"attributes\": [{\n            \"text\": \"id\",\n            \"id\": \"49be7d78-4dcf-38ab-3733-b4108711fce4\",\n            \"datatype\": \"int\",\n            \"pk\": true,\n            \"fk\": false,\n            \"isNullable\": false,\n            \"isRequired\": true\n        }, \n\t\t{\n            \"text\": \"username\",\n            \"id\": \"49be7d78-4dcf-38ab-3733-b4101511fce4\",\n            \"datatype\": \"text\",\n            \"pk\": false,\n            \"fk\": false,\n            \"isNullable\": false,\n            \"isRequired\": true\n        }\n    ]\n}]";
            List<ERView> ers = JsonConvert.DeserializeObject<List<ERView>>(json);
            List<Object> all = new List<Object>();

            foreach(ERView er in ers)
            {
                if(er.type.ToLower().CompareTo("dbModel.shape.DBTable".ToLower()) == 0)
                {
                    DBTableView db = new DBTableView(er);
                    all.Add(db);
                }
                else if(er.type.ToLower().CompareTo("dbModel.shape.TableConnection".ToLower()) == 0)
                {
                    TableConnectionView con = new TableConnectionView(er);
                    all.Add(con);
                }
            }

            string data = new JavaScriptSerializer().Serialize(all);
            string script = string.Format("showGraph({0});", data);
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "showGraph", script, true);
        }

        protected void hndJson_ValueChanged(object sender, EventArgs e)
        {
            //string json = this.hndJson.Value;
            
        }
    }
}