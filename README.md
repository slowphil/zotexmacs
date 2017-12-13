# Zotexmacs
Zotexmacs is a very simple tool that eases referencing articles in [TeXmacs](http://www.texmacs.org) when your bibliographic database is handled by [Zotero](https://www.zotero.org/).

With Zotexmacs you no longer have to know, guess, or look up what is the citation key of the articles you want to cite. From within a Zotero window, Zotexmacs directly inserts the appropriate cite tag for the selected items into the currently active TeXmacs document.

# Requirements
Zotexmacs works on any OS. You'll need both [Texmacs](http://www.texmacs.org) and [Zotero](https://www.zotero.org/) already installed. 

Zotexmacs 0.5 works with Zotero ⩾ 5.0. If you still use Zotero 4 (standalone or in Firefox ⩽ 56) then use zotexmacs 0.2 (Zotexmacs 0.2 and 0.5 are functionally equivalent).

# Short doc 
Install the released ["zotexmacs-XX-signed.xpi"](https://github.com/slowphil/zotexmacs/releases/latest) file in Zotero standalone (or Firefox ⩽ 56) and add the content of the file "place in my-init-texmacs.scm" in the file $TEXMACS_HOME_PATH/progs/my-init-texmacs.scm ($TEXMACS_HOME_PATH is the user's Texmacs settings folder whose exact location depends on your OS - see "More doc"). After restarting both Firefox and TeXmacs, Zotexmacs should work.

# More doc 
Open "zotexmacs doc.tm" in TeXmacs.


