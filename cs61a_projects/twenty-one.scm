(define (twenty-one strategy)
  (define (play-dealer customer-hand dealer-hand-so-far rest-of-deck)
    (cond ((> (best-total dealer-hand-so-far) 21) 1) ; customer wins if dealer busts
	  ((< (best-total dealer-hand-so-far) 17)
	   (play-dealer customer-hand
			(se dealer-hand-so-far (first rest-of-deck))
			(bf rest-of-deck)))
	  ((< (best-total customer-hand) (best-total dealer-hand-so-far)) -1) ; dealer wins
	  ((= (best-total customer-hand) (best-total dealer-hand-so-far)) 0) ; tie
	  (else 1))) ; customer wins

  (define (play-customer customer-hand-so-far dealer-up-card rest-of-deck)
    (cond ((> (best-total customer-hand-so-far) 21) -1)
		  ((strategy customer-hand-so-far dealer-up-card)
	       (play-customer (se customer-hand-so-far (first rest-of-deck)) dealer-up-card (bf rest-of-deck)))
	  (else
	   (play-dealer customer-hand-so-far
			(se dealer-up-card (first rest-of-deck))
			(bf rest-of-deck)))))
			

  (let ((deck (make-deck)))
    (play-customer (se (first deck) (first (bf deck)))
		   (first (bf (bf deck)))
		   (bf (bf (bf deck))))))

(define (play-n strategy n)
		(if (= n 0) 0 (+ (play-n strategy (- n 1))(twenty-one strategy))))
		
(define stop-at-17 (lambda (customer-hand-so-far dealer-up-card) (if (< (best-total customer-hand-so-far) 17) #t #f)))

(define (best-total hand-of-cards)
		(define (best-total-running hand-of-cards running-total)
			(cond ((empty? hand-of-cards) running-total)
				  ((equal? (bl (first hand-of-cards)) 'a) 
					(let ((new-running-total (+ 11 (best-total-running (bf hand-of-cards) running-total)))) 
						(if (< 21 new-running-total) (- new-running-total 10) new-running-total)))
				  ((member? (bl (first hand-of-cards)) '(j q k)) (best-total-running (bf hand-of-cards) (+ running-total 10)))
				  (else (best-total-running (bf hand-of-cards) (+ running-total (bl (first hand-of-cards)))))))
		(best-total-running hand-of-cards 0))
		
(define (make-ordered-deck)
  (define (make-suit s)
    (every (lambda (rank) (word rank s)) '(A 2 3 4 5 6 7 8 9 10 J Q K)) )
  (se (make-suit 'H) (make-suit 'S) (make-suit 'D) (make-suit 'C)) )

(define (make-deck)
  (define (shuffle deck size)
    (define (move-card in out which)
      (if (= which 0)
	  (se (first in) (shuffle (se (bf in) out) (- size 1)))
	  (move-card (bf in) (se (first in) out) (- which 1)) ))
    (if (= size 0)
	deck
    	(move-card deck '() (random size)) ))
  (shuffle (make-ordered-deck) 52) )
