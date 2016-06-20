# Zotexmacs
Zotexmacs is a very simple tool that eases referencing articles in [TeXmacs](http://www.texmacs.org) when your bibliographic database is handled by [Zotero](https://www.zotero.org/).

With Zotexmacs you no longer have to know, guess, or look up what is the citation key of the articles you want to cite. From within a Zotero window, Zotexmacs directly inserts the appropriate cite tag for the selected items into the currently active TeXmacs document.

#Requirements
You need both [Texmacs](http://www.texmacs.org) and [Zotero](https://www.zotero.org/) already installed.

#Short doc 
Install the "zotexmacs-XX-signed.xpi" file in Firefox (or Zotero standalone) and add the content of the file "place in my-init-texmacs.scm" in the user's Texmacs settings folder  ($TEXMACS_HOME_PATH/progs/my-init-texmacs.scm
 the exact location depends on your OS - see "More doc"). After restarting both Firefox and TeXmacs, Zotexmacs should work.

#More doc 
Open "zotexmacs doc.tm" in TeXmacs.

