(define (filter-lst fn lst)
  (define len (length lst))
  (if (= len 0)
      (list)
      ; else len > 0
      (if (fn (car lst))
          (append (list (car lst))
                  (filter-lst fn (cdr lst))
          )
          (filter-lst fn (cdr lst))
      )
  )
)

; ;; Tests
(define (even? x) (= (modulo x 2) 0))

(filter-lst even? '(0 1 1 2 3 5 8))

; expect (0 2 8)
(define (interleave first second)
  (define len_a (length first))
  (define len_b (length second))
  (if (> len_a 0)
      (if (> len_b 0)
          (append (list (car first) (car second))
                  (interleave (cdr first) (cdr second))
          )
          first
      )
      second
  )
)

(interleave (list 1 3 5) (list 2 4 6))

; expect (1 2 3 4 5 6)
(interleave (list 1 3 5) nil)

; expect (1 3 5)
(interleave (list 1 3 5) (list 2 4))

; expect (1 2 3 4 5)
(define (accumulate combiner start n term)
  (if (> n 0)
      (combiner (term n)
                (accumulate combiner start (- n 1) term)
      )
      start
  )
)

(define (no-repeats lst)
  (define (contain lst n)
    (if (null? lst)
        #f
        (if (= n (car lst))
            #t
            (contain (cdr lst) n)
        )
    )
  )
  (define (no-repeats-helper filtered raw)
    (define len (length raw))
    (if (= 0 len)
        filtered
        ; else len > 0
        (if (contain filtered (car raw))
            (no-repeats-helper filtered (cdr raw))
            ; else not contain
            (begin (if (null? filtered)
                       (define filtered `(,(car raw)))
                       ; else
                       (define filtered
                               (append filtered (list (car raw)))
                       )
                   )
                   (no-repeats-helper filtered (cdr raw))
            )
        )
    )
  )
  ; initial helper procedure
  (no-repeats-helper (list) lst)
)
