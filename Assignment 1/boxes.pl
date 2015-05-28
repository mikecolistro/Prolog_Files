person(dina).
person(william).
person(charlie).
person(daniel).
person(sam).
colour(black).
colour(white).
size(2).
size(4).
size(6).
%box(person(X),black,6).
%box(person(X),black,2).
%box(person(X),white,2).
%box(person(X),black,4).
%box(person(X),white,6).
firstrule :-
	colour(X),
	assert(box(dina,X,Y)),
	assert(box(william,X,Z)),!.
secondrule :-
	colour(X),
	box(dina,T,_),
	not(X =T),
	assert(box(daniel,X,Y)),
	assert(box(sam,X,Z)),!.
thirdrule :-
	size(X),
	box(daniel,Z,X),
	assert(box(charlie,Y,X)).
fourthrule :-
	box(sam,W,X),
	box(william,Z,Y),
	X < Y.

cleanup :-
	retractall(box(_,_,_)).














