cost(cornflakes,230).
cost(cocacola,210).
cost(chocolate,250).
cost(crisps,190).

total_cost([],0).
cost([Item|Rest],Cost) :-
	cost(Item, ItemCost),
	total_cost(Rest,CostofRest),
	Cost is ItemCost + CostOfRest.

