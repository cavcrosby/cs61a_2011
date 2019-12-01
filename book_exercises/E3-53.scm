(define s (cons-stream 1 (add-streams s s)))

;
; the first element the stream s will be 1, the rest a seqeuence of (s + s), so 2 would be the next element, followed by 4
;
;