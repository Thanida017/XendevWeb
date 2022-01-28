using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.dao;
using XenDevWeb.domain;
using XenDevWeb.include;
using XenDevWeb.Utils;

namespace XenDevWeb.secure
{
    public partial class F014_Problem : CRUDPageControler
    {
        private ProjectDAO pDAO;
        private TicketDAO ticketDAO;
        private FileUploadInfoDAO fuDAO;
        private EmailServerDAO emailServerDAO;
        private StaffAccountDAO staffAccountDAO;
        private TicketAssignmentDAO ticketAssignmentDAO;

        private List<Ticket> allTickets;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.pDAO = new ProjectDAO(ctx);
            this.ticketDAO = new TicketDAO(ctx);
            this.uaDAO = new UserAccountDAO(ctx);
            this.fuDAO = new FileUploadInfoDAO(ctx);
            this.emailServerDAO = new EmailServerDAO(ctx);
            this.staffAccountDAO = new StaffAccountDAO(ctx);
            this.ticketAssignmentDAO = new TicketAssignmentDAO(ctx);

            culture = CultureInfo.CreateSpecificCulture(Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName);

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
            populateStatus(selSearchStatus);
            this.txtDateFrom.Text = "1/01/" + DateTime.Now.ToString("yyyy", new CultureInfo("en-US"));
            this.txtDateTo.Text = DateTime.Now.ToString("d/MM/yyyy", new CultureInfo("en-US"));

            this.txtDateFrom.Attributes["readonly"] = "readonly";
            this.txtDateTo.Attributes["readonly"] = "readonly";
        }

        public void bindTicket()
        {
            this.allTickets = null;
            if (this.currentStaff.isAdmin)
            {
                this.allTickets = this.ticketDAO.getAllProblems(false);
            }
            else
            {
                this.allTickets = this.ticketDAO.getAllProblems(this.currentStaff.id, false);
            }

            if (this.allTickets != null && allTickets.Count > 0)
            {

                if (!ValidationUtil.isEmpty(txtProjectCode.Text))
                {
                    string projectCode = WebUtils.getLookupCode(txtProjectCode.Text);
                    Project project = this.pDAO.findByProjectCode(projectCode, false);

                    if (project != null)
                    {
                        this.allTickets = this.allTickets.Where(e => e.project != null                                                                     
                                                                     && e.project.id == project.id)
                                                          .ToList();
                    }
                }

                switch (selSearchStatus.SelectedValue)
                {
                    case "NEW":
                        this.allTickets = this.allTickets.Where(i => i.status == TICKET_STATUS.NEW).ToList();
                        break;
                    case "ON_REVIEW":
                        this.allTickets = this.allTickets.Where(i => i.status == TICKET_STATUS.ON_REVIEW).ToList();
                        break;
                    case "ASSIGNED":
                        this.allTickets = this.allTickets.Where(i => i.status == TICKET_STATUS.ASSIGNED).ToList();
                        break;
                    case "SOLVED":
                        this.allTickets = this.allTickets.Where(i => i.status == TICKET_STATUS.SOLVED).ToList();
                        break;
                    case "CLOSED":
                        this.allTickets = this.allTickets.Where(i => i.status == TICKET_STATUS.CLOSED).ToList();
                        break;
                    case "CANCEL":
                        this.allTickets = this.allTickets.Where(i => i.status == TICKET_STATUS.CANCEL).ToList();
                        break;
                }

                DateTime dateFrom = DateTime.ParseExact(txtDateFrom.Text, "d/MM/yyyy", new CultureInfo("en-US"));
                DateTime dateTo = DateTime.ParseExact(txtDateTo.Text, "d/MM/yyyy", new CultureInfo("en-US"));
                dateTo = dateTo.AddHours(23);
                dateTo = dateTo.AddMinutes(59);

                this.allTickets = this.allTickets.Where(e => e.lastUpDate >= dateFrom
                                                             && e.lastUpDate <= dateTo
                                                             && e.ticket_type == TICKET_TYPE.CLIENT)
                                                 .OrderByDescending(e => e.lastUpDate)
                                                 .ToList();
            }

            problemInDatabaseGridView.DataSource = this.allTickets;
            problemInDatabaseGridView.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            bindTicket();
        }

        public void populateStatus(DropDownList sel)
        {
            sel.Items.Clear();

            ListItem lstAll = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F014.Problem.aspx",
                                                                                "all", culture)
                                                                                .ToString(), "All");
            sel.Items.Add(lstAll);

            ListItem liNew = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F014.Problem.aspx",
                                                                             "New", culture).ToString()
                                                                             , TICKET_STATUS.NEW.ToString());


            ListItem liReview = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F014.Problem.aspx",
                                                                             "onReview", culture).ToString()
                                                                             , TICKET_STATUS.ON_REVIEW.ToString());

            sel.Items.Add(liReview);

            ListItem liAssigned = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F014.Problem.aspx",
                                                                             "Assigned", culture).ToString()
                                                                             , TICKET_STATUS.ASSIGNED.ToString());
            sel.Items.Add(liAssigned);
            ListItem liSolved = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F014.Problem.aspx",
                                                                             "Solved", culture).ToString()
                                                                             , TICKET_STATUS.SOLVED.ToString());
            sel.Items.Add(liSolved);
            ListItem liClosed = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F014.Problem.aspx",
                                                                             "Closed", culture).ToString()
                                                                             , TICKET_STATUS.CLOSED.ToString());
            sel.Items.Add(liClosed);
            ListItem liCancel = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F014.Problem.aspx",
                                                                             "Cancel", culture).ToString()
                                                                             , TICKET_STATUS.CANCEL.ToString());
            sel.Items.Add(liCancel);
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

            Ticket ticket = e.Row.DataItem as Ticket;

            Label lblProblemId = e.Row.FindControl("lblProblemId") as Label;
            lblProblemId.Text = ticket.id.ToString();

            Label lblGrid_ProjectCode = e.Row.FindControl("lblGrid_ProjectCode") as Label;
            Label lblGrid_Subject = e.Row.FindControl("lblGrid_Subject") as Label;
            Label lblGrid_Requester = e.Row.FindControl("lblGrid_Requester") as Label;
            Label lblGrid_LastUpdate = e.Row.FindControl("lblGrid_LastUpdate") as Label;
            Label lblGrid_TicketNumber = e.Row.FindControl("lblGrid_TicketNumber") as Label;

            lblGrid_ProjectCode.Text = string.Format("{0}({1})", ticket.project.name
                                                              , ticket.project.code);
            lblGrid_Subject.Text = ticket.subject;
            lblGrid_Requester.Text = ticket.requester.username;
            lblGrid_TicketNumber.Text = ticket.ticketNumber;
            lblGrid_LastUpdate.Text = ticket.lastUpDate.ToString("dd/MM/yyyy hh:mm", new CultureInfo("en-US"));

            if ((e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                DropDownList selGrid_Status = e.Row.FindControl("selGrid_Status") as DropDownList;
                DropDownList selGrid_AssignTo = e.Row.FindControl("selGrid_AssignTo") as DropDownList;

                populateStatus(selGrid_Status);
                selGrid_Status.SelectedValue = ticket.status.ToString();

                populateAssignTo(selGrid_AssignTo);
                TicketAssignment ticketAssign = this.ticketAssignmentDAO.findByTicketID(ticket.id, false);
                if (ticketAssign != null)
                {
                    selGrid_AssignTo.SelectedValue = ticketAssign.assignTo.ToString();
                }

            }
            else
            {
                Label lblGrid_Status = e.Row.FindControl("lblGrid_Status") as Label;
                Label lblGrid_AssignTo = e.Row.FindControl("lblGrid_AssignTo") as Label;

                switch (ticket.status)
                {
                    case TICKET_STATUS.NEW:
                        lblGrid_Status.Text = HttpContext.GetLocalResourceObject("~/secure/F014.Problem.aspx",
                                                                             "New", culture).ToString();
                        break;
                    case TICKET_STATUS.ON_REVIEW:
                        lblGrid_Status.Text = HttpContext.GetLocalResourceObject("~/secure/F014.Problem.aspx",
                                                                             "onReview", culture).ToString();
                        break;
                    case TICKET_STATUS.ASSIGNED:
                        lblGrid_Status.Text = HttpContext.GetLocalResourceObject("~/secure/F014.Problem.aspx",
                                                                             "Assigned", culture).ToString();
                        break;
                    case TICKET_STATUS.SOLVED:
                        lblGrid_Status.Text = HttpContext.GetLocalResourceObject("~/secure/F014.Problem.aspx",
                                                                             "Solved", culture).ToString();
                        break;
                    case TICKET_STATUS.CLOSED:
                        lblGrid_Status.Text = HttpContext.GetLocalResourceObject("~/secure/F014.Problem.aspx",
                                                                             "Closed", culture).ToString();
                        break;
                    case TICKET_STATUS.CANCEL:
                        lblGrid_Status.Text = HttpContext.GetLocalResourceObject("~/secure/F014.Problem.aspx",
                                                                             "Cancel", culture).ToString();
                        break;
                }

                switch (this.currentStaff.role)
                {
                    case USER_ROLE.SYSTEM:
                        TicketAssignment ticketAssign = this.ticketAssignmentDAO.findByTicketID(ticket.id, false);
                        lblGrid_AssignTo.Text = ticketAssign != null ? ticketAssign.assignTo.firstName : "-";
                        e.Row.Cells[9].Visible = true;
                        break;
                    case USER_ROLE.PROGRAMMER:
                        ticketAssign = this.ticketAssignmentDAO.findByTicketID(ticket.id, false);
                        lblGrid_AssignTo.Text = ticketAssign != null ? ticketAssign.assignTo.firstName : "-";
                        e.Row.Cells[9].Visible = false;
                        break;
                }
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

        protected void problemInDatabaseGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = this.problemInDatabaseGridView.Rows[e.RowIndex];
            Label lblProblemId = row.FindControl("lblProblemId") as Label;
            DropDownList selGrid_Status = row.FindControl("selGrid_Status") as DropDownList;
            DropDownList selGrid_AssignTo = row.FindControl("selGrid_AssignTo") as DropDownList;

            long id = long.Parse(lblProblemId.Text);

            Ticket ticket = this.ticketDAO.findById(id, true);
            switch (selGrid_Status.SelectedValue)
            {
                case "NEW":
                    ticket.status = TICKET_STATUS.NEW;
                    break;
                case "ON_REVIEW":
                    ticket.status = TICKET_STATUS.ON_REVIEW;
                    break;
                case "ASSIGNED":
                    ticket.status = TICKET_STATUS.ASSIGNED;
                    break;
                case "SOLVED":
                    ticket.status = TICKET_STATUS.SOLVED;
                    break;
                case "CLOSED":
                    ticket.status = TICKET_STATUS.CLOSED;
                    break;
                case "CANCEL":
                    ticket.status = TICKET_STATUS.CANCEL;
                    break;
            }
            ticket.lastUpDate = DateTime.Now;

            TicketAssignment tkAssign = this.ticketAssignmentDAO.findByTicketID(id, true);
            if (ValidationUtil.isDigit(selGrid_AssignTo.SelectedValue))
            {
                tkAssign.assignTo.id = int.Parse(selGrid_AssignTo.SelectedValue);
            }
            
            //Update status to user
            EmailServer emailServer = emailServerDAO.getRecentRecord(false);
            bool sendSuccess = false;
            try
            {
                string bodyHTML = string.Format(@"<h1>Your ticket number {0} had update Status to {1}.<br/>Click this 
                                                    <a href=""{2}"">link</a>  
                                                    for information.</h1>",
                                                    ticket.ticketNumber,
                                                    ticket.status,
                                                    this.getEmailApprovalLink(ticket.id.ToString()));
                sendSuccess = EmailUtil.sendEMail(emailServer.stmpAddress,
                                               int.Parse(emailServer.port),
                                               emailServer.username,
                                               emailServer.password,
                                               emailServer.senderAddress,
                                               ticket.requester.email,
                                               null,
                                               $"MetaLink {ticket.subject}",
                                               bodyHTML);
            }
            catch (Exception ioe)
            {
                sendSuccess = false;
                this.errorMessagesForGrid.Add(ioe.ToString());
            }

            if (sendSuccess)
            {
                this.infoMessagesForGrid.Add(string.Format(HttpContext.GetGlobalResourceObject("GlobalResource", "email_sended_success",
                                                        culture).ToString(),
                                                        ticket.requester.email));
            }

            this.ticketDAO.update(ticket);

            this.problemInDatabaseGridView.EditIndex = -1;
            bindTicket();

            this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                            "successfully_savedRc",
                                                                            culture).ToString());
        }

        private string getEmailApprovalLink(string ticketId)
        {
            return WebUtils.getAppServerPath() + "/secure/F015.Comment_Problem.aspx?problemId=" + ticketId;
        }

        protected void btnDetails_Command(object sender, CommandEventArgs e)
        {
            String problemId = e.CommandArgument.ToString();

            Response.Redirect("F015.Comment_Problem.aspx?problemId=" + HttpUtility.UrlEncode(QueryStringModule.Encrypt(problemId)) , true);
        }

        protected void btnAddTicket_Click(object sender, EventArgs e)
        {
            Response.Redirect(WebUtils.getAppServerPath() + "/secure/F030.CreateProblemTicket.aspx", true);
        }

        protected void btnUpdateTicket_Command(object sender, CommandEventArgs e)
        {
            String ticketId = e.CommandArgument.ToString();
            Response.Redirect(WebUtils.getAppServerPath() + "/secure/F031.UpdateProblemTicket.aspx?ticketId=" + HttpUtility.UrlEncode(QueryStringModule.Encrypt(ticketId)), true);
        }
    }
}