<%@ Page Language="C#"
    AutoEventWireup="true"
    CodeBehind="F026.StaffScore.aspx.cs"
    Inherits="XenDevWeb.secure.F026_StaffScore"
    MaintainScrollPositionOnPostback="true"
    MasterPageFile="~/include/master.Master" %>

<%@ Import Namespace="XenDevWeb.Utils" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentMainPlaceHolder" runat="Server">
    <head runat="server">
        <!-- Styles -->
        <style>
            #drawChartStaffScore {
                width: 100%;
                height: 500px;
            }
        </style>
    </head>
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-xs-12">
                    <section class="panel">
                        <header class="panel-heading tab-bg-dark-navy-blue tab-right ">
                            <span class="hidden-sm wht-color">
                                <strong>
                                    <asp:Label ID="lblStaffScore" runat="server" meta:resourcekey="lblStaffScoreRc" />
                                </strong>
                            </span>
                        </header>
                        <div class="panel-body">
                            <div class="tab-content">
                                <form id="myForm" role="form" runat="server">
                                    <asp:ScriptManager ID="scriptManager" runat="server" EnableScriptGlobalization="true"></asp:ScriptManager>
                                    <asp:UpdateProgress ID="updProgress" runat="server">
                                        <ProgressTemplate>
                                            <img alt="progress"
                                                style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 100;"
                                                src="<%= WebUtils.getAppServerPath() %>/include/img/loading.gif" />
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <%--<%= WebUtils.getErrorMessage(this.errorMessages) %>
                                            <%= WebUtils.getInfoMessage(this.infoMessages) %>--%>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b>
                                                        <asp:Label ID="lblStaffScoreHeader" runat="server" meta:resourcekey="lblStaffScoreRc" />
                                                    </b>
                                                </header>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="">
                                                    <div class="row">
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                            <!-- Date From -->
                                                            <div class="form-group" style="width: 85%; margin-left: 10px; float: left">
                                                                <asp:Label ID="lblDateFrom" runat="server" meta:resourcekey="lblDateFromRc" AssociatedControlID="txtDateFrom" />
                                                                <asp:TextBox ID="txtDateFrom"
                                                                    Width="98.5%"
                                                                    runat="server"
                                                                    ForeColor="#0094FF"
                                                                    BackColor="#FCF5D8"
                                                                    CssClass="form-control"
                                                                    meta:resourcekey="txtDateFromRc" />
                                                                <span class="input-group-btn add-on">
                                                                    <button id="btnDateFromCal"
                                                                        runat="server"
                                                                        class="btn btn-danger"
                                                                        style="margin-left: -15px; height: 35px"
                                                                        type="button">
                                                                        <i class="fa fa-calendar"></i>
                                                                    </button>
                                                                </span>
                                                                <asp:RequiredFieldValidator ID="rfvDateFrom"
                                                                    runat="server"
                                                                    ValidationGroup="vsQueryGroup"
                                                                    ControlToValidate="txtDateFrom"
                                                                    ForeColor="Red"
                                                                    Display="Dynamic"
                                                                    meta:resourcekey="txtDateFromRc"
                                                                    Enabled="false" />
                                                                <ajaxToolkit:CalendarExtender
                                                                    runat="server"
                                                                    TargetControlID="txtDateFrom"
                                                                    PopupButtonID="btnDateFromCal"
                                                                    Format="d/MM/yyyy" BehaviorID="" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-6" style="padding: 5px;">
                                                            <!-- Date From -->
                                                            <div class="form-group" style="width: 85%; margin-left: 10px; float: left">
                                                                <asp:Label ID="lblDateTo" runat="server" meta:resourcekey="lblDateToRc" AssociatedControlID="txtDateTo" />
                                                                <asp:TextBox ID="txtDateTo"
                                                                    Width="98.5%"
                                                                    runat="server"
                                                                    ForeColor="#0094FF"
                                                                    BackColor="#FCF5D8"
                                                                    CssClass="form-control"
                                                                    meta:resourcekey="txtDateToRc" />
                                                                <span class="input-group-btn add-on">
                                                                    <button id="btnDateToCal"
                                                                        runat="server"
                                                                        class="btn btn-danger"
                                                                        style="margin-left: -15px; height: 35px"
                                                                        type="button">
                                                                        <i class="fa fa-calendar"></i>
                                                                    </button>
                                                                </span>
                                                                <asp:RequiredFieldValidator ID="rfvDateTo"
                                                                    runat="server"
                                                                    ValidationGroup="vsQueryGroup"
                                                                    ControlToValidate="txtDateTo"
                                                                    ForeColor="Red"
                                                                    Display="Dynamic"
                                                                    meta:resourcekey="txtDateToRc"
                                                                    Enabled="false" />
                                                                <ajaxToolkit:CalendarExtender
                                                                    runat="server"
                                                                    TargetControlID="txtDateTo"
                                                                    PopupButtonID="btnDateToCal"
                                                                    Format="d/MM/yyyy" BehaviorID="" />
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-md-3 col-xs-12" style="padding: 5px;">
                                                            <div class="form-group" style="width: 100%; margin-top: 22px; float: left">
                                                                <asp:LinkButton ID="btnQuery"
                                                                    type="button"
                                                                    class="btn btn-warning btn-block"
                                                                    runat="server"
                                                                    OnClick="btnQuery_Click">
                                                                    <asp:Label ID="lblBtnQuery" runat="server" meta:resourcekey="lblBtnQueryRc"></asp:Label>
                                                                </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </section>
                                            <section class="panel" style="border: solid 1px #d0efde">
                                                <header class="panel-heading">
                                                    <b>
                                                        <asp:Label ID="lblGraphScore" runat="server" meta:resourcekey="lblGraphScoreRc" />
                                                    </b>
                                                </header>
                                                <asp:Panel runat="server" class="panel-body" DefaultButton="">
                                                    <div class="row">
                                                        <div class="col-lg-7 col-md-7 col-xs-12" style="padding: 5px;">
                                                            <div id="drawChartStaffScore"></div>
                                                        </div>
                                                        <div class="col-lg-5 col-md-5 col-xs-12" style="padding: 5px;">
                                                            <asp:GridView ID="staffScoreGridView"
                                                                            runat="server"
                                                                            AutoGenerateColumns="false"
                                                                            CssClass="table table-striped table-advance table-hover"
                                                                            Width="100%"
                                                                            GridLines="None"
                                                                            AllowPaging="true"
                                                                            ShowHeader="true"
                                                                            ShowHeaderWhenEmpty="true"
                                                                            OnPageIndexChanging="staffScoreGridView_PageIndexChanging"
                                                                            OnRowDataBound="staffScoreGridView_RowDataBound"
                                                                            PageSize="5">
                                                                <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                                <Columns>
                                                                    <asp:TemplateField ItemStyle-Width="5%" meta:resourcekey="staffScoreGridView_idRc">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblstaffScoreGridView_Id"
                                                                                runat="server" />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="staffScoreGridView_nameRc">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblstaffScoreGridView_name"
                                                                                runat="server" />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="staffScoreGridView_submitRc">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblStaffScoreGridView_submit"
                                                                                runat="server" />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="staffScoreGridView_passRc">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblStaffScoreGridView_pass"
                                                                                runat="server" />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="staffScoreGridView_failedSpecRc">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblStaffScoreGridView_failedSpec"
                                                                                runat="server" />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="staffScoreGridView_errorRc">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblStaffScoreGridView_error"
                                                                                runat="server" />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField ItemStyle-Width="10%" meta:resourcekey="staffScoreGridView_TotalRc">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblStaffScoreGridView_Total"
                                                                                runat="server" />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </section>
                                        </ContentTemplate>
                                        <Triggers>
                                        </Triggers>
                                    </asp:UpdatePanel>
                                    <script src="<%= WebUtils.getAppServerPath() %>/include/amCharts/core.js"></script>
                                    <script src="<%= WebUtils.getAppServerPath() %>/include/amCharts/charts.js"></script>
                                    <script src="<%= WebUtils.getAppServerPath() %>/include/amCharts/dark.js"></script>
                                    <script src="<%= WebUtils.getAppServerPath() %>/include/amCharts/animated.js"></script>
                                    <script src="<%= WebUtils.getAppServerPath() %>/include/amCharts/material.js"></script>
                                    <script>
                                        function drawChartStaffScore(dataJson) {
                                            // Create chart instance
                                            var chart = am4core.create("drawChartStaffScore", am4charts.XYChart);

                                            // Add data
                                            var dataJson = JSON.stringify(dataJson);
                                            const dataObjs = JSON.parse(dataJson);
                                            console.log("data : " + dataJson)

                                            // Add data
                                            chart.data = dataObjs;
                                            // Create axes
                                            var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
                                            categoryAxis.dataFields.category = "category";

                                            var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
                                            valueAxis.renderer.grid.template.strokeOpacity = 1;
                                            valueAxis.renderer.grid.template.stroke = am4core.color("#A0CA92");
                                            valueAxis.renderer.grid.template.strokeWidth = 2;
                                            for (var i = 0; i < dataObjs.length; i++) {
                                                var obj = dataObjs[i];

                                                console.log("id " + obj);
                                            }

                                            var cnt = 0;
                                            dataObjs.forEach((element, index, array) => {

                                                //series.name = key;

                                                var jsonParsedArray = element;
                                                if (cnt == 0) {
                                                    for (key in jsonParsedArray) {
                                                        if (jsonParsedArray.hasOwnProperty(key)) {
                                                            const checkCategoryStr = "category";
                                                            if (checkCategoryStr != key) {
                                                                var series = chart.series.push(new am4charts.LineSeries());

                                                                series.dataFields.categoryX = "category";
                                                                series.dataFields.valueY = key;
                                                                const name = key.replace("value-", "");
                                                                series.name = name;

                                                            }
                                                        }
                                                    }
                                                }
                                                cnt++
                                            });

                                            // Add cursor
                                            chart.cursor = new am4charts.XYCursor();

                                            // add legend
                                            chart.legend = new am4charts.Legend();
                                        }
                                        

                                        //function drawChartStaffScore(dataJson) {
                                        //    am4core.useTheme(am4themes_material);
                                        //    am4core.useTheme(am4themes_animated);
                                        //    var chart = am4core.create("drawChartStaffScore", am4charts.XYChart);

                                        //    // Create axes
                                        //    var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
                                        //    categoryAxis.dataFields.category = "category";

                                        //    var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
                                        //    valueAxis.renderer.grid.template.strokeOpacity = 1;
                                        //    valueAxis.renderer.grid.template.stroke = am4core.color("#A0CA92");
                                        //    valueAxis.renderer.grid.template.strokeWidth = 3;

                                        //    const dataObjs = JSON.parse(JSON.stringify(dataJson));
                                        //    // Create series
                                        //    dataObjs.forEach((element, index, array) => {
                                        //        var series = chart.series.push(new am4charts.LineSeries());
                                        //        series.dataFields.valueY = "value-" + element.personName;
                                        //        series.dataFields.categoryX = "category";
                                        //        series.name = element.personName;
                                        //        series.strokeWidth = 3;
                                        //        series.tensionX = 0.8;
                                        //        series.bullets.push(new am4charts.CircleBullet());
                                        //    });
                                            
                                        //    chart.cursor = new am4charts.XYCursor();

                                        //    // Add a legend
                                        //    chart.legend = new am4charts.Legend();
                                        //    chart.legend.position = "bottom";
                                            
                                        //}
                                        

                                        //function drawChartStaffScore(dataJson) {
                                        //    am4core.useTheme(am4themes_material);
                                        //    am4core.useTheme(am4themes_animated);
                                        //    //create charts
                                        //    var chart = am4core.create("drawChartStaffScore", am4charts.XYChart);

                                        //    // Create axes
                                        //    var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
                                        //    categoryAxis.dataFields.category = "xValues";
                                        //    //xAxis.renderer.minGridDistance = 20;

                                        //    // Create value axis
                                        //    var yAxis = chart.yAxes.push(new am4charts.ValueAxis());
                                            

                                        //    //create series
                                        //    const dataObjs = JSON.parse(JSON.stringify(dataJson));
                                        //    console.log(dataObjs)
                                        //    dataObjs.forEach((element, index, array) => {
                                        //        var serie = chart.series.push(new am4charts.LineSeries());
                                        //        serie.name = element.name;
                                        //        serie.dataFields.valueY = "yValue";
                                        //        serie.dataFields.categoryX = "xValues";
                                        //        serie.strokeWidth = 3;
                                        //        serie.tensionX = 0.8;
                                        //        serie.bullets.push(new am4charts.CircleBullet());
                                        //        serie.data = element.items;
                                        //    });


                                        //    chart.cursor = new am4charts.XYCursor();

                                        //    // Add a legend
                                        //    chart.legend = new am4charts.Legend();
                                        //    chart.legend.position = "bottom";
                                        //}
                                    </script>
                                </form>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </section>
    </section>
   
    <!--main content end-->
</asp:Content>
