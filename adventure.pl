mortal(X) :- person(X). %For all X, X is mortal if X is a person
person(socrates).%socrates is a person
person(plato).
person(zeno).
person(aristotle).
mortal_report:-
	write('Known mortals are:'),nl,
	mortal(X),
	write(X),nl,
	fail.

