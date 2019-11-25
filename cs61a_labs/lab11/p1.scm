;;; What is the type of the value of (delay (+ 1 27))?
;
; The value returned is a procedure that takes no arguments
;
;;; What is the type of the value of (force (delay (+ 1 27)))?
;
; 28, because force basically cashes in the promise
;

