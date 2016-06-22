<TeXmacs|1.99.4>

<style|tmdoc>

<\body>
  <doc-data|<doc-title|<name|ZoTeXmacs>: Using <TeXmacs> with
  <name|Zotero>.>>

  <name|Zotexmacs> is a very simple tool that eases referencing articles in
  <TeXmacs> when your bibliographic database is handled by <name|Zotero>.

  With <name|Zotexmacs> you no longer have to know, guess, or look up what is
  the citation key of <em|that> article you want to cite. From within a
  <name|Zotero> window, <name|Zotexmacs> directly inserts the appropriate
  <inactive|<cite|>> tag for the selected items into the currently active
  <TeXmacs> document.\ 

  Technically <name|Zotexmacs> is a <name|Zotero> extension. <name|Zotexmacs>
  does not change the way <TeXmacs> handles bibliography; your documents
  produced with the help of <name|Zotexmacs> are plain <TeXmacs> documents
  which can be used even in absence of <name|Zotero>.

  Below we explain how to install this extension and configure <TeXmacs> to
  work with it.

  <section*|Installation>

  We assume Zotero (Firefox plugin or Standalone version for use with Chrome
  or Safari) is already installed on your system. If not, visit Zotero
  website and install it.

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

  <paragraph*|Configure <TeXmacs> for working with Zotexmacs>

  <TeXmacs> needs to be configured for communicating with Zotexmacs. This is
  done by adding the content of the file <verbatim|place_in_my-init-texmacs.scm>
  available at<verbatim| github.com/slowphil/zotexmacs> to the user's
  initialization file <verbatim|$TEXMACS_HOME_PATH/progs/my-init-texmacs.scm>.

  This user's initialization file can be accessed simply from within
  <TeXmacs> by activating the <menu|Tools|Developper tools> menu and then
  using the <menu|Developer|Open my-init-texmacs.scm> menu item. Then, paste
  the content of the file on GitHub, save and restart <TeXmacs>. If this does
  not work see \PTechnical details\Q, below.

  <section*|Using <name|Zotero> with <TeXmacs> and <name|Zotexmacs>>

  <name|Zotexmacs> does not change the way <TeXmacs> handles bibliography.

  Basically, from Zotero you export a \Pcollection\Q as a <BibTeX> file, and
  you create a bibliography in a <TeXmacs> document by inserting a
  <inactive|<bibliography||||>> tag (<menu|Edit|Automatic|Bibliography...>)
  which points to that <BibTeX> file. For more details see <hlink|Compiling a
  bibliography|/usr/local/share/TeXmacs/doc/main/links/man-bibliography.en.tm>.

  The only small thing <name|Zotexmacs> does is a the moment you want place a
  call to a bibliographic item in a <TeXmacs> document: instead of using
  <menu|Insert|Link|Citation> and typing the key(s) of the item(s) you want
  to cite, you should

  <\itemize-minus>
    <item>switch to the <name|Zotero> window (or display the <name|Zotero>
    pane in Firefox)

    <item>select the item(s) you want to cite

    <item>click on the Zotexmacs button (or right-click and select cite in
    Texmacs)

    <item>finally \ switch back to Texmacs' window
  </itemize-minus>

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
  for instance) leading to inconsistencies between already inserted citation
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

  <section*|Technical details>

  <name|Zotexmacs> communicates with <TeXmacs> through internal network
  sockets. For this to work your OS's firewall should allow the connection,
  and <TeXmacs> needs to be configured such that:

  <\itemize>
    <item>it runs in server mode, listening for incoming connections

    <item>it accepts Zotexmacs logging in and understands the
    <menu|remote-cite> command.
  </itemize>

  The necessary configuration is done by commands written in
  <verbatim|scheme> (the scripting language TeXmacs uses for many things. See
  <hlink|<scheme> extension language|/usr/local/share/TeXmacs/doc/main/scheme/man-guile-intro.en.tm>)
  placed in the user's initialization file
  <verbatim|$TEXMACS_HOME_PATH/progs/my-init-texmacs.scm>. The exact location
  of that file depends on your OS and can be obtained by executing the
  <verbatim|scheme> command below (place the cursor on that line and press
  enter, or click the \PGo\Q button)

  <\session|scheme|default>
    <\folded-io|Scheme] >
      (url-concretize "$TEXMACS_HOME_PATH/progs/my-init-texmacs.scm")
    <|folded-io>
      \;
    </folded-io>
  </session>

  On the <name|Zotero> side, the extension consists of javascript code that
  handles the socket connection, and formatting the messages. It could easily
  be extended for performing more complex tasks.
</body>

<\initial>
  <\collection>
    <associate|index-enabled|false>
    <associate|preamble|false>
  </collection>
</initial>