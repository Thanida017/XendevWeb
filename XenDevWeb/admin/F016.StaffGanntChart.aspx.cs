using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.dao;
using XenDevWeb.domain;
using XenDevWeb.Test.SimpleGanttChart.view;

namespace XenDevWeb.admin
{
    public partial class F016_StaffGanntChart : System.Web.UI.Page
    {
        protected CultureInfo culture;
        protected List<string> errorMessages;
        protected List<string> infoMessages;

        public XenDevWebDbContext ctx;
        public StaffAccountDAO saDAO;
        public ProjectDAO pjDAO;
        public TicketDAO tkDAO;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.ctx = new XenDevWebDbContext();
            this.saDAO = new StaffAccountDAO(this.ctx);
            this.pjDAO = new ProjectDAO(this.ctx);
            this.tkDAO = new TicketDAO(this.ctx);

            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            initForm();
        }

        private void initForm()
        {
            this.populateStaff(this.selStaff);
            this.populateStatus(this.selStatus);
            bindStaffGanntChart();
        }

        private void populateStaff(DropDownList list)
        {
            list.Items.Clear();

            string liAll = HttpContext.GetLocalResourceObject("~/admin/F016.StaffGanntChart.aspx", "all", culture).ToString();
            list.Items.Add(new ListItem(liAll, "0"));

            List<StaffAccount> allStaffAccount = this.saDAO.getAllEnableStaffAccount(false);

            foreach(StaffAccount sa in allStaffAccount)
            {
                list.Items.Add(new ListItem(string.Format("{0} {1}", sa.firstName, sa.lastName), sa.id.ToString()));
            }
        }

        private void populateStatus(DropDownList list)
        {
            list.Items.Clear();

            string liAll = HttpContext.GetLocalResourceObject("~/admin/F016.StaffGanntChart.aspx", "all", culture).ToString();
            list.Items.Add(new ListItem(liAll, "0"));

            string liNew = HttpContext.GetLocalResourceObject("~/admin/F016.StaffGanntChart.aspx", "new", culture).ToString();
            list.Items.Add(new ListItem(liNew, "1"));

            string liOnReview = HttpContext.GetLocalResourceObject("~/admin/F016.StaffGanntChart.aspx", "onReview", culture).ToString();
            list.Items.Add(new ListItem(liOnReview, "2"));

            string liAssigned = HttpContext.GetLocalResourceObject("~/admin/F016.StaffGanntChart.aspx", "assigned", culture).ToString();
            list.Items.Add(new ListItem(liAssigned, "3"));

            string liSolved = HttpContext.GetLocalResourceObject("~/admin/F016.StaffGanntChart.aspx", "solved", culture).ToString();
            list.Items.Add(new ListItem(liSolved, "4"));

            string liClosed = HttpContext.GetLocalResourceObject("~/admin/F016.StaffGanntChart.aspx", "Closed", culture).ToString();
            list.Items.Add(new ListItem(liClosed, "5"));

            string liCancel = HttpContext.GetLocalResourceObject("~/admin/F016.StaffGanntChart.aspx", "Cancel", culture).ToString();
            list.Items.Add(new ListItem(liCancel, "6"));

        }

        public void bindStaffGanntChart()
        {
            List<Ticket> tkAll = this.tkDAO.getAllProblems(false);

            if (tkAll != null && tkAll.Count > 0)
            {
                if(long.Parse(this.selStaff.SelectedValue) > 0)
                {
                    tkAll = tkAll.Where(e => e.requester != null && e.requester.id == long.Parse(this.selStaff.SelectedValue)).ToList();
                }

                if (long.Parse(this.selStatus.SelectedValue) == 1)
                {
                    tkAll = tkAll.Where(e => e.status == TICKET_STATUS.NEW).ToList();
                }
                else if (long.Parse(this.selStatus.SelectedValue) == 2)
                {
                    tkAll = tkAll.Where(e => e.status == TICKET_STATUS.ON_REVIEW).ToList();
                }
                else if (long.Parse(this.selStatus.SelectedValue) == 3)
                {
                    tkAll = tkAll.Where(e => e.status == TICKET_STATUS.ASSIGNED).ToList();
                }
                else if (long.Parse(this.selStatus.SelectedValue) == 4)
                {
                    tkAll = tkAll.Where(e => e.status == TICKET_STATUS.SOLVED).ToList();
                }
                else if (long.Parse(this.selStatus.SelectedValue) == 5)
                {
                    tkAll = tkAll.Where(e => e.status == TICKET_STATUS.CLOSED).ToList();
                }
                else if (long.Parse(this.selStatus.SelectedValue) == 6)
                {
                    tkAll = tkAll.Where(e => e.status == TICKET_STATUS.CANCEL).ToList();
                }

                tkAll = tkAll.Where(e => e.ticket_type == TICKET_TYPE.INTERNAL).ToList();
                this.genStaffGanntChart(tkAll);
            }
        }

        public void genStaffGanntChart(List<Ticket> tks)
        {
            List<SimpleGanttChartView> fcView = new List<SimpleGanttChartView>();

            int beforeProjectId = 0;
            foreach(Ticket tk in tks)
            {
                SimpleGanttChartView fc = new SimpleGanttChartView();
                if (beforeProjectId != tk.project.id)
                {
                    beforeProjectId = tk.project.id;
                    fc = new SimpleGanttChartView();
                    fc.start = string.Format("{0:yyyy}-{0:MM}-{0:dd}", tk.project.creationDate);
                    fc.end = string.Format("{0:yyyy}-{0:MM}-{0:dd}", tk.project.lastUpdate); ;
                    fc.name = tk.project.name;
                    fc.id = string.Format("project {0}", tk.project.id);
                    fc.progress = tk.project.lastUpdate.Day - tk.project.creationDate.Day;
                    fc.dependencies = "";
                    fc.custom_class = "";
                    fcView.Add(fc);
                }

                fc = new SimpleGanttChartView();
                fc.start = string.Format("{0:yyyy}-{0:MM}-{0:dd}", tk.creationDate);
                fc.end = string.Format("{0:yyyy}-{0:MM}-{0:dd}", tk.lastUpDate); ;
                fc.name = tk.subject;
                fc.id = string.Format("Ticket {0}", tk.id);
                fc.progress = tk.lastUpDate.Day - tk.creationDate.Day;
                fc.dependencies = string.Format("project {0}", tk.project.id);
                fc.custom_class = "";
                fcView.Add(fc);
            }

            string data = new JavaScriptSerializer().Serialize(fcView);
            string script = string.Format("showGraph({0});", data);
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "showGraph", script, true);
        }

        protected void btnQuery_Click(object sender, EventArgs e)
        {
            bindStaffGanntChart();
        }
    }
}