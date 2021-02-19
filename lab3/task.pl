max(X,Y,Z):- X>=Y, Z is X, !.
max(_,Y,Z):- Z is Y.

max(X,Y,U,Z):- X>=Y, X>=U, Z is X, !.
max(_,Y,U,Z):- Y>=U, Z is Y, !.
max(_,_,U,Z):- Z is U.
% рекурсия вверх
fact(0,1):- !.
fact(N,X):- N1 is N-1, fact(N1, X1), X is X1*N.