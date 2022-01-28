using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.dao;
using XenDevWeb.domain;
using XenDevWeb.include;
using XenDevWeb.Utils;

namespace XenDevWeb.staff
{
    public partial class F021_StaffTicket : CRUDPageControler
    {
        private ProjectDAO pDAO;
        private TicketDAO ticketDAO;
        private FileUploadInfoDAO fuDAO;
        private EmailServerDAO emailServerDAO;
        private StaffAccountDAO staffAccountDAO;
        private TicketAssignmentDAO ticketAssignmentDAO;
        
        private List<Ticket> allTicket;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.pDAO = new ProjectDAO(ctx);
            this.ticketDAO = new TicketDAO(ctx);
            this.uaDAO = new UserAccountDAO(ctx);
            this.fuDAO = new FileUploadInfoDAO(ctx);
            this.emailServerDAO = new EmailServerDAO(ctx);
            this.staffAccountDAO = new StaffAccountDAO(ctx);
            this.ticketAssignmentDAO = new TicketAssignmentDAO(ctx);
            
            errorMessagesForGrid = new List<string>();
            infoMessagesForGrid = new List<string>();

            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }
            initForm();
            bindTicket();
        }

        private void initForm()
        {
            if (this.currentStaff.isAdmin)
            {
                showBtnAddTicket.Visible = true;
                populateStatus(selSearchStatus);
            }
            else
            {
                showBtnAddTicket.Visible = false;
                populateStatus(selSearchStatus);
                populateDefaultUserStatus(selSearchStatus);
            }
            
            this.txtDateFrom.Text = "1/01/" + DateTime.Now.ToString("yyyy", culture);
            this.txtDateTo.Text = DateTime.Now.ToString("d/MM/yyyy", culture);

            this.txtDateFrom.Attributes["readonly"] = "readonly";
            this.txtDateTo.Attributes["readonly"] = "readonly";
        }

        public void populateDefaultUserStatus(DropDownList sel)
        {
            sel.SelectedValue = TICKET_STATUS.ASSIGNED.ToString();
        }

        public void bindTicket()
        {
            this.allTicket = this.ticketDAO.getAllProblemsStaff(false);
            if (!(this.currentStaff.isAdmin))
            {
                this.allTicket = this.allTicket.Where(e => e.checkTicketToStaff(this.currentStaff.id) &&
                                                           e.status != TICKET_STATUS.NEW &&
                                                           e.status != TICKET_STATUS.CANCEL)
                                                           .ToList();
            }

            if (allTicket != null)
            {
                if (!ValidationUtil.isEmpty(txtProjectCode.Text))
                {
                    string projectCode = WebUtils.getLookupCode(txtProjectCode.Text);
                    Project project = this.pDAO.findByProjectCode(projectCode, false);

                    if (project != null)
                    {
                        allTicket = this.allTicket.Where(e => e.project != null
                                                         && e.project.id == project.id)
                                                         .ToList();
                    }
                }

                switch (selSearchStatus.SelectedValue)
                {
                    case "NEW":
                        allTicket = allTicket.Where(i => i.status == TICKET_STATUS.NEW).ToList();
                        break;
                    case "ON_REVIEW":
                        allTicket = allTicket.Where(i => i.status == TICKET_STATUS.ON_REVIEW).ToList();
                        break;
                    case "ASSIGNED":
                        allTicket = allTicket.Where(i => i.status == TICKET_STATUS.ASSIGNED).ToList();
                        break;
                    case "SOLVED":
                        allTicket = allTicket.Where(i => i.status == TICKET_STATUS.SOLVED).ToList();
                        break;
                    case "CLOSED":
                        allTicket = allTicket.Where(i => i.status == TICKET_STATUS.CLOSED).ToList();
                        break;
                    case "CANCEL":
                        allTicket = allTicket.Where(i => i.status == TICKET_STATUS.CANCEL).ToList();
                        break;
                }

                DateTime dateFrom = DateTime.ParseExact(txtDateFrom.Text, "d/MM/yyyy", culture);
                DateTime dateTo = DateTime.ParseExact(txtDateTo.Text, "d/MM/yyyy", culture);
                dateTo = dateTo.AddHours(23);
                dateTo = dateTo.AddMinutes(59);

                allTicket = allTicket.Where(e => e.lastUpDate >= dateFrom
                                            && e.lastUpDate <= dateTo
                                            && e.ticket_type == TICKET_TYPE.INTERNAL)
                                            .OrderByDescending(e => e.lastUpDate)
                                            .ToList();
            }

            problemInDatabaseGridView.DataSource = allTicket;
            problemInDatabaseGridView.DataBind();

        }
        
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            bindTicket();
        }

        public void populateStatus(DropDownList sel)
        {
            sel.Items.Clear();
            
            ListItem lstAll = new ListItem(HttpContext.GetLocalResourceObject("~/staff/F021.StaffTicket.aspx",
                                                                                "all", culture)
                                                                                .ToString(), "All");
            sel.Items.Add(lstAll);

            if (this.currentStaff.isAdmin)
            {
                ListItem liNew = new ListItem(HttpContext.GetLocalResourceObject("~/staff/F021.StaffTicket.aspx",
                                                                             "New", culture).ToString()
                                                                             , TICKET_STATUS.NEW.ToString());
                sel.Items.Add(liNew);

                ListItem liCancel = new ListItem(HttpContext.GetLocalResourceObject("~/staff/F021.StaffTicket.aspx",
                                                                             "Cancel", culture).ToString()
                                                                             , TICKET_STATUS.CANCEL.ToString());
                sel.Items.Add(liCancel);
            }
            
            ListItem liReview = new ListItem(HttpContext.GetLocalResourceObject("~/staff/F021.StaffTicket.aspx",
                                                                             "onReview", culture).ToString()
                                                                             , TICKET_STATUS.ON_REVIEW.ToString());

            sel.Items.Add(liReview);

            ListItem liAssigned = new ListItem(HttpContext.GetLocalResourceObject("~/staff/F021.StaffTicket.aspx",
                                                                             "Assigned", culture).ToString()
                                                                             , TICKET_STATUS.ASSIGNED.ToString());
            sel.Items.Add(liAssigned);
            ListItem liSolved = new ListItem(HttpContext.GetLocalResourceObject("~/staff/F021.StaffTicket.aspx",
                                                                             "Solved", culture).ToString()
                                                                             , TICKET_STATUS.SOLVED.ToString());
            sel.Items.Add(liSolved);
            ListItem liClosed = new ListItem(HttpContext.GetLocalResourceObject("~/staff/F021.StaffTicket.aspx",
                                                                             "Closed", culture).ToString()
                                                                             , TICKET_STATUS.CLOSED.ToString());
            sel.Items.Add(liClosed);
            
            
        }

        public void populateAssignTo(DropDownList sel)
        {
            sel.Items.Clear();

            List<StaffAccount> uaProgrammers = this.staffAccountDAO.getAllEnableStaffAccount(false)
                                                        .Where(n => n.role == USER_ROLE.PROGRAMMER)
                                                        .ToList();

            foreach (StaffAccount uaProgrammer in uaProgrammers)
            {
                ListItem liua = new ListItem(uaProgrammer.username, uaProgrammer.id.ToString());
                sel.Items.Add(liua);
            }
        }

        protected void problemInDatabaseGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            problemInDatabaseGridView.PageIndex = e.NewPageIndex;
            bindTicket();
        }

        protected void problemInDatabaseGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }

            Label lblProblemId = e.Row.FindControl("lblProblemId") as Label;
            Label lblGrid_ProjectCode = e.Row.FindControl("lblGrid_ProjectCode") as Label;
            Label lblGrid_Subject = e.Row.FindControl("lblGrid_Subject") as Label;
            Label lblGrid_Requester = e.Row.FindControl("lblGrid_Requester") as Label;
            Label lblGrid_LastUpdate = e.Row.FindControl("lblGrid_LastUpdate") as Label;
            Label lblGrid_TicketNumber = e.Row.FindControl("lblGrid_TicketNumber") as Label;

            Ticket ticket = e.Row.DataItem as Ticket;

            problemInDatabaseGridView.Columns[10].Visible = false;

            if (!(this.currentStaff.isAdmin))
            {
                problemInDatabaseGridView.Columns[8].Visible = false;
                
            }

            if (ticket.status == TICKET_STATUS.ASSIGNED)
            {
                problemInDatabaseGridView.Columns[10].Visible = true;
            }

            lblProblemId.Text = ticket.id.ToString();

            lblGrid_ProjectCode.Text = string.Format("{0}({1})", ticket.project.name
                                                              , ticket.project.code);
            lblGrid_Subject.Text = ticket.subject;
            lblGrid_Requester.Text = ticket.requester.username;
            lblGrid_TicketNumber.Text = ticket.ticketNumber;
            lblGrid_LastUpdate.Text = ticket.lastUpDate.ToString("dd/MM/yyyy hh:mm", culture);

            List<TicketAssignment> ticketAssigns = this.ticketAssignmentDAO.getAllTicketTypeInternalById(ticket.id, false);
            Label lblGrid_Status = e.Row.FindControl("lblGrid_Status") as Label;
            Label lblGrid_AssignTo = e.Row.FindControl("lblGrid_AssignTo") as Label;

            String strAssignTo = "";

            for (var i = 0; i < ticketAssigns.Count; i++)
            {
                TicketAssignment tkAssign = ticketAssigns[i];
                if (i == 0)
                {
                    strAssignTo = tkAssign.assignTo.firstName;
                }
                else
                {
                    strAssignTo = strAssignTo + " , " + tkAssign.assignTo.firstName;
                }
            }


            lblGrid_AssignTo.Text = strAssignTo;

            switch (this.currentStaff.role)
            {
                case USER_ROLE.SYSTEM:
                    lblGrid_AssignTo.Text = strAssignTo != null ? strAssignTo : "-";
                    e.Row.Cells[9].Visible = true;
                    break;
                case USER_ROLE.PROGRAMMER:
                    lblGrid_AssignTo.Text = strAssignTo != null ? strAssignTo : "-";
                    e.Row.Cells[9].Visible = false;
                    break;
            }

            switch (ticket.status)
            {
                case TICKET_STATUS.NEW:
                    lblGrid_Status.Text = HttpContext.GetLocalResourceObject("~/staff/F021.StaffTicket.aspx",
                                                                         "New", culture).ToString();
                    break;
                case TICKET_STATUS.ON_REVIEW:
                    lblGrid_Status.Text = HttpContext.GetLocalResourceObject("~/staff/F021.StaffTicket.aspx",
                                                                         "onReview", culture).ToString();
                    break;
                case TICKET_STATUS.ASSIGNED:
                    lblGrid_Status.Text = HttpContext.GetLocalResourceObject("~/staff/F021.StaffTicket.aspx",
                                                                         "Assigned", culture).ToString();
                    break;
                case TICKET_STATUS.SOLVED:
                    lblGrid_Status.Text = HttpContext.GetLocalResourceObject("~/staff/F021.StaffTicket.aspx",
                                                                         "Solved", culture).ToString();
                    break;
                case TICKET_STATUS.CLOSED:
                    lblGrid_Status.Text = HttpContext.GetLocalResourceObject("~/staff/F021.StaffTicket.aspx",
                                                                         "Closed", culture).ToString();
                    break;
                case TICKET_STATUS.CANCEL:
                    lblGrid_Status.Text = HttpContext.GetLocalResourceObject("~/staff/F021.StaffTicket.aspx",
                                                                         "Cancel", culture).ToString();
                    break;
            }

        }

        protected void problemInDatabaseGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            problemInDatabaseGridView.EditIndex = e.NewEditIndex;
            bindTicket();
        }

        protected void problemInDatabaseGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            problemInDatabaseGridView.EditIndex = -1;
            bindTicket();
        }

        protected void btnDetails_Command(object sender, CommandEventArgs e)
        {
            string ticketId = e.CommandArgument.ToString();

            Response.Redirect(WebUtils.getAppServerPath()+"/secure/F027.TicketComments.aspx?ticketId=" + HttpUtility.UrlEncode(QueryStringModule.Encrypt(ticketId)), true);
        }

        protected void btnAddTicket_Click(object sender, EventArgs e)
        {
            Response.Redirect("F019.CreateStaffTicket.aspx", true);
        }

        protected void btnUpdateTicket_Command(object sender, CommandEventArgs e)
        {
            string ticketId = e.CommandArgument.ToString();
            Response.Redirect("F020.UpdateStaffTicket.aspx?ticketId=" + HttpUtility.UrlEncode(QueryStringModule.Encrypt(ticketId)), true);
        }

        protected void btnSubmitTicket_Command(object sender, CommandEventArgs e)
        {
            long id = long.Parse(e.CommandArgument.ToString());

            Ticket tk = this.ticketDAO.findByStaffTicketTypeInternalId(id , true);

            tk.status = TICKET_STATUS.SOLVED;
            tk.lastUpDate = DateTime.Now;
            this.ticketDAO.update(tk);

            bindTicket();
            this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                              "successfully_savedRc",
                                                                               culture).ToString());
        }
    }
}