using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace XenDevWeb.Test
{
    public partial class test_dynamic_prop : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            List<RawData> everyone = new List<RawData>();

            //==================================
            //Test 1. has 2 people
            //==================================
            //1.1 prepare name
            everyone.Add(new RawData("somchai", 10, 15, 20, 25));
            everyone.Add(new RawData("somying", 16, 7, 4, 15));

            //1.2 prepare data
            object assignedData = getJSonObject(everyone, "Assigned");
            object wipData = getJSonObject(everyone, "WIP");
            object passData = getJSonObject(everyone, "submit-pass");
            object failedData = getJSonObject(everyone, "submit-failed");

            List<object> finalData = new List<object>();
            finalData.Add(assignedData);
            finalData.Add(wipData);
            finalData.Add(passData);
            finalData.Add(failedData);

            //1.3 output to json
            string outputJson = JsonConvert.SerializeObject(finalData);

            //==================================
            //Test 2. add one more people
            //==================================
            everyone.Add(new RawData("nuttichar", 32, 19, 22, 14));

            //2.2 prepare data
            assignedData = getJSonObject(everyone, "Assigned");
            wipData = getJSonObject(everyone, "WIP");
            passData = getJSonObject(everyone, "submit-pass");
            failedData = getJSonObject(everyone, "submit-failed");

            //2.3 output to json
            finalData = new List<object>();
            finalData.Add(assignedData);
            finalData.Add(wipData);
            finalData.Add(passData);
            finalData.Add(failedData);

            //1.3 output to json
            outputJson = JsonConvert.SerializeObject(finalData);
        }

        public object getJSonObject(List<RawData> everyone, string type)
        {
            Dictionary<string, object> dictionary = new Dictionary<string, object>();
            dictionary.Add("category", type);

            foreach (RawData rw in everyone)
            {
                string fieldName = "value-" + rw.personName;
                int value = 0;
                if (type.CompareTo("Assigned") == 0)
                {
                    value = rw.assigned;
                }
                else if (type.CompareTo("WIP") == 0)
                {
                    value = rw.wip;
                }
                else if (type.CompareTo("submit-pass") == 0)
                {
                    value = rw.submitPass;
                }
                else if (type.CompareTo("submit-failed") == 0)
                {
                    value = rw.submitFailed;
                }

                dictionary.Add(fieldName, value);
            }

            return dictionary;
        }
    }

    public class RawData
    {
        public string personName { get; set; }
        public int assigned { get; set; }
        public int wip { get; set; }
        public int submitPass { get; set; }
        public int submitFailed { get; set; }

        public RawData()
        {

        }

        public RawData(string name, int assigned, int wip, int submitPass, int submitFailed)
        {
            this.personName = name;
            this.assigned = assigned;
            this.wip = wip;
            this.submitPass = submitPass;
            this.submitFailed = submitFailed;
        }
    }
}