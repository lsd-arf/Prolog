% читаем строку фиксированной длины (пока не встретим enter)
read_str_fix(A, N) :-
  get0(X),
  r_str_fix(X, A, [], N, 0).
r_str_fix(10, A, A, N, N) :- !.
r_str_fix(X, A, B, N, K) :-
  K1 is K + 1,
  append(B, [X], B1),
  get0(X1),
  r_str_fix(X1, A, B1, N, K1).

% выводим строку
write_str([]) :- !.
write_str([H|Tail]):-
  put(H),
  write_str(Tail).

% читаем строку нефиксированной длины (пока не встретим enter)
read_str_nofix(A) :-
  get0(X),
  r_str_nofix(X, A, []).
r_str_nofix(10, A, A) :- !.
r_str_nofix(X, A, B) :-
  append(B, [X], B1),
  get0(X1),
  r_str_nofix(X1, A, B1).

% количество элементов в строке
count_els([], Count, Count) :- !.
count_els([_|T], CurCount, Count) :- 
  CurCount1 is CurCount + 1, 
  count_els(T, CurCount1, Count).
count_els(List, Count) :- count_els(List, 0, Count).

% Задание 1
task1 :-
  write("Str -> "),
  read_str_nofix(S),
  write_str(S),
  write(", "),
  write_str(S),
  write(", "),
  write_str(S), nl,
  write("Elements => "),
  count_els(S, Count),
  write(Count).