#lang racket

(provide make-link make-file-name output-dir)

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
