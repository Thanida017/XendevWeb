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
    public partial class F023_NewRequirement : CRUDPageControler
    {
        private ProjectDAO pjDAO;
        private MeetingNoteDAO mnDAO;
        private RequirementDAO rqmDAO;

        public List<string> errorMessagesForCreate;
        public List<string> infoMessagesForCreate;

        protected void Page_Load(object sender, EventArgs e)
        {
            pjDAO = new ProjectDAO(ctx);
            mnDAO = new MeetingNoteDAO(ctx);
            rqmDAO = new RequirementDAO(ctx);

            errorMessagesForCreate = new List<string>();
            infoMessagesForCreate = new List<string>();

            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            this.initForm();
        }

        private void initForm()
        {
            txtRevision.Attributes["readonly"] = "readonly";
            populateProject(selProject);
            populateMeetingNote(selMeetingNote,selProject);
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
            this.btnCreate.Visible = (mns != null && mns.Count > 0);
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
            Requirement rqm = this.rqmDAO.findByCode(txtCode.Text,false);
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
                this.errorMessagesForCreate.Add(mesg);
                return;
            }
            MeetingNote meetingNote = this.mnDAO.findById(long.Parse(this.selMeetingNote.SelectedValue), true);

            Requirement rqm = new Requirement();
            rqm.code = WebUtils.getFieldIfNotNull(this.txtCode.Text);
            rqm.title = WebUtils.getFieldIfNotNull(this.txtTitle.Text);
            rqm.revision = int.Parse(WebUtils.getFieldIfNotNull(this.txtRevision.Text));
            rqm.description = WebUtils.getFieldIfNotNull(this.txtDescription.Text);
            rqm.meetingNote = meetingNote;
            rqm.status = REQUIREMENT_STATUS.COMPOSING;
            rqm.manDays = double.Parse(WebUtils.getFieldIfNotNull(this.txtManday.Text));
            rqm.creationDate = DateTime.Now;
            rqm.lastUpDate = DateTime.Now;
            this.rqmDAO.create(rqm);

            //Clear form
            WebUtils.ClearControls(this);

            //Refresh GUI
            this.initForm();
            
            Requirement rqmLastId = this.rqmDAO.getLastId(false);
            string requirementId = rqmLastId.id.ToString();
            string newCreate = "true";
            Response.Redirect("F025.UpdateRequirement.aspx?rqmId=" + HttpUtility.UrlEncode(QueryStringModule.Encrypt(requirementId)) + "&&newCreate="+ HttpUtility.UrlEncode(QueryStringModule.Encrypt(newCreate)), true);
            
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/secure/F022.ListRequirements.aspx", true);
            return;
        }
    }
}