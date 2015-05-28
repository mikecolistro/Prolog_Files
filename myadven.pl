
room(kitchen).
room(office).
room(hall).
room('dining room').
room(cellar).
location(desk, office).
location(apple, kitchen).
location(flashlight, desk).
location('washing machine', cellar).
location(nani, 'washing machine').
location(broccoli, kitchen).
location(crackers, kitchen).
location(computer, office).
door(office,hall).
door(kitchen,office).
door(hall, 'dining room').
door(kitchen,cellar).
door('dining room',kitchen).
edible(apple).
edible(crackers).
tastes_yucky(broccoli).
turned_off(flashlight).
:- dynamic
	here/1.
here(kitchen).
where_food(X,Y) :-
	location(X,Y),
	edible(X).
where_food(X,Y) :-
	location(X,Y),
	tastes_yucky(X).
connect(X,Y) :- door(X,Y).
connect(X,Y) :- door(Y,X).
list_things(Place):-
	location(X,Place),
	tab(2),
	write(X),
	nl,
	fail.
list_things(_).
list_connections(Place) :-
  connect(Place, X),
  tab(2),
  write(X),
  nl,
  fail.
list_connections(_).
look :- here(Place),
  write('You are in the '), write(Place), nl,
  write('You can see:'), nl,
  list_things(Place),
  write('You can go to:'), nl,
  list_connections(Place).
goto(Place) :-
	can_go(Place),
	move(Place),
	look.
can_go(Place):-
	here(X),
	connect(X,Place).
can_go(Place):-
  write('You can''t get there from here.'), nl,
  fail.
move(Place):-
  retract(here(X)),
  asserta(here(Place)).
take(X):-
	can_take(X),
	take_object(X).
can_take(Thing) :-
  here(Place),
  location(Thing, Place).
can_take(Thing) :-
  write('There is no '), write(Thing),
  write(' here.'),
  nl, fail.
take_object(X):-
  retract(location(X,_)),
  asserta(have(X)),
  write('taken'), nl.
location(envelope, desk).
location(stamp, envelope).
location(key, envelope).
is_contained_in(T1,T2):-
	location(T1,T2).
is_contained_in(T1,T2) :-
  location(X,T2),
  is_contained_in(T1,X).
location_s(object(candle, red, small, 1), kitchen).
location_s(object(apple, red, small, 1), kitchen).
location_s(object(apple, green, small, 1), kitchen).
location_s(object(table, blue, big, 50), kitchen).
can_take_s(Thing) :-
  here(Room),
  location_s(object(Thing, _, small,_), Room).
can_take_s(Thing) :-
  here(Room),
  location_s(object(Thing, _, big, _), Room),
  write('The '), write(Thing),
  write(' is too big to carry.'), nl,
  fail.
can_take_s(Thing) :-
  here(Room),
  not(location_s(object(Thing, _, _, _), Room)),
  write('There is no '), write(Thing), write(' here.'), nl,
  fail.

list_things_s(Place) :-
  location_s(object(Thing, Color, Size, Weight),Place),
  write('A '),write(Size),tab(1),
  write(Color),tab(1),
  write(Thing), write(', weighing '),
  write_weight(Weight), nl,
  fail.
list_things_s(_).
write_weight(1) :-
  write('1 pound').
write_weight(W) :-
  W > 1,
  write(W), write(' pounds').
loc_list([apple, broccoli, crackers], kitchen).
loc_list([desk, computer], office).
loc_list([flashlight, envelope], desk).
loc_list([stamp, key], envelope).
loc_list(['washing machine'], cellar).
loc_list([nani], 'washing machine').
loc_list([], hall).
member(H,[H|T]).
member(X,[H|T]) :- member(X,T).

location(X,Y):-
  loc_list(List, Y),
  member(X, List).
add_thing(NewThing, Container, NewList):-
  loc_list(OldList, Container),
  append([NewThing],OldList, NewList).
