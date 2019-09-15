(define (accumulate-n op init seqs)
	(if (null? (car seqs))
		nil
		(cons (accumulate op init (map car seqs))
			  (accumulate-n op init (map cdr seqs)))))

(define (dot-product v w)
	(accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
	(map (lambda (x) (dot-product v x)) m))
(define (transpose mat)
	(accumulate-n cons '() mat))
(define (matrix-*-matrix m n)
	(let ((cols (transpose n)))
		(map (lambda (m_v) (map (lambda (n_v) (dot-product n_v m_v)) (transpose cols))) m)))
		
(define m '((1 2 3 4) (4 5 6 6) (6 7 8 9)))