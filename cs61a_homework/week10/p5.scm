;https://networkengineering.stackexchange.com/questions/24068/why-do-we-need-a-3-way-handshake-why-not-just-2-way
;
;Basically 2 parties need to account for what each recieves. To do this, both parties generate a random seqeuence number and make sure the other party knows about it and acknowledges it. 
; x -- > y (y knows x's initial seqeuence number)
; x < -- y (y acknowledges x's number, and x know this along with y's initial seqeuence number)
; x -- > y (x acknowledges y's number, and x let's y know this
;