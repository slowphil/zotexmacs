(display "running my-init-texmacs\n")

(define-preferences   ("zotero-server" #t noop))


;; Do (server-start) automatically at boot-up if preferences are set so
;; to enable incoming connections

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
      (server-return envelope #t))
  ))
