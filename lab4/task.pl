% Задание 1
% связываем 2 списка
append_ls([], X, X).
append_ls([H|T1], X, [H|T2]) :- append_ls(T1, X, T2).

% читаем список
read_ls(N, L) :- read_ls(N, 0, [], L), !.
read_ls(N, N, L, L) :- !.
read_ls(N, CurN, CurL, L) :- 
  CurN1 is CurN + 1, 
  read(X), 
  append_ls(CurL, [X], CurL1), 
  read_ls(N, CurN1, CurL1, L).

% выводим список
write_ls([]) :- !.
write_ls([H|T]) :- 
  write(H), 
  write(" "), 
  write_ls(T).

% Задание 2
sum_ls_down([], Sum, Sum) :- !.
sum_ls_down([H|T], CurSum, Sum) :- CurSum1 is CurSum + H, sum_ls_down(T, CurSum1, Sum).
sum_ls_down([H|T], Sum) :- sum_ls_down([H|T], 0, Sum).