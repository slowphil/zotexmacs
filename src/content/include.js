///////////////////////////////////////////////////////////////////////////////
//
// MODULE      : Zotexmacs
// DESCRIPTION : Extension enabling Zotero to interact with GNU TeXmacs
// COPYRIGHT   : (C) 2016 Philippe Joyez
//
// This software falls under the GNU general public license version 3 or later.
// It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
// in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
//
///////////////////////////////////////////////////////////////////////////////


// Only create main object once
if (!Zotero.zotexmacs) {
    const zotexmacsLoader = Components.classes["@mozilla.org/moz/jssubscript-loader;1"]
	.getService(Components.interfaces.mozIJSSubScriptLoader);
    zotexmacsLoader.loadSubScript("chrome://zotexmacs/content/zotexmacsbrowserOverlay.js");
    window.addEventListener('load', function(e) { Zotero.zotexmacs.init(); }, false);
}
