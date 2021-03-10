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
count_words([], CountWords, CountWords) :- !.
count_words(List, CurCountWords, CountWords) :-
  list_nofirstspaces(List, ListNoFirstSpaces),
  (ListNoFirstSpaces \= [] ->
  (firstword(ListNoFirstSpaces, FirstWord),
  append(FirstWord, ListNoFirstWord, ListNoFirstSpaces),
  CurCountWords1 is CurCountWords + 1);
  (ListNoFirstWord = [],
  CurCountWords1 is CurCountWords)),
  count_words(ListNoFirstWord, CurCountWords1, CountWords).