#lang racket

(provide parse-tsv/port parse-tsv/file)

(define (parse-tsv-line l)
  (define (cr->str cr) (list->string (reverse cr)))
  (let loop ([cs (string->list l)]
             [cur-rev empty])
    (if (empty? cs)
        (list (cr->str cur-rev))
        (let ([a (first cs)] [d (rest cs)])
          (if (char=? a #\tab)
              (cons (cr->str cur-rev)
                    (loop d empty))
              (loop d (cons a cur-rev)))))))

(define (parse-tsv/port p)
  (let loop ([l (read-line p)])
    (if (eof-object? l) empty
        (cons (parse-tsv-line l)
              (parse-tsv/port p)))))

(define (parse-tsv/file f)
  (parse-tsv/port (open-input-file f)))

