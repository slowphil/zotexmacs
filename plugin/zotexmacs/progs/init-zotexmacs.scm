;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; MODULE      : zotexmacs.scm
;; DESCRIPTION : plugin for working with Zotero, the bibliographics database manager 
;; COPYRIGHT   : (C) 2023  Philippe Joyez
;;
;; This software falls under the GNU general public license version 3 or later.
;; It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
;; in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Zotexmacs is a plugin that eases referencing articles in TeXmacs when your
;; bibliographic database is handled by Zotero.
;; This part is the "server". For it to work, one also needs to install an extension in
;; Zotero (zotexmacs-XX.xpi), that will act as the "client" part.
;; See https://github.com/slowphil/zotexmacs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(plugin-configure zotexmacs

(:versions 0.5)
(:require #t))

(when (supports-zotexmacs?)
(display "running init-zotexmacs\n")

;(define-preferences   ("zotero-server" "off" noop)) ; Dont! this actually prevents initializing the pref to off and toggling it afterwards.
(if (not (cpp-has-preference? "zotero-server")) (set-preference "zotero-server" "off")) ; this is OK
;(display* "zotero server on? " (get-boolean-preference "zotero-server") "\n")

(if (get-boolean-preference "zotero-server")
  (begin 
;; Do (server-start) automatically at boot-up if preferences are set so
;; to enable incoming connections
    (import-from (server server-base)) ;; define tm-service for use below
    (with srv (client-start "localhost")
      (if (== srv -1) 
        (begin (display "starting server for zotexmacs\n")  ; no texmacs server was found : start it
               (server-start))
        (begin (display "found local server\n")(client-stop srv)  ; a texmacs server is already started (in another instance, for example)
        )))
;; define a login for connecting to texmac's server
    (server-set-user-information "zotero" "zotero-remote-cite" "zotero" "" "no")

;; define service that zotexmacs uses

    (tm-service (remote-cite key)
      (if (list? key) 
        (insert (append '(cite) key)) 
        (insert `(cite ,key)))
      (merge-cite-tags)
      (server-return envelope #t))
  
;; if there are adjascent cite tags, merge them all        
(define (merge-cite-tags)
  (let ((ps (path-paragraph-start)))
  (while (tm-is? (before-cursor) 'cite)
    (traverse-left)
    (if  (path-less? ps (path-previous (root-tree) (cursor-path))) 
          (go-to-previous))  
      ))
  (let* ((pstart (cursor-path))
         (cite+keys (list 'cite)))
    (while (tm-is? (after-cursor) 'cite)
      (begin (append! cite+keys (cdr (tree->stree (after-cursor))))
        (traverse-right)))
    (selection-set pstart (cursor-path))
    (clipboard-cut "nowhere")
    (insert cite+keys)
    (add-undo-mark)) ;; Doesn't work??
  )

(define (path-paragraph-start)
  (let* ((cp (cursor-path))
         (ps (begin (go-start-paragraph) (cursor-path))))
    (go-to-path cp)
    ps))
  ))


(define (set-zotexmacs on?)
  (set-boolean-preference "zotero-server" on?)
  )

;;;;;;;;;;;;
;; settings widget and preferences
;;;;;;;;;;;;
  
(tm-widget (zotexmacs-preferences-widget . cmd)
  ======
  (aligned
    (item (text "Activate Zotexmacs plugin (listen to Zotero)")           
            (toggle (set-zotexmacs answer) (get-boolean-preference "zotero-server")))
            )
  ======
  (centered
    (explicit-buttons ("Help" (load-help-buffer "zotexmacs"))))
)

(if (not (defined? 'plugins-with-pref-widget)) ;see https://savannah.gnu.org/patch/?10177
;; no preference tab widgets for plugins: setup a menu in the tools menu
  (begin 
    (tm-define (open-zotexmacs-widget)
      (:interactive #t)
        (dialogue-window zotexmacs-preferences-widget noop "Zotexmacs plugin settings"))

    (tm-menu (zotexmacs-menu)
      (if (use-popups?) 
        ("Zotexmacs plugin" (open-zotexmacs-widget)))
      (if (use-menus?)
       (-> "Zotexmacs plugin"
         (if (get-boolean-preference "zotero-server")
           ("active (deactivate at next start)" (toggle-preference "zotero-server")))
         (if (not (get-boolean-preference "zotero-server"))
           ("activate at next start" (toggle-preference "zotero-server")))
         ("Help" (load-help-buffer "zotexmacs")))))
     
    (delayed (:idle 2000)
      (tm-menu (tools-menu)
        (former)
        ---
        (link zotexmacs-menu))
      ))
))
