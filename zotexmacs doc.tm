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
  <TeXmacs> when your bibliographic database is handled by <name|Zotero>.

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

  <paragraph|Getting Zotexmacs>

  The <name|Zotexmacs> extension is distributed as a signed .xpi file. You
  can get it either at <verbatim|addons.mozilla.org> or at
  <verbatim|https://github.com/slowphil/zotexmacs/raw/master/zotexmacs-XX-signed.xpi>
  (You can find the source there too).

  <paragraph|Installing Zotexmacs>

  <\itemize>
    <item>Zotero as Firefox plugin

    In Firefox enter \Pabout:addons\Q in the search bar (or use the
    <menu|Tools|Add-ons> menu), then open the popup menu under the \Pgear\Q
    icon and select <menu|install from file...>

    <item>Zotero Standalone

    In Zotero standalone open the <menu|Tools|Add-ons> menu, then open the
    popup menu under the \Pgear\Q icon and select <menu|install from file...>
  </itemize>

  and navigate to the xpi file. Note that even though the extension was
  signed by Mozilla, you may receive a warning that the identity of creator
  of the extension cannot be confirmed. The unsigned version available on
  <name|Github> cannot be installed on standard Firefox releases.

  <section*|Recommended <name|Zotero> settings>

  Although it is possible to use <name|Zotexmacs> with plain <name|Zotero>,
  we recommend to further add <name|Zotero>'s <name|Better BibTeX> extension.
  Among others things <name|Better BibTeX> enables full control over the
  format of the citation key, automated updating of <BibTeX> files...

  <name|Zotero> should be configured (<menu|Gear
  icon|Preferences|Export|Format>) to export Bibtex (or Better Bibtex)
  format.

  If you use <name|Better BibTeX>, the following preferences are suggested
  (see <name|Better BibTeX> online documentation for more details):

  <menu|Citation key format> : whatever suits you! <verbatim|[zotero]> means
  a key of the form FirstAuthorLastName_FirstTitleWord_Year_OptionalDisambiguationDigit

  Check <menu|Force citation key to ASCII>

  Pining of citation keys: by default, <name|Zotero> and <name|Better BibTex>
  create the citation keys on-the-fly while exporting Bibtex files, using a
  predefined scheme (see above). In some instances two articles may have the
  same citation key, or citation keys may change (after correcting a typo,
  for instance) leading to inconsitencies between already inserted citation
  keys and the updated bibtex file. In order to settle such cases Better
  Bibtex enables \Ppining\Q (making them fixed) citation keys by adding a
  \Pbibtex: citekey\Q in the \Pextra\Q field of the reference.

  In <menu|fields to omit> you may enter: <verbatim|abstract, file> (to keep
  the bibtex files lean).\ 

  Do not check <menu|Export Bibtex as ASCII> as this would likely cause
  problems with non-latin or accented characters.

  Check <menu|Retain LaTeX markup on BibTeX import> if you plan to import
  bibtex files from TeXmacs.

  Use <menu|automatic export> to keep the bibtex file up-to-date when adding
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

    <item>it accepts Zotexmacs logging in and understands the
    <menu|remote-cite> command.
  </itemize>

  The necessary configuration is done by adding to <verbatim|<extern|(lambda
  (x) (url-concretize "$TEXMACS_HOME_PATH/progs/my-init-texmacs.scm"))|>> the
  content of the file <verbatim|place_in_my-init-texmacs.scm> available
  at<verbatim| github.com/slowphil/zotexmacs>. This can be done simply from
  within <TeXmacs> by activating the <menu|Tools|Developper tools> menu and
  then using the <menu|Developer|Open my-init-texmacs.scm>

  On the <name|Zotero> side, the extension consists of javascript code that
  handles the socket connection, and formatting the messages. It could easily
  be extended for performing more complex tasks.

  \;
</body>

<\initial>
  <\collection>
    <associate|preamble|false>
  </collection>
</initial>
