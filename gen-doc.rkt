#lang racket

(require "structure-data.rkt")
(require "static-text.rkt")
(require scribble/base)
(require scribble/decode)

(provide generate-document)

(define (make-link sub-paths file-name)
  (cond
    [(empty? sub-paths) file-name]
    [(cons? sub-paths)
     (string-append (first sub-paths) "/" 
                    (make-link (rest sub-paths) file-name))]))

(define (generate-paper-list ps)
  (tabular #:style 'boxed #:sep (hspace 1)
   (map (lambda (p)
          (list (paper-group p)
                (paper-authors p)
                (paper-title p)
                (hyperlink 
                 (make-link (cons ".." (paper-path p)) "build_notes.txt")
                 "notes")))
        ps)))

(define (generate-document bs bfs)
  (decode
   (list
    (title #:tag "how-to" "Examining ``Reproducibility in Computer Science''")
    (section #:tag "what-doing" "What We Are Doing")
    top-matter
    threats-to-validity
    review-format
    (section #:tag "build-fails" "Reported as Not Building")
    (generate-paper-list bfs)
    (section #:tag "builds" "Reported as Building")
    (generate-paper-list bs))))

