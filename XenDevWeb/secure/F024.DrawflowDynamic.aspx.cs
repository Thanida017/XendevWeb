using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.dao;
using XenDevWeb.domain;
using XenDevWeb.include;
using XenDevWeb.Utils;
using XenDevWeb.view;

namespace XenDevWeb.secure
{
    public partial class F024_DrawflowDynamic : CRUDPageControler
    {
        private RequirementDAO rqmDAO;

        protected void Page_Load(object sender, EventArgs e)
        {
            rqmDAO = new RequirementDAO(ctx);

            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            if (ValidationUtil.isEmpty(Request.QueryString["rqmId"]))
            {
                Response.Redirect("F022.ListRequirements.aspx", true);
                return;
            }

            this.hndRequirementId.Value = QueryStringModule.Decrypt(HttpUtility.UrlDecode(Request.QueryString["rqmId"]));

            initForm();
        }

        public void initForm()
        {
            Requirement rqm = this.rqmDAO.findById(long.Parse(this.hndRequirementId.Value), true);
            if (rqm != null)
            {
                if (rqm.status != REQUIREMENT_STATUS.COMPOSING)
                {
                    txtTitle.Enabled = false;
                    txtText.Enabled = false;
                    txtPortRight.Enabled = false;
                    txtPortLeft.Enabled = false;
                    selNode.Disabled = false;
                    btnBack.Enabled = false;
                    btnSetNode.Disabled = false;
                    btnSave.Disabled = false;
                    WebUtils.DisableControls(this);
                }
            }
            bindGraph();


        }

        public void bindGraph()
        {
            Requirement rqm = this.rqmDAO.findById(long.Parse(this.hndRequirementId.Value), true);
            if (rqm != null)
            {
                if (rqm.chartJsonFileName != null)
                {
                    string getJsonFile = WebUtils.getJsonFile(rqm.chartJsonFileName);

                    DrawflowView df = new DrawflowView();
                    df.graphName = rqm.chartType.ToString();
                    df.json = getJsonFile.ToString();
                    df.creationDate = rqm.creationDate;
                    df.lastUpdate = rqm.lastUpDate;

                    string script = string.Format("showGraph({0});", df.json);
                    ScriptManager.RegisterStartupScript(this, Page.GetType(), "showGraph", script, true);
                }
            }
        }
        
        protected void hndJson_ValueChanged(object sender, EventArgs e)
        {
            string json = this.hndJson.Value;
            string jsonEmpty = "{\"drawflow\":{\"Home\":{\"data\":{}},\"Other\":{\"data\":{}}}}";
            if (json.CompareTo(jsonEmpty) == 0)
            {
                this.errorMessages.Add(HttpContext.GetLocalResourceObject("~/secure/F024.DrawflowDynamic.aspx",
                                                                                "pls_draw_graph",
                                                                                culture)
                                                                                .ToString());
                return;
            }

            Requirement rqm = this.rqmDAO.findById(long.Parse(this.hndRequirementId.Value), true);
            if (rqm != null)
            {
                string newfileName = string.Format("{0}.json", Guid.NewGuid());
                WebUtils.writeJsonFile(newfileName, rqm.chartJsonFileName, json);

                rqm.chartJsonFileName = newfileName;
                rqm.chartType = CHART_TYPE.CHART_DRAW_FLOW;
                rqm.lastUpDate = DateTime.Now;
                rqmDAO.update(rqm);

            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/secure/F022.ListRequirements.aspx", true);
            return;
        }
    }
}