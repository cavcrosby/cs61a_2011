(define (special-form-or x y)
  (or (= 0 0) (/ x y)))
  
(define (special-form-and x y)
  (and (= 0 1) (/ x y)))

; both or and 'and' are considered special forms in scheme, because in like or
; if the first predicate returns true, then or will return true and not evaluate the other expression(s)
; if the first predicate returns false in terms of and, then and will return false, the next expression will only
; be evaluated if true
