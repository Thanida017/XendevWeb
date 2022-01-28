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

namespace XenDevWeb.secure
{
    public partial class F022_ListRequirements : CRUDPageControler
    {
        private ProjectDAO pjDAO;
        private RequirementDAO rqmDAO;

        private List<Requirement> allRqm;

        protected void Page_Load(object sender, EventArgs e)
        {
            pjDAO = new ProjectDAO(ctx);
            rqmDAO = new RequirementDAO(ctx);

            if (this.scriptManager.IsInAsyncPostBack || this.Page.IsPostBack)
            {
                return;
            }

            this.initForm();
        }

        private void initForm()
        {
            populateStatus(selRequirmentStatus);
            populateProject(selProject);
            bindListRequirements();
        }

        public void populateStatus(DropDownList sel)
        {
            sel.Items.Clear();

            ListItem lstAll = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F022.ListRequirements.aspx",
                                                                                "all", culture)
                                                                                .ToString(), "All");
            sel.Items.Add(lstAll);

            ListItem liComposing = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F022.ListRequirements.aspx",
                                                                             "composing", culture).ToString()
                                                                             , REQUIREMENT_STATUS.COMPOSING.ToString());
            sel.Items.Add(liComposing);

            ListItem liAwait_Approval = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F022.ListRequirements.aspx",
                                                                             "await_approval", culture).ToString()
                                                                             , REQUIREMENT_STATUS.AWAIT_APPROVAL.ToString());

            sel.Items.Add(liAwait_Approval);

            ListItem liAccepted = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F022.ListRequirements.aspx",
                                                                             "accepted", culture).ToString()
                                                                             , REQUIREMENT_STATUS.ACCEPTED.ToString());
            sel.Items.Add(liAccepted);

            ListItem liRejected = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F022.ListRequirements.aspx",
                                                                             "rejected", culture).ToString()
                                                                             , REQUIREMENT_STATUS.REJECTED.ToString());
            sel.Items.Add(liRejected);

            ListItem liCancel = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F022.ListRequirements.aspx",
                                                                             "cancel", culture).ToString()
                                                                             , REQUIREMENT_STATUS.CANCEL.ToString());
            sel.Items.Add(liCancel);
        }
        
        private void populateProject(DropDownList sel)
        {
            sel.Items.Clear();

            ListItem defaultItem = new ListItem(HttpContext.GetLocalResourceObject("~/secure/F022.ListRequirements.aspx",
                                                                                 "all",
                                                                                 culture).ToString(),
                                                                                 "0");
            sel.Items.Add(defaultItem);

            List<Project> pjs = this.pjDAO.getAllProject(false)
                                                    .OrderBy(o => o.name)
                                                    .ToList();

            foreach (Project pj in pjs)
            {
                ListItem li = new ListItem(string.Format("{0} ({1})", pj.name, pj.code), pj.id.ToString());
                sel.Items.Add(li);
            }
        }

        public void bindListRequirements()
        {
            this.allRqm = this.rqmDAO.getAllRequirement(false);

            if (this.allRqm != null && allRqm.Count > 0)
            {

                if (!ValidationUtil.isEmpty(txtCode.Text))
                {
                    Requirement rqm = this.rqmDAO.findByCode(txtCode.Text, false);

                    if (rqm != null)
                    {
                        this.allRqm = this.allRqm.Where(e => e.code != null
                                                        && e.code.ToString().ToLower().IndexOf(txtCode.Text.ToLower()) == 0)
                                                          .ToList();
                    }
                }

                switch (selRequirmentStatus.SelectedValue)
                {
                    case "COMPOSING":
                        this.allRqm = this.allRqm.Where(i => i.status == REQUIREMENT_STATUS.COMPOSING).ToList();
                        break;
                    case "AWAIT_APPROVAL":
                        this.allRqm = this.allRqm.Where(i => i.status == REQUIREMENT_STATUS.AWAIT_APPROVAL).ToList();
                        break;
                    case "ACCEPTED":
                        this.allRqm = this.allRqm.Where(i => i.status == REQUIREMENT_STATUS.ACCEPTED).ToList();
                        break;
                    case "REJECTED":
                        this.allRqm = this.allRqm.Where(i => i.status == REQUIREMENT_STATUS.REJECTED).ToList();
                        break;
                    case "CANCEL":
                        this.allRqm = this.allRqm.Where(i => i.status == REQUIREMENT_STATUS.CANCEL).ToList();
                        break;
                }
            }

            listRequirementsGridView.DataSource = this.allRqm;
            listRequirementsGridView.DataBind();
        }

        protected void btnQuery_Click(object sender, EventArgs e)
        {
            this.bindListRequirements();
        }

        protected void listRequirementsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            listRequirementsGridView.PageIndex = e.NewPageIndex;
            bindListRequirements();
        }

        protected void listRequirementsGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }

            Requirement rqm = e.Row.DataItem as Requirement;
            Label lblListRequirementId = e.Row.FindControl("lblListRequirementId") as Label;
            Label lblGrid_Code = e.Row.FindControl("lblGrid_Code") as Label;
            Label lblGrid_Title = e.Row.FindControl("lblGrid_Title") as Label;
            Label lblGrid_Project = e.Row.FindControl("lblGrid_Project") as Label;
            Label lblGrid_RequirmentStatus = e.Row.FindControl("lblGrid_RequirmentStatus") as Label;
            Label lblGrid_LastUpdate = e.Row.FindControl("lblGrid_LastUpdate") as Label;
            Label lblGrid_Revision = e.Row.FindControl("lblGrid_Revision") as Label;

            lblListRequirementId.Text = rqm.id.ToString();
            lblGrid_Code.Text = rqm.code.ToString();
            lblGrid_Title.Text = rqm.title.ToString();
            lblGrid_Project.Text = rqm.meetingNote.project.name.ToString();
            populateStatus(selRequirmentStatus);
            lblGrid_RequirmentStatus.Text = (rqm.status != 0) ?rqm.status.ToString() : "-";
            lblGrid_LastUpdate.Text = rqm.lastUpDate.ToString("dd/MM/yyyy hh:mm", culture);
            lblGrid_Revision.Text = rqm.revision.ToString();
        }

        protected void btnEdit_Command(object sender, CommandEventArgs e)
        {
            string requirementId = e.CommandArgument.ToString();
            Response.Redirect("F025.UpdateRequirement.aspx?rqmId=" + HttpUtility.UrlEncode(QueryStringModule.Encrypt(requirementId)), true);
        }
        
        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            Response.Redirect("F023.NewRequirement.aspx", true);
        }

        protected void btnDrawGraph_Command(object sender, CommandEventArgs e)
        {
            string requirementId = e.CommandArgument.ToString();
            Response.Redirect("F024.DrawflowDynamic.aspx?rqmId=" + HttpUtility.UrlEncode(QueryStringModule.Encrypt(requirementId)), true);
        }

        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            long idToDelete = long.Parse(e.CommandArgument.ToString());

            try
            {
                Requirement rqmIdDelete = this.rqmDAO.findById(idToDelete, true);
                string getJsonFile = WebUtils.getJsonFile(rqmIdDelete.chartJsonFileName);
                string oldFullPath = string.Format("{0}\\{1}", Constants.REQUIREMENT_JSON_FOLDER
                                                         , rqmIdDelete.chartJsonFileName);
                File.Delete(oldFullPath);
                rqmDAO.delete(rqmIdDelete);
                bindListRequirements();
                this.infoMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource", "successfully_savedRc", culture).ToString());
            }
            catch (Exception ex)
            {
                this.errorMessagesForGrid.Add(HttpContext.GetGlobalResourceObject("GlobalResource", "dataIsUse", culture).ToString());
            }
        }
    }
}