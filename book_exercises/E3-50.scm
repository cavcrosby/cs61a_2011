(define (stream-map proc . argstreams)
	(if (stream-null? (car argstreams)) ; added stream-null?
		the-empty-stream
		(cons-stream ; added cons-stream
		 (apply proc (map stream-car argstreams)) ; added stream-car
		 (apply stream-map
			(cons proc (map stream-cdr argstreams)))))) ; added stream-cdr