#lang racket

(require "parse-tsv.rkt")
(provide convert-to-struct strip-header)
(provide (struct-out paper))

(struct paper (group authors title practical 
                     article/google email-sent email-reply 
                     build-results database-entry build-notes)
  #:transparent)

(define (strip-header l)
  (rest l))

(define (convert-to-struct l)
  (map (lambda (p)
         (apply paper
                (map (lambda (s)
                       (if (string=? s "-") false s))
                     p)))
       l))
