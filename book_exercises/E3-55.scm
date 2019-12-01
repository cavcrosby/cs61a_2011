(define ones (cons-stream 1 ones))

(define (stream-map proc . argstreams)
	(if (stream-null? (car argstreams))
		the-empty-stream
		(cons-stream
		 (apply proc (map stream-car argstreams))
		 (apply stream-map
			(cons proc (map stream-cdr argstreams)))))) 

(define (add-streams s1 s2) (stream-map + s1 s2))

(define integers
	(cons-stream 1 (add-streams ones integers)))

(define partial-sums
	(cons-stream 1 (add-streams partial-sums (stream-cdr integers))))
	
