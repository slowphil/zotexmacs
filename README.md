# Zotexmacs
Zotexmacs is a very simple tool that eases referencing articles in [TeXmacs](http://www.texmacs.org) when your bibliographic database is handled by [Zotero](https://www.zotero.org/).

With Zotexmacs you no longer have to know, guess, or look up what is the citation key of the articles you want to cite. From within a Zotero window, Zotexmacs directly inserts the appropriate cite tag for the selected items into the currently active TeXmacs document.

# Requirements
Zotexmacs works on any OS. You'll need both [Texmacs](http://www.texmacs.org) and [Zotero](https://www.zotero.org/) already installed. 

Zotexmacs can be installed in Zotero 5.0, but it currently has [this issue](https://github.com/slowphil/zotexmacs/issues/3). If you think you cannot work without Zotero/zotexmacs, you should stick with firefox (<=56)/zotero 4 for the moment (and be careful that firefox does not update zotero). 

# Short doc 
Install the released ["zotexmacs-XX-signed.xpi"](https://github.com/slowphil/zotexmacs/releases/latest) file in Firefox (or Zotero standalone) and add the content of the file "place in my-init-texmacs.scm" in the file $TEXMACS_HOME_PATH/progs/my-init-texmacs.scm ($TEXMACS_HOME_PATH is the user's Texmacs settings folder whose exact location depends on your OS - see "More doc"). After restarting both Firefox and TeXmacs, Zotexmacs should work.

# More doc 
Open "zotexmacs doc.tm" in TeXmacs.

