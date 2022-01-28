using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;

namespace XenDevWeb.Utils
{
    public abstract class ReportUtil
    {
        public static void sendReportToClient(ReportClass report, HttpResponse Response, string reportFileName, bool closeStreamWhenCompleted, ExportFormatType formatType)
        {
            System.IO.Stream oStream = null;
            byte[] byteArray = null;
            oStream = report.ExportToStream(formatType);
            byteArray = new byte[oStream.Length];
            oStream.Read(byteArray, 0, Convert.ToInt32(oStream.Length - 1));
            Response.ClearContent();
            Response.ClearHeaders();
            Response.AddHeader("content-disposition", "attachment; filename=" + reportFileName);
            if (formatType == ExportFormatType.PortableDocFormat)
            {
                Response.ContentType = "application/pdf";
            }
            else if(formatType == ExportFormatType.Excel)
            {
                Response.ContentType = "application/vnd.ms-excel";
            }
            
            Response.BinaryWrite(byteArray);

            if (closeStreamWhenCompleted)
            {
                Response.Flush();
                Response.Close();
                report.Close();
                report.Dispose();
            }
        }
    }
}



