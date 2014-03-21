#lang racket

(provide convert-to-struct strip-header)
(provide (struct-out paper))

(struct raw-paper (group authors title practical 
                         article/google email-sent email-reply 
                         build-results database-entry build-notes)
  #:transparent)

(struct paper (group authors title build-results path)
  #:transparent)

(define (strip-header l)
  (rest l))

(define (split-into-sub-paths-strip.txt prefix s)
  (and s
       (regexp-split #rx"_" 
                     (second
                      (regexp-match
                       (regexp (string-append "data/(.*)_" prefix ".txt"))
                       s)))))
;; Note: the "." in ".txt" above should be quoted: we mean the literal dot,
;; not the regexp for any ol' character. Maybe the "_" too. Regexps. Hunoz. WAT.

(define (convert-to-struct l)
  (map (lambda (rp)
         (let ([path (split-into-sub-paths-strip.txt "build" (raw-paper-build-notes rp))])
           (paper (raw-paper-group rp) (raw-paper-authors rp) (raw-paper-title rp)
                  (raw-paper-build-results rp)
                  path)))
       (map (lambda (p)
              (apply raw-paper
                     (map (lambda (s)
                            (if (string=? s "-") false s))
                          p)))
            l)))
