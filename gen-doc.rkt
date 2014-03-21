#lang racket

(require "structure-data.rkt")
(require "static-text.rkt")
(require "paths.rkt")
(require scribble/core)
(require scribble/base)
(require scribble/decode)
(require file/sha1)

(provide generate-document)

(define (generate-paper-list ps color)
  (tabular 
   #:style (style #f
                  (list (background-color-property color)))
   #:sep (hspace 1)
   (map (lambda (p)
          (list (paper-group p)
                (paper-authors p)
                (paper-title p)
                (hyperlink 
                 (build-notes-link (paper-path p))
                 "notes")
                (list
                 (if (paper-dispute? p)
                     (hyperlink (dispute-link (paper-path p)) "dispute!")
                     " ")
                 (linebreak)
                 (if (paper-cleared? p)
                     (hyperlink (cleared-link (paper-path p)) "cleared?")
                     " ")
                 (linebreak)
                 (if (paper-problem? p)
                     (hyperlink (problem-link (paper-path p)) "problem?")
                     " "))))
        ps)))

(define (color-string->color-list s)
  (bytes->list (hex-string->bytes s)))

#| Colors from http://www.colourlovers.com/palette/3289630/Easter_Glory |#
(define (generate-document bs bfs)
  (decode
   (list
    (title #:tag "how-to" "Examining ``Reproducibility in Computer Science''")
    (section #:tag "what-doing" "What We Are Doing")
    top-matter
    threats-to-validity
    (section #:tag "review-details" "How to Review")
    review-protocol
    review-format
    (section #:tag "build-fails" "Reported as Not Building")
    (generate-paper-list bfs (color-string->color-list "FB755F"))
    (section #:tag "builds" "Reported as Building")
    (generate-paper-list bs (color-string->color-list "6BEEE2")))))

