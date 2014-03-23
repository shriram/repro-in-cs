#lang racket

(require "structure-data.rkt")

(provide builds)
(provide build-fails)
(provide papers-with-build-status)
(provide and-filters or-filters not-filter
         building? not-building?
         disputed? not-disputed?
         misclassified? not-misclassified?
         cleared? not-cleared?
         problem? not-problem?
         checked? not-checked?)

(define (and-filters . fs)
  (lambda (e)
    (let loop ([fs fs])
      (or (empty? fs)
          (and ((first fs) e)
               (loop (rest fs)))))))

(define (or-filters . fs)
  (lambda (e)
    (let loop ([fs fs])
      (and (not (empty? fs))
          (or ((first fs) e)
              (loop (rest fs)))))))

(define (not-filter f)
  (lambda (e) (not (f e))))

(define building? paper-builds?)
(define not-building? (not-filter building?))
(define misclassified? paper-misclassified?)
(define not-misclassified? (not-filter misclassified?))
(define disputed? paper-dispute?)
(define not-disputed? (not-filter disputed?))
(define cleared? paper-cleared?)
(define not-cleared? (not-filter cleared?))
(define problem? paper-problem?)
(define not-problem? (not-filter problem?))

(define checked? (or-filters cleared? problem?))
(define not-checked? (not-filter checked?))

(define (builds ss) (filter building? ss))
(define (build-fails ss) (filter not-building? ss))

#| The 8th column has the build status, as a string that is not "-". |#

(define (papers-with-build-status ss)
  (filter (lambda (p) (not (string=? "-" (list-ref p 7)))) ss))
