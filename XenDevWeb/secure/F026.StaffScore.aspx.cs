using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.domain;
using XenDevWeb.include;
using XenDevWeb.view;

namespace XenDevWeb.secure
{
    public partial class F026_StaffScore : CRUDPageControler
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            culture = CultureInfo.CreateSpecificCulture(Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName);
            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            initForm();
        }

        private void initForm()
        {
            this.txtDateFrom.Text = "1/01/" + DateTime.Now.ToString("yyyy", culture);
            this.txtDateTo.Text = "31/12/" + DateTime.Now.ToString("yyyy", culture);

            this.txtDateFrom.Attributes["readonly"] = "readonly";
            this.txtDateTo.Attributes["readonly"] = "readonly";

            bindStaffScore();
        }

        public void bindStaffScore()
        {
            getScoreGridViewData();
            getScoreChartData();
        }

        public void getScoreGridViewData()
        {
            List<StaffAccount> allS = this.saDAO.getAllEnableStaffAccount(false);
            List<StaffScoreView> allSsv = new List<StaffScoreView>();
            Random r = new Random();
            foreach (StaffAccount sa in allS)
            {
                StaffScoreView ssv = new StaffScoreView();
                int submit = r.Next(20) > 0? r.Next(20): 15;
                int failedSpec = r.Next(10) ;
                int error = r.Next(5);
                int total = submit - (failedSpec + error);

                ssv.name = sa.firstName;
                ssv.submit = submit.ToString();
                ssv.pass = total.ToString();
                ssv.failedSpec = failedSpec.ToString();
                ssv.error = error.ToString();
                ssv.total = total.ToString();

                allSsv.Add(ssv);
            }

            staffScoreGridView.DataSource = allSsv;
            staffScoreGridView.DataBind();
        }

        public void getScoreChartData()
        {
            List<StaffAccount> allS = this.saDAO.getAllEnableStaffAccount(false);
            List<StaffScoreGraphElementsView> sgeViews = new List<StaffScoreGraphElementsView>();
            Random r = new Random();
            foreach (StaffAccount sa in allS)
            {
                StaffScoreGraphElementsView sseView = new StaffScoreGraphElementsView();
                sseView.personName = sa.firstName;
                sseView.assigned = r.Next(100);
                sseView.submitFailed = r.Next(100);
                sseView.submitPass = r.Next(100);
                sseView.wip = r.Next(100);
                sgeViews.Add(sseView);
            }

            object assignedData = getJSonObject(sgeViews, "Assigned");
            object wipData = getJSonObject(sgeViews, "WIP");
            object passData = getJSonObject(sgeViews, "submit-pass");
            object failedData = getJSonObject(sgeViews, "submit-failed");

            List<object> finalData = new List<object>();
            finalData.Add(assignedData);
            finalData.Add(wipData);
            finalData.Add(passData);
            finalData.Add(failedData);

            //1.3 output to json
            string outputJson = JsonConvert.SerializeObject(finalData);
            getScoreChartData(outputJson);
        }

        public object getJSonObject(List<StaffScoreGraphElementsView> everyone, string type)
        {
            Dictionary<string, object> dictionary = new Dictionary<string, object>();
            dictionary.Add("category", type);

            foreach (StaffScoreGraphElementsView rw in everyone)
            {
                string fieldName = "value-" + rw.personName;
                int value = 0;
                if (type.CompareTo("Assigned") == 0)
                {
                    value = rw.assigned;
                }
                else if (type.CompareTo("WIP") == 0)
                {
                    value = rw.wip;
                }
                else if (type.CompareTo("submit-pass") == 0)
                {
                    value = rw.submitPass;
                }
                else if (type.CompareTo("submit-failed") == 0)
                {
                    value = rw.submitFailed;
                }

                dictionary.Add(fieldName, value);
            }

            return dictionary;
        }

        public void getScoreChartData(string strJson)
        {
            //string data = new JavaScriptSerializer().Serialize(finalData);
            string script = string.Format("drawChartStaffScore({0});", strJson);
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "drawChartStaffScore", script, true);
        }

        protected void btnQuery_Click(object sender, EventArgs e)
        {
            bindStaffScore();
        }

        protected void staffScoreGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            staffScoreGridView.PageIndex = e.NewPageIndex;
            bindStaffScore();
        }

        protected void staffScoreGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }

            StaffScoreView ssv = e.Row.DataItem as StaffScoreView;
            Label lblstaffScoreGridView_name = e.Row.FindControl("lblstaffScoreGridView_name") as Label;
            Label lblStaffScoreGridView_submit = e.Row.FindControl("lblStaffScoreGridView_submit") as Label;
            Label lblStaffScoreGridView_pass = e.Row.FindControl("lblStaffScoreGridView_pass") as Label;
            Label lblStaffScoreGridView_failedSpec = e.Row.FindControl("lblStaffScoreGridView_failedSpec") as Label;
            Label lblStaffScoreGridView_error = e.Row.FindControl("lblStaffScoreGridView_error") as Label;
            Label lblStaffScoreGridView_Total = e.Row.FindControl("lblStaffScoreGridView_Total") as Label;

            lblstaffScoreGridView_name.Text = ssv.name;
            lblStaffScoreGridView_submit.Text = ssv.submit;
            lblStaffScoreGridView_pass.Text = ssv.pass;
            lblStaffScoreGridView_failedSpec.Text = ssv.failedSpec == "0" ? "" : ssv.failedSpec;
            lblStaffScoreGridView_error.Text = ssv.error;
            lblStaffScoreGridView_Total.Text = ssv.total;
        }
    }
}