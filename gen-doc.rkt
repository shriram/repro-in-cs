#lang racket

(require "structure-data.rkt")
(require scribble/base)
(require scribble/decode)

(provide generate-document)

(define (generate-paper-list ps)
  (tabular #:style 'boxed #:sep (hspace 1)
   (map (lambda (p)
          (list (paper-group p)
                (paper-authors p)
                (paper-title p)
                (paper-build-results p)
                (paper-build-notes p)))
        ps)))

(define (generate-document bs bfs)
  (decode
   (list
    (title #:tag "how-to" "Examining ``Reproducibility in Computer Science''")
    (section #:tag "build-fails" "Reported as Not Building")
    (generate-paper-list bfs)
    (section #:tag "builds" "Reported as Building")
    (generate-paper-list bs))))

