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

% Задание 1.3
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
  see0, read_list_str(List),
  list_of_words_file(List, LWF),
  regular_word(LWF, Word),
  write("Regular word => ["),
  write_str(Word),
  write("]"), seen.

% Задание 1.5
% номер первого вхождения элемента
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

% лист из неповторяющихся элементов
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

% Задание 2.6
% псевдослучайное перемешивание листа из символов
random_list_chrs([H1, H2], CurList, List) :-
  ((0 is (H1 + H2) mod 3) ->
  append(CurList, [H1, H2], List);
  append(CurList, [H2, H1], List)), !.
random_list_chrs([H1], CurList, List) :-
  ((0 is H1 mod 3) ->
  append(CurList, [H1], List);
  append([H1], CurList, List)), !.
random_list_chrs([], List, List) :- !.
random_list_chrs([H1|[H2|[H3|T]]], CurList, List) :-
  ((0 is (H1 + H2 + H3) mod 3) ->
  append(CurList, [H3, H1, H2], CurList1);
  append(CurList, [H2, H3, H1], CurList1)),
  random_list_chrs(T, CurList1, List).
random_list_chrs(List, NewList) :- random_list_chrs(List, [], NewList).

% мешаем в каждом слове символы между первым и последним
words_rnd_chrs([], Words, Words) :- !.
words_rnd_chrs([H|T], CurWords, Words) :-
  count_els(H, Count),
  ((Count >= 1, Count =< 3) ->
  append(CurWords, [H], CurWords1);
  (append([First|HNoFirstNoLast], [Last], H),
  random_list_chrs(HNoFirstNoLast, RandomList),
  append([First|RandomList], [Last], RandomH),
  append(CurWords, [RandomH], CurWords1))),
  words_rnd_chrs(T, CurWords1, Words).
words_rnd_chrs(Words, NewWords) :- words_rnd_chrs(Words, [], NewWords), !.

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

t2_6 :-
  write("Str -> "),
  read_str_nofix(S),
  list_of_words(S, LW),
  words_rnd_chrs(LW, RLW),
  str_with1space(RLW, NewS),
  write("New Str => ["),
  write_str(NewS),
  write("]").

% Задание 2.12
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

% Задание 2.13
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

t2_13 :-
  write("Str -> "),
  read_str_nofix(S),
  list_of_words(S, LW),
  random_list_words(LW, RLW),
  str_with1space(RLW, NewS),
  write("New Str => ["),
  write_str(NewS),
  write("]").

% Задание 3
% переводим list в год
list_to_year([X1, X2, X3, X4], Year) :-
  X11 is X1 - 48,
  X21 is X2 - 48,
  X31 is X3 - 48,
  X41 is X4 - 48,
  Year is (X11 * 1000 + X21 * 100 + X31 * 10 + X41).

% сначала факты (месяцы в формате: января, февраля, и т д)
month(1, L) :- L = [1103, 1085, 1074, 1072, 1088, 1103], !.
month(2, L) :- L = [1092, 1077, 1074, 1088, 1072, 1083, 1103], !.
month(3, L) :- L = [1084, 1072, 1088, 1090, 1072], !.
month(4, L) :- L = [1072, 1087, 1088, 1077, 1083, 1103], !.
month(5, L) :- L = [1084, 1072, 1103], !.
month(6, L) :- L = [1080, 1102, 1085, 1103], !.
month(7, L) :- L = [1080, 1102, 1083, 1103], !.
month(8, L) :- L = [1072, 1074, 1075, 1091, 1089, 1090, 1072], !.
month(9, L) :- L = [1089, 1077, 1085, 1090, 1103, 1073, 1088, 1103], !.
month(10, L) :- L = [1086, 1082, 1090, 1103, 1073, 1088, 1103], !.
month(11, L) :- L = [1085, 1086, 1103, 1073, 1088, 1103], !.
month(12, L) :- L = [1076, 1077, 1082, 1072, 1073, 1088, 1103], !.

% факты (дни - день/месяц/год)
day([X1, X2], _, _) :- (X1 = 48, X2 >= 49, X2 =< 57), !.
day([X1, X2], _, _) :- (X1 = 49, X2 >= 48, X2 =< 57), !.
day([X1, X2], _, _) :- (X1 = 50, X2 >= 48, X2 =< 56), !.
day([X1, X2], M, Y) :- (X1 = 50, X2 = 57, M = 2, 0 is Y mod 4), !.
day([X1, X2], M, _) :- (X1 = 51, X2 = 48, M \= 2), !.
day([X1, X2], M, _) :- (X1 = 51, X2 = 49, (M = 1 | M = 3 | M = 5 | M = 7 | M = 8 | M = 10 | M = 12)), !.

% год
year([X1, X2, X3, X4]) :- (X1 >= 48, X1 =< 57, X2 >= 48, X2 =< 57, X3 >= 48, X3 =< 57, X4 >= 48, X4 =< 57).

% состоит ли список только из пробелов
only_spaces([]) :- !.
only_spaces([H|T]) :-
  (H = 32 ->
  only_spaces(T);
  fail).

% читаем список и ищем совпадение "28 февраля 2005"
find_date_in_str([], Dates, Dates) :- !.
find_date_in_str(List, Dates, Dates) :- only_spaces(List), !.
find_date_in_str(List, Dates, Dates) :-
  list_of_words(List, Words),
  count_els(Words, Count),
  Count < 3, !.
find_date_in_str([D1|DT], CurDates, Dates) :-
  (([_|[D2|[32|ListNoDay]]] = [D1|DT],
  [D1, D2] = WordDay,
  firstword(ListNoDay, WordMonth),
  month(Month, WordMonth),
  append(WordMonth, ListNoMonth1, ListNoDay),
  append([32], ListNoMonth, ListNoMonth1),
  [Y1|[Y2|[Y3|[Y4|_]]]] = ListNoMonth,
  [Y1, Y2, Y3, Y4] = WordYear,
  year(WordYear),
  list_to_year(WordYear, Year),
  day(WordDay, Month, Year)
  ) ->
  (append(WordDay, [32], DS),
  append(DS, WordMonth, DSM),
  append(DSM, [32], DSMS),
  append(DSMS, WordYear, DSMSY),
  append(CurDates, [DSMSY], CurDates1),
  append([Y1, Y2], NewT, ListNoMonth),
  find_date_in_str(NewT, CurDates1, Dates));
  (find_date_in_str(DT, CurDates, Dates))).
find_date_in_str(Str, Dates) :- find_date_in_str(Str, [], Dates).

t3 :-
  write("Str -> "),
  read_str_nofix(S),
  find_date_in_str(S, Dates),
  write("Dates =>"), nl,
  write_list_str(Dates).

% Задание 4.12 (Кириллица: 1072-1105, != 1104)
% формируем список из кодов кириллицы
russian_codes_in_str([], List, List) :- !.
russian_codes_in_str([H|T], CurList, List) :-
  ((H >= 1072,
  H =< 1105,
  H \= 1104,
  not(in_ls(CurList, H))
  ) ->
  append(CurList, [H], CurList1);
  CurList1 = CurList),
  russian_codes_in_str(T, CurList1, List).
russian_codes_in_str(Str, List) :- russian_codes_in_str(Str, [], List).

% формируем список из кодов кириллицы, не входящих в заданный
russian_codes_out_str(_, 1106, List, List) :- !.
russian_codes_out_str(ListCodes, CurCode, CurList, List) :-
  ((not(in_ls(ListCodes, CurCode)), CurCode \= 1104) ->
  append(CurList, [CurCode], CurList1);
  CurList1 = CurList),
  CurCode1 is CurCode + 1,
  russian_codes_out_str(ListCodes, CurCode1, CurList1, List).
russian_codes_out_str(ListCodes, List) :- russian_codes_out_str(ListCodes, 1072, [], List).

t4_12 :-
  write("Str -> "),
  read_str_nofix(S),
  russian_codes_in_str(S, RCIN),
  russian_codes_out_str(RCIN, RCOUT),
  write("Russian codes out str => ["),
  write_str(RCOUT),
  write("]").