; #1 could have been given part of the work to do, assuming the client program sends a sequence of clients to send the message to, but a recursive call on the client side is easier to implement
; #2 could have been entirely done on the client side. As the client side always has a current copy of the clients that are connected to the server. If this is a feature to be included for different kinds of client programs, it might be a better idea to have this as a feature on the server, so its not isolated on a particular client program.
;
;