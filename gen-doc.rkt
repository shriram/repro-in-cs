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
  (define (make-section title relevant-papers color)
    (list (section title " (" (number->string (length relevant-papers)) ")")
          (generate-paper-list (shuffle relevant-papers) color)))
  (define not-building/disputed/not-checked
    (filter (and-filters not-building? disputed? not-checked?) papers))
  (define building/disputed/not-checked
    (filter (and-filters building? disputed? not-checked?) papers))
  (define conflicting-checks
    (filter (and-filters cleared? problem?) papers))
  (define not-building/building
    (filter (and-filters not-building? cleared? not-problem?) papers))
  (define building/not-building
    (filter (and-filters building? not-cleared? problem?) papers))
  (define not-building/confirmed
    (filter (and-filters not-building? not-cleared? problem?) papers))
  (define building/confirmed
    (filter (and-filters building? cleared? not-problem?) papers))
  (define others-not-building
    (filter (and-filters not-building? not-disputed? not-checked? not-problem?) papers))
  (define others-building
    (filter (and-filters building? not-disputed? not-checked? not-problem?) papers))
  (decode
   (list
    (title "Examining ``Reproducibility in Computer Science''")
    (section "What We Are Doing")
    top-matter
    (section "How to Review")
    review-protocol
    review-format
    (make-section "Purported Not Building; Disputed; Not Checked"
                   not-building/disputed/not-checked neutral-color)
    (make-section "Purported Building; Disputed; Not Checked"
                   building/disputed/not-checked neutral-color)
    (make-section "Conflicting Checks!"
                   conflicting-checks bad-color)
    ;; don't use disputed? for the next two, because people may have checked
    ;; without a formal dispute filed!
    (make-section "Purported Not Building But Found Building"
                  not-building/building bad-color)
    (make-section "Purported Building But Found Not Building"
                  building/not-building bad-color)
    (make-section "Purported Not Building; Confirmed"
                  not-building/confirmed good-color)
    (make-section "Purported Building; Confirmed"
                  building/confirmed good-color)
    (make-section "All Others Purported Not Building"
                  others-not-building bad-color)
    (make-section "All Other Purported Building"
                  others-building good-color)
    (section "Threats to Validity")
    threats-to-validity

;    (section (emph "All") " Reported as Not Building")
;    (gen-filtered not-building? bad-color)
;    (section (emph "All") " Reported as Building")
;    (gen-filtered building? good-color)
    )))

