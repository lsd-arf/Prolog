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

% количество элементов в списке
count_els([], Count, Count) :- !.
count_els([_|T], CurCount, Count) :- 
  CurCount1 is CurCount + 1, 
  count_els(T, CurCount1, Count).
count_els(List, Count) :- count_els(List, 0, Count).

% количество символов в строке
count_chrs([], Count, Count) :- !.
count_chrs([H|T], CurCount, Count) :- 
  (H = 32 ->
  CurCount1 is CurCount;
  CurCount1 is CurCount + 1), 
  count_chrs(T, CurCount1, Count).
count_chrs(List, Count) :- count_chrs(List, 0, Count).

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

% Задание 2
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

% считаем количество слов
% убираем первые пробелы
% если новый список не пустой, убираем слово, считаем + 1
% иначе слов не осталось, ничего не считаем
% кидаем новый ListNoFirstWord или с (пробелами + словами), или пустой
count_words([], Count, Count) :- !.
count_words(List, CurCount, Count) :-
  list_nofirstspaces(List, ListNoFirstSpaces),
  (ListNoFirstSpaces \= [] ->
  (firstword(ListNoFirstSpaces, FirstWord),
  append(FirstWord, ListNoFirstWord, ListNoFirstSpaces),
  CurCount1 is CurCount + 1);
  (ListNoFirstWord = [],
  CurCount1 is CurCount)),
  count_words(ListNoFirstWord, CurCount1, Count).
count_words(List, Count) :- count_words(List, 0, Count).

task2 :-
  write("Str -> "),
  read_str_nofix(S),
  write("Count of words => "),
  count_words(S, Count),
  write(Count).

% Задание 3
% получаем первое слово несмотря на пробелы
firstword_nfs(List, Word) :-
  list_nofirstspaces(List, ListNFS),
  firstword(ListNFS, Word).

% получаем список слов
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

% одинаковые ли списки
lists_equals([], []) :- !.
lists_equals([H|T1], [H|T2]) :- lists_equals(T1, T2).

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
  CurWord1 = H;
  CurWord1 = CurWord),
  regular_word(T, Count1, CurWord1, Word).
regular_word(List, Word) :- regular_word(List, 0, [], Word).

task3 :-
  write("Str -> "),
  read_str_nofix(S),
  list_of_words(S, LW),
  regular_word(LW, Word),
  write("Regular word => "),
  write_str(Word).