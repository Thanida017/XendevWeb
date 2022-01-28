using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.dao;
using XenDevWeb.domain;
using XenDevWeb.include;
using XenDevWeb.Test.SimpleGanttChart.view;

namespace XenDevWeb.staff
{
    public partial class F017_StaffTicketGanntChart : CRUDPageControler
    {
        public ProjectDAO pjDAO;
        public TicketDAO tkDAO;
        public TicketAssignmentDAO tkAssignDAO;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.pjDAO = new ProjectDAO(this.ctx);
            this.tkDAO = new TicketDAO(this.ctx);
            this.tkAssignDAO = new TicketAssignmentDAO(this.ctx);

            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            initForm();
        }

        private void initForm()
        {
            this.txtDateFrom.Text = DateTime.Now.ToString("d/MM/yyyy", culture);
            this.txtDateTo.Text = DateTime.Now.ToString("d/MM/yyyy", culture);
            this.txtDateFrom.Attributes["readonly"] = "readonly";
            this.txtDateTo.Attributes["readonly"] = "readonly";
            this.populateStatus(this.selStatus);
            bindStaffGanntChart();
        }

        private void populateStatus(DropDownList list)
        {
            list.Items.Clear();

            string liAll = HttpContext.GetLocalResourceObject("~/staff/F017.StaffTicketGanntChart.aspx", "all", culture).ToString();
            list.Items.Add(new ListItem(liAll, "0"));

            string liNew = HttpContext.GetLocalResourceObject("~/staff/F017.StaffTicketGanntChart.aspx", "new", culture).ToString();
            list.Items.Add(new ListItem(liNew, "1"));

            string liOnReview = HttpContext.GetLocalResourceObject("~/staff/F017.StaffTicketGanntChart.aspx", "onReview", culture).ToString();
            list.Items.Add(new ListItem(liOnReview, "2"));

            string liAssigned = HttpContext.GetLocalResourceObject("~/staff/F017.StaffTicketGanntChart.aspx", "assigned", culture).ToString();
            list.Items.Add(new ListItem(liAssigned, "3"));

            string liSolved = HttpContext.GetLocalResourceObject("~/staff/F017.StaffTicketGanntChart.aspx", "solved", culture).ToString();
            list.Items.Add(new ListItem(liSolved, "4"));

            string liClosed = HttpContext.GetLocalResourceObject("~/staff/F017.StaffTicketGanntChart.aspx", "Closed", culture).ToString();
            list.Items.Add(new ListItem(liClosed, "5"));

            string liCancel = HttpContext.GetLocalResourceObject("~/staff/F017.StaffTicketGanntChart.aspx", "Cancel", culture).ToString();
            list.Items.Add(new ListItem(liCancel, "6"));

        }

        public void bindStaffGanntChart()
        {

            DateTime dateFrom = DateTime.ParseExact(txtDateFrom.Text, "d/MM/yyyy", culture);
            DateTime dateTo = DateTime.ParseExact(txtDateTo.Text, "d/MM/yyyy", culture);
            dateTo = dateTo.AddHours(23);
            dateTo = dateTo.AddMinutes(59);
            
            List<TicketAssignment> tkAssign = this.tkAssignDAO.getAllTicketByAssignToId(long.Parse(this.currentStaff.id.ToString()), false)
                                                                                        .Where(o => o.ticket.ticket_type == TICKET_TYPE.INTERNAL)
                                                                                        .ToList();
            if (long.Parse(this.selStatus.SelectedValue) == 0)
            {
                tkAssign = tkAssign.Where(o => o.ticket.project != null &&
                                            o.ticket.project.creationDate >= dateFrom &&
                                            o.ticket.project.lastUpdate <= dateTo)
                                            .OrderBy(o => o.ticket.id)
                                            .ToList();
            }
            else if (long.Parse(this.selStatus.SelectedValue) == 1)
            {
                tkAssign = tkAssign.Where(o => o.ticket.project != null &&
                                            o.ticket.project.creationDate >= dateFrom &&
                                            o.ticket.project.lastUpdate <= dateTo &&
                                            o.ticket.status == TICKET_STATUS.NEW)
                                            .OrderBy(o => o.ticket.id)
                                            .ToList();
            }
            else if (long.Parse(this.selStatus.SelectedValue) == 2)
            {
                tkAssign = tkAssign.Where(o => o.ticket.project != null &&
                                            o.ticket.project.creationDate >= dateFrom &&
                                            o.ticket.project.lastUpdate <= dateTo &&
                                            o.ticket.status == TICKET_STATUS.ON_REVIEW)
                                            .OrderBy(o => o.ticket.id)
                                            .ToList();
            }
            else if (long.Parse(this.selStatus.SelectedValue) == 3)
            {
                tkAssign = tkAssign.Where(o => o.ticket.project != null &&
                                            o.ticket.project.creationDate >= dateFrom &&
                                            o.ticket.project.lastUpdate <= dateTo &&
                                            o.ticket.status == TICKET_STATUS.ASSIGNED)
                                            .OrderBy(o => o.ticket.id)
                                            .ToList();
            }
            else if (long.Parse(this.selStatus.SelectedValue) == 4)
            {
                tkAssign = tkAssign.Where(o => o.ticket.project != null &&
                                            o.ticket.project.creationDate >= dateFrom &&
                                            o.ticket.project.lastUpdate <= dateTo &&
                                            o.ticket.status == TICKET_STATUS.SOLVED)
                                            .OrderBy(o => o.ticket.id)
                                            .ToList();
            }
            else if (long.Parse(this.selStatus.SelectedValue) == 5)
            {
                tkAssign = tkAssign.Where(o => o.ticket.project != null &&
                                            o.ticket.project.creationDate >= dateFrom &&
                                            o.ticket.project.lastUpdate <= dateTo &&
                                            o.ticket.status == TICKET_STATUS.CLOSED)
                                            .OrderBy(o => o.ticket.id)
                                            .ToList();
            }
            else if (long.Parse(this.selStatus.SelectedValue) == 6)
            {
                tkAssign = tkAssign.Where(o => o.ticket.project != null &&
                                            o.ticket.project.creationDate >= dateFrom &&
                                            o.ticket.project.lastUpdate <= dateTo &&
                                            o.ticket.status == TICKET_STATUS.CANCEL)
                                            .OrderBy(o => o.ticket.id)
                                            .ToList();
            }

            this.genStaffGanntChart(tkAssign);
        }

        public void genStaffGanntChart(List<TicketAssignment> tkAssigns)
        {
            List<SimpleGanttChartView> fcView = new List<SimpleGanttChartView>();

            int beforeProjectId = 0;
            foreach (TicketAssignment tkAssign in tkAssigns)
            {
                SimpleGanttChartView fc = new SimpleGanttChartView();
                if (beforeProjectId != tkAssign.ticket.project.id)
                {
                    beforeProjectId = tkAssign.ticket.project.id;
                    fc = new SimpleGanttChartView();
                    fc.start = string.Format("{0:yyyy}-{0:MM}-{0:dd}", tkAssign.ticket.project.creationDate);
                    fc.end = string.Format("{0:yyyy}-{0:MM}-{0:dd}", tkAssign.ticket.project.lastUpdate); ;
                    fc.name = tkAssign.ticket.project.name;
                    fc.id = string.Format("project {0}", tkAssign.ticket.project.id);
                    fc.progress = tkAssign.ticket.project.lastUpdate.Day - tkAssign.ticket.project.creationDate.Day;
                    fc.dependencies = "";
                    fc.custom_class = "";
                    fcView.Add(fc);
                }

                fc = new SimpleGanttChartView();
                fc.start = string.Format("{0:yyyy}-{0:MM}-{0:dd}", tkAssign.ticket.creationDate);
                fc.end = string.Format("{0:yyyy}-{0:MM}-{0:dd}", tkAssign.ticket.lastUpDate); ;
                fc.name = tkAssign.ticket.subject;
                fc.id = string.Format("Ticket {0}", tkAssign.ticket.id);
                fc.progress = tkAssign.ticket.lastUpDate.Day - tkAssign.ticket.creationDate.Day;
                fc.dependencies = string.Format("project {0}", tkAssign.ticket.project.id);
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