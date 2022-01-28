using System;
using System.Collections.Generic;
using System.Data;
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

namespace XenDevWeb.admin
{
    public partial class F005_MeetingNote : CRUDPageControler
    {
        private MeetingNoteDAO mtnDAO;
        private ProjectDAO proDAO;
        private CompanyDAO comDAO;

        private List<MeetingNote> allmtn;
        private List<Project> allpro;

        protected void Page_Load(object sender, EventArgs e)
        {
            mtnDAO = new MeetingNoteDAO(ctx);
            proDAO = new ProjectDAO(ctx);
            comDAO = new CompanyDAO(ctx);

            culture = CultureInfo.CreateSpecificCulture(Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName);

            infoMessagesForGrid = new List<string>();
            errorMessagesForGrid = new List<string>();

            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            this.initForm();
            this.bindMeetingNoteGrid();
        }

        private void initForm()
        {
            this.txtRowPerPage.Text = Constants.DEFAULT_ROW_PER_PAGE.ToString();
            this.txtDateFrom.Text = DateTime.Now.ToString("d/MM/yyyy", new CultureInfo("en-US"));
            this.txtDateTo.Text = DateTime.Now.ToString("d/MM/yyyy", new CultureInfo("en-US"));

            this.txtDateFrom.Attributes["readonly"] = "readonly";
            this.txtDateTo.Attributes["readonly"] = "readonly";

            this.populateCompany(this.selCompany);

            setDefaultCompanySelection();
            checkChangingCompanyPrivileges();
            this.populateProject(this.selProjects);
        }

        private int getUserCompanyId()
        {
            return this.currentUser != null ? this.currentUser.company.id : 0;
        }

        private void setDefaultCompanySelection()
        {
            Company com = this.comDAO.findById(this.getUserCompanyId(), false);

            if (com != null)
            {
                this.selCompany.SelectedValue = com.id.ToString();
            }
        }


        private void checkChangingCompanyPrivileges()
        {
            if (this.currentUser != null)
            {
                this.divSelCompany.Visible = false;
            }
            else
            {
                this.divSelCompany.Visible = true;
            }
        }

        private void populateCompany(DropDownList sel)
        {
            sel.Items.Clear();

            List<Company> coms = this.comDAO.getAllEnabledCompanies(false)
                                                    .OrderBy(o => o.name)
                                                    .ToList();
            foreach (Company com in coms)
            {
                ListItem li = new ListItem(com.name, com.id.ToString());
                sel.Items.Add(li);
            }
        }

        private void populateProject(DropDownList sel)
        {
            sel.Items.Clear();

            this.allpro = this.proDAO.getCompanyProject(long.Parse(this.selCompany.SelectedValue), false)
                                                    .OrderBy(o => o.name)
                                                    .ToList();

            this.btnAddMeeting.Visible = (this.allpro != null && this.allpro.Count > 0);

            foreach (Project pro in this.allpro)
            {
                ListItem li = new ListItem(pro.name, pro.id.ToString());
                sel.Items.Add(li);
            }
        }

        private void bindMeetingNoteGrid()
        {
            DateTime dateFrom = DateTime.ParseExact(txtDateFrom.Text, "d/MM/yyyy", new CultureInfo("en-US"));
            DateTime dateTo = DateTime.ParseExact(txtDateTo.Text, "d/MM/yyyy", new CultureInfo("en-US"));
            dateTo = dateTo.AddHours(23);
            dateTo = dateTo.AddMinutes(59);

            if (!ValidationUtil.isEmpty(selProjects.SelectedValue))
            {
                int selectedProjectId = int.Parse(selProjects.SelectedValue);

                this.allmtn = this.mtnDAO.getAllNoteEnable(selectedProjectId, dateFrom, dateTo, false)
                                                               .OrderByDescending(o => o.creationDate)
                                                               .ToList();
            }

            this.meetingNotesGridView.PageSize = int.Parse(this.txtRowPerPage.Text);
            this.meetingNotesGridView.DataSource = this.allmtn;
            this.meetingNotesGridView.DataBind();
        }

        protected void meetingNotesGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.meetingNotesGridView.PageIndex = e.NewPageIndex;
            this.bindMeetingNoteGrid();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void meetingNotesGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            this.meetingNotesGridView.PageIndex = e.NewEditIndex;
            this.bindMeetingNoteGrid();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void meetingNotesGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            //No Update Data
        }

        protected void meetingNotesGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            this.meetingNotesGridView.PageIndex = -1;
            this.bindMeetingNoteGrid();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void meetingNotesGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }

            MeetingNote obj = e.Row.DataItem as MeetingNote;
            Label lblMeetingNoteGrid_Id = e.Row.FindControl("lblMeetingNoteGrid_Id") as Label;
            Label lblMeetingNoteGrid_Date = e.Row.FindControl("lblMeetingNoteGrid_Date") as Label;
            Label lblMeetingNoteGrid_Participant = e.Row.FindControl("lblMeetingNoteGrid_Participant") as Label;
            HyperLink hplGridPdf = e.Row.FindControl("hplGridPdf") as HyperLink;
            lblMeetingNoteGrid_Id.Text = obj.id.ToString();
            lblMeetingNoteGrid_Date.Text = string.Format(obj.meetingDateTime.ToString("dd/MM/yyyy HH:mm", new CultureInfo("en-Us")));
            //lblMeetingNoteGrid_Participant.Text = obj.participant.ToString();

            hplGridPdf.NavigateUrl = WebUtils.getAppServerPath() + "/secure/Meeing_note_download.aspx?mtnId=" + obj.id;
            hplGridPdf.Target = "_blank";
            hplGridPdf.CssClass = "activeLink";

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Page.Validate("vsSearchGroup");
            if (!Page.IsValid)
            {
                return;
            }
            this.bindMeetingNoteGrid();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
        }

        protected void btnDeteils_Command(object sender, CommandEventArgs e)
        {
            string mnID = e.CommandArgument.ToString();
            Response.Redirect("F006.AddMeetingNote.aspx?mtnId=" + HttpUtility.UrlEncode(QueryStringModule.Encrypt(mnID)), true);
        }

        protected void btnAddMeeting_Click(object sender, EventArgs e)
        {
            Project pj = proDAO.findByProjectId(long.Parse(selProjects.SelectedValue), true);

            if (pj != null)
            {
                MeetingNote mn = new MeetingNote();
                mn.project = pj;
                mn.meetingDateTime = DateTime.Now;
                mn.lastUpdate = DateTime.Now;
                mn.creationDate = DateTime.Now;
                mn.isEnabled = true;

                if (this.currentUser != null)
                {
                    mn.createdBy = uaDAO.findByUsername(this.currentUser.username, true);
                }

                mtnDAO.create(mn);

                Response.Redirect("F006.AddMeetingNote.aspx?mtnId=" + HttpUtility.UrlEncode(QueryStringModule.Encrypt(mn.id.ToString())), true);
            }
        }

        protected void btnDetete_Command(object sender, CommandEventArgs e)
        {
            long mnID = long.Parse(e.CommandArgument.ToString());

            MeetingNote mn = mtnDAO.findById(mnID, true);
            mn.isEnabled = false;
            mtnDAO.update(mn);
            bindMeetingNoteGrid();
            ScriptManager.RegisterStartupScript(Page, GetType(), "updateNiceScroll", "$('body').getNiceScroll().resize();", true);
            this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                  "successfully_savedRc",
                                                                  culture).ToString());
        }

        protected void selCompany_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.populateProject(this.selProjects);
        }
    }
}