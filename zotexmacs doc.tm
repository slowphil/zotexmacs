<TeXmacs|1.99.19>

<style|tmdoc>

<\body>
  <doc-data|<doc-title|Using <name|Zotero> with <TeXmacs>
  :<next-line><name|ZoTeXmacs>>>

  <name|Zotexmacs> is a very simple tool that eases referencing articles in
  <TeXmacs> when your bibliographic database is handled by
  <name|<hlink|Zotero|https://www.zotero.org/>> (a FOSS tool) .

  With <name|Zotexmacs> you no longer have to know, guess, or look up what is
  the citation key of <em|that> article you want to cite. From within a
  <name|Zotero> window, <name|Zotexmacs> directly inserts the appropriate
  <inactive|<cite|>> tag for the selected items into the currently active
  <TeXmacs> document.\ 

  Technically, <name|Zotexmacs> is a <name|Zotero> extension that interacts
  with a couple of simple scheme macros on <TeXmacs> side. <name|Zotexmacs>
  does not change the way <TeXmacs> handles bibliography; Documents produced
  with the help of <name|Zotexmacs> are plain <TeXmacs> documents which can
  still be used in absence of <name|Zotero> or \ <name|Zotexmacs>.

  Below we explain how to install this extension and the <TeXmacs> plugin
  that works with it.

  <section*|Installation>

  We assume Zotero is already installed on your system. If not, visit Zotero
  website and install it.

  <paragraph|Get Zotexmacs>

  The <name|Zotexmacs> extension is distributed as an .xpi file. The latest
  version (for Zotero <math|\<geqslant\>> 5) is found at
  <verbatim|https://github.com/slowphil/zotexmacs/releases/latest> (You can
  find the source there too).\ 

  <paragraph|Install Zotexmacs extension in Zotero>

  In Zotero standalone open the <menu|Tools|Add-ons> menu, then open the
  popup menu under the \Pgear\Q icon and select <menu|install from file...>

  <paragraph*|Install the corresponding <TeXmacs> plugin>

  <TeXmacs> needs to be configured for automatically listen for Zotexmacs at
  startup. This is done by adding a plugin in your user's
  <verbatim|$TEXMACS_HOME_PATH> (see <hlink|below|#findhomepath> how to find
  this folder).

  Get this plugin from <hlink|github.com/slowphil/zotexmacs/tree/master/plugin|https://github.com/slowphil/zotexmacs/tree/master/plugin>
  and copy the <code*|zotexmacs> folder found there in
  <verbatim|$TEXMACS_HOME_PATH/plugins> , then restart <TeXmacs> and do
  <samp|Tool<math|\<rightarrow\>>Update<math|\<rightarrow\>>Plugins>. If this
  does not work see \PTechnical details\Q, below, or <hlink|raise an issue in
  GitHub|https://github.com/slowphil/zotexmacs/issues>.

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

    <item>click on the Zotexmacs button <move|<move|<image|<tuple|<#89504E470D0A1A0A0000000D494844520000001F0000001F08060000001FAE16390000000473424954080808087C08648800000009704859730000020000000200017E7ED3E30000001974455874536F667477617265007777772E696E6B73636170652E6F72679BEE3C1A00000696494441544889AD977B5094D719879F6FD93BB2BBE02EB09482B8600B74B51A95D2C4504D32AD537534D33AD40BA329B6B5E86013AB4EA27627A5B1A44D474D34C278A1259332A6166C1263BC253A304A506282A8182F6858169765D9CDEE925DF6D63FB6109505C1E9FBCF77E67DDFF33EE777CEF9BEEF1C8147B08A8A0A89542ADDA450281E77381CF55D5D5D7F36994C81B1D689196B87CACACAB5A9A9A97B7273730B351A8D59A552AD542A950B0A0A0AC2478E1CB930965AC268132B2A2A9E484A4ADA3261C2843952A9540CE0F57A4FBBDDEE0280402010B0582CA76C36DB1F4B4B4BEBFF2FF0F2F2F294949494D70C06C35C8D46A3BE37762F7CC05C2E97D36C367FD0DBDBFBC2C68D1B3B1F096E3299A4696969A68C8C8C25494949E9D172A2C107CC6EB7DFEEECEC7CDB6AB59A4C2653FFA8E1959595852929292FA4A7A74F8F89197E5B8C0407088542582C96F33D3D3DAFAD59B3A66644F8CE9D3B6726272797190C86D90A85423C2C7594F001F3F97CFE8E8E8E8F9D4EE74BEBD6AD6B1A02AFAEAE7E352D2DAD48A7D3250DF81A0F5751F74E0D313E17899A714C9EBD801F2D291911DEE7E8E68BC653088280F1E99F218844833187C3D175F7EEDDEA55AB566D001854A7D3E9160D8083FE7E362C9D8BB3DBC2924CB8129432253981AF5A8EF3CF57AEF18B17770C51D7D76BE51FAFFC1EB7CDCC13DA7EE4623870F23D566EAB1A1C8046A349F6F97C8B80FBE1F7DA9B2FAEE2DB410B5BF3E1A6E1597EBD7C3362A9FC7FCA6C98AF34A39F34F9BE3ECAF8447EF397BF0370A3F13827F7BF4A617A3BF56FFD8D5945EBA32EC710783814A2E9C2A71C98059FA96632F5976583B1B7B73DCFE5B32730AA03F8E5F1381529534E34B731373396D4E94F33B3B0140043DE339C3DFE1E2DF64F51C65C8C0A06103DE870F77431292E802F08CEC4EF0FFA6B776C41D47A9497A7065049A1DFDD4B01AD9A9559019E4B7392D77188ABB56F7C33134A259E00287DF6D1C3951A2D3122014B1F7CD67C1E80F7F794D1DB58C78C4428A9870E3768E5F0610758BF867FDF82EA2FA0E1FD83BCFBFA5642C10077AE5FC198006165FCB0F021D31E2391F2558C863BEE5E32FCCDEC583C05A3DA4F7A2C7883B02C2B02CE520F2DD66C83ED1F7D4C63C3198AB24274F54168D28CD12B07F8E19C9FB0B909EEF6C1F4043FDE20A428215B0375ED11709B03B6B7402004362FBC79190EB7C39669506F09F1F20578A74BC3D49FAF19BD728079BFDDC297B76FB1FBC8397C41C85441DD8FA1D707FDA1488E2F04D3B42016C17839B8FCD0ED0589089E3588796AD95AB20BE6238A19FE5B155539C0EAF2FD9CFEE824DBD7AFC4383EE2DB7D39A21E6072023CA98FB405605E1A14E4CF64774712C16080B7AAF6120CF887050FAB7CC0545A3D7D6E173F4884776F43CD75D8FAD8FD399F5823CF198970DB76CD9F9F9B2399BCB01C99721C12996244F8B0CA01BE763B3970F0309F58E1AF9F0BE89422AADABE8977F5415377A4DD6C83B95A8724F6CED9B04C2AEF52C6278E087E28DCDC7ADE3B2D2BD59D37AF3070E65C139392D574F6C1D12F23F14405ACCE0163023CA605B30798325FF8EEB43CB556AB3D2D80E751E061A944D2602CF8A9A3BCE6D4B8C5CF6F13C7AAC753B47C19FE10FCE17C64977F6E07673F28C4E00F45DAC8D5000AA54251909A9AEA52AB540D40381A64C89A8B44A24B32994C24C0E30FC69E295AC7E2A34738D878838B3D305D175973731F84C3703B14CFA6D52F0DE60B8290AC56AB93D56A75ABB5BB3BECF57ABF379C72B75C2E6F90CB64B902E4441BA9201251B6BF8EEF68E5545C815038B2D12C1EB08A7518F3662191CAA275CD4DD4E972F57A7D832008EE217087DD7EACDB6ACDE421E73AA9721C1F9C6B41A54DE67767A1A12BF281C99EBD88851B86FE6AEF1DBBBDA7C7E0F7FB3F1C700C9E91FE75E8D009A3D178D0E3F1C42B150A835C2E8F2A616006E6153E8724D4CFB1361BF9D9692C5BFF27243279D47C87C3E1BA74E952CD95AB57971617171F1AAC132D79EFDEBD4F2624246CCECDC9992393C9C67CB61F309FCF176CBD7CF994DD6E2F2B2E2E3E3344C4087D85EAEAEA5FA5E8F56B3332327245A211DFCAFB2C140A71ABBDBDB5B3B3F3F5E5CB975732CC6E1F51556D6DED8589132756793C1EA9582C9E18171717F730B0D96CB6B4B4B4ECB978F1E2D2D2D2D27323E58EFAC6B26BD7AECC6FE9F5264366E6C2B8B8B8D807E32E97CB73E3FAF53AB3C5622A2929B93E9A9AA3860FD8BE7DFB1668B5DA8D39D9D9F9128944F0FBFDE1B66BD7EA6D365BD98A152B8E8DA5D698E110B9A52A95CA4DDAF1E3E777DB6CFFB979F3E623DD52FF0B49F6916A8CC8351F0000000049454E44AE426082>|png>|18pt|||>||-4pt>||>
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
  and <TeXmacs> needs to be configured such that:

  <\itemize>
    <item>it runs in server mode, listening for incoming connections

    <item>it accepts Zotexmacs logging in and understands the
    <menu|remote-cite> command.
  </itemize>

  The necessary configuration is done by commands written in
  <verbatim|scheme> (the scripting language TeXmacs uses for many things. See
  <hlink|<scheme> extension language|/usr/local/share/TeXmacs/doc/main/scheme/man-guile-intro.en.tm>)
  placed in the plugin initialization file
  <verbatim|$TEXMACS_HOME_PATH/plugins/zotexmacs/progs/init-zotexmacs.scm>.\ 

  <subsubsection*|Location of your user preference folder
  <verbatim|$TEXMACS_HOME_PATH >><label|findhomepath>

  The exact location of your user preference folder
  <verbatim|$TEXMACS_HOME_PATH >depends on your OS and can be obtained by
  executing the <verbatim|scheme> command below (place the cursor on that
  line and press enter, or click the \PGo\Q button)

  <\session|scheme|default>
    <\folded-io|Scheme] >
      (url-concretize "$TEXMACS_HOME_PATH")
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
    <associate|preamble|false>
  </collection>
</initial>