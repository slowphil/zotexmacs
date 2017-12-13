///////////////////////////////////////////////////////////////////////////////
//
// MODULE      : Zotexmacs
// DESCRIPTION : Extension enabling Zotero to interact with GNU TeXmacs
// COPYRIGHT   : (C) 2016-2017 Philippe Joyez
//
// This software falls under the GNU general public license version 3 or later.
// It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
// in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
//
///////////////////////////////////////////////////////////////////////////////
// Credits:
// - small bits were borrowed from the Lyz Zotero extension

Zotero.zotexmacs = {

	wm : Components.classes["@mozilla.org/appshell/window-mediator;1"].getService(Components.interfaces.nsIWindowMediator),
	os: null,
	
	tm_transport : null,
	tm_outstream : null,
	tm_instream : null, //Components.classes['@mozilla.org/scriptableinputstream;1'].createInstance(Components.interfaces.nsIScriptableInputStream),
	tm_InputStream : null,	
	fails : 0,
	maxfails : 3,
	tm_connected : false,
	keep_connected : false, //do we want a persistent connection? otherwise we connect and login for each command.
	


	init : function() {	
		if (Zotero.version.split('.')[0] < 5) {
			var win = this.wm.getMostRecentWindow("navigator:browser");
			win.alert('Warning: Zotemacs 0.5 is for Zotero 5 or higher. For Zotero 4, please install Zotexmacs 0.2 from https://github.com/slowphil/zotexmacs/releases/tag/v0.2');
		  return false
    }
	},
	
	tm_connect : function (server, port) {
	  this.tm_instream = Components.classes['@mozilla.org/scriptableinputstream;1'].createInstance(Components.interfaces.nsIScriptableInputStream);
	
	  this.tm_transport = Components.classes['@mozilla.org/network/socket-transport-service;1'].getService(Components.interfaces.nsISocketTransportService).createTransport(null, 0, server, port, null);
	  var connect_timeout = 50;

	  this.tm_outstream = this.tm_transport.openOutputStream(0, 0, 0);
	  this.tm_InputStream = this.tm_transport.openInputStream(0, 0, 0);
	  // Initialize
	  this.tm_instream.init(this.tm_InputStream,"UTF-8",0,0);
	  var start = new Date().getTime();
	  for (var i = 0; i < 1e7; i++) { // make sure we are connected before going on (and try sending data) or timeout after connect_timeout ms
	    if (((new Date().getTime() - start) > connect_timeout ) ||(this.tm_transport.isAlive())) {
	      break;
	    }}
	  //console.log("connect end alive?" +   this.tm_transport.isAlive());
	},

	tm_read : function (){
		try{
			// first, poll for available data or timeout after 500 ms
			var start = new Date().getTime();
			for (var i = 0; i < 1e7; i++) { 
				if (((new Date().getTime() - start) > 2500 ) ||(this.tm_instream.available()>0)) {
					break;
					}
				}
			//console.log("read available:"+ this.tm_instream.available());
			
			if (this.tm_instream.available() > 0 ) {
				var data = this.tm_instream.read(2048);
				// console.log("read data:" +   data);
				var answer = /client-remote-(error|result) (?:[0-9]+) (.*)\)\)/.exec(data)[2];
				// console.log("answer:" +   answer);
				return this.unquote(answer)}
			else {
				return false} //timed out 
		}
		catch (x) {
			console.log("READ ERROR:" +   x);
			return false;
			}
	},

	tm_send : function (data) {
		// Send data
		//console.log("send alive?" +   this.tm_transport.isAlive());
		var outData = String(data.length)+  "\n" + data + "\n" ;
		//console.log("sending:" + outData);
		this.tm_outstream.write(outData, outData.length);
	},
    
  tm_close : function () {
    // Close stream
    this.tm_outstream.close();
    this.tm_instream.close();
    this.tm_InputStream.close();
    // make sure we are actually disconnected before going on
    var start = new Date().getTime();
    for (var i = 0; i < 1e7; i++) { // wait for data or timeout after 500 ms
      if (((new Date().getTime() - start) > 500 ) || !(this.tm_transport.isAlive())) {
        this.tm_connected=false;
        break;}
    }
    if (this.tm_transport.isAlive()) {console.log("NOT DISCONNECTED!!!!")}
  },
  
  tm_write_and_read_answer : function (data) {
    this.tm_send(data);
    return this.tm_read();
  },

	tm_login : function () {
		this.tm_connect('localhost', 6561);
		resp = this.tm_write_and_read_answer("(0 (remote-login \"zotero\" \"zotero\"))") 
		if (resp) {
			if (resp == "ready") 
				{return true}
			else {
				console.log("can't login"); this.tm_close();
		        return false
		        }
		    }
		else {
			console.log("can't connect");
			this.tm_close();
			return false
			}
	},

	ask_texmacs : function (cmd, arg) { //arg is optional, can be a string, a boolean, a list of strings
		// syntax that we are using to communicate with texmacs:
		// messages are of the form 
		// (msg-id (service arg1 arg2 ...))
		// where msg-id is a number, and service is the name of a tm-service that texmacs knows (= it is defined somewhere in a scheme file)
		// and that is responsible for handling the arguments
		// args are optional and can be : boolean, string, list of string
		// 
		// (0 (remote-buffer-load "/tmp/myfile.tm"))
		// (0 (remote-set-cursor-pos "(2 1 0 0 8 1)"))
		// (0 (remote-login "zotero" "zotero"))
		// (0 (remote-cite ("marcel" "gilbert" "henri")))
		// (0 (remote-cite "monique"))
		// (0 (remote-whatever #t))
		
		// the whole message is sent as a unique string
		// and when receiving the message, texmacs expects first a string containing the number
		// of bytes to read in the subsequent command (see tm_send())
		
		
		// On windows , while probing instream.available() 
		// (that is the method nsIScriptableInputStream.available)
		//  I often got 
		// "Exception... Component returned failure NS_BASE_STREAM_CLOSED"
		// 
		// I see no other workaround than retrying...
		
		
		// first check if we are (still) connected and, if not try (re) connecting. 
		if (!(this.tm_connected) || !( this.tm_transport.isAlive()) ) {
			while (!((this.tm_connected) && (this.tm_transport.isAlive())) && (this.fails<this.maxfails)) {
				this.fails++;
				if (this.tm_connected) {this.tm_close()};
				this.tm_connected = this.tm_login();
				}
			if (this.fails<this.maxfails) {this.fails=0}
			else {
				// connect/login failed repeatedly
    		var win = this.wm.getMostRecentWindow("navigator:browser");
				win.alert("SERVER ERROR:\n" + "cannot connect with TeXmacs, or cannot login\n"+"try restarting TeXmacs or check config.");
				this.tm_close();
				return false
				}
			}
			
		// second, format args properly, send & get answer
			
		//Zotero.debug("ask_texmacs  typeof args :"+ typeof arg);
		switch (true) {
		  case (typeof arg === 'boolean') :
				arg=(arg)?"#t":"#f";
				break;
		  case (typeof arg === 'object') ://assume it's a list of strings
		        arg ='("'+ arg.join('" "')+'")' ;
		        break;
		  case (typeof arg === 'string') :
		        arg ='"'+ arg+'"';
		        break;
//		  case (typeof arg === 'undefined') :
          default : //including 'undefined' if we arrive here
				arg = '';
		        
	      }
		//Zotero.debug("ask_texmacs args :"+arg);
		repl = this.tm_write_and_read_answer("(0 ("+cmd+" "+arg+"))");
		
		//console.log("reply :"+repl);
		
		// clean up connection if required
		if (!(this.keep_connected)) {this.tm_close()};
		return repl;            
	},
	
	unquote : function (str, quoteChar) {
		quoteChar = quoteChar || '"';
		if (str[0] === quoteChar && str[str.length - 1] === quoteChar)
			return str.slice(1, str.length - 1);
		else return str;
	},


	checkAndCite : function() {
		// insert "cite" tag in texmacs corresponding to the currently selected items
		var win = this.wm.getMostRecentWindow("navigator:browser");
		var zitems = win.ZoteroPane.getSelectedItems();
		if (!zitems.length) {
			win.alert("Please select at least one citation.");
			return;
		};
    this.item_keys(zitems).then(function(keys) {
      this.fails=0;
      Zotero.debug("before ask_texmacs");
      var res = Zotero.zotexmacs.ask_texmacs("remote-cite", keys);
//      Zotero.debug("ask_texmacs done");
    });

	},

  item_keys : Zotero.Promise.coroutine(function* (zitems) {	
    var keys = [];
    for ( var i = 0; i < zitems.length; i++) {
      try {
        keys[i] = Zotero.BetterBibTeX.KeyManager.get(zitems[i].id, 'on-export').citekey
      }
      catch (x) {
        // Zotero.debug("catched :",x);
        // BetterBibTeX likely not installed : use zotero's default key scheme
        // but no simple method to call to get the key (maybe in Zotero 5.1?)
        // we perform the bibtex export and extract the key in it
        var translation = new Zotero.Translate.Export;
        translation.setTranslator("9cb70025-a888-4a29-a210-93ec52da40d4");//zotero's bibtex
        try {
          var text = yield this._promiseTranslate(translation, [zitems[i]]);
  //        Zotero.debug("promise returned :"+ text )
        }
        catch (e) {
          Zotero.debug("translate: " + e);
        }
        keys[i] = /@(?:.*){(.*),/.exec(text)[1];
        }
      }
    return keys
  }),


  _promiseTranslate : Zotero.Promise.coroutine(function* (translate, items) {
    var text2;
		translate.setHandler("done", function(translate, success) {
	  	text2 = translate.string;
			});
		translate.setItems(items);
		yield translate.translate();
    return text2;
  }),
	
};


