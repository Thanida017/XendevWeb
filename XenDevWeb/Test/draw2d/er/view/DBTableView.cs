using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.Test.draw2d.er.view
{
    public class DBTableView
    {
        public DBTableView()
        {

        }

        public DBTableView(ERView erView)
        {
            type = erView.type;
            id = erView.id;
            x = erView.x;
            y = erView.y;
            width = erView.width;
            height = erView.height;
            userData = erView.userData;
            cssClass = erView.cssClass;
            bgColor = erView.bgColor;
            color = erView.color;
            stroke = erView.stroke;
            alpha = erView.alpha;
            radius = erView.radius;
            tableName = erView.tableName;
            tablePorts = new List<TablePortERView>();
            tablePorts.AddRange(erView.tablePorts);
            attributes = new List<AttributeERView>();
            attributes.AddRange(erView.attributes);
        }

        public string type { get; set; }
        public string id { get; set; }
        public double x { get; set; }
        public double y { get; set; }
        public double width { get; set; }
        public double height { get; set; }
        public object userData { get; set; }
        public string cssClass { get; set; }
        public string bgColor { get; set; }
        public string color { get; set; }
        public double stroke { get; set; }
        public double alpha { get; set; }
        public double radius { get; set; }
        public string tableName { get; set; }
        public List<TablePortERView> tablePorts { get; set; }
        public List<AttributeERView> attributes { get; set; }
    }
}