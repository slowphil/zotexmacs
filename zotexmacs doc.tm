<TeXmacs|1.99.4>

<style|tmdoc>

<\body>
  <\hide-preamble>
    <assign|hlink2|<macro|label|target|<action|<arg|label|>|<extern|(lambda
    (x) (ext-hlink|<quote-arg|target>>>>>

    \;
  </hide-preamble>

  <doc-data|<doc-title|<name|ZoTeXmacs>: Using <TeXmacs> with
  <name|Zotero>.>>

  <name|Zotexmacs> is a very simple tool that eases referencing articles in
  <TeXmacs> when your bibilographic database is handled by <name|Zotero>.

  With <name|Zotexmacs> you no longer have to know, guess, or look up what is
  the citation key of <em|that> article you want to cite. From within a
  <name|Zotero> window, <name|Zotexmacs> directly inserts the appropriate
  <inactive|<cite|>> tag for the selected items into the currently active
  <TeXmacs> document.\ 

  Technically <name|Zotexmacs> is a <name|Zotero> extension. Below we explain
  how to install this extension and configure <TeXmacs> to work with it.

  <section*|Installation>

  We assume Zotero (Firefox plugin or Standalone version for use with Chrome
  or Safari) is already installed on your system. If not visit Zotero website
  and install it.

  <paragraph|Getting the Zotexmacs extension>

  The <name|Zotexmacs> extension is distributed as a signed .xpi file. You
  can get it either at <verbatim|addons.mozilla.org> or at
  <verbatim|github.com/slowphil/zotexmacs> (together with it's source).

  <paragraph|Installing the Zotexmacs extension>

  <\itemize>
    <item>Zotero as Firefox plugin

    In Firefox enter \Pabout:addons\Q in the search bar (or use the
    tools/addon menu), then open the popup menu under the toothed wheel icon
    and select \Pinstall from file...\Qn Firefox enter \Pabout:addons\Q in
    the search bar (or use the Tools/addon menu), then open the popup menu
    under the toothed wheel icon and select \Pinstall from file...\Q

    <item>Zotero Standalone

    In Zotero standalone open the Tools/addon menu, then open the popup menu
    under the toothed wheel icon and select \Pinstall from file...\Q
  </itemize>

  and navigate to the xpi file. Although the extension was signed by Mozilla,
  you may receive a warning that the identity of creator of the extension
  cannot be confirmed.

  <section*|Recommended <name|Zotero> settings>

  Although it is possible to use <name|Zotexmacs> with plain <name|Zotero>,
  we recommend to further add <name|Zotero>'s <name|Better BibTeX> extension.
  Among others things <name|Better BibTeX> enables full control over the
  format of the citation key, automated updating of <BibTeX> files...

  <name|Zotero> should be configured (preferences/export/format) to export
  Bibtex (or Better Bibtex) format.

  If you use Better Bibtex, the following preferences are suggested (see
  Better Bibtex online documentation for more details):

  Citation key format : whatever suits you! [zotero] means a key of the form
  FirstAuthorLastName_FirstTitleWord_Year_OptionalDisambiguationDigit

  Check \PForce citation key to ASCII\Q

  Pining of citation keys: by default, Zotero and Better BibTex create the
  citation keys on-the-fly while exporting Bibtex files, using a predefined
  scheme (see above). In some instances two articles may have the same
  citation key, or citation keys may change (after correcting a typo, for
  instance) leading to inconsitencies between already inserted citation keys
  and the updated bibtex file. In order to settle such cases Better Bibtex
  enables \Ppining\Q (making them fixed) citation keys by adding a \Pbibtex:
  citekey\Q in the \Pextra\Q field of the reference.

  In \Pfields to omit\Q you may enter: <verbatim|abstract, file> (to keep the
  bibtex files lean).\ 

  Do not check \PExport Bibtex as ASCII\Q as this would likely cause problems
  with non-latin or accented characters.

  Check \PRetain LaTeX markup on BibTeX import\Q if you plan to import bibtex
  files from TeXmacs.

  Use \Pautomatic export\Q to keep the bibtexfile up-to-date when adding
  references.

  \;

  <name|Zotexmacs> makes no choice regarding how texmacs handles the
  bibliographic items: it is the user's choice to have <TeXmacs> database
  either \Pmirroring\Q <name|Zotero>'s or simply disabled.

  <section*|Technical details>

  <name|Zotexmacs> communicates with <TeXmacs> through internal network
  sockets. For this to work your OS's firewall should allow the connection,
  and <TeXmacs> needs to be configured such that:

  <\itemize>
    <item>it runs in server mode, listening for incomming connections

    <item>it accepts Zotexmacs logging in and understands the \Premote-cite\Q
    command.
  </itemize>

  The necessary configuration is done by adding to <verbatim|<extern|(lambda
  (x) (url-concretize "$TEXMACS_HOME_PATH/progs/my-init-texmacs.scm"))|>> the
  content of the file <verbatim|place_in_my-init-texmacs.tm> available
  at<verbatim| github.com/slowphil/zotexmacs>.

  On the Zotero side, the extension consists of javascript code that handles
  the socket connection, and formatting the messages. It could easily be
  extended for performing more complex tasks.

  \;
</body>

<\initial>
  <\collection>
    <associate|preamble|false>
  </collection>
</initial>