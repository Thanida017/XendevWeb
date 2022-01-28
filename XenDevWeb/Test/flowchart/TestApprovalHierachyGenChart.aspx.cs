using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.dao;
using XenDevWeb.domain;
using XenDevWeb.Test.flowchart.view;

namespace XenDevWeb.Test.flowchart
{
    public partial class TestApprovalHierachyGenChart : System.Web.UI.Page
    {
        public XenDevWebDbContext ctx;
        public StaffAccountDAO saDAO;
        private ApprovalHierarchyDAO ahDAO;
        private ApprovalHierarchyDetailDAO ahdDAO;
        private UserAccountDAO usDAO;
        private CompanyDAO comDAO;

        protected void Page_Load(object sender, EventArgs e)
        {
            ctx = new XenDevWebDbContext();
            saDAO = new StaffAccountDAO(ctx);
            ahDAO = new ApprovalHierarchyDAO(ctx);
            ahdDAO = new ApprovalHierarchyDetailDAO(ctx);
            usDAO = new UserAccountDAO(ctx);
            comDAO = new CompanyDAO(ctx);
        }

        public void genChart()
        {
            ApprovalHierarchy ahData = this.ahDAO.findById(1, false);
            
            List<ApprovalHierarchyDetail> ahds = ahData.details;

            for(int i = 0; i < ahds.Count; i++)
            {
                OperatorUserView opUser = new OperatorUserView();
                opUser.left = 20;
                opUser.top = 20;
                opUser.properties = new PropertiesView();
                opUser.properties.title = ahds[i].userAccount.firstName;
                opUser.properties.inputs = new InputsView();

                if (i > 0)
                {
                    opUser.properties.inputs.input_1 = new InputOView();
                    int n = i - 1;
                    opUser.properties.inputs.input_1.label = ahds[i - 1].userAccount.firstName;

                    if (i % 2 == 0)
                    {
                        LinksUserView lu = new LinksUserView();
                        lu.fromConnector = ahds[i-1].userAccount.username;
                        lu.fromConnector = "input_1";
                        lu.fromConnector = ahds[i].userAccount.username;
                        lu.fromConnector = "output_1";
                    }
                }

                opUser.properties.outputs = new OutputsView();
                opUser.properties.outputs.output_1 = new OutputOView();
                opUser.properties.outputs.output_1.label = ahds[i - 1] != null ? ahds[i - 1].userAccount.firstName : "";

                string data = new JavaScriptSerializer().Serialize(opUser);
                string option = string.Format("{0}:{1}", ahds[i].userAccount.username, data);

               
            }
        }
    }
}