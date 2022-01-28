using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.Test.drawflow.view;

namespace XenDevWeb.Test.drawflow
{
    public partial class TestDrawflow : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnShow_Click(object sender, EventArgs e)
        {
            string json = this.hndJson.Value;

            DrawflowView df = new DrawflowView();
            df.graphName = "flow Char";
            df.json = json;
            df.creationDate = DateTime.Now;
            df.lastUpdate = DateTime.Now;

            string script = string.Format("showGraph({0});", df.json);
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "showGraph", script, true);
        }

        protected void hndJson_ValueChanged(object sender, EventArgs e)
        {
            string json = this.hndJson.Value;
        }
    }
}