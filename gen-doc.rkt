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
  (define (make-section title f color)
    (let ([relevant-papers (filter f papers)])
      (list (section title " (" (number->string (length relevant-papers)) ")")
            (generate-paper-list (shuffle relevant-papers) color))))
  (decode
   (list
    (title "Examining ``Reproducibility in Computer Science''")
    (section "What We Are Doing")
    top-matter
    threats-to-validity
    (section "How to Review")
    review-protocol
    review-format
    (make-section "Purported Not Building; Disputed; Not Checked"
                  (and-filters not-building? disputed? not-checked?) neutral-color)
    (make-section "Purported Building; Disputed; Not Checked"
                  (and-filters building? disputed? not-checked?) neutral-color)
    (make-section "Conflicting Checks!"
                  (and-filters cleared? problem?) bad-color)
    ;; don't use disputed? for the next two, because people may have checked
    ;; without a formal dispute filed!
    (make-section "Purported Not Building But Found Building"
                  (and-filters not-building? cleared? not-problem?) bad-color)
    (make-section "Purported Building But Found Not Building"
                  (and-filters building? not-cleared? problem?) bad-color)
    (make-section "Purported Not Building; Confirmed"
                  (and-filters not-building? not-cleared? problem?) good-color)
    (make-section "Purported Building; Confirmed"
                  (and-filters building? cleared? not-problem?) good-color)
    (make-section "All Others Purported Not Building"
                  (and-filters not-building? not-disputed? not-checked? not-problem?) bad-color)
    (make-section "All Other Purported Building"
                  (and-filters building? not-disputed? not-checked? not-problem?) good-color)

;    (section (emph "All") " Reported as Not Building")
;    (gen-filtered not-building? bad-color)
;    (section (emph "All") " Reported as Building")
;    (gen-filtered building? good-color)
    )))

