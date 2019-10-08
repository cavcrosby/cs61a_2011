(load "p1.scm")

(define-class (double-talker1 name)
  (parent (person name))
  (method (say stuff) (se (usual 'say stuff) (ask self 'repeat)))) 



(define-class (double-talker2 name)
  (parent (person name))
  (method (say stuff) (se stuff stuff)))


(define-class (double-talker3 name)
  (parent (person name))
  (method (say stuff) (usual 'say (se stuff stuff))))

; MY ANSWER:
; From what I can tell, the first two defintions are basically the same. As (usual 'say stuff) returns just stuff, while (ask self 'repeat) also returns stuff, hence the arguments really being (se stuff stuff)
; The third defintion takes a longer way of doing things, by asking the parent/super class to return the same expression from the first two methods
