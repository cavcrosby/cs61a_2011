;;;  Data for adventure game.  This file is adv-world.scm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; setting up the world
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define Soda (instantiate place 'Soda))
(define BH-Office (instantiate place 'BH-Office))
(define MJC-Office (instantiate place 'MJC-Office))
(define art-gallery (instantiate place 'art-gallery))
(define Pimentel (instantiate place 'Pimentel))
(define 61A-Lab (instantiate place '61A-Lab))
(define Sproul-Plaza (instantiate place 'Sproul-Plaza))
(define Telegraph-Ave (instantiate place 'Telegraph-Ave))
(define Noahs (instantiate place 'Noahs))
(define Intermezzo (instantiate place 'Intermezzo))
(define s-h (instantiate place 'sproul-hall))
(define Dormitory (instantiate place 'Dormitory))
(define Kirin (instantiate place 'Kirin))
(define disneyland (instantiate locked-place 'disneyland))
(define g1 (instantiate garage 'g1))
(define g2 (instantiate garage 'g2))
(define starbucks (instantiate hotspot 'starbucks 'password1))
(define laptop1 (instantiate laptop 'connerslaptop))
(define laptop2 (instantiate laptop 'brianslaptop))
(define berk_pold (instantiate jail 'berkpol))


(can-go Soda 'up art-gallery)
(can-go Soda 'north Kirin)
(can-go Kirin 'south Soda)
(can-go art-gallery 'down Soda)
(can-go art-gallery 'west BH-Office)
(can-go BH-Office 'east art-gallery)
(can-go art-gallery 'east MJC-Office)
(can-go MJC-office 'west art-gallery)
(can-go Soda 'south Pimentel)
(can-go Pimentel 'north Soda)
;(can-go Pimentel 'south 61A-Lab)
(can-go Pimentel 'south Sproul-Plaza)
(can-go 61A-Lab 'north Pimentel)
(can-go 61A-Lab 'west s-h)
(can-go s-h 'east 61A-Lab)
(can-go Sproul-Plaza 'east s-h)
(can-go s-h 'west Sproul-Plaza)
(can-go Sproul-Plaza 'north Pimentel)
(can-go Sproul-Plaza 'south Telegraph-Ave)
(can-go Telegraph-Ave 'north Sproul-Plaza)
(can-go Telegraph-Ave 'south Noahs)
(can-go Noahs 'north Telegraph-Ave)
(can-go Noahs 'south Intermezzo)
(can-go Intermezzo 'north Noahs)
(can-go Sproul-Plaza 'west Dormitory)
(can-go Dormitory 'east Sproul-Plaza)
(can-go disneyland 'east BH-Office)
(can-go BH-Office 'west disneyland)
(can-go g1 'west g2)
(can-go g2 'east g1)
(can-go g1 'east Telegraph-Ave)
(can-go Telegraph-Ave 'west g1)
(can-go art-gallery 'north starbucks)
(can-go starbucks 'south art-gallery)




;; Some people.
; MOVED above the add-entry-procedure stuff, to avoid the "The computers
; seem to be down" message that would occur when hacker enters 61a-lab
; -- Ryan Stejskal

(define Brian (instantiate person 'Brian BH-Office))
(define hacker (instantiate person 'hacker 61A-lab))
(define nasty (instantiate thief 'nasty sproul-plaza))
(define preacher (instantiate person 'preacher sproul-plaza))
(define Conner (instantiate person 'Conner Dormitory))
(define po1 (instantiate police 'police1 starbucks berkeley_police))
(define po2 (instantiate police 'police2 Kirin berkeley_police))

(ask brian 'set-talk 'Diddly-do)
(ask hacker 'set-talk '....)
(ask preacher 'set-talk "Praise the Lord!")

(define potstickers (instantiate thing 'potstickers))
(define a_car (instantiate thing 'a_car))
(define b_car (instantiate thing 'b_car))
(ask Kirin 'appear potstickers)
(ask Kirin 'appear a_car)
(ask BH-Office 'appear b_car)
(ask BH-Office 'appear laptop1)
(ask BH-Office 'appear laptop2)

(ask Conner 'go 'east)
(ask Conner 'go 'north)
(ask Conner 'go 'north)
(ask Conner 'go 'north)
(ask Conner 'take potstickers)
(ask Conner 'take a_car)
(ask Conner 'go 'south)
(ask Conner 'go 'up)
(ask Conner 'go 'west)
(ask Conner 'lose potstickers)
(ask Brian 'take potstickers)
(ask Brian 'take b_car)
(ask Brian 'take laptop2)
(ask Conner 'take laptop1)

; (define (sproul-hall-exit)
   ; (error "You can check out any time you'd like, but you can never leave"))
   
(define sproul-hall-exit
	(let ((times-called 0))
		(lambda ()
			(if (<= times-called 3)
				(begin (set! times-called (+ 1 times-called)) 
					   (error "You can check out any time you'd like, but you can never leave"))
					'okay))))

(define (bh-office-exit)
  (print "What's your favorite programming language?")
  (let ((answer (read)))
    (if (eq? answer 'scheme)
	(print "Good answer, but my favorite is Logo!")
	(begin (newline) (bh-office-exit)))))
    

(ask s-h 'add-entry-procedure
 (lambda () (print "Miles and miles of students are waiting in line...")))
(ask s-h 'add-exit-procedure sproul-hall-exit)
(ask BH-Office 'add-exit-procedure bh-office-exit)
(ask Noahs 'add-entry-procedure
 (lambda () (print "Would you like lox with it?")))
(ask Noahs 'add-exit-procedure
 (lambda () (print "How about a cinnamon raisin bagel for dessert?")))
(ask Telegraph-Ave 'add-entry-procedure
 (lambda () (print "There are tie-dyed shirts as far as you can see...")))
(ask 61A-Lab 'add-entry-procedure
 (lambda () (print "The computers seem to be down")))
(ask 61A-Lab 'add-exit-procedure
 (lambda () (print "The workstations come back to life just in time.")))

;; Some things.

(define bagel (instantiate thing 'bagel))
(ask Noahs 'appear bagel)

(define coffee (instantiate thing 'coffee))
(ask Intermezzo 'appear coffee)
