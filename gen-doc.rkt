#lang racket

(require "structure-data.rkt")
(require "static-text.rkt")
(require "paths.rkt")
(require "filters.rkt")
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
(define bad-color (color-string->color-list "FB755F"))
(define good-color (color-string->color-list "6BEEE2"))
(define neutral-color (color-string->color-list "B297F4"))

(define (generate-document papers)
  (define (gen-filtered f color) (generate-paper-list (filter f papers) color))
  (decode
   (list
    (title #:tag "how-to" "Examining ``Reproducibility in Computer Science''")
    (section #:tag "what-doing" "What We Are Doing")
    top-matter
    threats-to-validity
    (section #:tag "review-details" "How to Review")
    review-protocol
    review-format
    (section "Purported Not Building; Disputed; Not Checked")
    (gen-filtered (and-filters not-building? disputed? not-checked?) neutral-color)
    (section "Purported Building; Disputed; Not Checked")
    (gen-filtered (and-filters building? disputed? not-checked?) neutral-color)
    (section "Conflicting Checks!")
    (gen-filtered (and-filters cleared? problem?) bad-color)
    (section "Purported Not Building; Disputed; Found Building")
    (gen-filtered (and-filters not-building? disputed? cleared?) bad-color)
    (section "Purported Building; Disputed; Found Not Building")
    (gen-filtered (and-filters building? disputed? problem?) bad-color)
    (section "Purported Not Building; Confirmed")
    (gen-filtered (and-filters not-building? problem?) good-color)
    (section "Purported Building; Confirmed")
    (gen-filtered (and-filters building? cleared?) good-color)
    
    (section (emph "All") " Reported as Not Building")
    (gen-filtered not-building? bad-color)
    (section (emph "All") " Reported as Building")
    (gen-filtered building? good-color)
    )))

