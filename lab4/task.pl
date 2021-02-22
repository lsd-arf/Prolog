% читаем список
read_str(N, L) :- read_str(N, 0, [], L), !.
read_str(N, N, L, L) :- !.
read_str(N, CurN, CurL, L) :- 
  CurN1 is CurN + 1, 
  read(X), 
  append(CurL, [X], CurL1), 
  read_str(N, CurN1, CurL1, L).

% выводим список
write_list([]) :- !.
write_list([H|T]) :- 
  write(H), 
  write(" "), 
  write_list(T).