﻿<%@ Page Language="C#"
     AutoEventWireup="true"
     CodeBehind="TestDrawflow.aspx.cs"
     ValidateRequest="false"
     Inherits="XenDevWeb.Test.drawflow.TestDrawflow" %>

<%@ Import Namespace="XenDevWeb.Utils" %>

<!DOCTYPE html>
<html >
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Drawflow</title>
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
                    <div class="row" style="padding:10px;">
                        <button onclick="saveJson()" 
                                style = "font-family: Roboto;
                                        font-weight: 500;
                                        font-size: 14px;
                                        color: #FFF;
                                        background-color: #1aca74;
                                        border: 1px solid #1aca74;
                                        border-radius: 5px;
                                        width: 143px;
                                        height: 38px;
                                        margin-left: 10px;
                                        display: inline-block;
                                        vertical-align: top;
                                        text-align: center;
                                        line-height: 38px;
                                        margin-right: 20px;
                                        transition: all .2s cubic-bezier(.05,.03,.35,1);">Save</button>
                        <asp:LinkButton ID="btnShow" runat="server" OnClick="btnShow_Click" Text="Show"
                                        style = "font-family: Roboto;
                                                font-weight: 500;
                                                font-size: 14px;
                                                color: #FFF;
                                                background-color: #217CE8;
                                                border-radius: 5px;
                                                width: 143px;
                                                height: 38px;
                                                margin-left: 10px;
                                                display: inline-block;
                                                vertical-align: top;
                                                text-align: center;
                                                line-height: 38px;
                                                margin-right: 20px;
                                                transition: all .2s cubic-bezier(.05,.03,.35,1);"> </asp:LinkButton>
                    </div>
                    <asp:HiddenField ID="hndJson" runat="server" OnValueChanged="hndJson_ValueChanged" />
                </ContentTemplate>
            </asp:UpdatePanel>
    </div>
    </form>   
  </header>
  <div class="wrapper">
    <div class="col">
      <div class="drag-drawflow" draggable="true" ondragstart="drag(event)" data-node="facebook">
        <i class="fab fa-facebook"></i><span> Facebook</span>
      </div>
      <div class="drag-drawflow" draggable="true" ondragstart="drag(event)" data-node="slack">
        <i class="fab fa-slack"></i><span> Slack recive message</span>
      </div>
      <div class="drag-drawflow" draggable="true" ondragstart="drag(event)" data-node="github">
        <i class="fab fa-github"></i><span> Github Star</span>
      </div>
      <div class="drag-drawflow" draggable="true" ondragstart="drag(event)" data-node="telegram">
        <i class="fab fa-telegram"></i><span> Telegram send message</span>
      </div>
      <div class="drag-drawflow" draggable="true" ondragstart="drag(event)" data-node="aws">
        <i class="fab fa-aws"></i><span> AWS</span>
      </div>
      <div class="drag-drawflow" draggable="true" ondragstart="drag(event)" data-node="log">
        <i class="fas fa-file-signature"></i><span> File Log</span>
      </div>
      <div class="drag-drawflow" draggable="true" ondragstart="drag(event)" data-node="google">
        <i class="fab fa-google-drive"></i><span> Google Drive save</span>
      </div>
      <div class="drag-drawflow" draggable="true" ondragstart="drag(event)" data-node="email">
        <i class="fas fa-at"></i><span> Email send</span>
      </div>
      <div class="drag-drawflow" draggable="true" ondragstart="drag(event)" data-node="template">
        <i class="fas fa-code"></i><span> Template</span>
      </div>
      <div class="drag-drawflow" draggable="true" ondragstart="drag(event)" data-node="multiple">
        <i class="fas fa-code-branch"></i><span> Multiple inputs/outputs</span>
      </div>
      <div class="drag-drawflow" draggable="true" ondragstart="drag(event)" data-node="personalized">
        <i class="fas fa-fill"></i><span> Personalized</span>
      </div>
      <div class="drag-drawflow" draggable="true" ondragstart="drag(event)" data-node="dbclick">
        <i class="fas fa-mouse"></i><span> DBClick!</span>
      </div>


    </div>
    <div class="col-right">
      <div class="menu">
        <ul>
          <li onclick="editor.changeModule('Home'); changeModule(event);" class="selected">Home</li>
          <li onclick="editor.changeModule('Other'); changeModule(event);">Other Module</li>
        </ul>
      </div>
      <div id="drawflow" ondrop="drop(event)" ondragover="allowDrop(event)">

        <div class="btn-export" onclick="Swal.fire({ title: 'Export',
        html: '<pre><code>'+JSON.stringify(editor.export(), null,4)+'</code></pre>'
        })">Export</div>
        <div class="btn-clear" onclick="editor.clearModuleSelected()">Clear</div>
        <div class="btn-lock">
          <i id="lock" class="fas fa-lock" onclick="editor.editor_mode='fixed'; changeMode('lock');"></i>
          <i id="unlock" class="fas fa-lock-open" onclick="editor.editor_mode='edit'; changeMode('unlock');" style="display:none;"></i>
        </div>
        <div class="bar-zoom">
          <i class="fas fa-search-minus" onclick="editor.zoom_out()"></i>
          <i class="fas fa-search" onclick="editor.zoom_reset()"></i>
          <i class="fas fa-search-plus" onclick="editor.zoom_in()"></i>
        </div>
      </div>
    </div>
  </div>

  <script>

    var id = document.getElementById("drawflow");
    const editor = new Drawflow(id);
    editor.reroute = true;
    editor.reroute_fix_curvature = true;
    editor.force_first_input = false;

    const dataToImport =  {"drawflow":{"Home":{"data":{"1":{"id":1,"name":"welcome","data":{},"class":"welcome","html":"\n    <div>\n      <div class=\"title-box\">👏 Welcome!!</div>\n      <div class=\"box\">\n        <p>Simple flow library <b>demo</b>\n        <a href=\"https://github.com/jerosoler/Drawflow\" target=\"_blank\">Drawflow</a> by <b>Jero Soler</b></p><br>\n\n        <p>Multiple input / outputs<br>\n           Data sync nodes<br>\n           Import / export<br>\n           Modules support<br>\n           Simple use<br>\n           Type: Fixed or Edit<br>\n           Events: view console<br>\n           Pure Javascript<br>\n        </p>\n        <br>\n        <p><b><u>Shortkeys:</u></b></p>\n        <p>🎹 <b>Delete</b> for remove selected<br>\n        💠 Mouse Left Click == Move<br>\n        ❌ Mouse Right == Delete Option<br>\n        🔍 Ctrl + Wheel == Zoom<br>\n        📱 Mobile support<br>\n        ...</p>\n      </div>\n    </div>\n    ", "typenode": false, "inputs":{},"outputs":{},"pos_x":50,"pos_y":50},"2":{"id":2,"name":"slack","data":{},"class":"slack","html":"\n          <div>\n            <div class=\"title-box\"><i class=\"fab fa-slack\"></i> Slack chat message</div>\n          </div>\n          ", "typenode": false, "inputs":{"input_1":{"connections":[{"node":"7","input":"output_1"}]}},"outputs":{},"pos_x":1028,"pos_y":87},"3":{"id":3,"name":"telegram","data":{"channel":"channel_2"},"class":"telegram","html":"\n          <div>\n            <div class=\"title-box\"><i class=\"fab fa-telegram-plane\"></i> Telegram bot</div>\n            <div class=\"box\">\n              <p>Send to telegram</p>\n              <p>select channel</p>\n              <select df-channel>\n                <option value=\"channel_1\">Channel 1</option>\n                <option value=\"channel_2\">Channel 2</option>\n                <option value=\"channel_3\">Channel 3</option>\n                <option value=\"channel_4\">Channel 4</option>\n              </select>\n            </div>\n          </div>\n          ", "typenode": false, "inputs":{"input_1":{"connections":[{"node":"7","input":"output_1"}]}},"outputs":{},"pos_x":1032,"pos_y":184},"4":{"id":4,"name":"email","data":{},"class":"email","html":"\n            <div>\n              <div class=\"title-box\"><i class=\"fas fa-at\"></i> Send Email </div>\n            </div>\n            ", "typenode": false, "inputs":{"input_1":{"connections":[{"node":"5","input":"output_1"}]}},"outputs":{},"pos_x":1033,"pos_y":439},"5":{"id":5,"name":"template","data":{"template":"Write your template"},"class":"template","html":"\n            <div>\n              <div class=\"title-box\"><i class=\"fas fa-code\"></i> Template</div>\n              <div class=\"box\">\n                Ger Vars\n                <textarea df-template></textarea>\n                Output template with vars\n              </div>\n            </div>\n            ", "typenode": false, "inputs":{"input_1":{"connections":[{"node":"6","input":"output_1"}]}},"outputs":{"output_1":{"connections":[{"node":"4","output":"input_1"},{"node":"11","output":"input_1"}]}},"pos_x":607,"pos_y":304},"6":{"id":6,"name":"github","data":{"name":"https://github.com/jerosoler/Drawflow"},"class":"github","html":"\n          <div>\n            <div class=\"title-box\"><i class=\"fab fa-github \"></i> Github Stars</div>\n            <div class=\"box\">\n              <p>Enter repository url</p>\n            <input type=\"text\" df-name>\n            </div>\n          </div>\n          ", "typenode": false, "inputs":{},"outputs":{"output_1":{"connections":[{"node":"5","output":"input_1"}]}},"pos_x":341,"pos_y":191},"7":{"id":7,"name":"facebook","data":{},"class":"facebook","html":"\n        <div>\n          <div class=\"title-box\"><i class=\"fab fa-facebook\"></i> Facebook Message</div>\n        </div>\n        ", "typenode": false, "inputs":{},"outputs":{"output_1":{"connections":[{"node":"2","output":"input_1"},{"node":"3","output":"input_1"},{"node":"11","output":"input_1"}]}},"pos_x":347,"pos_y":87},"11":{"id":11,"name":"log","data":{},"class":"log","html":"\n            <div>\n              <div class=\"title-box\"><i class=\"fas fa-file-signature\"></i> Save log file </div>\n            </div>\n            ", "typenode": false, "inputs":{"input_1":{"connections":[{"node":"5","input":"output_1"},{"node":"7","input":"output_1"}]}},"outputs":{},"pos_x":1031,"pos_y":363}}},"Other":{"data":{"8":{"id":8,"name":"personalized","data":{},"class":"personalized","html":"\n            <div>\n              Personalized\n            </div>\n            ", "typenode": false, "inputs":{"input_1":{"connections":[{"node":"12","input":"output_1"},{"node":"12","input":"output_2"},{"node":"12","input":"output_3"},{"node":"12","input":"output_4"}]}},"outputs":{"output_1":{"connections":[{"node":"9","output":"input_1"}]}},"pos_x":764,"pos_y":227},"9":{"id":9,"name":"dbclick","data":{"name":"Hello World!!"},"class":"dbclick","html":"\n            <div>\n            <div class=\"title-box\"><i class=\"fas fa-mouse\"></i> Db Click</div>\n              <div class=\"box dbclickbox\" ondblclick=\"showpopup(event)\">\n                Db Click here\n                <div class=\"modal\" style=\"display:none\">\n                  <div class=\"modal-content\">\n                    <span class=\"close\" onclick=\"closemodal(event)\">&times;</span>\n                    Change your variable {name} !\n                    <input type=\"text\" df-name>\n                  </div>\n\n                </div>\n              </div>\n            </div>\n            ", "typenode": false, "inputs":{"input_1":{"connections":[{"node":"8","input":"output_1"}]}},"outputs":{"output_1":{"connections":[{"node":"12","output":"input_2"}]}},"pos_x":209,"pos_y":38},"12":{"id":12,"name":"multiple","data":{},"class":"multiple","html":"\n            <div>\n              <div class=\"box\">\n                Multiple!\n              </div>\n            </div>\n            ", "typenode": false, "inputs":{"input_1":{"connections":[]},"input_2":{"connections":[{"node":"9","input":"output_1"}]},"input_3":{"connections":[]}},"outputs":{"output_1":{"connections":[{"node":"8","output":"input_1"}]},"output_2":{"connections":[{"node":"8","output":"input_1"}]},"output_3":{"connections":[{"node":"8","output":"input_1"}]},"output_4":{"connections":[{"node":"8","output":"input_1"}]}},"pos_x":179,"pos_y":272}}}}}
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
          editor.clear();
          editor.import(dataJson);
    }
  </script>
</body>
</html>

