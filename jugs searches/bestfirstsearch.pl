:- dynamic
	jug1/1,
	jug2/1.
jug1(0).
jug2(0).
nodeused(0,0).
emptyj1:-%empty jug 1
	jug1(T),
	jug2(S),
	nodeused(T,S),
	retract(jug1(X)),
	asserta(jug1(0)).
emptyj2:-%empty jug 2
	jug1(T),
	jug2(S),
	nodeused(T,S),
	retract(jug2(X)),
	asserta(jug2(0)).
fillj1:-%fill j1
	jug1(T),
	jug2(S),
	nodeused(T,S),
	retract(jug1(X)),
	asserta(jug1(3)).
fillj2:-%fill j2
	jug1(T),
	jug2(S),
	nodeused(T,S),
	retract(jug2(X)),
	asserta(jug2(4)).
xferj1toj2:-%transfer whats in jug1 to jug 2
	jug1(Y),
	jug1(T),
	jug2(S),
	nodeused(T,S),
	retract(jug2(X)),
	asserta(jug2(Y)),
	j2overfill.
xferj2toj1:-%transfer whats in jug2 to jug 1
	jug2(Y),
	jug1(T),
	jug2(S),
	nodeused(T,S),
	retract(jug1(X)),
	asserta(jug1(Y)),
	j1overfill.
j1overfill:-%checks to see if the jug would overflow if so correct its
	jug1(X),
	X > 3,
	retract(jug1(X)),
	asserta(jug1(3)).
j2overfill:-%checks to see if the jug would overflow if so corrects it
	jug2(X),
	X > 4,
	retract(jug2(X)),
	asserta(jug2(4)).
goalreached:-
	jug1(X),
	jug2(Y),
	X is 0,
	Y is 4.
bestsearch:-
	jug1(X),
	jug2(Y),
	not(nodeused(X,Y)),
	not(goalreached),
	fillj1,
	fillj2,
	emptyj1,
	emptyj2,
	xferj1toj2,
	xferj2toj1,
	bestsearch.
bestsearch:-
	goalreached,
	write('Its over game reached').










