using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Services;
using XenDevWeb.dao;
using XenDevWeb.domain;

namespace XenDevWeb.WebServices
{
    /// <summary>
    /// Summary description for Lookup
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class Lookup : System.Web.Services.WebService
    {

        [System.Web.Services.WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public List<string> GetProjectCode(string prefixText, int count, string contextKey)
        {
            List<string> results = new List<string>();

            using (XenDevWebDbContext ctx = new XenDevWebDbContext())
            {
                ProjectDAO pjDAO = new ProjectDAO(ctx);
                List<Project> allProjects = pjDAO.getAllProject(false)
                                                     .Where(o => o.code.ToLower().IndexOf(prefixText.ToLower()) >= 0 ||
                                                            o.name.ToLower().IndexOf(prefixText.ToLower()) >= 0)
                                                     .ToList();

                foreach (Project pj in allProjects)
                {
                    string value = string.Format("{0} ({1})", pj.name, pj.code);
                    results.Add(value);
                }
            }

            if (results.Count == 0)
            {
                CultureInfo culture = CultureInfo.CreateSpecificCulture(Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName);
                string noRecord = HttpContext.GetGlobalResourceObject("GlobalResource", "no_record", culture).ToString();
                results.Add("*" + noRecord);
            }

            return results;
        }
    }
}
