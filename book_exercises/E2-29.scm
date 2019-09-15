; (define (make-mobile left right)
	; (list left right))
	
; (define (make-branch length structure)
	; (list length structure))

(define (make-mobile left right)
	(cons left right))
	
(define (make-branch length structure)
	(cons length structure))

;test cases
(define t1 (make-mobile 
			(make-branch 10 
						(make-mobile 
							(make-branch 5 4) 
							(make-branch 3 2)))
			(make-branch 3 1)))


(define t2 (make-mobile
			(make-branch 
				5
				(make-mobile
					(make-branch
						4
						10)
					(make-branch
						4
						8)
				)
			)
			(make-branch
				10
				(make-mobile
					(make-branch
						3
						7)
					(make-branch
						4
						8)
				)
			)
		))
		
(define t3 (make-mobile
			(make-branch
				5
				(make-mobile
					(make-branch
						1
						6)
					(make-branch
						3
						2)
				))
			(make-branch
				10
				4
			)
		   )
)

(define t4 (make-mobile
			(make-branch
				5
				(make-mobile
					(make-branch
						1
						6)
					(make-branch
						3
						2))
				)
			(make-branch
				1
				(make-mobile
					(make-branch
						3
						10)
					(make-branch
						1
						30)
					))))
;a

; (define (left-branch mobile) (car mobile))

; (define (right-branch mobile) (cadr mobile))

; (define (branch-length branch) (car branch))

; (define (branch-structure branch) (cadr branch))

(define (left-branch mobile) (car mobile))

(define (right-branch mobile) (cdr mobile))

(define (branch-length branch) (car branch))

(define (branch-structure branch) (cdr branch))

(define (mobile? x) (not (number? x)))

;b

(define (total-weight mobile)
	(define (total-helper lb rb)
		(if (number? rb)
			rb
			(accumulate + (map (lambda (x) (if (mobile? x) (total-weight x) x)) (list (branch-structure lb) (branch-structure rb))))))
	(total-helper (left-branch mobile) (right-branch mobile)))
	
;c

(define (balanced-mobile? mobile)
	(define (balanced-helper lb rb)
		(let (
			 (lb-total (* (branch-length lb) (if (number? (branch-structure lb)) (branch-structure lb) (total-weight (branch-structure lb)))))
			 (rb-total (* (branch-length rb) (if (number? (branch-structure rb)) (branch-structure rb) (total-weight (branch-structure rb))))))
			(if (not (equal? lb-total rb-total))
				#f
				(map (lambda (x) (if (mobile? x) (balanced-helper (left-branch x) (right-branch x)) #t)) (list (branch-structure lb) (branch-structure rb))))))
	(not (memq #f (list(balanced-helper (left-branch mobile) (right-branch mobile))))))
	
(define b balanced-mobile?)

;d
	
; To my surprise, all I needed to change was the selectors
;
;
;
;