initial_state(jugs,jugs(0,0)).
final_state(jugs(2,C2)).
final_state(jugs(C1,2)).
transition(jugs(C1,C2),fill(j1)).
transition(jugs(C1,C2),fill(j1)).
transition(jugs(C1,C2),fill(j2)).
transition(jugs(C1,C2),empty(j1)) :-
        C1 > 0.
transition(jugs(C1,C2),empty(j2)) :-
        C2 > 0.
transition(jugs(C1,C2),transfer(j2,j1)).
transition(jugs(C1,C2),transfer(j1,j2)).
update(jugs(C1,C2),empty(j1),jugs(0,C2)).
update(jugs(C1,C2),empty(j2),jugs(C1,0)).
update(jugs(C1,C2),fill(j1),jugs(Capacity,C2)) :-
        capacity(j1,Capacity).
update(jugs(C1,C2),fill(j2),jugs(C1,Capacity)) :-
        capacity(j2,Capacity).
update(jugs(C1,C2),transfer(j2,j1),jugs(W1,W2)) :-
        capacity(j1,Capacity),
        Water is C1 + C2,
        Overhang is Water - Capacity ,
        adapt(Water,Overhang,W1,W2).
update(jugs(C1,C2),transfer(j1,j2),jugs(W1,W2)) :-
        capacity(j2,Capacity),
        Water is C1 + C2,
        Overhang is Water - Capacity ,
        adapt(Water,Overhang,W2,W1).
adapt(Water,Overhang,Water,0) :- Overhang =< 0.
adapt(Water,Overhang,C,Overhang) :-
        Overhang > 0,
        C is Water - Overhang.
legal(jugs(C1,C2)).
capacity(j1,4).
capacity(j2,3).


go(Start, Goal) :-
	empty_stack(Empty_been_list),
	stack(Start, Empty_been_list, Been_list),
	path(Start, Goal, Been_list).

	% path implements a depth first search in PROLOG

	% Current state = goal, print out been list
path(Goal, Goal, Been_list) :-
	reverse_print_stack(Been_list).

path(State, Goal, Been_list) :-
	mov(State, Next),
	% not(unsafe(Next)),
	not(member_stack(Next, Been_list)),
	stack(Next, Been_list, New_been_list),
	path(Next, Goal, New_been_list), !.

reverse_print_stack(S) :-
	empty_stack(S).
reverse_print_stack(S) :-
	stack(E, Rest, S),
	reverse_print_stack(Rest),
	write(E), nl.

























