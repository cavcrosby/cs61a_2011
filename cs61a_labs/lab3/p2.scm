(define (count-change amount)
	(cc amount 2))
(define (cc amount kinds-of-coins)
	(cond ((= amount 0) 1)
		  ((or (< amount 0) (= kinds-of-coins 0)) 0)
		  (else (+ (cc amount (- kinds-of-coins 1)) (cc (- amount (first-denomination kinds-of-coins)) kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
	(cond ((= kinds-of-coins 1) 1)
		  ((= kinds-of-coins 2) 5)))
		  
		  
; ((= kinds-of-coins 1) 50) ; w1
		  ; ((= kinds-of-coins 2) 25) 
		  ; ((= kinds-of-coins 3) 10)
		  ; ((= kinds-of-coins 4) 5)
		  ; ((= kinds-of-coins 5) 1)))
		  
		  
; (define (count-change amount) ; w2
	; (cc amount 1))
; (define (cc amount kinds-of-coins)
	; (cond ((= amount 0) 1)
		  ; ((or (< amount 0) (= (first-denomination kinds-of-coins) 0)) 0)
		  ; (else (+ (cc amount (+ kinds-of-coins 1)) (cc (- amount (first-denomination kinds-of-coins)) kinds-of-coins)))))

; (define (first-denomination kinds-of-coins)
	; (cond ((= kinds-of-coins 1) 1)
		  ; ((= kinds-of-coins 2) 5) 
		  ; ((= kinds-of-coins 3) 10)
		  ; ((= kinds-of-coins 4) 25)
		  ; ((= kinds-of-coins 5) 50)
		  ; (else 0)))
		  
		  
; By having the largest value of the coin first (e.g. 50), and the smallest value of coin last, the efficiency decreases.
; This is mainly because the number of top level nodes will increase as they are decreasing at the lowest value of coin.