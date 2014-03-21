#lang racket

(require "structure-data.rkt")
(require "static-text.rkt")
(require scribble/core)
(require scribble/base)
(require scribble/decode)

(provide generate-document output-dir)



(define output-dir "data")

;; Note: output goes to a output subdir, so the link doesn't need to include it
;; (because it's automatically the base directory) whereas the check in the
;; filesystem needs to include it (because it's not).

(define (make-link sub-paths file-name)
  (cond
    [(empty? sub-paths) file-name]
    [(cons? sub-paths)
     (string-append (first sub-paths) "/" 
                    (make-link (rest sub-paths) file-name))]))

(define (make-file-name path file)
  (apply build-path (cons output-dir (append path (list file)))))

(define (generate-paper-list ps color)
  (tabular 
   #:style (style #f
                  (list (color-property color)))
   #:sep (hspace 1)
   (map (lambda (p)
          (list (paper-group p)
                (paper-authors p)
                (paper-title p)
                (hyperlink 
                 (make-link (paper-path p) "build_notes.txt")
                 "notes")
                (let ([dispute-file (make-file-name (paper-path p) "dispute.txt")]
                      [cleared-file (make-file-name (paper-path p) "cleared.txt")]
                      [problem-file (make-file-name (paper-path p) "problem.txt")])
                  (list
                   (if (file-exists? dispute-file)
                       (hyperlink (make-link (paper-path p) "dispute.txt") "dispute!")
                       " ")
                   (linebreak)
                   (if (file-exists? cleared-file)
                       (hyperlink (make-link (paper-path p) "cleared.txt") "cleared?")
                       " ")
                   (linebreak)
                   (if (file-exists? problem-file)
                       (hyperlink (make-link (paper-path p) "problem.txt") "problem?")
                       " ")))))
        ps)))

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
    (generate-paper-list bfs "red")
    (section #:tag "builds" "Reported as Building")
    (generate-paper-list bs "green"))))

