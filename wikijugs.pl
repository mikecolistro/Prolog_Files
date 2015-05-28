% The Water Jugs Problem
% ======================
%
% This classic AI problem is described in Artificial Intelligence as
% follows:
%
%   "You are given two jugs, a 4-gallon one and a 3-gallon one. Neither
%   has any measuring markers on it. There is a tap that can be used to
%   fill the jugs with water. How can you get exactly 2 gallons of water
%   into the 4-gallon jug?". E. Rich & K. Knight, Artificial Intelligence,
%   2nd edition, McGraw-Hill, 1991
%
% This program implements an "environmentally responsible" solution to the
% water jugs problem. Rather than filling and spilling from an infinite
% water resource, we conserve a finite initial charge with a third jug:
% (reservoir).
%
% This approach is simpler than the traditional method, because there are
% only two actions; it is more flexible than the traditional method,
% because it can solve problems that are constrained by a limited supply
% from the reservoir.
%
% To simulate the infinite version, we use a filled reservoir with a
% capacity greater than the combined capacities of the jugs, so that the
% reservoir can never be emptied.
%
%   "Perfection is achieved not when there is nothing more to add, but
%   when there is nothing more to take away." Antoine de Saint-Exupéry
%
% Solution
% --------
%
% water_jugs
%
% is the entry point. The solution is derived by a simple, breadth-first,
% state-space search; and translated into a readable format by a DCG.

water_jugs :-
     SmallCapacity = 3,
     LargeCapacity = 4,
     Reservoir is SmallCapacity + LargeCapacity + 1,
     volume( small, Capacities, SmallCapacity ),
     volume( large, Capacities, LargeCapacity ),
     volume( reservoir, Capacities, Reservoir ),
     volume( small, Start, 0 ),
     volume( large, Start, 0 ),
     volume( reservoir, Start, Reservoir ),
     volume( large, End, 2 ),
     water_jugs_solution( Start, Capacities, End, Solution ),
     phrase( narrative(Solution, Capacities, End), Chars ),
     put_chars( Chars ).

% water_jugs_solution( +Start, +Capacities, +End, ?Solution )
%
% holds when Solution is the terminal 'node' in a state-space search -
% beginning with a 'start state' in which the water-jugs have Capacities
% and contain the Start volumes. The terminal node is reached when the
% water-jugs contain the End volumes.

water_jugs_solution( Start, Capacities, End, Solution ) :-
     solve_jugs( [start(Start)], Capacities, [], End, Solution ).

% solve_jugs( +Nodes, +Capacities, +Visited, +End, ?Solution )
%
% holds when Solution is the terminal 'node' in a state-space search,
% beginning with a first 'open' node in Nodes, and terminating when the
% water-jugs contain the End volumes. Capacities define the capacities of
% the water-jugs, while Visited is a list of expanded ('closed') node
% states.
%
% The 'breadth-first' operation of solve_jugs is due to the 'existing'
% Nodes being appended to the 'new' nodes. (If the 'new' nodes were
% appended to the 'existing' nodes, the operation would be 'depth-first'.)

solve_jugs( [Node|Nodes], Capacities, Visited, End, Solution ) :-
     node_state( Node, State ),
     ( State = End ->
         Solution = Node
     ; otherwise ->
         findall(
             Successor,
             successor(Node, Capacities, Visited, Successor),
             Successors
             ),
         append( Nodes, Successors, NewNodes ),
         solve_jugs( NewNodes, Capacities, [State|Visited], End, Solution )
     ).

% successor( +Node, +Capacities, +Visited, ?Successor )
%
% Successor is a successor of Node, for water-jugs with Capacities, if
% there is a legal 'transition' from Node's state to Successor's state,
% and Successor's state is not a member of the Visited states.

successor( Node, Capacities, Visited, Successor ) :-
     node_state( Node, State ),
     Successor = node(Action,State1,Node),
     jug_transition( State, Capacities, Action, State1 ),
     \+ member( State1, Visited ).

% Transition Rules
%
% jug_transition( +State, +Capacities, ?Action, ?SuccessorState )
%
% holds when Action describes a valid transition, from State to
% SuccessorState, for water-jugs with Capacities.
%
% There are two sorts of Action:
%
% -   empty_into(Source,Target) valid if Source is not already empty and
%     the combined contents from Source and Target, (in State), are not
%     greater than the capacity of the Target jug. In SuccessorState:
%     Source becomes empty, while the Target jug acquires the combined
%     contents of Source and Target in State.
% -   fill_from(Source,Target) valid if Source is not already empty and
%     the combined contents from Source and Target, (in State), are
%     greater than the capacity of the Target jug. In SuccessorState: the
%     Target jug becomes full, while Source retains the difference between
%     the combined contents of Source and Target, in State, and the
%     capacity of the Target jug.
%
% In either case, the contents of the unused jug are unchanged.

jug_transition( State0, Capacities, empty_into(Source,Target), State1 ) :-
     volume( Source, State0, Content0 ),
     Content0 > 0,
     jug_permutation( Source, Target, Unused ),
     volume( Target, State0, Content1 ),
     volume( Target, Capacities, Capacity ),
     Content0 + Content1 =< Capacity,
     volume( Source, State1, 0 ),
     volume( Target, State1, Content2 ),
     Content2 is Content0 + Content1,
     volume( Unused, State0, Unchanged ),
     volume( Unused, State1, Unchanged ).
jug_transition( State0, Capacities, fill_from(Source,Target), State1 ) :-
     volume( Source, State0, Content0 ),
     Content0 > 0,
     jug_permutation( Source, Target, Unused ),
     volume( Target, State0, Content1 ),
     volume( Target, Capacities, Capacity ),
     Content1 < Capacity,
     Content0 + Content1 > Capacity,
     volume( Source, State1, Content2 ),
     volume( Target, State1, Capacity ),
     Content2 is Content0 + Content1 - Capacity,
     volume( Unused, State0, Unchanged ),
     volume( Unused, State1, Unchanged ).

% Data Abstraction
% ----------------
%
% volume( ?Jug, ?State, ?Volume )
%
% holds when Jug ('large', 'small' or 'reservoir') has Volume in State.

volume( small, jugs(Small, _Large, _Reservoir), Small ).
volume( large, jugs(_Small, Large, _Reservoir), Large ).
volume( reservoir, jugs(_Small, _Large, Reservoir), Reservoir ).

% jug_permutation( ?Source, ?Target, ?Unused )
%
% holds when Source, Target and Unused are a permutation of 'small',
% 'large' and 'reservoir'.

jug_permutation( Source, Target, Unused ) :-
     select( Source, [small, large, reservoir], Residue ),
     select( Target, Residue, [Unused] ).

% node_state( ?Node, ?State )
%
% holds when the contents of the water-jugs at Node are described by
% State.

node_state( start(State), State ).
node_state( node(_Transition, State, _Predecessor), State ).

% Definite Clause Grammar
% -----------------------
%
% narrative/5
%
% is a DCG presenting water-jugs solutions in a readable format. The
% grammar is 'head-recursive', because the 'nodes list', describing the
% solution, has the last node outermost.

narrative( start(Start), Capacities, End ) -->
     "Given three jugs with capacities of:", newline,
     literal_volumes( Capacities ),
     "To obtain the result:", newline,
     literal_volumes( End ),
     "Starting with:", newline,
     literal_volumes( Start ),
     "Do the following:", newline.
narrative( node(Transition, Result, Predecessor), Capacities, End ) -->
     narrative( Predecessor, Capacities, End ),
     literal_action( Transition, Result ).

literal_volumes( Volumes ) -->
     indent, literal( Volumes ), ";", newline.

literal_action( Transition, Result ) -->
     indent, "- ", literal( Transition ), " giving:", newline,
     indent, indent, literal( Result ), newline.

literal( empty_into(From,To) ) -->
     "Empty the ", literal( From ), " into the ",
     literal( To ).
literal( fill_from(From,To) ) -->
     "Fill the ", literal( To ), " from the ",
     literal( From ).
literal( jugs(Small,Large,Reservoir) ) -->
     literal_number( Small ), " gallons in the small jug, ",
     literal_number( Large ), " gallons in the large jug and ",
     literal_number( Reservoir ), " gallons in the reservoir".
literal( small ) --> "small jug".
literal( large ) --> "large jug".
literal( reservoir ) --> "reservoir".

literal_number( Number, Plus, Minus ) :-
     number( Number ),
     number_chars( Number, Chars ),
     append( Chars, Minus, Plus ).

indent --> "  ".

newline --> "
 ".

% Utility Predicates
% ------------------
%
% Load a small library of puzzle utilities.
