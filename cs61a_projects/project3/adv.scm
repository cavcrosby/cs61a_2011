;; ADV.SCM
;; This file contains the definitions for the objects in the adventure
;; game and some utility procedures.

(define-class (place name)
  (instance-vars
   (directions-and-neighbors '())
   (things '())
   (people '())
   (entry-procs '())
   (exit-procs '()))
  (method (type) 'place)
  (method (neighbors) (map cdr directions-and-neighbors))
  (method (exits) (map car directions-and-neighbors))
  (method (look-in direction)
    (let ((pair (assoc direction directions-and-neighbors)))
      (if (not pair)
	  '()                     ;; nothing in that direction
	  (cdr pair))))           ;; return the place object
  (method (appear new-thing)
    (if (memq new-thing things)
	(error "Thing already in this place" (list name new-thing)))
    (set! things (cons new-thing things))
    'appeared)
  (method (enter new-person)
    (if (memq new-person people)
	(error "Person already in this place" (list name new-person)))
	(for-each (lambda (person) (ask person 'notice new-person)) people)
    (set! people (cons new-person people))
    (for-each (lambda (proc) (proc)) entry-procs)
    'appeared)
  (method (gone thing)
    (if (not (memq thing things))
	(error "Disappearing thing not here" (list name thing)))
    (set! things (delete thing things)) 
    'disappeared)
  (method (exit person)
    (for-each (lambda (proc) (proc)) exit-procs)
    (if (not (memq person people))
	(error "Disappearing person not here" (list name person)))
    (set! people (delete person people)) 
    'disappeared)

  (method (new-neighbor direction neighbor)
    (if (assoc direction directions-and-neighbors)
	(error "Direction already assigned a neighbor" (list name direction)))
    (set! directions-and-neighbors
	  (cons (cons direction neighbor) directions-and-neighbors))
    'connected)
	
  (method (may-enter? person) #t)

  (method (add-entry-procedure proc)
    (set! entry-procs (cons proc entry-procs)))
  (method (add-exit-procedure proc)
    (set! exit-procs (cons proc exit-procs)))
  (method (remove-entry-procedure proc)
    (set! entry-procs (delete proc entry-procs)))
  (method (remove-exit-procedure proc)
    (set! exit-procs (delete proc exit-procs)))
  (method (clear-all-procs)
    (set! exit-procs '())
    (set! entry-procs '())
    'cleared) )

(define-class (person name place)
  (instance-vars
   (possessions '())
   (saying ""))
  (initialize
   (ask place 'enter self))
  (method (type) 'person)
  (method (look-around)
    (map (lambda (obj) (ask obj 'name))
	 (filter (lambda (thing) (not (eq? thing self)))
		 (append (ask place 'things) (ask place 'people)))))
  (method (take thing)
    (cond ((not (thing? thing)) (error "Not a thing" thing))
	  ((not (memq thing (ask place 'things)))
	   (error "Thing taken not at this place"
		  (list (ask place 'name) thing)))
	  ((memq thing possessions) (error "You already have it!"))
	  (else
	   (announce-take name thing)
	   (set! possessions (cons thing possessions))
	       
	   ;; If somebody already has this object...
	   (for-each
	    (lambda (pers)
	      (if (and (not (eq? pers self)) ; ignore myself
		       (memq thing (ask pers 'possessions)))
		  (begin
		   (ask pers 'lose thing)
		   (have-fit pers))))
	    (ask place 'people))
	       
	   (ask thing 'change-possessor self)
	   'taken)))

  (method (lose thing)
    (set! possessions (delete thing possessions))
    (ask thing 'change-possessor 'no-one)
    'lost)
  (method (talk) (print saying))
  (method (set-talk string) (set! saying string))
  (method (exits) (ask place 'exits))
  (method (notice person) (ask self 'talk))
  (method (go direction)
    (let ((new-place (ask place 'look-in direction)))
      (cond ((null? new-place)
				(error "Can't go" direction))
		 ((not (ask new-place 'may-enter? self))
				(error "Place is locked -- " (ask new-place 'name)))
	    (else
	     (ask place 'exit self)
	     (announce-move name place new-place)
	     (for-each
	      (lambda (p)
		(ask place 'gone p)
		(ask new-place 'appear p))
	      possessions)
	     (set! place new-place)
	     (ask new-place 'enter self))))) )

; (define thing
  ; (let ()
    ; (lambda (class-message)
      ; (cond
       ; ((eq? class-message 'instantiate)
	; (lambda (name)
	  ; (let ((self '()) (possessor 'no-one))
	    ; (define (dispatch message)
	      ; (cond
	       ; ((eq? message 'initialize)
		; (lambda (value-for-self)
		  ; (set! self value-for-self)))
	       ; ((eq? message 'send-usual-to-parent)
		; (error "Can't use USUAL without a parent." 'thing))
	       ; ((eq? message 'name) (lambda () name))
	       ; ((eq? message 'possessor) (lambda () possessor))
	       ; ((eq? message 'type) (lambda () 'thing))
	       ; ((eq? message 'change-possessor)
		; (lambda (new-possessor)
		  ; (set! possessor new-possessor)))
	       ; (else (no-method 'thing))))
	    ; dispatch)))
       ; (else (error "Bad message to class" class-message))))))
	   
	   
(define-class (thing name)
	(instance-vars (possessor 'no-one))
	(method (type) 'thing)
	(method (change-possessor new-possessor)
		(set! possessor new-possessor)
		'okay)
	(default-method (error "Bad message to class: " message)))

(define-class (locked-place name)
	(parent (place name))
	(instance-vars (locked #t))
	(method (unlock) 
		(set! locked #f)  
		(display name)
		(display " is now unlocked")
		(newline))
	(method (lock)
		(set! locked #t)
		(display name)
		(display " is now locked")
		(newline))
	(method (may-enter? person)
		(if locked
			#f
			#t)))
			
(define-class (garage name)
	(parent (place name))
	(class-vars (serial-counter 1))
	(instance-vars (table (make-table)))
	(method (park thing-car)
		(let ((possessor (ask thing-car 'possessor)))
			(cond ((null? (flatmap 
					  (lambda (thing) (if (eq? thing thing-car) (list thing-car) '()))
					  (usual 'things))) (error "Car is not in the garage " thing-car))
				  ((eq? 'no-one possessor) (error "Whose driving this car?!?! " thing-car))
				(else 
					(begin
						(let ((new-ticket (instantiate ticket 'ticket serial-counter)))
							(insert! serial-counter thing-car table)
							(ask possessor 'lose thing-car)
							(ask self 'appear new-ticket)
							(ask possessor 'take new-ticket)
							(set! serial-counter (+ 1 serial-counter))
							'okay))))))
	(method (un-park ticket)
		(if (not (ticket? ticket)) 
			(error "Not a ticket " ticket)
			(let ((ticket-number (ask ticket 'number)))
				(let ((thing-car (lookup ticket-number table)) (possessor (ask ticket 'possessor)))
					(if (not thing-car)
						(error "Car is not parked here")
						(begin
							(ask possessor 'lose ticket)
							(ask possessor 'take thing-car)
							(insert! ticket-number #f table)
							'okay)))))))
	
				
(define-class (ticket name number)
	(parent (thing name)))
			
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Implementation of thieves for part two
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define *foods* '(pizza potstickers coffee))

(define (edible? thing)
  (member? (ask thing 'name) *foods*))

(define-class (thief name initial-place)
  (parent (person name initial-place))
  (instance-vars
   (behavior 'steal))
  (method (type) 'thief)

  (method (notice person)
    (if (eq? behavior 'run)
	(ask self 'go (pick-random (ask (usual 'place) 'exits)))
	(let ((food-things
	       (filter (lambda (thing)
			 (and (edible? thing)
			      (not (eq? (ask thing 'possessor) self))))
		       (ask (usual 'place) 'things))))
	  (if (not (null? food-things))
	      (begin
	       (ask self 'take (car food-things))
	       (set! behavior 'run)
	       (ask self 'notice person)) )))) )

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Utility procedures
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (name obj) (ask obj 'name))
(define (inventory obj)
  (if (person? obj)
      (map name (ask obj 'possessions))
      (map name (ask obj 'things))))
	  
(define (whereis obj)
	(if (person? obj)
		(ask (ask obj 'place) 'name)
		(error "Not a person -- " obj)))
		
(define (owner obj)
	(if (thing? obj)
		(let ((owner (ask obj 'possessor)))
			(if (equal? owner 'no-one)
				'no-one
				(ask owner 'name)))
		(error "Not a thing -- " ob)))

(define (people-here location)
	(map name (ask location 'people)))

		
(define (get-ticket person)
	(let ((tickets (flatmap (lambda (possession) (if (ticket? possession) (list possession) '())) (ask person 'possessions))))
		(if (not (null? tickets))
			(car tickets)
			'())))

;;; this next procedure is useful for moving around

(define (move-loop who)
  (newline)
  (print (ask who 'exits))
  (display "?  > ")
  (let ((dir (read)))
    (if (equal? dir 'stop)
	(newline)
	(begin (print (ask who 'go dir))
	       (move-loop who)))))


;; One-way paths connect individual places.

(define (can-go from direction to)
  (ask from 'new-neighbor direction to))


(define (announce-take name thing)
  (newline)
  (display name)
  (display " took ")
  (display (ask thing 'name))
  (newline))

(define (announce-move name old-place new-place)
  (newline)
  (newline)
  (display name)
  (display " moved from ")
  (display (ask old-place 'name))
  (display " to ")
  (display (ask new-place 'name))
  (newline))

(define (have-fit p)
  (newline)
  (display "Yaaah! ")
  (display (ask p 'name))
  (display " is upset!")
  (newline))


(define (pick-random set)
  (nth (random (length set)) set))

(define (delete thing stuff)
  (cond ((null? stuff) '())
	((eq? thing (car stuff)) (cdr stuff))
	(else (cons (car stuff) (delete thing (cdr stuff)))) ))

(define (person? obj)
  (and (procedure? obj)
       (member? (ask obj 'type) '(person police thief))))

(define (thing? obj)
  (and (procedure? obj)
       (eq? (ask obj 'type) 'thing)))
	   
(define (ticket? obj)
	(and (procedure? obj)
		(eq? (ask obj 'type) 'thing)
		(eq? (ask obj 'name) 'ticket)))
