using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Globalization;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Data;

using System.Reflection;
using System.Reflection.Emit;
using AjaxControlToolkit;
using System.IO;
using System.Drawing.Imaging;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace XenDevWeb.Utils
{
    public class WebUtils
    {
        public static DataTable converToDataTable(List<Object> objs)
        {
            if (objs == null || objs.Count == 0)
            {
                return new DataTable();
            }

            PropertyInfo[] properties = objs[0].GetType().GetProperties();
            DataTable dt = createDataTable(properties);

            foreach (object o in objs)
            {
                fillData(properties, dt, o);
            }
            return dt;
        }

        private static DataTable createDataTable(PropertyInfo[] properties)
        {
            DataTable dt = new DataTable();
            DataColumn dc = null;
            foreach (PropertyInfo pi in properties)
            {
                dc = new DataColumn();
                dc.ColumnName = pi.Name;
                dc.DataType = pi.PropertyType;
                dt.Columns.Add(dc);
            }
            return dt;
        }

        private static void fillData(PropertyInfo[] properties, DataTable dt, Object o)
        {
            DataRow dr = dt.NewRow();
            foreach (PropertyInfo pi in properties)
            {
                dr[pi.Name] = pi.GetValue(o, null);
            }
            dt.Rows.Add(dr);
        }

        public static Bitmap ResizeImage(Bitmap imgToResize, Size size)
        {
            try
            {
                Bitmap b = new Bitmap(size.Width, size.Height);
                using (Graphics g = Graphics.FromImage((System.Drawing.Image)b))
                {
                    g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
                    g.DrawImage(imgToResize, 0, 0, size.Width, size.Height);
                }
                return b;
            }
            catch
            {
                //Console.WriteLine("Bitmap could not be resized");
                return imgToResize;
            }
        }

        public static string readThaiBaht(string strNumber, bool IsTrillion = false)
        {
            string BahtText = "";
            string strTrillion = "";
            string[] strThaiNumber = { "ศูนย์", "หนึ่ง", "สอง", "สาม", "สี่", "ห้า", "หก", "เจ็ด", "แปด", "เก้า", "สิบ" };
            string[] strThaiPos = { "", "สิบ", "ร้อย", "พัน", "หมื่น", "แสน", "ล้าน" };

            decimal decNumber = 0;
            decimal.TryParse(strNumber, out decNumber);

            if (decNumber == 0)
            {
                return "ศูนย์บาทถ้วน";
            }

            strNumber = decNumber.ToString("0.00");
            string strInteger = strNumber.Split('.')[0];
            string strSatang = strNumber.Split('.')[1];

            if (strInteger.Length > 13)
                throw new Exception("รองรับตัวเลขได้เพียง ล้านล้าน เท่านั้น!");

            bool _IsTrillion = strInteger.Length > 7;
            if (_IsTrillion)
            {
                strTrillion = strInteger.Substring(0, strInteger.Length - 6);
                BahtText = readThaiBaht(strTrillion, _IsTrillion);
                strInteger = strInteger.Substring(strTrillion.Length);
            }

            int strLength = strInteger.Length;
            for (int i = 0; i < strInteger.Length; i++)
            {
                string number = strInteger.Substring(i, 1);
                if (number != "0")
                {
                    if (i == strLength - 1 && number == "1" && strLength != 1)
                    {
                        BahtText += "เอ็ด";
                    }
                    else if (i == strLength - 2 && number == "2" && strLength != 1)
                    {
                        BahtText += "ยี่";
                    }
                    else if (i != strLength - 2 || number != "1")
                    {
                        BahtText += strThaiNumber[int.Parse(number)];
                    }

                    BahtText += strThaiPos[(strLength - i) - 1];
                }
            }

            if (IsTrillion)
            {
                return BahtText + "ล้าน";
            }

            if (strInteger != "0")
            {
                BahtText += "บาท";
            }

            if (strSatang == "00")
            {
                BahtText += "ถ้วน";
            }
            else
            {
                strLength = strSatang.Length;
                for (int i = 0; i < strSatang.Length; i++)
                {
                    string number = strSatang.Substring(i, 1);
                    if (number != "0")
                    {
                        if (i == strLength - 1 && number == "1" && strSatang[0].ToString() != "0")
                        {
                            BahtText += "เอ็ด";
                        }
                        else if (i == strLength - 2 && number == "2" && strSatang[0].ToString() != "0")
                        {
                            BahtText += "ยี่";
                        }
                        else if (i != strLength - 2 || number != "1")
                        {
                            BahtText += strThaiNumber[int.Parse(number)];
                        }

                        BahtText += strThaiPos[(strLength - i) - 1];
                    }
                }

                BahtText += "สตางค์";
            }

            return BahtText;
        }

        public static List<string> getASPXPages(string serverBasePath)
        {
            List<string> resutls = new List<string>();

            try
            {
                string[] allFiles = System.IO.Directory.GetFiles(serverBasePath,
                                                             "*.aspx",
                                                             System.IO.SearchOption.AllDirectories);

                foreach (string filePath in allFiles)
                {
                    var sections = filePath.Split('\\');
                    var fileName = sections[sections.Length - 1];

                    resutls.Add(fileName);
                }
            }
            catch
            {
                //Do nothing
            }

            return resutls;
        }

        public static string genRandomUniqueId()
        {
            var ticks = DateTime.Now.Ticks;
            var guid = Guid.NewGuid().ToString();
            var uniqueSessionId = ticks.ToString() + '-' + guid; //guid created by combining ticks and guid

            return uniqueSessionId;
        }

        public static string getLookupCode(string input)
        {
            if (input == null)
            {
                return "";
            }

            try
            {
                string result = input.Substring(input.LastIndexOf("(") + 1);
                result = new string(result.ToCharArray().Reverse().ToArray());
                result = result.Substring(result.IndexOf(")") + 1);
                result = new string(result.ToCharArray().Reverse().ToArray());

                return result;
            }
            catch
            {
                return "";
            }
        }

        public static string getFieldIfNotNull(string input)
        {
            if (input == null || ValidationUtil.isEmpty(input))
            {
                return null;
            }

            return input;
        }

        public static string getAppServerPath()
        {
            return HttpContext.Current.Request.Url.Scheme + "://" + HttpContext.Current.Request.Url.Authority + HttpContext.Current.Request.ApplicationPath;
        }

        public static string getAppServerPathFile()
        {
            return AppDomain.CurrentDomain.BaseDirectory;
        }

        public static string getErrorMessage(List<string> errorMessages)
        {
            if (errorMessages == null || errorMessages.Count == 0)
            {
                return "";
            }

            StringBuilder strs = new StringBuilder();

            strs.Append("<div class=\"alert alert-block alert-danger fade in\">");
            strs.Append("<button data-dismiss=\"alert\" class=\"close close-sm\" type=\"button\"><i class=\"fa fa-times\"></i></button>");
            foreach (string s in errorMessages)
            {
                strs.Append("- " + s + "<br/>");
            }
            strs.Append("</div>");

            return strs.ToString();
        }

        public static string getInfoMessage(List<string> messages)
        {
            if (messages == null || messages.Count == 0)
            {
                return "";
            }

            StringBuilder strs = new StringBuilder();

            strs.Append("<div class=\"alert alert-success alert-block fade in\">");
            strs.Append("<button data-dismiss=\"alert\" class=\"close close-sm\" type=\"button\"><i class=\"fa fa-times\"></i></button>");
            foreach (string s in messages)
            {
                strs.Append("- " + s + "<br/>");
            }
            strs.Append("</div>");

            return strs.ToString();
        }

        public static string getWarningMessage(List<string> warning)
        {
            if (warning == null || warning.Count == 0)
            {
                return "";
            }

            StringBuilder strs = new StringBuilder();

            strs.Append("<div class=\"alert alert-warning alert-block fade in\">");
            foreach (string s in warning)
            {
                strs.Append("- " + s + "<br/>");
            }
            strs.Append("</div>");

            return strs.ToString();
        }

        public static void DisableControls(Control parent)
        {
            foreach (Control c in parent.Controls)
            {
                if ((c.GetType() == typeof(TextBox)))  //Clear TextBox
                {
                    ((TextBox)(c)).Enabled = false;
                }
                if ((c.GetType() == typeof(DropDownList)))  //Clear DropDownList
                {
                    ((DropDownList)(c)).Enabled = false;
                }
                if ((c.GetType() == typeof(CheckBox)))  //Clear CheckBox
                {
                    ((CheckBox)(c)).Enabled = false;
                }
                if ((c.GetType() == typeof(CheckBoxList)))  //Clear CheckBoxList
                {
                    ((CheckBoxList)(c)).Enabled = false;
                }
                if ((c.GetType() == typeof(RadioButton)))  //Clear RadioButton
                {
                    ((RadioButton)(c)).Enabled = false;
                }
                if ((c.GetType() == typeof(RadioButtonList)))  //Clear RadioButtonList
                {
                    ((RadioButtonList)(c)).Enabled = false;
                }
                if ((c.GetType() == typeof(HtmlButton)))
                {
                    ((HtmlButton)(c)).Disabled = true;
                }
                if ((c.GetType() == typeof(LinkButton)))
                {
                    ((LinkButton)(c)).Enabled = false;
                }
                if ((c.GetType() == typeof(HiddenField)))  //Clear HiddenField
                {
                    //((HiddenField)(c)).Value = "";
                }
                if ((c.GetType() == typeof(System.Web.UI.WebControls.Label)))  //Clear Label
                {
                    //((Label)(c)).Text = "";
                }
                if (c.HasControls())
                {
                    DisableControls(c);
                }

                if (c.GetType() == typeof(HtmlEditorExtender))
                {
                    HtmlEditorExtender html = c as HtmlEditorExtender;
                    html.Enabled = false;
                }

                if (c.HasControls())
                {
                    DisableControls(c);
                }
            }
        }

        public static void ClearControls(Control parent)
        {
            foreach (Control c in parent.Controls)
            {
                if ((c.GetType() == typeof(TextBox)))  //Clear TextBox
                {
                    ((TextBox)(c)).Text = "";
                }
                if ((c.GetType() == typeof(DropDownList)))  //Clear DropDownList
                {
                    ((DropDownList)(c)).ClearSelection();
                }
                if ((c.GetType() == typeof(CheckBox)))  //Clear CheckBox
                {
                    ((CheckBox)(c)).Checked = false;
                }
                if ((c.GetType() == typeof(CheckBoxList)))  //Clear CheckBoxList
                {
                    ((CheckBoxList)(c)).ClearSelection();
                }
                if ((c.GetType() == typeof(RadioButton)))  //Clear RadioButton
                {
                    ((RadioButton)(c)).Checked = false;
                }
                if ((c.GetType() == typeof(RadioButtonList)))  //Clear RadioButtonList
                {
                    ((RadioButtonList)(c)).ClearSelection();
                }
                if ((c.GetType() == typeof(HiddenField)))  //Clear HiddenField
                {
                    //((HiddenField)(c)).Value = "";
                }
                if ((c.GetType() == typeof(System.Web.UI.WebControls.Label)))  //Clear Label
                {
                    //((Label)(c)).Text = "";
                }
                if (c.HasControls())
                {
                    ClearControls(c);
                }
            }
        }

        public static string readEngBaht(string number)
        {
            string word = "";
            double dNumber = double.Parse(number);
            string dataNumber = dNumber.ToString("N2");
            string[] spNumber = dataNumber.Split('.');
            int integer = int.Parse(spNumber[0].Replace(",", ""));
            int dec = 0;

            if (spNumber.Count() > 1)
            {
                dec = int.Parse(spNumber[1]);
            }

            word = integerToWords(integer) + decimalWord(dec);
            return word;
        }

        private static string integerToWords(int integer)
        {
            if (integer == 0)
                return "Zero";

            if (integer < 0)
                return "Minus " + integerToWords(Math.Abs(integer));

            string words = "";

            if ((integer / 1000000) > 0)
            {
                words += integerToWords(integer / 1000000) + " Million ";
                integer %= 1000000;
            }

            if ((integer / 1000) > 0)
            {
                words += integerToWords(integer / 1000) + " Thousand ";
                integer %= 1000;
            }

            if ((integer / 100) > 0)
            {
                words += integerToWords(integer / 100) + " Hundred ";
                integer %= 100;
            }

            if (integer > 0)
            {
                if (words != "")
                    words += "";

                var unitsMap = new[] { "Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen" };
                var tensMap = new[] { "Zero", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety" };

                if (integer < 20)
                    words += unitsMap[integer];
                else
                {
                    words += tensMap[integer / 10];
                    if ((integer % 10) > 0)
                        words += "-" + unitsMap[integer % 10];
                }
            }

            return words;
        }

        private static string decimalWord(int decimals)
        {
            if (decimals == 0)
            {
                return "";
            }
            string words = " And ";

            if (decimals > 0)
            {
                var unitsMap = new[] { "Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen" };
                var tensMap = new[] { "Zero", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety" };

                if (decimals < 20)
                    words += unitsMap[decimals] + " Stang";
                else
                {
                    words += tensMap[decimals / 10];
                    if ((decimals % 10) > 0)
                        words += "-" + unitsMap[decimals % 10] + " Stang";
                }
            }

            return words;


        }

        public static string getImageBase64(string imageFileName, bool withBase64Header = true)
        {
            string base64Img = string.Empty;

            string fullPathFileName = Constants.MEETINGNOTE_IMG_FOLDER + "\\" + imageFileName;
            if (!File.Exists(fullPathFileName))
            {
                return base64Img;
            }

            System.Drawing.Image image = System.Drawing.Image.FromFile(fullPathFileName);
            using (MemoryStream ms = new MemoryStream())
            {
                image.Save(ms, ImageFormat.Jpeg);
                byte[] imageBytes = ms.ToArray();

                base64Img = Convert.ToBase64String(imageBytes);
            }

            if (image != null)
            {
                image.Dispose();
            }

            return (withBase64Header ? "data:image/gif;base64," : "") + base64Img;
        }

        public static string getImageBase64(Bitmap bmp, bool withBase64Header = true)
        {
            string base64Img = string.Empty;

            System.Drawing.Image image = bmp;
            using (MemoryStream ms = new MemoryStream())
            {
                image.Save(ms, ImageFormat.Jpeg);
                byte[] imageBytes = ms.ToArray();

                base64Img = Convert.ToBase64String(imageBytes);
            }

            if (image != null)
            {
                image.Dispose();
            }

            return (withBase64Header ? "data:image/gif;base64," : "") + base64Img;
        }

        public static Bitmap ConvertToBitmap(string fileName)
        {
            Bitmap bitmap;
            using (Stream bmpStream = System.IO.File.Open(fileName, System.IO.FileMode.Open))
            {
                System.Drawing.Image image = System.Drawing.Image.FromStream(bmpStream);

                bitmap = new Bitmap(image);

            }
            return bitmap;
        }

        public static Bitmap ResizeBitmap(Bitmap bmp, int width, int height)
        {
            Bitmap result = new Bitmap(width, height);
            using (Graphics g = Graphics.FromImage(result))
            {
                g.DrawImage(bmp, 0, 0, width, height);
            }

            return result;
        }

        public static string getImageUserBase64(string imageFileName, bool withBase64Header = true)
        {
            string base64Img = string.Empty;

            string fullPathFileName = Constants.USERACCOUNT_IMG_FOLDER + "\\" + imageFileName;
            if (!File.Exists(fullPathFileName))
            {
                return base64Img;
            }

            System.Drawing.Image image = System.Drawing.Image.FromFile(fullPathFileName);
            using (MemoryStream ms = new MemoryStream())
            {
                image.Save(ms, ImageFormat.Jpeg);
                byte[] imageBytes = ms.ToArray();

                base64Img = Convert.ToBase64String(imageBytes);
            }

            if (image != null)
            {
                image.Dispose();
            }

            return (withBase64Header ? "data:image/gif;base64," : "") + base64Img;
        }

        public static string getImageMeetingBase64(string imageFileName, bool withBase64Header = true)
        {
            string base64Img = string.Empty;

            string fullPathFileName = Constants.MEETINGNOTE_IMG_FOLDER + "\\" + imageFileName;
            if (!File.Exists(fullPathFileName))
            {
                return base64Img;
            }

            System.Drawing.Image image = System.Drawing.Image.FromFile(fullPathFileName);
            using (MemoryStream ms = new MemoryStream())
            {
                image.Save(ms, ImageFormat.Jpeg);
                byte[] imageBytes = ms.ToArray();

                base64Img = Convert.ToBase64String(imageBytes);
            }

            if (image != null)
            {
                image.Dispose();
            }

            return (withBase64Header ? "data:image/gif;base64," : "") + base64Img;
        }

        public static string getImageProjectBase64(string imageFileName, bool withBase64Header = true)
        {
            string base64Img = string.Empty;

            string fullPathFileName = Constants.PROJECT_IMG_FOLDER + "\\" + imageFileName;
            if (!File.Exists(fullPathFileName))
            {
                return base64Img;
            }

            System.Drawing.Image image = System.Drawing.Image.FromFile(fullPathFileName);
            using (MemoryStream ms = new MemoryStream())
            {
                image.Save(ms, ImageFormat.Jpeg);
                byte[] imageBytes = ms.ToArray();

                base64Img = Convert.ToBase64String(imageBytes);
            }

            if (image != null)
            {
                image.Dispose();
            }

            return (withBase64Header ? "data:image/gif;base64," : "") + base64Img;
        }

        public static string getImageAppChangeBase64(string imageFileName, bool withBase64Header = true)
        {
            string base64Img = string.Empty;

            string fullPathFileName = Constants.APPLICATION_CHANGE_IMG_FOLDER + "\\" + imageFileName;
            if (!File.Exists(fullPathFileName))
            {
                return base64Img;
            }

            System.Drawing.Image image = System.Drawing.Image.FromFile(fullPathFileName);
            using (MemoryStream ms = new MemoryStream())
            {
                image.Save(ms, ImageFormat.Jpeg);
                byte[] imageBytes = ms.ToArray();

                base64Img = Convert.ToBase64String(imageBytes);
            }

            if (image != null)
            {
                image.Dispose();
            }

            return (withBase64Header ? "data:image/gif;base64," : "") + base64Img;
        }

        public static string getImageTicketCommentBase64(string imageFileName, bool withBase64Header = true)
        {
            string base64Img = string.Empty;

            string fullPathFileName = Constants.TICKET_TYPE_INTERNAL_IMG_FOLDER + "\\" + imageFileName;
            if (!File.Exists(fullPathFileName))
            {
                return base64Img;
            }

            System.Drawing.Image image = System.Drawing.Image.FromFile(fullPathFileName);
            using (MemoryStream ms = new MemoryStream())
            {
                image.Save(ms, ImageFormat.Jpeg);
                byte[] imageBytes = ms.ToArray();

                base64Img = Convert.ToBase64String(imageBytes);
            }

            if (image != null)
            {
                image.Dispose();
            }

            return (withBase64Header ? "data:image/gif;base64," : "") + base64Img;
        }

        public static void writeJsonFile(string jsonFileName, string jsonOldFileName, string data)
        {
            string jsonResult = JsonConvert.SerializeObject(data);
            string fullPathFileName = Constants.REQUIREMENT_JSON_FOLDER + "\\" + jsonFileName;
            string fullOldPathFileName = string.Format("{0}\\{1}", Constants.REQUIREMENT_JSON_FOLDER
                                                         , jsonOldFileName);

            if (!File.Exists(fullOldPathFileName))
            {
                using (StreamWriter sw = new StreamWriter(fullPathFileName, true))
                {
                    sw.WriteLine(jsonResult.ToString());
                    sw.Close();
                }
            }
            else if (File.Exists(fullOldPathFileName))
            {
                using (StreamWriter sw = new StreamWriter(fullOldPathFileName, true))
                {
                    sw.WriteLine(jsonResult.ToString());
                    sw.Close();
                }
            }
        }

        public static string getJsonFile(string jsonFileName)
        {
            string data = string.Empty;
            string fullPathFileName = Constants.REQUIREMENT_JSON_FOLDER + "\\" + jsonFileName;

            using (StreamReader file = File.OpenText(fullPathFileName))
            using (JsonTextReader reader = new JsonTextReader(file))
            {
                reader.Read();
                data = reader.Value.ToString();
            }
            return data;
        }

        public static string writeImageBase64ToImageToDisk(string imageBase64, string pathFile)
        {
            if (ValidationUtil.isEmpty(imageBase64))
            {
                return null;
            }
            //data:image/png;base64,

            string fileName = string.Format("{0}.jpg", Guid.NewGuid());
            string fullPathName = pathFile + "\\" + fileName;

            //var base64Data = Regex.Match(imageBase64, @"data:image/(?<type>.+?),(?<data>.+)").Groups["data"].Value;
            var binData = Convert.FromBase64String(imageBase64);
            using (var stream = new MemoryStream(binData))
            {
                Bitmap image = new Bitmap(stream);
                image.Save(fullPathName);
            }

            return fileName;
        }

        public static void writeImageToImageDisk(HttpPostedFile file, string fullPath)
        {
            Stream fs = file.InputStream;
            BinaryReader br = new BinaryReader(fs);
            byte[] bytes = br.ReadBytes((Int32)fs.Length);
            string filePath = fullPath.Replace("\\", "/");
            File.WriteAllBytes(filePath, bytes);
        }
        
    }
}