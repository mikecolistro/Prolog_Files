bear(yogi).
cat(tom).
dog(steven).
animal(steven).
animal(yogi).
animal(tom).
likes(colbert,X) :- bear(X), !, fail.
likes(colbert,X) :- animal(X).

