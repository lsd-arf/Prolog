max(X, Y, Z) :- X >= Y, Z is X, !.
max(_, Y, Z) :- Z is Y.

max(X, Y, U, Z) :- X >= Y, X >= U, Z is X, !.
max(_, Y, U, Z) :- Y >= U, Z is Y, !.
max(_, _, U, Z) :- Z is U.

% рекурсия вверх
fact(0, 1) :- !.
fact(N, X) :- N1 is N - 1, fact(N1, X1), X is X1 * N.

% рекурсия вниз
fact(0, CurX, CurX) :- !.
fact(N, CurX, X) :- CurX1 is CurX * N, N1 is N - 1, fact(N1, CurX1, X).
factorial(N, X) :- fact(N, 1, X).

fib(1, 1) :- !.
fib(2, 1) :- !.
fib(N, X) :- N1 is N - 1, N2 is N - 2, fib(N1, X1), fib(N2, X2), X is X1 + X2.

fib(1, CurX1, CurX2, CurX2) :- !.
fib(2, CurX1, CurX2, CurX2) :- !.
fib(N, CurX1, CurX2, X) :- CurX3 is CurX1 + CurX2, N1 is N - 1, fib(N1, CurX2, CurX3, X).
fibonacci(N, X) :- fib(N, 1, 1, X).