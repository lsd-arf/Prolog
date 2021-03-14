% читаем строку
read_str(A, N, Flag) :-
  get0(X),
  r_str(X, A, [], N, 0, Flag).
r_str(-1, A, A, N, N, 1) :- !.
r_str(10, A, A, N, N, 0) :- !.
r_str(X, A, B, N, K, Flag) :-
  K1 is K + 1,
  append(B, [X], B1),
  get0(X1),
  r_str(X1, A, B1, N, K1, Flag).

% выводим строку
write_str([]) :- !.
write_str([H|Tail]) :-
  put(H),
  write_str(Tail).

% читаем набор строк
read_list_str(List) :-
  read_str(A, _, Flag),
  read_list_str([A], List, Flag).
read_list_str(List, List, 1) :- !.
read_list_str(Cur_list, List, 0):-
  read_str(A, _, Flag),
  append(Cur_list, [A], C_l),
  read_list_str(C_l, List, Flag).

% выводим набор строк
write_list_str([]) :- !.
write_list_str([H|T]) :-
  write_str(H), nl,
  write_list_str(T).

see0 :- see('C:/Users/Владислав/Desktop/Prolog/lab8/in.txt').
tell0 :- tell('C:/Users/Владислав/Desktop/Prolog/lab8/out.txt').

% количество символов в списке
count_els([], Count, Count) :- !.
count_els([_|T], CurCount, Count) :- 
  CurCount1 is CurCount + 1, 
  count_els(T, CurCount1, Count).
count_els(List, Count) :- count_els(List, 0, Count).

% длина максимальной строки
length_of_max_line([], Max, Max) :- !.
length_of_max_line([BigH|BigT], CurMax, Max) :-
  count_els(BigH, Count),
  (Count > CurMax ->
  CurMax1 is Count;
  CurMax1 is CurMax),
  length_of_max_line(BigT, CurMax1, Max).
length_of_max_line(BigList, Max) :- length_of_max_line(BigList, 0, Max).

% количество пробелов в строке
count_spaces([], Count, Count) :- !.
count_spaces([H|T], CurCount, Count) :- 
  (H = 32 -> 
  CurCount1 is CurCount + 1;
  CurCount1 is CurCount),
  count_spaces(T, CurCount1, Count).

% количество строк без пробелов
count_lines_without_spaces([], Count, Count) :- !.
count_lines_without_spaces([BigH|BigT], CurCount, Count) :- 
  ((count_spaces(BigH, 0, C), C = 0) ->
  CurCount1 is CurCount + 1;
  CurCount1 is CurCount),
  count_lines_without_spaces(BigT, CurCount1, Count).

t1_1 :-
  see0, read_list_str(List), 
  length_of_max_line(List, Max),
  seen, write("Max length -> "), write(Max).