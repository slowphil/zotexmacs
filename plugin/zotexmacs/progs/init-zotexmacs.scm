(plugin-configure zotexmacs

(:versions 0.5)
(:require #t))

(when (supports-zotexmacs?)
(display "running init-zotexmacs\n")

(define-preferences   ("zotero-server" #t noop))

(if (get-preference "zotero-server")
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
)
