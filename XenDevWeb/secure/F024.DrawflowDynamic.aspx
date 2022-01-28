<%@ Page Language="C#" 
    AutoEventWireup="true" 
    CodeBehind="F024.DrawflowDynamic.aspx.cs" 
    ValidateRequest="false"
    Inherits="XenDevWeb.secure.F024_DrawflowDynamic" %>

<%@ Import Namespace="XenDevWeb.Utils" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<!DOCTYPE html>
<html >
<head runat="server">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Drawflow Dynamic</title>
</head>
<body>
  <link rel="stylesheet" href="<%= WebUtils.getAppServerPath() %>/include/drawflow/dist/drawflow.min.css" />
  <script src="<%= WebUtils.getAppServerPath() %>/include/drawflow/dist/drawflow.min.js"></script>
  <script src="<%= WebUtils.getAppServerPath() %>/include/drawflow/src/all.min.js" ></script>
  <link rel="stylesheet" href="<%= WebUtils.getAppServerPath() %>/include/drawflow/src/all.min.css" />
  <link rel="stylesheet" type="text/css" href="<%= WebUtils.getAppServerPath() %>/include/drawflow/src/drawflow.css" />
  <link rel="stylesheet" type="text/css" href="<%= WebUtils.getAppServerPath() %>/include/drawflow/docs/beautiful.css" />  
  <link href="<%= WebUtils.getAppServerPath() %>/include/drawflow/src/css2.css" rel="stylesheet">
  <script src="<%= WebUtils.getAppServerPath() %>/include/drawflow/src/sweetalert2@9.js"></script>
  <script src="<%= WebUtils.getAppServerPath() %>/include/drawflow/src/micromodal.min.js"></script>


  <header>
    <h2>Drawflow</h2>
    <form id="form1" runat="server">
         <div class="github-link">
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
                    <%= WebUtils.getErrorMessage(this.errorMessages) %>
                    <%= WebUtils.getInfoMessage(this.infoMessages) %>
                </ContentTemplate>
            </asp:UpdatePanel>
         </div>
        <div class="wrapper" style="margin: 1px">
            <div class="col">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="lblDrawFlowSelNode" runat="server" meta:resourcekey="lblDrawFlowSelNodeRc"/>
                        <select id="selNode" style="width:90%; margin:10px;border-radius: 10px; padding:10px;" runat="server">
                            <option value="style_header_only">Style header only</option>
                            <option value="style_header_and_body_label">Style header and body label</option>
                            <option value="style_with_one_text_box">Style with one text box</option>
                            <option value="style_with_two_textbox">Style with two textbox</option>
                            <option value="style_double_click">Style double click</option>
                            <option value="style_personalized">Style personalized</option>
                        </select>
                        <asp:Label ID="lblDrawFlowTitle" runat="server" meta:resourcekey="lblDrawFlowTitleRc" AssociatedControlID="txtTitle" />
                        <asp:TextBox ID="txtTitle" 
                                    runat="server" 
                                    meta:resourcekey="txtDrawFlowTitleRc" 
                                    Style="width: 80%; margin: 10px; border-radius: 10px; padding: 10px;">
                        </asp:TextBox>
                        <asp:Label ID="lblDrawFlowText" runat="server" meta:resourcekey="lblDrawFlowTextRc" AssociatedControlID="txtText" />
                        <asp:TextBox ID="txtText" 
                                    runat="server" 
                                    meta:resourcekey="txtDrawFlowTextRc" 
                                    Style="width: 80%; margin: 10px; border-radius: 10px; padding: 10px;">
                        </asp:TextBox>
                        <asp:Label ID="lblDrawFlowPortLeft" runat="server" meta:resourcekey="lblDrawFlowPortLeftRc" AssociatedControlID="txtPortLeft" />
                        <asp:TextBox ID="txtPortLeft" 
                                    runat="server" 
                                    TextMode="Number" 
                                    min="0" 
                                    Text="0" 
                                    Style="width: 80%; margin: 10px; border-radius: 10px; padding: 10px;">
                        </asp:TextBox>
                        <asp:Label ID="lblDrawFlowPortRight" runat="server" meta:resourcekey="lblDrawFlowPortRightRc" AssociatedControlID="txtPortRight" />
                        <asp:TextBox ID="txtPortRight" runat="server" TextMode="Number" min="0" Text="0" Style="width: 80%; margin: 10px; border-radius: 10px; padding: 10px;"></asp:TextBox>

                        <button onclick="setNode()"
                            style="font-family: Roboto;
                                    font-weight: 500;
                                    font-size: 14px;
                                    color: #FFF;
                                    background-color: #8bc34a;
                                    border: 1px solid #8bc34a;
                                    border-radius: 5px;
                                    width: 90%;
                                    height: 38px;
                                    margin-left: 10px;
                                    display: inline-block;
                                    vertical-align: top;
                                    text-align: center;
                                    line-height: 38px;
                                    margin-right: 20px;
                                    margin-bottom: 60px;
                                    transition: all .2s cubic-bezier(.05,.03,.35,1);" runat="server" id="btnSetNode">
                            <asp:Label ID="lblBtnSetNode" runat="server" meta:resourcekey="lblBtnSetNodeRc"></asp:Label>
                        </button>
                        <button onclick="saveJson()" runat="server" id="btnSave"
                            style="font-family: Roboto; font-weight: 500; font-size: 14px; color: #FFF; background-color: #1aca74; border: 1px solid #1aca74; border-radius: 5px; width: 90%; height: 38px; margin-left: 10px; display: inline-block; vertical-align: top; text-align: center; line-height: 38px; margin-right: 20px; margin-bottom: 15px; transition: all .2s cubic-bezier(.05,.03,.35,1);">
                            <asp:Label ID="lblSave" runat="server" meta:resourcekey="lblBtnSaveRc"></asp:Label>
                        </button>
                        <asp:LinkButton ID="btnBack"
                                        runat="server"
                                        style = "font-family: Roboto;
                                                font-weight: 500;
                                                font-size: 14px;
                                                color: #FFF;
                                                background-color: #f0ad4e;
                                                border-radius: 5px;
                                                width: 90%;
                                                height: 38px;
                                                margin-left: 10px;
                                                display: inline-block;
                                                vertical-align: top;
                                                text-align: center;
                                                line-height: 38px;
                                                margin-right: 20px;
                                                margin-bottom: 15px;
                                                transition: all .2s cubic-bezier(.05,.03,.35,1);"
                                        OnClick="btnBack_Click">
                            <asp:Label ID="lblBack" runat="server" meta:resourcekey="lblBackRc"></asp:Label>
                        </asp:LinkButton>
                        <asp:HiddenField ID="hndJson" runat="server" OnValueChanged="hndJson_ValueChanged" />
                    </ContentTemplate>
                </asp:UpdatePanel>
                
            </div>
            <div class="col-right">
                <div class="menu">
                    <ul>
                        <li onclick="editor.changeModule('Home'); changeModule(event);" class="selected">
                            <asp:Label ID="lblHome" runat="server" meta:resourcekey="lblHomeRc"></asp:Label>
                        </li>
                        <li onclick="editor.changeModule('Other'); changeModule(event);">
                            <asp:Label ID="lblOtherModule" runat="server" meta:resourcekey="lblOtherModuleRc"></asp:Label>
                        </li>
                    </ul>
                </div>
                <div id="drawflow" ondrop="drop(event)" ondragover="allowDrop(event)" onload="showGraph()">
                    <div class="btn-clear" onclick="editor.clearModuleSelected()">
                        <asp:Label ID="lblClear" runat="server" meta:resourcekey="lblClearRc"></asp:Label>
                    </div>
                    <div class="btn-lock">
                        <i id="lock" class="fas fa-lock" onclick="editor.editor_mode='fixed'; changeMode('lock');"></i>
                        <i id="unlock" class="fas fa-lock-open" onclick="editor.editor_mode='edit'; changeMode('unlock');" style="display: none;"></i>
                    </div>
                    <div class="bar-zoom">
                        <i class="fas fa-search-minus" onclick="editor.zoom_out()"></i>
                        <i class="fas fa-search" onclick="editor.zoom_reset()"></i>
                        <i class="fas fa-search-plus" onclick="editor.zoom_in()"></i>
                    </div>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hndRequirementId" runat="server" />
        <script type="text/javascript" language="javascript">
    var id = document.getElementById("drawflow");
    const editor = new Drawflow(id);
    editor.reroute = true;
    editor.reroute_fix_curvature = true;
    editor.force_first_input = false;

    const dataToImport = {
        "drawflow": {
            "Home": {
                "data": {}
            },
            "Other": {
                "data": {}
            }
        }
    };
    console.log(dataToImport)
    editor.start();
    editor.import(dataToImport);
  
    // Events!
    editor.on('nodeCreated', function(id) {
      console.log("Node created " + id);
    })

    editor.on('nodeRemoved', function(id) {
      console.log("Node removed " + id);
    })

    editor.on('nodeSelected', function(id) {
      console.log("Node selected " + id);
    })

    editor.on('moduleCreated', function(name) {
      console.log("Module Created " + name);
    })

    editor.on('moduleChanged', function(name) {
      console.log("Module Changed " + name);
    })

    editor.on('connectionCreated', function(connection) {
      console.log('Connection created');
      console.log(connection);
    })

    editor.on('connectionRemoved', function(connection) {
      console.log('Connection removed');
      console.log(connection);
    })
/*
    editor.on('mouseMove', function(position) {
      console.log('Position mouse x:' + position.x + ' y:'+ position.y);
    })
*/
    editor.on('nodeMoved', function(id) {
      console.log("Node moved " + id);
    })

    editor.on('zoom', function(zoom) {
      console.log('Zoom level ' + zoom);
    })

    editor.on('translate', function(position) {
      console.log('Translate x:' + position.x + ' y:'+ position.y);
    })

    editor.on('addReroute', function(id) {
      console.log("Reroute added " + id);
    })

    editor.on('removeReroute', function(id) {
      console.log("Reroute removed " + id);
    })
    /* DRAG EVENT */

    /* Mouse and Touch Actions */

    var elements = document.getElementsByClassName('drag-drawflow');
    for (var i = 0; i < elements.length; i++) {
      elements[i].addEventListener('touchend', drop, false);
      elements[i].addEventListener('touchmove', positionMobile, false);
      elements[i].addEventListener('touchstart', drag, false );
    }

    var mobile_item_selec = '';
    var mobile_last_move = null;
   function positionMobile(ev) {
     mobile_last_move = ev;
   }

   function allowDrop(ev) {
      ev.preventDefault();
    }

    function drag(ev) {
      if (ev.type === "touchstart") {
        mobile_item_selec = ev.target.closest(".drag-drawflow").getAttribute('data-node');
      } else {
      ev.dataTransfer.setData("node", ev.target.getAttribute('data-node'));
      }
    }

    function drop(ev) {
      if (ev.type === "touchend") {
        var parentdrawflow = document.elementFromPoint( mobile_last_move.touches[0].clientX, mobile_last_move.touches[0].clientY).closest("#drawflow");
        if(parentdrawflow != null) {
          addNodeToDrawFlow(mobile_item_selec, mobile_last_move.touches[0].clientX, mobile_last_move.touches[0].clientY);
        }
        mobile_item_selec = '';
      } else {
        ev.preventDefault();
        var data = ev.dataTransfer.getData("node");
        addNodeToDrawFlow(data, ev.clientX, ev.clientY);
      }

    }

    function addNodeToDrawFlow(name, pos_x, pos_y) {
      if(editor.editor_mode === 'fixed') {
        return false;
      }
      pos_x = pos_x * ( editor.precanvas.clientWidth / (editor.precanvas.clientWidth * editor.zoom)) - (editor.precanvas.getBoundingClientRect().x * ( editor.precanvas.clientWidth / (editor.precanvas.clientWidth * editor.zoom)));
      pos_y = pos_y * ( editor.precanvas.clientHeight / (editor.precanvas.clientHeight * editor.zoom)) - (editor.precanvas.getBoundingClientRect().y * ( editor.precanvas.clientHeight / (editor.precanvas.clientHeight * editor.zoom)));


      switch (name) {
        case 'facebook':
        var facebook = `
        <div>
          <div class="title-box"><i class="fab fa-facebook"></i> Facebook Message</div>
        </div>
        `;
          editor.addNode('facebook', 0,  1, pos_x, pos_y, 'facebook', {}, facebook );
          break;
        case 'slack':
          var slackchat = `
          <div>
            <div class="title-box"><i class="fab fa-slack"></i> Slack chat message</div>
          </div>
          `
          editor.addNode('slack', 1, 0, pos_x, pos_y, 'slack', {}, slackchat );
          break;
        case 'github':
          var githubtemplate = `
          <div>
            <div class="title-box"><i class="fab fa-github "></i> Github Stars</div>
            <div class="box">
              <p>Enter repository url</p>
            <input type="text" df-name>
            </div>
          </div>
          `;
          editor.addNode('github', 0, 1, pos_x, pos_y, 'github', { "name": ''}, githubtemplate );
          break;
        case 'telegram':
          var telegrambot = `
          <div>
            <div class="title-box"><i class="fab fa-telegram-plane"></i> Telegram bot</div>
            <div class="box">
              <p>Send to telegram</p>
              <p>select channel</p>
              <select df-channel>
                <option value="channel_1">Channel 1</option>
                <option value="channel_2">Channel 2</option>
                <option value="channel_3">Channel 3</option>
                <option value="channel_4">Channel 4</option>
              </select>
            </div>
          </div>
          `;
          editor.addNode('telegram', 1, 0, pos_x, pos_y, 'telegram', { "channel": 'channel_3'}, telegrambot );
          break;
        case 'aws':
          var aws = `
          <div>
            <div class="title-box"><i class="fab fa-aws"></i> Aws Save </div>
            <div class="box">
              <p>Save in aws</p>
              <input type="text" df-db-dbname placeholder="DB name"><br><br>
              <input type="text" df-db-key placeholder="DB key">
              <p>Output Log</p>
            </div>
          </div>
          `;
          editor.addNode('aws', 1, 1, pos_x, pos_y, 'aws', { "db": { "dbname": '', "key": '' }}, aws );
          break;
        case 'log':
            var log = `
            <div>
              <div class="title-box"><i class="fas fa-file-signature"></i> Save log file </div>
            </div>
            `;
            editor.addNode('log', 1, 0, pos_x, pos_y, 'log', {}, log );
            break;
          case 'google':
            var google = `
            <div>
              <div class="title-box"><i class="fab fa-google-drive"></i> Google Drive save </div>
            </div>
            `;
            editor.addNode('google', 1, 0, pos_x, pos_y, 'google', {}, google );
            break;
          case 'email':
            var email = `
            <div>
              <div class="title-box"><i class="fas fa-at"></i> Send Email </div>
            </div>
            `;
            editor.addNode('email', 1, 0, pos_x, pos_y, 'email', {}, email );
            break;

          case 'template':
            var template = `
            <div>
              <div class="title-box"><i class="fas fa-code"></i> Template</div>
              <div class="box">
                Ger Vars
                <textarea df-template></textarea>
                Output template with vars
              </div>
            </div>
            `;
            editor.addNode('template', 1, 1, pos_x, pos_y, 'template', { "template": 'Write your template'}, template );
            break;
          case 'multiple':
            var multiple = `
            <div>
              <div class="box">
                Multiple!
              </div>
            </div>
            `;
            editor.addNode('multiple', 3, 4, pos_x, pos_y, 'multiple', {}, multiple );
            break;
          case 'personalized':
            var personalized = `
            <div>
              Personalized
            </div>
            `;
            editor.addNode('personalized', 1, 1, pos_x, pos_y, 'personalized', {}, personalized );
            break;
          case 'dbclick':
            var dbclick = `
            <div>
            <div class="title-box"><i class="fas fa-mouse"></i> Db Click</div>
              <div class="box dbclickbox" ondblclick="showpopup(event)">
                Db Click here
                <div class="modal" style="display:none">
                  <div class="modal-content">
                    <span class="close" onclick="closemodal(event)">&times;</span>
                    Change your variable {name} !
                    <input type="text" df-name>
                  </div>

                </div>
              </div>
            </div>
            `;
            editor.addNode('dbclick', 1, 1, pos_x, pos_y, 'dbclick', { name: ''}, dbclick );
            break;

        default:
      }
    }

  var transform = '';
  function showpopup(e) {
    e.target.closest(".drawflow-node").style.zIndex = "9999";
    e.target.children[0].style.display = "block";
    //document.getElementById("modalfix").style.display = "block";

    //e.target.children[0].style.transform = 'translate('+translate.x+'px, '+translate.y+'px)';
    transform = editor.precanvas.style.transform;
    editor.precanvas.style.transform = '';
    editor.precanvas.style.left = editor.canvas_x +'px';
    editor.precanvas.style.top = editor.canvas_y +'px';
    console.log(transform);

    //e.target.children[0].style.top  =  -editor.canvas_y - editor.container.offsetTop +'px';
    //e.target.children[0].style.left  =  -editor.canvas_x  - editor.container.offsetLeft +'px';
    editor.editor_mode = "fixed";

  }

   function closemodal(e) {
     e.target.closest(".drawflow-node").style.zIndex = "2";
     e.target.parentElement.parentElement.style.display  ="none";
     //document.getElementById("modalfix").style.display = "none";
     editor.precanvas.style.transform = transform;
       editor.precanvas.style.left = '0px';
       editor.precanvas.style.top = '0px';
      editor.editor_mode = "edit";
   }

    function changeModule(event) {
      var all = document.querySelectorAll(".menu ul li");
        for (var i = 0; i < all.length; i++) {
          all[i].classList.remove('selected');
        }
      event.target.classList.add('selected');
    }

    function changeMode(option) {

    //console.log(lock.id);
      if(option == 'lock') {
        lock.style.display = 'none';
        unlock.style.display = 'block';
      } else {
        lock.style.display = 'block';
        unlock.style.display = 'none';
      }

    }

    function saveJson() {
        var dataJson = JSON.stringify(editor.export());
        console.log(dataJson)
        document.getElementById("<%= hndJson.ClientID %>").value = dataJson;
        __doPostBack("<%= hndJson.ClientID %>");
    }
    
    function showGraph(dataJson) {
        console.log("Show" + dataJson);
        //editor.clear();
        editor.import(dataJson);
    }

    function setNode() {
        var title = document.getElementById("<%= txtTitle.ClientID %>").value;
        var text = document.getElementById("<%= txtText.ClientID %>").value;
        var portLeft = document.getElementById("<%= txtPortLeft.ClientID %>").value;
        var portRight = document.getElementById("<%= txtPortRight.ClientID %>").value;
        var selNode = document.getElementById("selNode").value;
        var x = (-1* editor.canvas_x) + window.innerWidth / 2.5;
        var y = (-1*editor.canvas_y) + window.innerHeight / 2.5;

        console.log("editor : " + editor.canvas_x)

        switch(selNode){
            case 'style_header_only':
                var headerOnly = `<div>
                                      <div class ="title-box"> ${title}</div>
                                  </div>`;
                editor.addNode('headerOnly', portLeft, portRight, x, y, 'headerOnly', {}, headerOnly);
                break;
            case 'style_header_and_body_label':
                var style_header_and_body_label = `<div>
                                                      <div class ="title-box"> ${title}</div>
                                                       <div class ="box">
                                                            ${text}
                                                       </div>
                                                    </div>`;
                editor.addNode('style_header_and_body_label', portLeft, portRight, x, y, 'style_header_and_body_label', {}, style_header_and_body_label);
                break;
            case 'style_with_one_text_box':
                var style_with_one_text_box = `<div>
                                              <div class ="title-box"> ${title}</div>
                                              <div class="box">
                                                Ger Vars
                                                <textarea df-template></textarea>
                                                Output template with vars
                                              </div>
                                            </div>`;
                editor.addNode('style_with_one_text_box', portLeft, portRight, x, y, 'style_with_one_text_box', { "template": text }, style_with_one_text_box);
                break;
            case 'style_with_two_textbox':
                var style_with_two_textbox = `   <div>
                                <div class ="title-box"> ${title} </div>
                                <div class="box">
                                  <p>Save in aws</p>
                                  <input type="text" df-db-dbname placeholder="DB name"><br><br>
                                  <input type="text" df-db-key placeholder="DB key">
                                  <p>Output Log</p>
                                </div>
                              </div>
                              `;
                editor.addNode('style_with_two_textbox', portLeft, portRight, x, y, 'style_with_two_textbox', { "db": { "dbname": title, "key": text } }, style_with_two_textbox);
                break;
            case 'style_double_click':
                var style_double_click = `
                                    <div>
                                    <div class ="title-box"> ${title}</div>
                                      <div class="box dbclickbox" ondblclick="showpopup(event)">
                                        Db Click here
                                        <div class="modal" style="display:none">
                                          <div class="modal-content">
                                            <span class="close" onclick="closemodal(event)">&times;</span>
                                            Change your variable {name} !
                                            <input type="text" df-name>
                                          </div>

                                        </div>
                                      </div>
                                    </div>
                                    `;
                editor.addNode('style_double_click', portLeft, portRight, x, y, 'style_double_click', { name: text }, style_double_click);
                break;
            case 'style_personalized':
                var style_personalized = `<div>
                                      ${title}
                                    </div>
                                    `;
                editor.addNode('personalized', portLeft, portRight, x, y, 'personalized', {}, style_personalized);
                break;
        }
    }
    </script>
    </form>
  </header>
    
</body>
</html>
