(define (pigl wd)
  (new-if (pl-done? wd)
      (word wd 'ay)
      (pigl (word (bf wd) (first wd)))))

(define (pl-done? wd)
  (vowel? (first wd)))

(define (vowel? letter)
  (member? letter '(a e i o u)))


(define (new-if pred then-c else-c)
  (cond (pred then-c)
	(else else-c)))


; pigl will never terminate, new-if not being of special form and that scheme uses applicative order
; evaluation. The else-c being a recursive call will evaulate before even going into new-if
;
