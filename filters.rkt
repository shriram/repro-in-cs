#lang racket

(require "structure-data.rkt")

(provide builds)
(provide build-fails)

(define (get-papers-building expected papers)
  (filter (lambda (p)
            (let ([b (paper-build-results p)])
              (and b (string=? b expected))))
          papers))

(define (builds ss) (get-papers-building "Builds" ss))
(define (build-fails ss) (get-papers-building "Build fails" ss))
