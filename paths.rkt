#lang racket

(provide output-dir 
         dispute-file-name cleared-file-name problem-file-name
         dispute-link cleared-link problem-link
         build-notes-link)

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

(define (dispute-link path)
  (make-link path "dispute.txt"))
(define (cleared-link path)
  (make-link path "cleared.txt"))
(define (problem-link path)
  (make-link path "problem.txt"))
(define (build-notes-link path)
  (make-link path "build_notes.txt"))

(define (make-file-name path file)
  (apply build-path (cons output-dir (append path (list file)))))

(define (dispute-file-name path)
  (make-file-name path "dispute.txt"))
(define (cleared-file-name path)
  (make-file-name path "cleared.txt"))
(define (problem-file-name path)
  (make-file-name path "problem.txt"))
