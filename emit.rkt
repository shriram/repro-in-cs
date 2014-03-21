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

(define the-doc (generate-document structured-built-papers))

(render (list the-doc) 
        (list "index.html")
        #:dest-dir output-dir
        #:style-extra-files (list "style-changes.css")
        )
