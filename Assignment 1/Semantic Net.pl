prolang(prolog).
prolang(java).
prolang(sml).
natlang(english).
natlang(chinese).
features(prolog,logic).
features(java,objects).
features(lisp,functions).
features(english,letters).
features(chinese,symbols).
invented(prolog,colmeraur).
invented(java,gosling).
invented(lisp,mccarthy).
researches(colmeraur, nlp).
citizen(colmeraur, france).
country(france).
info(X) :-
	prolang(X),
	write(X),
	write(' is a programming language'),
	nl.
info(X) :-
	natlang(X),
	write(X),
	write(' is a natural language '),
	nl.
info(X) :-
	features(X,Y),
	write(X),
	write(' features '),
	write(Y),
	nl.
info(X) :-
	invented(Y,X),
	write(X),
	write(' invented ' ),
	write(Y),
	nl.
info(X) :-
	researches(X,Y),
	write(X),
	write(' researches '),
	write(Y),
	nl.
info(X):-
	citizen(X,Y),
	write(X),
	write(' is a citizen of '),
	write(Y),
	nl.
info(X):-
	country(X),
	write(X),
	write(' is a country'),
	nl.

start:-
	write('Now what do you want to know about?  '),
	read(X),
	info(X),
	nl.

