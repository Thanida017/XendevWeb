using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.Test.flowy.view;

namespace XenDevWeb.Test.flowy
{
    public partial class TestFlowy : System.Web.UI.Page
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
            FlowyView fcView = JsonConvert.DeserializeObject<FlowyView>(this.hndJson.Value);

            string data = new JavaScriptSerializer().Serialize(fcView);
            string script = string.Format("showGraph({0});", data);
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "showGraph", script, true);
        }

    
    }
}