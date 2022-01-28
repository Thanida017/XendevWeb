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

namespace XenDevWeb.secure
{
    public partial class F025_UpdateRequirement : CRUDPageControler
    {
        private ProjectDAO pjDAO;
        private MeetingNoteDAO mnDAO;
        private RequirementDAO rqmDAO;
        private ApprovalTransactionsDAO atDAO;
        private ApproveUtil approveUtilDAO;

        public List<string> errorMessagesForUpdate;
        public List<string> infoMessagesForUpdate;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.pjDAO = new ProjectDAO(this.ctx);
            this.mnDAO = new MeetingNoteDAO(this.ctx);
            this.rqmDAO = new RequirementDAO(this.ctx);
            this.approveUtilDAO = new ApproveUtil(ctx);
            this.atDAO = new ApprovalTransactionsDAO(this.ctx);

            this.errorMessagesForUpdate = new List<string>();
            this.infoMessagesForUpdate = new List<string>();

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

            if (!ValidationUtil.isEmpty(Request.QueryString["newCreate"]))
            {
                this.hndNewCreate.Value = QueryStringModule.Decrypt(HttpUtility.UrlDecode(Request.QueryString["newCreate"]));
                if (this.hndNewCreate.Value == "true")
                {
                    this.infoMessagesForUpdate.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                              "successfully_savedRc",
                                                                               culture).ToString());
                }
            }
            
            this.initForm();
        }

        private void initForm()
        {
            this.populateProject(selProject);
            this.populateMeetingNote(selMeetingNote, selProject);

            Requirement rqm = this.rqmDAO.findById(long.Parse(this.hndRequirementId.Value), false);
            if (rqm.status != REQUIREMENT_STATUS.COMPOSING)
            {
                this.txtTitle.Enabled = false;
                this.txtCode.Enabled = false;
                this.txtRevision.Enabled = false;
                this.txtManday.Enabled = false;
                this.txtDescription.Enabled = false;
                this.selMeetingNote.Enabled = false;
                this.selProject.Enabled = false;
                this.btnRelease.Enabled = false;
                this.btnUpdate.Enabled = false;
            }
            else
            {
                this.txtTitle.Enabled = true;
                this.txtCode.Enabled = true;
                this.txtRevision.Enabled = true;
                this.txtManday.Enabled = true;
                this.txtDescription.Enabled = true;
                this.selMeetingNote.Enabled = true;
                this.selProject.Enabled = true;
                this.btnRelease.Enabled = true;
                this.btnUpdate.Enabled = true;
            }

            this.loadData();
        }

        private void loadData()
        {
            Requirement rqm = this.rqmDAO.findById(long.Parse(this.hndRequirementId.Value), false);
            this.populateProject(this.selProject);
            this.selProject.SelectedValue = rqm.meetingNote.project.id.ToString();

            this.populateMeetingNote(this.selMeetingNote, this.selProject);
            this.selMeetingNote.SelectedValue = rqm.meetingNote.id.ToString();

            this.txtTitle.Text = rqm.title;
            this.txtCode.Text = rqm.code;
            this.txtRevision.Text = rqm.revision.ToString();
            this.txtManday.Text = rqm.manDays.ToString();
            this.txtDescription.Text = rqm.description;
        }

        private void populateProject(DropDownList sel)
        {
            sel.Items.Clear();
            List<Project> pjs = this.pjDAO.getAllProject(false)
                                                    .OrderBy(o => o.name)
                                                    .ToList();
            foreach (Project pj in pjs)
            {
                ListItem li = new ListItem(string.Format("{0} ({1})", pj.name, pj.code), pj.id.ToString());
                sel.Items.Add(li);
            }
        }

        private void populateMeetingNote(DropDownList selMeetingNote, DropDownList selProjectID)
        {
            selMeetingNote.Items.Clear();

            if (ValidationUtil.isEmpty(selProjectID.SelectedValue) || !ValidationUtil.isDigit(selProjectID.SelectedValue))
            {
                return;
            }

            List<MeetingNote> mns = this.mnDAO.getAllMeetingNoteFromProjectId(long.Parse(selProject.SelectedValue), false);
            foreach (MeetingNote mn in mns)
            {
                ListItem li = new ListItem(string.Format("{0}", mn.meetingTitle), mn.id.ToString());
                this.selMeetingNote.Items.Add(li);
            }
        }

        protected void selProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (selProject.SelectedValue == null)
            {
                return;
            }

            this.populateMeetingNote(this.selMeetingNote, this.selProject);
        }

        
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/secure/F022.ListRequirements.aspx", true);
            return;
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Page.Validate("vsUpdateRequirmentGroup");
            if (!Page.IsValid)
            {
                return;
            }
            Requirement rqm = this.rqmDAO.findById(long.Parse(this.hndRequirementId.Value), true);

            MeetingNote meetingNote = this.mnDAO.findById(long.Parse(this.selMeetingNote.SelectedValue), true);
            
            rqm.code = WebUtils.getFieldIfNotNull(this.txtCode.Text);
            rqm.title = WebUtils.getFieldIfNotNull(this.txtTitle.Text);
            rqm.revision = int.Parse(WebUtils.getFieldIfNotNull(this.txtRevision.Text));
            rqm.meetingNote = meetingNote;
            rqm.description = WebUtils.getFieldIfNotNull(this.txtDescription.Text);
            rqm.lastUpDate = DateTime.Now;
            rqm.manDays = double.Parse(WebUtils.getFieldIfNotNull(this.txtManday.Text));
            this.rqmDAO.update(rqm);
            
            //Refresh GUI
            this.initForm();

            this.infoMessagesForUpdate.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                              "successfully_savedRc",
                                                                               culture).ToString());
        }

        protected void btnRelease_Click(object sender, EventArgs e)
        {
            Requirement rqm = this.rqmDAO.findById(long.Parse(this.hndRequirementId.Value), true);
            rqm.status = REQUIREMENT_STATUS.AWAIT_APPROVAL;
            rqm.lastUpDate = DateTime.Now;
            this.rqmDAO.update(rqm);

            ApprovalTransactions at = approveUtilDAO.getNextRequirementApprover(rqm);
            this.atDAO.create(at);
            //Refresh GUI
            this.initForm();

            this.infoMessagesForUpdate.Add(HttpContext.GetGlobalResourceObject("GlobalResource",
                                                                              "successfully_savedRc",
                                                                               culture).ToString());
        }
    }
}