using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XenDevWeb.Test.draw2d.er.view
{
    public class TableConnectionView
    {
        public TableConnectionView()
        {

        }

        public TableConnectionView(ERView erView)
        {
            type = erView.type;
            id = erView.id;
            name = erView.name;
            userData = new UserDataERView();
            userData = erView.userData;
            cssClass = erView.cssClass;
            stroke = erView.stroke;
            color = erView.color;
            policy = erView.policy;
            router = erView.router;
            source = new SourceERView();
            source = erView.source;
            target = new TargetERView();
            target = erView.target;
        }

        public string type { get; set; }
        public string id { get; set; }
        public string name { get; set; }
        public UserDataERView userData { get; set; }
        public string cssClass { get; set; }
        public double stroke { get; set; }
        public string color { get; set; }
        public string policy { get; set; }
        public string router { get; set; }
        public SourceERView source { get; set; }
        public TargetERView target { get; set; }
    }
}