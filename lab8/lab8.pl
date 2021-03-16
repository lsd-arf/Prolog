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

see0 :- see('C:/Users/¬ладислав/Desktop/Prolog/lab8/in.txt').
tell0 :- tell('C:/Users/¬ладислав/Desktop/Prolog/lab8/out.txt').

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

% «адание 1.1
t1_1 :-
  see0, read_list_str(List), 
  length_of_max_line(List, Max),
  seen, write("Max length => "), write(Max).

% «адание 1.2
t1_2 :-
  see0, read_list_str(List),
  count_lines_without_spaces(List, 0, Count),
  seen, write("Count => "), write(Count).

% «адание 1.3
% файл в виде листа из символов
list_file([], List, List) :- !.
list_file([H|T], CurList, List) :-
  append(CurList, H, CurList1),
  list_file(T, CurList1, List).
list_file(ListString, List) :- list_file(ListString, [], List).

% количество заданных символов в листе (здесь буква A)
count_chr_in([], _, Count, Count) :- !.
count_chr_in([H|T], Chr, CurCount, Count) :-
  (H = Chr ->
  CurCount1 is CurCount + 1;
  CurCount1 is CurCount),
  count_chr_in(T, Chr, CurCount1, Count).
count_chr_in(List, Chr, Count) :- count_chr_in(List, Chr, 0, Count).
count_chr_in(List, Count) :- count_chr_in(List, 65, Count).

% лист из строк, где кол-во букв A больше среднего на файл
list_where_A_more_than_AVG([], _, List, List) :- !.
list_where_A_more_than_AVG([H|T], Count, CurList, List) :-
  count_chr_in(H, CurCount),
  (CurCount > Count ->
  append(CurList, [H], CurList1);
  CurList1 = CurList),
  list_where_A_more_than_AVG(T, Count, CurList1, List).
list_where_A_more_than_AVG(ListString, Count, List) :- list_where_A_more_than_AVG(ListString, Count, [], List).

t1_3 :-
  see0, read_list_str(ListString),
  list_file(ListString, List),
  count_chr_in(List, CountChr),
  count_els(ListString, CountString),
  (CountString \= 0 ->
  AVG is CountChr / CountString;
  fail),
  list_where_A_more_than_AVG(ListString, AVG, ListWhere),
  write_list_str(ListWhere), seen.

% «адание 1.4
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

% получаем первое слово несмотр€ на пробелы
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

% число раз, которое повтор€етс€ заданный элемент в списке
count_equals([], _, Count, Count) :- !.
count_equals([H|T], El, CurCount, Count) :- 
  (H = El -> 
  CurCount1 is CurCount + 1; 
  CurCount1 is CurCount), 
  count_equals(T, El, CurCount1, Count).
count_equals(List, El, Count) :- count_equals(List, El, 0, Count).

% слово, которое встречаетс€ чаще всего
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
  see0, read_list_str(List),
  list_of_words_file(List, LWF),
  regular_word(LWF, Word),
  write("Regular word => ["),
  write_str(Word),
  write("]"), seen.

% «адание 1.5
% номер первого вхождени€ элемента
ls_num_el([H], El, CurNum, Num) :- 
  ((H = El) -> 
  Num is CurNum + 1; 
  write("Such element isn\'t found")), !.
ls_num_el([H|T], El, CurNum, Num) :- 
  CurNum1 is CurNum + 1, 
  ((El = H) -> 
  Num is CurNum1; 
  ls_num_el(T, El, CurNum1, Num)).
ls_num_el([H|T], El, Num) :- ls_num_el([H|T], El, 0, Num).

% номер элемента в списке
ls_el_at_num([], _, _, _) :- write("Such element isn\'t found"), !.
ls_el_at_num([_], CurNum, Num, _) :- 
  CurNum1 is CurNum + 1, 
  CurNum1 < Num, 
  write("Such element isn\'t found"), !.
ls_el_at_num([H|T], CurNum, Num, El) :- 
  CurNum1 is CurNum + 1, 
  ((CurNum1 is Num) -> 
  El is H; 
  ls_el_at_num(T, CurNum1, Num, El)).
ls_el_at_num([H|T], Num, El) :- ls_el_at_num([H|T], 0, Num, El).

% есть ли элемент в списке
in_ls([H|_], H) :- !.
in_ls([_|T], El) :- in_ls(T, El).

% получаем лист без элемента
rm_el([_|T], CurList, Num, Num, NewList) :- append(CurList, T, NewList), !.
rm_el([H|T], CurList, CurNum, Num, NewList) :- 
  append(CurList, [H], CurList1), 
  CurNum1 is CurNum + 1, 
  rm_el(T, CurList1, CurNum1, Num, NewList).
rm_el(List, Num, NewList) :- rm_el(List, [], 1, Num, NewList).

% удаление одинаковых с заданным элементов
rm_equals(List, El, List) :- not(in_ls(List, El)), !.
rm_equals(List, El, NewList) :- 
  ls_num_el(List, El, Num), 
  rm_el(List, Num, List1), 
  rm_equals(List1, El, NewList).

% получаем лист из уникальных элементов
uni_list([], []) :- !.
uni_list([H|T], List) :-
  rm_equals(T, H, RmList),
  uni_list(RmList, List1),
  append([H], List1, List).

% лист из неповтор€ющихс€ элементов
list_norepeat(_, [], List, List) :- !.
list_norepeat(BigList, [UniH|UniT], CurList, NewList) :-
  count_equals(BigList, UniH, Count),
  (Count = 1 ->
  append(CurList, [UniH], CurList1);
  CurList1 = CurList),
  list_norepeat(BigList, UniT, CurList1, NewList).
list_norepeat(BigList, UniList, NewList) :- list_norepeat(BigList, UniList, [], NewList).

t1_5 :-
  see0,
  read_list_str(ListStr),
  list_of_words_file(ListStr, LWF),
  uni_list(LWF, LWFUNI),
  list_norepeat(LWF, LWFUNI, LWFNR),
  seen,
  tell0,
  write_list_str(LWFNR),
  told.

% «адание 2.12
% цифры в начале, буквы в конце
digits_first_letters_second([], ListDigits, ListLetters, List) :- append(ListDigits, ListLetters, List), !.
digits_first_letters_second([H|T], ListDigits, ListLetters, List) :-
  ((H >= 48, H =< 57) ->
  (append(ListDigits, [H], ListDigits1),
  ListLetters1 = ListLetters);
  (append(ListLetters, [H], ListLetters1),
  ListDigits1 = ListDigits)),
  digits_first_letters_second(T, ListDigits1, ListLetters1, List).
digits_first_letters_second(List, NewList) :- digits_first_letters_second(List, [], [], NewList).

t2_12 :-
  write("Str -> "),
  read_str_nofix(S),
  digits_first_letters_second(S, NewS),
  write("New Str => ["),
  write_str(NewS),
  write("]").

% «адание 2.13
% псевдослучайное перемешивание листа из слов
random_list_words([H1, H2], CurList, List) :-
  count_els(H1, Count1),
  count_els(H2, Count2),
  ((0 is (Count1 + Count2) mod 2) ->
  append(CurList, [H1, H2], List);
  append(CurList, [H2, H1], List)), !.
random_list_words([H1], CurList, List) :-
  count_els(H1, Count1),
  ((0 is Count1 mod 2) ->
  append(CurList, [H1], List);
  append([H1], CurList, List)), !.
random_list_words([], List, List) :- !.
random_list_words([H1|[H2|[H3|T]]], CurList, List) :-
  count_els(H1, Count1),
  count_els(H2, Count2),
  count_els(H3, Count3),
  ((0 is (Count1 + Count2 + Count3) mod 2) ->
  append(CurList, [H3, H1, H2], CurList1);
  append(CurList, [H2, H3, H1], CurList1)),
  random_list_words(T, CurList1, List).
random_list_words(List, NewList) :- random_list_words(List, [], NewList).

% составим список слов
% далее будет вытаскивать слово из списка и ставить после него пробел
% после последнего слова списка пробел не ставим
str_with1space([], Str, Str) :- write("Str hasn\'t words"), !.
str_with1space([H], CurStr, Str) :- append(CurStr, H, Str), !.
str_with1space([H|T], CurStr, Str) :-
  append(H, [32], H1),
  append(CurStr, H1, CurStr1),
  str_with1space(T, CurStr1, Str).
str_with1space(List, Str) :- str_with1space(List, [], Str).

t2_13 :-
  write("Str -> "),
  read_str_nofix(S),
  list_of_words(S, LW),
  random_list_words(LW, RLW),
  str_with1space(RLW, NewS),
  write("New Str => ["),
  write_str(NewS),
  write("]").