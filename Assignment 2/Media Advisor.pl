envpaper :-
	environment(X),
	X = paper,!.
envpaper :-
	environment(X),
	X = manuals,!.

envpaper :-
	environment(X),
	X = documents,!.

envpaper :-
	environment(X),
	X = textbooks,!.

envphoto :-
	environment(X),
	X = pictures,!.
envphoto :-
	environment(X),
	X = illustartions,!.
envphoto :-
	environment(X),
	X = photographs,!.
envphoto :-
	environment(X),
	X = diagrams,!.

envphysical :-
	environment(X),
	X = machines,!.
envphysical :-
	environment(X),
	X = buildings,!.
envphysical :-
	environment(X),
	X = tools,!.

envnumerical :-
	environment(X),
	X = numbers,!.
envnumerical :-
	environment(X),
	X = formulas,!.
envnumerical :-
	environment(X),
	X = 'computer programs',!.
rule :-
	envnumerical,
	assert(stimulus_situation(symbolic)),!.
rule :-
	envphysical,
	assert(stimulus_situation('physical object')),!.
rule:-
	envphoto,
	assert(stimulus_situation(visual)),!.
rule:-
	envpaper,
	assert(stimulus_situation(verbal)),!.
rule:-
	nl,nl,
	write('I am unable to draw any conclusions on the basis of the data'),nl.
joboral :-
	job(X),
	X = lecturing,!.
joboral :-
	job(X),
	X = advising,!.
joboral :-
	job(X),
	X = counceling,!.
jobhands :-
	job(X),
	X = building,!.
jobhands :-
	job(X),
	X = repairing,!.
jobhands :-
	job(X),
	X = troubleshooting,!.
jobdocumented :-
	job(X),
	X = writing,!.
jobdocumented :-
	job(X),
	X = typing,!.
jobdocumented :-
	job(X),
	X = drawing,!.
jobanalytical :-
	job(X),
	X = evaluating,!.
jobanalytical :-
	job(X),
	X = reasoning,!.
jobanalytical :-
	job(X),
	X = investigating,!.
rule2 :-
	jobanalytical,
	assert(stimulus_response(jobanalytical)),!.
rule2 :-
	jobdocumented,
	assert(stimulus_response(documented)),!.
rule2 :-
	jobhands,
	assert(stimulus_response('hands on')),!.
rule2 :-
	joboral,
	assert(stimulus_response(oral)),!.
rule2 :-
	nl,nl,
	write('I am unable to draw any conclusions on the basis of the data'),nl.
stimcheck :-
	stimulus_situation(X),
	stimulus_response(Y),
	feedback(Z),
	X = 'physical object',
	Y = 'hands on',
	Z = required,
	assert(medium(workshop)),!.
stimcheck :-
	stimulus_situation(X),
	stimulus_response(Y),
	feedback(Z),
	X = symbolic,
	Y = analytical,
	Z = required,
	assert(medium('lecture-tutorial')),!.
stimcheck :-
	stimulus_situation(X),
	stimulus_response(Y),
	feedback(Z),
	X = visual,
	Y = documented,
	Z = 'not required',
	assert(medium(videocasette)),!.

stimcheck :-
	stimulus_situation(X),
	stimulus_response(Y),
	feedback(Z),
	X = visual,
	Y = oral,
	Z = required,
	assert(medium('lecture-tutorial')),!.

stimcheck :-
	stimulus_situation(X),
	stimulus_response(Y),
	feedback(Z),
	X = verbal,
	Y = analytical,
	Z = required,
	assert(medium('lecture-tutorial')),!.

stimcheck :-
	stimulus_situation(X),
	stimulus_response(Y),
	feedback(Z),
	X = verbal,
	Y = oral,
	Z = required,
	assert(medium('role-play exercises')),!.

start :-
	write('Q:What sort of environment is a trainee dealing with on the job?'),
	nl,
	write('A: '),
	read(X),
	assert(environment(X)),
	nl,
	write('Q:In what way is a trainee expected to act or respond on the job?'),
	nl,
	write('A: '),
	read(Y),
	assert(job(Y)),
	write('Q:Is feedback on the trainee\'s progress required or not required?'),
	nl,
	write('A: '),
	read(Z),
	assert(feedback(Z)),
	rule,
	rule2,
	stimcheck,
	nl,
	write('Output: medium is '),
	medium(T),
	write(T),!.


cleanup:-
	retractall(environment(_)),
	retractall(stimulus_situation(_)),
	retractall(stimulus_response(_)),
	retractall(job(_)),
	retractall(medium(_)).
