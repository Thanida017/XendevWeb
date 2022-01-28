using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.Test.flowchart.view;

namespace XenDevWeb.Test.flowchart
{
    public partial class TestFlowchart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnShow_Click(object sender, EventArgs e)
        {
            FlowChartView fcView = JsonConvert.DeserializeObject<FlowChartView>(this.hndJson.Value);

            string data = new JavaScriptSerializer().Serialize(fcView);
            string script = string.Format("showGraph({0});", data);
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "showGraph", script, true);
        }

        protected void hndJson_ValueChanged(object sender, EventArgs e)
        {
            string json = this.hndJson.Value;
        }
    }
}