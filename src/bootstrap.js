///////////////////////////////////////////////////////////////////////////////
//
// MODULE      : Zotexmacs
// DESCRIPTION : Extension enabling Zotero to interact with GNU TeXmacs
// COPYRIGHT   : (C) 2016-2024 Philippe Joyez
//
// This software falls under the GNU general public license version 3 or later.
// It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
// in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
//
///////////////////////////////////////////////////////////////////////////////

// rootURI is passed by Zotero to every lifecycle hook and is the base URL
// of the unpacked XPI (e.g. "jar:file:///...!/"). All plugin resources are
// referenced as rootURI + relative path — no chrome:// registration needed.

var _rootURI;
var _menuRegistrationID;

function startup({ id, version, rootURI }, reason) {
    _rootURI = rootURI;

    // Load the main plugin object into the Zotero namespace
    Services.scriptloader.loadSubScript(rootURI + "content/zotexmacsbrowserOverlay.js");

    // Non-window initialization
    if (Zotero.zotexmacs && Zotero.zotexmacs.init) {
        Zotero.zotexmacs.init();
    }

    // Register context menu item via the official Zotero 8+ MenuManager API.
    // Zotero automatically removes it on shutdown/uninstall when pluginID matches.
    _menuRegistrationID = Zotero.MenuManager.registerMenu({
        menuID: "zotexmacs-cite",
        pluginID: "zotexmacs@texmacs.org",
        target: "main/library/item",
        menus: [{
            menuType: "menuitem",
            l10nID: "zotexmacs-cite",
            onCommand: (_event, _context) => {
                Zotero.zotexmacs.checkAndCite();
            },
        }],
    });

    // Add UI to any windows already open when the plugin starts
    for (let win of Zotero.getMainWindows()) {
        if (win.ZoteroPane) _addToWindow(win);
    }
}

function shutdown({ id, version, rootURI }, reason) {
    // Unregister context menu (belt-and-suspenders)
    if (_menuRegistrationID !== undefined) {
        try { Zotero.MenuManager.unregisterMenu(_menuRegistrationID); } catch(e) {}
        _menuRegistrationID = undefined;
    }

    // Remove UI from all open windows
    for (let win of Zotero.getMainWindows()) {
        _removeFromWindow(win);
    }

    // Disconnect from TeXmacs if connected, then clean up namespace
    if (Zotero.zotexmacs) {
        if (Zotero.zotexmacs.tm_connected) {
            try { Zotero.zotexmacs.tm_close(); } catch(e) {}
        }
        delete Zotero.zotexmacs;
    }
}

function install(data, reason) {}
function uninstall(data, reason) {}

function onMainWindowLoad({ window }) {
    _addToWindow(window);
}

function onMainWindowUnload({ window }) {
    _removeFromWindow(window);
}

// ---------------------------------------------------------------------------
// Window-level UI helpers (toolbar button only; menu handled by MenuManager)
// ---------------------------------------------------------------------------

function _addToWindow(win) {
    var doc = win.document;

    // Inject Fluent localization (Zotero auto-registered our locale/ folder)
    win.MozXULElement.insertFTLIfNeeded("zotexmacs.ftl");

    // Inject stylesheet directly from rootURI (no chrome:// needed)
    var style = doc.createElementNS("http://www.w3.org/1999/xhtml", "link");
    style.id = "zotexmacs-stylesheet";
    style.rel = "stylesheet";
    style.href = _rootURI + "skin/zotexmacsbrowserOverlay.css";
    doc.documentElement.appendChild(style);

    // Add toolbar button to the items toolbar
    var toolbar = doc.getElementById("zotero-items-toolbar");
    if (toolbar) {
        var btn = doc.createXULElement("toolbarbutton");
        btn.id = "zotexmacs-menu-button";
        btn.setAttribute("tooltiptext", "Insert citation in current TeXmacs doc");
        // Use rootURI for the icon too
        btn.style.listStyleImage = "url('" + _rootURI + "skin/zotexmacs.png')";
        var anchor = doc.getElementById("zotero-tb-attachment-add");
        if (anchor && anchor.nextSibling) {
            toolbar.insertBefore(btn, anchor.nextSibling);
        } else {
            toolbar.appendChild(btn);
        }
        btn.addEventListener("command", () => Zotero.zotexmacs.checkAndCite());
    }
}

function _removeFromWindow(win) {
    var doc = win.document;
    doc.getElementById("zotexmacs-stylesheet")?.remove();
    doc.getElementById("zotexmacs-menu-button")?.remove();
    doc.querySelector('[href="zotexmacs.ftl"]')?.remove();
}
