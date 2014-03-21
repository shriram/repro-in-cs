#lang racket

(require "parse-tsv.rkt")
(require "structure-data.rkt")
(require "filters.rkt")
(require "gen-doc.rkt")
(require "paths.rkt")
(require scribble/render)

(define all-papers (strip-header (parse-tsv/file (build-path "metadata" "summary.tsv"))))
(define built-papers (papers-with-build-status all-papers))
(define structured-built-papers (convert-to-struct built-papers))

(define l1 (builds structured-built-papers))
;(define l1 (take (builds g) 5))
(define l2 (build-fails structured-built-papers))
;(define l2 (take (build-fails g) 5))

(define the-doc (generate-document l1 l2))

(render (list the-doc) 
        (list "index.html")
        #:dest-dir output-dir
        #:style-extra-files (list "style-changes.css")
        )
