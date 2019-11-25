;;; (stream-cdr (stream-cdr (cons-stream 1 ’(2 3)))) Why does this produce an error?
;
; 1. cons-stream returns (1 . (promise for '(2 3)))
; 2. stream-cdr cashes in on the promise, getting just the value '(2 3)
; 3. The second stream-cdr expects a promise, while the argument '(2 3) is not a promise but a list