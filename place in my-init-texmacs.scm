(display "running my-init-texmacs\n")

(define-preferences   ("zotero-server" #t noop))


;; Do (server-start) automatically at boot-up if preferences are set so
;; to enable incoming connections

(if (get-preference "zotero-server")
  (let ((srv (client-start "localhost")))
    (if (== srv -1) 
        (begin (display "starting server\n")
               (server-start))
        (begin (display "found local server\n")(client-stop srv) ;; other instance already running
           (server-start)(server-stop)) ;; FIXME : stupid but otherwise server-related stuff is not defined, causing problems below
        ))
)

(server-set-user-information "zotero" "zotero-remote-cite" "zotero" "" "no")

;; define service that zotexmacs uses

(tm-service (remote-cite key)
  (if (list? key) 
     (insert (append '(cite) key)) 
     (insert `(cite ,key)))
  (server-return envelope #t))


