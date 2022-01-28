using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using XenDevWeb.Utils;

namespace XenDevWeb.include
{
    public partial class master_publicPages : System.Web.UI.MasterPage
    {
        protected string language;

        protected void Page_Load(object sender, EventArgs e)
        {
            language = Constants.LANGUAGE_TH;
            if (Session[Utils.Constants.SESSION_ADD_LANGUAGE] != null)
            {
                language = Session[Utils.Constants.SESSION_ADD_LANGUAGE] as string;
            }
        }
        
    }
}