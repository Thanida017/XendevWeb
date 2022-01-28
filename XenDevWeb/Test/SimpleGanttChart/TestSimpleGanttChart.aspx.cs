using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.Test.SimpleGanttChart.view;

namespace XenDevWeb.Test.SimpleGanttChart
{
    public partial class TestSimpleGanttChart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void hndJson_ValueChanged(object sender, EventArgs e)
        {
            string json = this.hndJson.Value;
        }

        protected void btnShow_Click(object sender, EventArgs e)
        {
            string json = "[\n   {\n      \"start\":\"2021-12-01\",\n      \"end\":\"2021-12-08\",\n      \"name\":\"Redesign website\",\n      \"id\":\"Task 0\",\n      \"progress\":91\n   },\n   {\n      \"start\":\"2021-12-03\",\n      \"end\":\"2021-12-06\",\n      \"name\":\"Write new content\",\n      \"id\":\"Task 1\",\n      \"progress\":55,\n      \"dependencies\":\"Task 0\"\n   },\n   {\n      \"start\":\"2021-12-04\",\n      \"end\":\"2021-12-08\",\n      \"name\":\"Apply new styles\",\n      \"id\":\"Task 2\",\n      \"progress\":40,\n      \"dependencies\":\"Task 1\"\n   },\n   {\n      \"start\":\"2021-12-08\",\n      \"end\":\"2021-12-09\",\n      \"name\":\"Review\",\n      \"id\":\"Task 3\",\n      \"progress\":20,\n      \"dependencies\":\"Task 2\"\n   },\n   {\n      \"start\":\"2021-12-08\",\n      \"end\":\"2021-12-10\",\n      \"name\":\"Deploy\",\n      \"id\":\"Task 4\",\n      \"progress\":50,\n      \"dependencies\":\"Task 2\"\n   },\n   {\n      \"start\":\"2021-12-11\",\n      \"end\":\"2021-12-11\",\n      \"name\":\"Go Live!\",\n      \"id\":\"Task 5\",\n      \"progress\":10,\n      \"dependencies\":\"Task 4\",\n      \"custom_class\":\"bar-milestone\"\n   }\n]";

            List<SimpleGanttChartView> fcView = JsonConvert.DeserializeObject<List<SimpleGanttChartView>>(json);

            string data = new JavaScriptSerializer().Serialize(fcView);
            string script = string.Format("showGraph({0});", data);
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "showGraph", script, true);
        }
    }
}