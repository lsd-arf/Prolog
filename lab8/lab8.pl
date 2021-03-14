% читаем строку нефиксированной длины (пока не встретим enter)
read_str_nofix(A) :-
  get0(X),
  r_str_nofix(X, A, []).
r_str_nofix(10, A, A) :- !.
r_str_nofix(-1, A, A) :- !.
r_str_nofix(X, A, B) :-
  append(B, [X], B1),
  get0(X1),
  r_str_nofix(X1, A, B1).

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

% количество элементов в списке
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

% Задание 1.1
t1_1 :-
  see0, read_list_str(List), 
  length_of_max_line(List, Max),
  seen, write("Max length => "), write(Max).

% Задание 1.2
t1_2 :-
  see0, read_list_str(List),
  count_lines_without_spaces(List, 0, Count),
  seen, write("Count => "), write(Count).

% Задание 1.4
% получаем строку без первых пробелов
list_nofirstspaces([], []) :- !.
list_nofirstspaces([H|T], [H|T]) :- H \= 32, !.
list_nofirstspaces([_|T], NewList) :- list_nofirstspaces(T, NewList).

% получаем слово до первого пробела (работает, если в начале нет пробелов)
firstword([], Word, Word) :- !.
firstword([H|_], Word, Word) :- H = 32, !.
firstword([H|T], CurWord, NewWord) :-
  append(CurWord, [H], CurWord1),
  firstword(T, CurWord1, NewWord).
firstword(List, Word) :- firstword(List, [], Word).

% получаем первое слово несмотря на пробелы
firstword_nfs(List, Word) :-
  list_nofirstspaces(List, ListNFS),
  firstword(ListNFS, Word).

% получаем список слов из строки
list_of_words(List, LW, LW) :-
  list_nofirstspaces(List, ListNFS),
  ListNFS = [], !.
list_of_words(Str, CurLW, LW) :-
  list_nofirstspaces(Str, StrNFS),
  firstword(StrNFS, Word),
  append(Word, StrNoWord, StrNFS),
  append(CurLW, [Word], CurLW1),
  list_of_words(StrNoWord, CurLW1, LW).
list_of_words(Str, LW) :- list_of_words(Str, [], LW).

% получаем список слов из файла
list_of_words_file([], LWF, LWF) :- !.
list_of_words_file([H|T], CurLWF, LWF) :-
  list_of_words(H, LW),
  append(CurLWF, LW, CurLWF1),
  list_of_words_file(T, CurLWF1, LWF).
list_of_words_file(ListOfLines, LWF) :- list_of_words_file(ListOfLines, [], LWF).

% число раз, которое повторяется заданный элемент в списке
count_equals([], _, Count, Count) :- !.
count_equals([H|T], El, CurCount, Count) :- 
  (H = El -> 
  CurCount1 is CurCount + 1; 
  CurCount1 is CurCount), 
  count_equals(T, El, CurCount1, Count).
count_equals(List, El, Count) :- count_equals(List, El, 0, Count).

% слово, которое встречается чаще всего
regular_word([], _, Word, Word) :- !.
regular_word([H|T], Count, CurWord, Word) :-
  count_equals([H|T], H, Count1),
  (Count1 > Count ->
  (CurWord1 = H,
  Count2 = Count1);
  (CurWord1 = CurWord,
  Count2 = Count)),
  regular_word(T, Count2, CurWord1, Word).
regular_word(List, Word) :- regular_word(List, 0, [], Word).

t1_4 :-
  see0, read_list_str(List), seen,
  list_of_words_file(List, LWF),
  regular_word(LWF, Word),
  write("Regular word => ["),
  write_str(Word),
  write("]").