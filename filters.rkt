#lang racket

(require "structure-data.rkt")

(provide builds)
(provide build-fails)
(provide papers-with-build-status)

(define (and-filters . fs)
  (lambda (e)
    (let loop ([fs fs])
      (or (empty? fs)
          (and ((first fs) e)
               (loop (rest fs)))))))

(define builds? paper-builds?)
(define dispute? paper-dispute?)
(define cleared? paper-cleared?)
(define problem? paper-problem?)

(define (builds ss) (filter builds? ss))
(define (build-fails ss) (filter (lambda (x) (not (builds? x))) ss))

#| The 8th column has the build status, as a string that is not "-". |#

(define (papers-with-build-status ss)
  (filter (lambda (p) (not (string=? "-" (list-ref p 7)))) ss))
