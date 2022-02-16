<TeXmacs|2.1.1>

<style|<tuple|tmdoc|doc|british|old-spacing|old-dots|old-lengths>>

<\body>
  <tmdoc-title|The Zotexmacs plugin>

  <name|Zotexmacs> is a very simple tool that eases citing articles in
  <TeXmacs> when your bibliographic database is handled by
  <name|<hlink|Zotero|https://www.zotero.org/>> (a FOSS tool) .

  With <name|Zotexmacs> you no longer have to know, guess, or look up what is
  the citation key of <em|that> article you want to cite. From within a
  <name|Zotero> window, <name|Zotexmacs> directly inserts the appropriate
  <inactive|<cite|>> tag for the selected items into the currently active
  <TeXmacs> document.\ 

  Using <name|Zotexmacs> does not change the way <TeXmacs> handles
  bibliography; Documents produced with the help of <name|Zotexmacs> are
  plain <TeXmacs> documents which can still be used in absence of
  <name|Zotero> or \ <name|Zotexmacs>.

  Below we explain how to install the <name|Zotexmacs> extension in
  <name|Zotero>, and how to use it.

  <section*|Installation>

  We assume Zotero is already installed on your system. If not, visit
  <hlink|Zotero website|https://www.zotero.org/> and install it.

  <paragraph|Get Zotexmacs>

  The <name|Zotexmacs> extension is distributed as an .xpi file. The latest
  version (for <name|Zotero> <math|\<geqslant\>> 5) is found at
  <hlink|<verbatim|https://github.com/slowphil/zotexmacs/releases/latest>|https://github.com/slowphil/zotexmacs/releases/latest>
  (You can find the source there too).\ 

  <paragraph|Install Zotexmacs extension in Zotero>

  In Zotero standalone open the <menu|Tools|Add-ons> menu, then open the
  popup menu under the \Pgear\Q icon and select <menu|install from file...>

  <section*|Using <name|Zotero> with <TeXmacs> and <name|Zotexmacs>>

  As said above, <name|Zotexmacs> does not change the way <TeXmacs> handles
  bibliography. Basically, from Zotero you export a \Pcollection\Q as a
  <BibTeX> file, and you create a bibliography in a <TeXmacs> document by
  inserting a <inactive|<bibliography||||>> tag
  (<menu|Edit|Automatic|Bibliography...>) which points to that <BibTeX> file.
  For more details see <with|font-shape|italic|Compiling a bibliography> in
  <TeXmacs> documentation.

  The only small thing <name|Zotexmacs> does is to assist when you want place
  a reference to a bibliographic item (<em|i.e.> a <inactive|<cite|>> tag) in
  a <TeXmacs> document: instead of using <menu|Insert|Link|Citation> and
  typing the key(s) of the item(s) you want to cite, you should

  <\itemize-minus>
    <item>switch to the <name|Zotero> window

    <item>select the item(s) you want to cite

    <item>click on the Zotexmacs button <move|<move|<image|zotexmacs.en-image-1.png|18pt|||>||-4pt>||>
    (or right-click and select \Pcite in Texmacs\Q)

    <item>finally \ switch back to Texmacs' window

    <item>At this point the newly inserted <inactive|<cite|>> tag may show up
    as <cite|>. In that case, it may be simply a matter of doing
    <menu|Document|Update|Bibliography>. You may also further need to refresh
    the content of the <BibTeX> file itself in case the cited document was
    recently added to the Zotero database (see below about the
    <menu|automatic export> feature of <name|Better BibTeX>).
  </itemize-minus>

  Tips and tricks :\ 

  When a new cite tag is inserted next to a prexisting one, the cite tags are
  merged automatically. If this is not desired, simply insert a white space
  before inserting the new tag.

  While drafting a document I find it convenient to use the
  <verbatim|tm-abstract> bibliography style (or BibTeX's <verbatim|abstract>
  style) because the reference call then appear as [citation_key] (instead of
  numbers) making it easier to ensure you actually refer to the articles you
  want.

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
  a key of the form FirstAuthorLastName_FirstTitleWord_Year_OptionalDisambiguationDigit.
  Beware however that if at some point you change the key format in
  <name|Zotero>, all your former \ <TeXmacs> documents still use the old key
  format and become incompatible with the newly exported <BibTeX> file.\ 

  Check <menu|Force citation key to ASCII>

  Pining of citation keys: by default, <name|Zotero> and <name|Better BibTex>
  create the citation keys on-the-fly while exporting Bibtex files, using a
  predefined scheme (see above). In some instances two articles may have the
  same citation key, or citation keys may change (after correcting a typo,
  for instance) leading to inconsistencies between already inserted citation
  keys and the updated bibtex file. In order to settle such cases Better
  Bibtex enables \Ppining\Q (making them fixed) citation keys by adding a
  \PCitation Key: mycitekey\Q in the \Pextra\Q field of the reference.

  In <menu|fields to omit> you may enter: <verbatim|abstract, file> (to keep
  the bibtex files lean).\ 

  Do not check <menu|Export Bibtex as ASCII> as this would likely cause
  problems with non-latin or accented characters.

  Check <menu|Retain LaTeX markup on BibTeX import> if you plan to import
  bibtex files from TeXmacs.

  Use <menu|automatic export> to keep the bibtex file up-to-date when adding
  references.

  <section*|Technical details>

  <name|Zotexmacs> communicates with <TeXmacs> through internal network
  sockets. For this to work your OS's firewall should allow the connection,
  and this plugin configures <TeXmacs> such that:

  <\itemize>
    <item>it runs in server mode, listening for incoming connections

    <item>it accepts Zotexmacs logging in and understands the
    <menu|remote-cite> command.
  </itemize>

  On the <name|Zotero> side, the extension consists of javascript code that
  handles the socket connection, and formatting the messages. It could easily
  be extended for performing more complex tasks.

  <tmdoc-copyright|2022|Philippe Joyez>

  <tmdoc-license|Permission is granted to copy, distribute and/or modify this
  document under the terms of the GNU Free Documentation License, Version 1.1
  or any later version published by the Free Software Foundation; with no
  Invariant Sections, with no Front-Cover Texts, and with no Back-Cover
  Texts. A copy of the license is included in the section entitled "GNU Free
  Documentation License".>
</body>

<initial|<\collection>
</collection>>