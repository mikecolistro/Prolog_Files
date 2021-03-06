start :-
	write('What is the value of A?  '),
	read(X),
	assert(a(X)),
	nl,
	write('What is the value of B?  '),
	read(Y),
	assert(b(Y)),
	nl,
	write('What is the value of the Carry-In?  '),
	read(Z),
	assert(carryin(Z)),
	checkvalues,
	phase1.
phase1 :-
	a(X),
	b(Y),
	carryin(Z),
	assert(and(X,Y)),
	assert(xor(X,Y)),
	retract(a(_)),
	retract(b(_)),
	andvalue,
	xorvalue,
	phase2.
phase2 :-
	and(Z),
	retract(and(Z)),
	assert(and(Z,0,1)),
	xor(X),
	carryin(Y),
	assert(and(X,Y)),
	assert(xor(X,Y)),
	retract(xor(X)),
	retract(carryin(Y)),
	andvalue,
	xorvalue,
	phase3.
phase3 :-
	and(Z),
	and(X,Y,W),
	xor(T),
	assert(or(Z,X)),
	assert(sum(T)),
	retract(and(Z)),
	retract(and(X,Y,W)),
	retract(xor(T)),
	orvalue,
	nl,
	write('Sum is :'),
	write(T),
	cleanup.
orvalue :-
	or(X,Y),
	X is 0,
	Y is 0,
	retract(or(X,Y)),
	assert(or(0)),
	write('Carry out is : 0').
orvalue :-
	or(X,Y),
	X is 0,
	Y is 1,
	retract(or(X,Y)),
	assert(or(1)),
	write('Carry out is : 1').

orvalue :-
	or(X,Y),
	X is 1,
	Y is 0,
	retract(or(X,Y)),
	assert(or(1)),
	write('Carry out is : 1').

orvalue :-
	or(X,Y),
	X is 1,
	Y is 1,
	retract(or(X,Y)),
	assert(or(1)),
	write('Carry out is : 1').


xorvalue :-
	xor(X,Y),
	X is 0,
	Y is 0,
	retract(xor(X,Y)),
	assert(xor(0)).

xorvalue :-
	xor(X,Y),
	X is 0,
	Y is 1,
	retract(xor(X,Y)),
	assert(xor(1)).

xorvalue :-
	xor(X,Y),
	X is 1,
	Y is 0,
	retract(xor(X,Y)),
	assert(xor(1)).

xorvalue :-
	xor(X,Y),
	X is 1,
	Y is 1,
	retract(xor(X,Y)),
	assert(xor(0)).

andvalue :-
	and(X,Y),
	X is 0,
	Y is 0,
	retract(and(X,Y)),
	assert(and(0)).
andvalue :-
	and(X,Y),
	X is 0,
	Y is 1,
	retract(and(X,Y)),
	assert(and(0)).
andvalue :-
	and(X,Y),
	X is 1,
	Y is 0,
	retract(and(X,Y)),
	assert(and(0)).
andvalue :-
	and(X,Y),
	X is 1,
	Y is 1,
	retract(and(X,Y)),
	assert(and(1)).

checkvalues :-
	a(X),
	X > 1,
	write('Error Values can only be between 1 and 0, A is incorrect'),
	assert(flag('Error')),!.
checkvalues :-
	b(X),
	X > 1,
	write('Error Values can only be between 1 and 0, B is incorrect'),
	assert(flag('Error')),!.
checkvalues :-
	carryin(X),
	X > 1,
	write('Error Values can only be between 1 and 0, CarryIn is incorrect'),
	assert(flag('Error')),!.
checkvalues :-
	assert(flag('Good')),
	retract(flag('Good')).
cleanup :-
	retractall(a(_)),
	retractall(b(_)),
	retractall(carryin(_)),
	retractall(flag(_)),
	retractall(and(_,_)),
	retractall(xor(_,_)),
	retractall(and(_)),
	retractall(or(_)),
	retractall(or(_,_)),
	retractall(sum(_)).
