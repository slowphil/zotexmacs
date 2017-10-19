(display "running my-init-texmacs\n")

(define-preferences   ("zotero-server" #t noop))

(if (get-preference "zotero-server")
  (begin 
;; Do (server-start) automatically at boot-up if preferences are set so
;; to enable incoming connections
    (import-from (server server-base)) ;; define tm-service for use below
    (with srv (client-start "localhost")
      (if (== srv -1) 
        (begin (display "starting server\n")  ; no texmacs server was found : start it
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
  (while (tm-is? (before-cursor) 'cite)
      (begin (traverse-left)(traverse-left)))
  (let* ((pstart (cursor-path))
         (cite+keys (list 'cite)))
    (while (tm-is? (after-cursor) 'cite)
      (begin (append! cite+keys (cdr (tree->stree (after-cursor))))
        (traverse-right)))
    (selection-set pstart (cursor-path))
    (clipboard-cut "nowhere")
    (insert cite+keys)))
  ))
