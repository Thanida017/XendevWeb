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

namespace XenDevWeb.Test
{
    public partial class TestF023_NewRequirement : CRUDPageControler
    {
        private ProjectDAO pjDAO;
        private MeetingNoteDAO mnDAO;
        private RequirementDAO rqmDAO;

        protected void Page_Load(object sender, EventArgs e)
        {
            pjDAO = new ProjectDAO(ctx);
            mnDAO = new MeetingNoteDAO(ctx);
            rqmDAO = new RequirementDAO(ctx);

            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            this.initForm();
        }

        private void initForm()
        {
            txtRevision.Attributes["readonly"] = "readonly";
            txtDrawFlowPortLeft.Text = "0";
            txtDrawFlowPortRight.Text = "0";
            populateProject(selProject);
            populateMeetingNote(selMeetingNote, selProject);
            //populateDrawFlowNode(selDrawFlowSelectNode);
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
                selMeetingNote.Items.Add(li);
            }
        }

        protected void selProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (selProject.SelectedValue == null)
            {
                return;
            }

            populateMeetingNote(this.selMeetingNote, this.selProject);
        }

        protected void txtCode_TextChanged(object sender, EventArgs e)
        {
            Requirement rqm = this.rqmDAO.findByCode(txtCode.Text, false);
            if (rqm == null)
            {
                txtRevision.Text = "1";
                return;
            }
            int revision = rqm.revision + 1;
            txtRevision.Text = revision.ToString();
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            Page.Validate("vsAddRequirmentGroup");
            if (!Page.IsValid)
            {
                return;
            }

            Requirement someoneRequirementTitle = this.rqmDAO.findByTitle(this.txtTitle.Text, false);
            if (someoneRequirementTitle != null)
            {
                string mesg = string.Format(HttpContext.GetLocalResourceObject("~/secure/F023.NewRequirement.aspx",
                                                                                "title",
                                                                                culture)
                                                                                .ToString(),
                                                                                this.txtTitle.Text);
                this.errorMessages.Add(mesg);
                return;
            }
            MeetingNote meetingNote = this.mnDAO.findById(long.Parse(this.selMeetingNote.SelectedValue), true);

            Requirement rqm = new Requirement();
            rqm.code = WebUtils.getFieldIfNotNull(this.txtCode.Text);
            rqm.title = WebUtils.getFieldIfNotNull(this.txtTitle.Text);
            rqm.revision = int.Parse(WebUtils.getFieldIfNotNull(this.txtRevision.Text));
            rqm.meetingNote = meetingNote;
            rqm.status = REQUIREMENT_STATUS.COMPOSING;
            rqm.creationDate = DateTime.Now;
            rqm.lastUpDate = DateTime.Now;
            this.rqmDAO.create(rqm);
        }
    }
}