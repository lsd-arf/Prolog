% ������ ������ ��������������� ����� (���� �� �������� enter)
read_str_nofix(A) :-
  get0(X),
  r_str_nofix(X, A, []).
r_str_nofix(10, A, A) :- !.
r_str_nofix(-1, A, A) :- !.
r_str_nofix(X, A, B) :-
  append(B, [X], B1),
  get0(X1),
  r_str_nofix(X1, A, B1).

% ������ ������
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

% ������� ������
write_str([]) :- !.
write_str([H|Tail]) :-
  put(H),
  write_str(Tail).

% ������ ����� �����
read_list_str(List) :-
  read_str(A, _, Flag),
  read_list_str([A], List, Flag).
read_list_str(List, List, 1) :- !.
read_list_str(Cur_list, List, 0):-
  read_str(A, _, Flag),
  append(Cur_list, [A], C_l),
  read_list_str(C_l, List, Flag).

% ������� ����� �����
write_list_str([]) :- !.
write_list_str([H|T]) :-
  write_str(H), nl,
  write_list_str(T).

see0 :- see('C:/Users/���������/Desktop/Prolog/lab8/in.txt').
tell0 :- tell('C:/Users/���������/Desktop/Prolog/lab8/out.txt').

% ���������� ��������� � ������
count_els([], Count, Count) :- !.
count_els([_|T], CurCount, Count) :- 
  CurCount1 is CurCount + 1, 
  count_els(T, CurCount1, Count).
count_els(List, Count) :- count_els(List, 0, Count).

% ����� ������������ ������
length_of_max_line([], Max, Max) :- !.
length_of_max_line([BigH|BigT], CurMax, Max) :-
  count_els(BigH, Count),
  (Count > CurMax ->
  CurMax1 is Count;
  CurMax1 is CurMax),
  length_of_max_line(BigT, CurMax1, Max).
length_of_max_line(BigList, Max) :- length_of_max_line(BigList, 0, Max).

% ���������� �������� � ������
count_spaces([], Count, Count) :- !.
count_spaces([H|T], CurCount, Count) :- 
  (H = 32 -> 
  CurCount1 is CurCount + 1;
  CurCount1 is CurCount),
  count_spaces(T, CurCount1, Count).

% ���������� ����� ��� ��������
count_lines_without_spaces([], Count, Count) :- !.
count_lines_without_spaces([BigH|BigT], CurCount, Count) :- 
  ((count_spaces(BigH, 0, C), C = 0) ->
  CurCount1 is CurCount + 1;
  CurCount1 is CurCount),
  count_lines_without_spaces(BigT, CurCount1, Count).

% ������� 1.1
t1_1 :-
  see0, read_list_str(List), 
  length_of_max_line(List, Max),
  seen, write("Max length => "), write(Max).

% ������� 1.2
t1_2 :-
  see0, read_list_str(List),
  count_lines_without_spaces(List, 0, Count),
  seen, write("Count => "), write(Count).

% ������� 1.3
% ���� � ���� ����� �� �������� (���������� �� ������ �����)
list_file([], List, List) :- !.
list_file([H|T], CurList, List) :-
  append(CurList, H, CurList1),
  list_file(T, CurList1, List).
list_file(ListString, List) :- list_file(ListString, [], List).

% ���������� �������� �������� � ����� (����� ����� A)
count_chr_in([], _, Count, Count) :- !.
count_chr_in([H|T], Chr, CurCount, Count) :-
  (H = Chr ->
  CurCount1 is CurCount + 1;
  CurCount1 is CurCount),
  count_chr_in(T, Chr, CurCount1, Count).
count_chr_in(List, Chr, Count) :- count_chr_in(List, Chr, 0, Count).
count_chr_in(List, Count) :- count_chr_in(List, 65, Count).

% ���� �� �����, ��� ���-�� ���� A ������ �������� �� ����
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

% ������� 1.4
% �������� ������ ��� ������ ��������
list_nofirstspaces([], []) :- !.
list_nofirstspaces([H|T], [H|T]) :- H \= 32, !.
list_nofirstspaces([_|T], NewList) :- list_nofirstspaces(T, NewList).

% �������� ����� �� ������� ������� (��������, ���� � ������ ��� ��������)
firstword([], Word, Word) :- !.
firstword([H|_], Word, Word) :- H = 32, !.
firstword([H|T], CurWord, NewWord) :-
  append(CurWord, [H], CurWord1),
  firstword(T, CurWord1, NewWord).
firstword(List, Word) :- firstword(List, [], Word).

% �������� ������ ����� �������� �� �������
firstword_nfs(List, Word) :-
  list_nofirstspaces(List, ListNFS),
  firstword(ListNFS, Word).

% �������� ������ ���� �� ������
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

% �������� ������ ���� �� �����
list_of_words_file([], LWF, LWF) :- !.
list_of_words_file([H|T], CurLWF, LWF) :-
  list_of_words(H, LW),
  append(CurLWF, LW, CurLWF1),
  list_of_words_file(T, CurLWF1, LWF).
list_of_words_file(ListOfLines, LWF) :- list_of_words_file(ListOfLines, [], LWF).

% ����� ���, ������� ����������� �������� ������� � ������
count_equals([], _, Count, Count) :- !.
count_equals([H|T], El, CurCount, Count) :- 
  (H = El -> 
  CurCount1 is CurCount + 1; 
  CurCount1 is CurCount), 
  count_equals(T, El, CurCount1, Count).
count_equals(List, El, Count) :- count_equals(List, El, 0, Count).

% �����, ������� ����������� ���� �����
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

% ������� 1.5
% ����� ������� ��������� ��������
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

% ����� �������� � ������
ls_el_at_num([], _, _, _) :- write("Such element isn\'t found"), !.
ls_el_at_num([_], CurNum, Num, _) :- 
  CurNum1 is CurNum + 1, 
  CurNum1 < Num, 
  write("Such element isn\'t found"), !.
ls_el_at_num([H|T], CurNum, Num, El) :- 
  CurNum1 is CurNum + 1, 
  ((CurNum1 is Num) -> 
  El = H; 
  ls_el_at_num(T, CurNum1, Num, El)).
ls_el_at_num([H|T], Num, El) :- ls_el_at_num([H|T], 0, Num, El).

% ���� �� ������� � ������
in_ls([H|_], H) :- !.
in_ls([_|T], El) :- in_ls(T, El).

% �������� ���� ��� ��������
rm_el([_|T], CurList, Num, Num, NewList) :- append(CurList, T, NewList), !.
rm_el([H|T], CurList, CurNum, Num, NewList) :- 
  append(CurList, [H], CurList1), 
  CurNum1 is CurNum + 1, 
  rm_el(T, CurList1, CurNum1, Num, NewList).
rm_el(List, Num, NewList) :- rm_el(List, [], 1, Num, NewList).

% �������� ���������� � �������� ���������
rm_equals(List, El, List) :- not(in_ls(List, El)), !.
rm_equals(List, El, NewList) :- 
  ls_num_el(List, El, Num), 
  rm_el(List, Num, List1), 
  rm_equals(List1, El, NewList).

% �������� ���� �� ���������� ���������
uni_list([], []) :- !.
uni_list([H|T], List) :-
  rm_equals(T, H, RmList),
  uni_list(RmList, List1),
  append([H], List1, List).

% ���� �� ��������������� ���������
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

% ������� 2.6
% ��������������� ������������� ����� �� ��������
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

% ������ � ������ ����� ������� ����� ������ � ���������
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

% �������� ������ ����
% ����� ����� ����������� ����� �� ������ � ������� ����� ���� ������
% ����� ���������� ����� ������ ������ �� ������
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

% ������� 2.12
% ����� � ������, ����� � �����
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

% ������� 2.13
% ��������������� ������������� ����� �� ����
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

% ������� 3
% ��������� list � ���
list_to_year([X1, X2, X3, X4], Year) :-
  X11 is X1 - 48,
  X21 is X2 - 48,
  X31 is X3 - 48,
  X41 is X4 - 48,
  Year is (X11 * 1000 + X21 * 100 + X31 * 10 + X41).

% ������� ����� (������ � �������: ������, �������, � � �)
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

% ����� (��� - ����/�����/���)
day([X1, X2], _, _) :- (X1 = 48, X2 >= 49, X2 =< 57), !.
day([X1, X2], _, _) :- (X1 = 49, X2 >= 48, X2 =< 57), !.
day([X1, X2], _, _) :- (X1 = 50, X2 >= 48, X2 =< 56), !.
day([X1, X2], M, Y) :- (X1 = 50, X2 = 57, M = 2, 0 is Y mod 4), !.
day([X1, X2], M, _) :- (X1 = 50, X2 = 57, M \= 2), !.
day([X1, X2], M, _) :- (X1 = 51, X2 = 48, M \= 2), !.
day([X1, X2], M, _) :- (X1 = 51, X2 = 49, (M = 1 | M = 3 | M = 5 | M = 7 | M = 8 | M = 10 | M = 12)), !.

% ���
year([X1, X2, X3, X4]) :- (X1 >= 48, X1 =< 57, X2 >= 48, X2 =< 57, X3 >= 48, X3 =< 57, X4 >= 48, X4 =< 57).

% ������� �� ������ ������ �� ��������
only_spaces([]) :- !.
only_spaces([H|T]) :-
  (H = 32 ->
  only_spaces(T);
  fail).

% ������ ������ � ���� ���������� "28 ������� 2005"
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

% ������� 4.6
% �������� ������ n ��������� ������
first_n_els(_, 0, List, List) :- !.
first_n_els([H|T], N, CurList, List) :-
  append(CurList, [H], CurList1),
  N1 is N - 1,
  first_n_els(T, N1, CurList1, List).
first_n_els(List, N, NewList) :- first_n_els(List, N, [], NewList).

% �������� ���� �� ���� n ���������, ������� �����
% ���������, ����� ���������� ��������� �����, �� �������� ��������, ������ N
list_n_els(List, N, NewList, NewList) :-
  count_els(List, Count),
  Count < N, !.
list_n_els([H|T], N, CurList, NewList) :-
  first_n_els([H|T], N, FNE),
  append(CurList, [FNE], CurList1),
  list_n_els(T, N, CurList1, NewList).
list_n_els(List, N, NewList) :- list_n_els(List, N, [], NewList).

% ��������� ������ �� (1, N) ����� ������� ���������
list_from_1_to_n_els(_, 0, List, List) :- !.
list_from_1_to_n_els(List, N, CurList, NewList) :-
  list_n_els(List, N, ListN),
  append(CurList, ListN, CurList1),
  N1 is N - 1,
  list_from_1_to_n_els(List, N1, CurList1, NewList).
list_from_1_to_n_els(List, NewList) :-
  count_els(List, Count),
  list_from_1_to_n_els(List, Count, [], NewList).

% �������� ������� K ��� ����� N
degree_of_n(_, 0, Num, Num) :- !.
degree_of_n(N, K, CurNum, Num) :-
  K1 is K - 1,
  CurNum1 is CurNum * N,
  degree_of_n(N, K1, CurNum1, Num).
degree_of_n(N, K, Num) :- degree_of_n(N, K, 1, Num).

% ����� �� �����
num_from_l([], _, Num, Num) :- !.
num_from_l([H|T], N, CurNum, Num) :-
  H1 is H - 48,
  degree_of_n(10, N, Deg10inN),
  H2 is H1 * Deg10inN,
  CurNum1 is CurNum + H2,
  N1 is N - 1,
  num_from_l(T, N1, CurNum1, Num).
num_from_l(List, Num) :-
  count_els(List, Count),
  Count1 is Count - 1,
  num_from_l(List, Count1, 0, Num).

% ��������� ���� ����� �� ����� ������ �������� 0-9
nums_from_ll([], List, List) :- !.
nums_from_ll([H|T], CurList, List) :-
  num_from_l(H, Num),
  append(CurList, [Num], CurList1),
  nums_from_ll(T, CurList1, List).
nums_from_ll(LL, Nums) :- nums_from_ll(LL, [], Nums).

% ������ ����� � ������
% �������� ������� �� ������ �����
str_no_first_chrs_before_digit([], []) :- !.
str_no_first_chrs_before_digit([H|T], [H|T]) :- (H >= 48, H =< 57), !.
str_no_first_chrs_before_digit([_|T], List) :- str_no_first_chrs_before_digit(T, List).

% ������ ������ ����� � ������ (�������� ������ ���� ������ ��� �����)
first_num([], List, List) :- !.
first_num([H|_], List, List) :- not((H >= 48, H =< 57)), !.
first_num([H|T], CurList, List) :-
  ((H >= 48, H =< 57) ->
  append(CurList, [H], CurList1);
  CurList1 = CurList),
  first_num(T, CurList1, List).
first_num(Str, List) :- first_num(Str, [], List).

% ������ ��� ����� � ������
str_nums([], Nums, Nums) :- !.
str_nums(Str, Nums, Nums) :-
  str_no_first_chrs_before_digit(Str, Str1),
  [] = Str1, !.
str_nums(Str, CurNums, Nums) :-
  str_no_first_chrs_before_digit(Str, StrNoChrs),
  ([] \= StrNoChrs ->
  (first_num(StrNoChrs, Num),
  append(CurNums, [Num], CurNums1),
  append(Num, StrNoNum, StrNoChrs));
  (StrNoNum = [],
  CurNums1 = CurNums)),
  str_nums(StrNoNum, CurNums1, Nums).
str_nums(Str, Nums) :- str_nums(Str, [], Nums).

% ��� ��������� ����� � ������
all_nums_in_str([], Nums, Nums) :- !.
all_nums_in_str([H|T], CurNums, Nums) :-
  list_from_1_to_n_els(H, H1n),
  append(CurNums, H1n, CurNums1),
  all_nums_in_str(T, CurNums1, Nums).
all_nums_in_str(Nums, AllNums) :- all_nums_in_str(Nums, [], AllNums).

% �����, �������� ������� ������ 5
nums_which_more_than_5([], Nums, Nums) :- !.
nums_which_more_than_5([H|T], CurNums, Nums) :-
  (H > 5 ->
  append(CurNums, [H], CurNums1);
  CurNums1 = CurNums),
  nums_which_more_than_5(T, CurNums1, Nums).
nums_which_more_than_5(List, Nums) :- nums_which_more_than_5(List, [], Nums).

% ��������� ���������� ���� ������ ����� �������� �������� � �����
% ����� ���������� ��������, ��� 06 � 6 - ������ �����
t4_6 :-
  write("Str -> "),
  read_str_nofix(S),
  str_nums(S, Nums),
  all_nums_in_str(Nums, AllNums),
  nums_from_ll(AllNums, TrueNums),
  uni_list(TrueNums, UniTrueNums),
  nums_which_more_than_5(UniTrueNums, UniTrueNumsMoreThan5),
  write("Nums more than 5 =>"), nl,
  write(UniTrueNumsMoreThan5).

% ������� 4.12 (���������: 1072-1105, != 1104)
% ��������� ������ �� ����� ���������
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

% ��������� ������ �� ����� ���������, �� �������� � ��������
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

% ������� 4.13
% ������������ �������
max_ls_down([], Max, Max) :- !.
max_ls_down([H|T], CurMax, Max) :- 
  (H > CurMax -> 
  CurMax1 is H; 
  CurMax1 is CurMax), 
  max_ls_down(T, CurMax1, Max).
max_ls_down([H|T], Max) :- max_ls_down(T, H, Max).

t4_13 :-
  write("Str -> "),
  read_str_nofix(S),
  str_nums(S, Nums),
  all_nums_in_str(Nums, AllNums),
  nums_from_ll(AllNums, TrueNums),
  uni_list(TrueNums, UniTrueNums),
  (UniTrueNums \= [] ->
  max_ls_down(UniTrueNums, Max);
  Max = -1),
  (Max > 0 ->
  (write("Natural max => "),
  write(Max));
  write("Natural max isn\'t exist")).

% ������� 5
% �������� ������ ���� �����
list_of_lengths([], List, List) :- !.
list_of_lengths([H|T], CurList, List) :-
  count_els(H, Count),
  append(CurList, [Count], CurList1),
  list_of_lengths(T, CurList1, List).
list_of_lengths(ListStrs, ListLengths) :- list_of_lengths(ListStrs, [], ListLengths).

% ����������� ������� � ������
min_ls_down([], Min, Min) :- !.
min_ls_down([H|T], CurMin, Min) :- 
  (H < CurMin -> 
  CurMin1 is H; 
  CurMin1 is CurMin), 
  min_ls_down(T, CurMin1, Min).
min_ls_down([H|T], Min) :- min_ls_down(T, H, Min).

% ������������� ������ ����� �� �� �����
sort_strs_by_length([], [], List, List) :- !.
sort_strs_by_length(ListStrs, ListLengths, CurList, List) :-
  min_ls_down(ListLengths, Min),
  ls_num_el(ListLengths, Min, Num),
  ls_el_at_num(ListStrs, Num, El),
  append(CurList, [El], CurList1),
  rm_el(ListStrs, Num, ListStrs1),
  rm_el(ListLengths, Num, ListLengths1),
  sort_strs_by_length(ListStrs1, ListLengths1, CurList1, List).
sort_strs_by_length(ListStrs, NewListStrs) :-
  list_of_lengths(ListStrs, ListLengths),
  sort_strs_by_length(ListStrs, ListLengths, [], NewListStrs).

% ��������� ANSI �����
t5 :-
  see0,
  read_list_str(ListStr),
  sort_strs_by_length(ListStr, NewListStr),
  seen,
  tell0,
  write_list_str(NewListStr),
  told.

% ������� 6
% ������� ���������� ����
% ������� ������ �������
% ���� ����� ������ �� ������, ������� �����, ������� + 1
% ����� ���� �� ��������, ������ �� �������
% ������ ����� ListNoFirstWord ��� � (��������� + �������), ��� ������
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

% �������� ������ ���������� ���� � ������ ������
list_of_count_words([], List, List) :- !.
list_of_count_words([H|T], CurList, List) :-
  count_words(H, Count),
  append(CurList, [Count], CurList1),
  list_of_count_words(T, CurList1, List).
list_of_count_words(ListStrs, ListCounts) :- list_of_count_words(ListStrs, [], ListCounts).

% ��������� �� ���������� ����
sort_strs_by_count(ListStrs, NewListStrs) :-
  list_of_count_words(ListStrs, ListCounts),
  sort_strs_by_length(ListStrs, ListCounts, [], NewListStrs).

t6 :-
  see0,
  read_list_str(ListStr),
  sort_strs_by_count(ListStr, NewListStr),
  seen,
  tell0,
  write_list_str(NewListStr),
  told.

% ������� 7
% �������� ����� �� �����
check_for_num([]) :- !.
check_for_num([H|T]) :-
  (H >= 48, H =< 57),
  check_for_num(T).

% ���������� ����, ������ ����� ����� � ������
count_words_after_num([_], Count, Count) :- !.
count_words_after_num([], Count, Count) :- !.
count_words_after_num([H|T], CurCount, Count) :-
  ((check_for_num(H)) ->
  CurCount1 is CurCount + 1;
  CurCount1 is CurCount),
  count_words_after_num(T, CurCount1, Count).
count_words_after_num(List, Count) :-
  list_of_words(List, Words),
  count_words_after_num(Words, 0, Count).

% �������� ������ ���������� ����, ������ ����� ����� � ������ ������
list_of_count_words_after_num([], List, List) :- !.
list_of_count_words_after_num([H|T], CurList, List) :-
  count_words_after_num(H, Count),
  append(CurList, [Count], CurList1),
  list_of_count_words_after_num(T, CurList1, List).
list_of_count_words_after_num(ListStrs, ListCounts) :- list_of_count_words_after_num(ListStrs, [], ListCounts).

% ��������� �� ���������� ����, ������ ����� ����� � ������ ������
sort_strs_by_count_words_after_num(ListStrs, NewListStrs) :-
  list_of_count_words_after_num(ListStrs, ListCounts),
  sort_strs_by_length(ListStrs, ListCounts, [], NewListStrs).

t7 :-
  see0,
  read_list_str(ListStr),
  list_of_count_words_after_num(ListStr, Counts),
  write(Counts),
  sort_strs_by_count_words_after_num(ListStr, NewListStr),
  seen,
  tell0,
  write_list_str(NewListStr),
  told.

% ������� 8. ������� 12.
% ������ 3
% ���� �������� ����� ����������� ������
ls_most_meet_el(_, [], _, El, El) :- !.
ls_most_meet_el(List, [UniH|UniT], Count, CurEl, El) :-
  count_equals(List, UniH, Count1),
  (Count1 > Count ->
  (CurEl1 is UniH,
  Count2 is Count1);
  (CurEl1 is CurEl,
  Count2 is Count)),
  ls_most_meet_el(List, UniT, Count2, CurEl1, El).
%ls_most_meet_el([], _) :- fail, !.
ls_most_meet_el([H|T], El) :-
  uni_list(T, UniList),
  count_equals([H|T], H, Count),
  ls_most_meet_el(T, UniList, Count, H, El).

% ���� ������� ��������� � ������
% ���� ������� ��������� � �����
% ���� ������� ������
delta_between_regular_in_str_and_in_file(CurStr, FileStr, Delta) :-
  ls_most_meet_el(CurStr, El),
  count_equals(CurStr, El, CountElInStr),
  count_equals(FileStr, El, CountElInFile),
  count_els(CurStr, CountInStr),
  count_els(FileStr, CountInFile),
  AverageInStr is CountElInStr / CountInStr,
  AverageInFile is CountElInFile / CountInFile,
  Delta is AverageInStr - AverageInFile.

% �������� ������ ��� ������ ������ (����� �����)
delta_for_every_str([], _, Deltas, Deltas) :- !.
delta_for_every_str([CurStr|ListStr], FileStr, CurDeltas, Deltas) :-
  delta_between_regular_in_str_and_in_file(CurStr, FileStr, Delta),
  append(CurDeltas, [Delta], CurDeltas1),
  delta_for_every_str(ListStr, FileStr, CurDeltas1, Deltas).
delta_for_every_str(ListStr, Deltas) :-
  list_file(ListStr, FileStr),
  delta_for_every_str(ListStr, FileStr, [], Deltas).

% ���������
sort_strs_task8_3(ListStrs, NewListStrs) :-
  delta_for_every_str(ListStrs, ListDeltas),
  sort_strs_by_length(ListStrs, ListDeltas, [], NewListStrs).

t8_3 :-
  see0,
  read_list_str(ListStr),
  delta_for_every_str(ListStr, Deltas),
  write(Deltas),
  sort_strs_task8_3(ListStr, NewListStr),
  seen,
  tell0,
  write_list_str(NewListStr),
  told.

% ������ 6
% �������� ����� ���� �����
list_of_count_els([], List, List) :- !.
list_of_count_els([H|T], CurList, List) :-
  count_els(H, Count),
  append(CurList, [Count], CurList1),
  list_of_count_els(T, CurList1, List).
list_of_count_els(ListStr, List) :- list_of_count_els(ListStr, [], List).

% �������� ������ � ������������ ������
str_max_length([], _, Str, Str) :- !.
str_max_length([H|T], Length, CurStr, Str) :-
  count_els(H, Count),
  (Count > Length ->
  (Length1 is Count,
  CurStr1 = H);
  (Length1 is Length,
  CurStr1 = CurStr)),
  str_max_length(T, Length1, CurStr1, Str).
str_max_length(ListStr, Str) :- str_max_length(ListStr, 0, [], Str).

% �������� ������ � ����������� ������
str_min_length([], _, Str, Str) :- !.
str_min_length([H|T], Length, CurStr, Str) :-
  count_els(H, Count),
  (Count < Length ->
  (Length1 is Count,
  CurStr1 = H);
  (Length1 is Length,
  CurStr1 = CurStr)),
  str_min_length(T, Length1, CurStr1, Str).
str_min_length([H|T], Str) :-
  count_els(H, Count),
  str_min_length(T, Count, H, Str).

% �������� ������ �� ������� ������ (��� � ���� ��������� ��������, ��� ������ �������� ����)
% ������ �����, 1 - ������� ������ � ����� ������� ������, 0 - � ����� ���������
str_avg_length([Str], _, Str) :- !.
str_avg_length(ListStr, Flag, Str) :-
  (Flag = 0 ->
    (
      str_min_length(ListStr, FoundStr),
      Flag1 = 1
    );
    (
      str_max_length(ListStr, FoundStr),
      Flag1 = 0
    )
  ),
  ls_num_el(ListStr, FoundStr, Num),
  rm_el(ListStr, Num, NewListStr),
  str_avg_length(NewListStr, Flag1, Str).
str_avg_length(ListStr, Str) :- str_avg_length(ListStr, 0, Str).

% ���� �������, ��������� ��������� � ����� ������, ������� �� ����������� ������
f_t8_6([], List, List) :- !.
f_t8_6(ListStr, CurList, List) :-
  str_avg_length(ListStr, StrAVG),
  append(CurList, [StrAVG], CurList1),
  ls_num_el(ListStr, StrAVG, Num),
  rm_el(ListStr, Num, NewListStr),
  f_t8_6(NewListStr, CurList1, List).
f_t8_6(ListStr, List) :- f_t8_6(ListStr, [], List).

t8_6 :-
  see0,
  read_list_str(ListStr),
  list_of_count_els(ListStr, CountEls),
  write(CountEls),
  f_t8_6(ListStr, NewListStr),
  seen,
  tell0,
  write_list_str(NewListStr),
  told.

% ������ 9
% �������� ���� �� ����� ascii-����� ���
list_of_delta_between_ascii([], List, List) :- !.
list_of_delta_between_ascii([_], List, List) :- !.
list_of_delta_between_ascii([H|T], CurList, List) :-
  append(TNoEl, [El], T),
  Delta1 is H - El,
  Delta is abs(Delta1),
  append(CurList, [Delta], CurList1),
  list_of_delta_between_ascii(TNoEl, CurList1, List).
list_of_delta_between_ascii(Str, List) :- list_of_delta_between_ascii(Str, [], List).

% ����� ��������� ������
sum_ls_down([], Sum, Sum) :- !.
sum_ls_down([H|T], CurSum, Sum) :- 
  CurSum1 is CurSum + H, 
  sum_ls_down(T, CurSum1, Sum).
sum_ls_down([H|T], Sum) :- sum_ls_down([H|T], 0, Sum).

% ���� ������� �������� ����� ascii-���
%avg_of_delta_between_ascii(Deltas, AVG) :-
%  count_els(Deltas, Count),
%  sum_ls_down(Deltas, Sum),
%  AVG is Sum / Count.

% ���������� �� ��������� ascii-����
deviation_from_the_ascii([], _, Deltas, Deltas) :- !.
deviation_from_the_ascii([H|T], ASCII, CurDeltas, Deltas) :-
  Delta is H - ASCII,
  append(CurDeltas, [Delta], CurDeltas1),
  deviation_from_the_ascii(T, ASCII, CurDeltas1, Deltas).
deviation_from_the_ascii(List, ASCII, Deltas) :- deviation_from_the_ascii(List, ASCII, [], Deltas).

% �������� �������� ���� ����������
sqr_deviation_from_the_ascii([], Deltas, Deltas) :- !.
sqr_deviation_from_the_ascii([H|T], CurDeltas, Deltas) :-
  DeltaSqr is H * H,
  append(CurDeltas, [DeltaSqr], CurDeltas1),
  sqr_deviation_from_the_ascii(T, CurDeltas1, Deltas).
sqr_deviation_from_the_ascii(List, DeltaSqrs) :- sqr_deviation_from_the_ascii(List, [], DeltaSqrs).

% ��������� ������� �������������� ���������� � ������
standard_deviation(Str, ASCII, StandardDeviation) :-
  list_of_delta_between_ascii(Str, Deltas),
  deviation_from_the_ascii(Deltas, ASCII, Deviation),
  sqr_deviation_from_the_ascii(Deviation, DeltaSqrs),
  count_els(DeltaSqrs, Count),
  sum_ls_down(DeltaSqrs, Sum),
  Dispersion is Sum / Count,
  StandardDeviation is sqrt(Dispersion).

% �������� ����� ������� �������������� ���������� �����
list_of_standard_deviation([], List, List) :- !.
list_of_standard_deviation([H|T], CurList, List) :-
  max_ls_down(H, ASCII),
  standard_deviation(H, ASCII, StandardDeviation),
  append(CurList, [StandardDeviation], CurList1),
  list_of_standard_deviation(T, CurList1, List).
list_of_standard_deviation(ListStr, List) :- list_of_standard_deviation(ListStr, [], List).

% ���������
sort_strs_task8_9(ListStrs, NewListStrs) :-
  list_of_standard_deviation(ListStrs, ListOfStandardDeviation),
  sort_strs_by_length(ListStrs, ListOfStandardDeviation, [], NewListStrs).

t8_9 :-
  see0,
  read_list_str(ListStr),
  list_of_standard_deviation(ListStr, ListOfStandardDeviation),
  write(ListOfStandardDeviation),
  sort_strs_task8_9(ListStr, NewListStr),
  seen,
  tell0,
  write_list_str(NewListStr),
  told, !.

% ������ 10
% ���������� ���������� ����� � ������
mirror_3_in_str([_, _], Count, Count) :- !.
mirror_3_in_str([_], Count, Count) :- !.
mirror_3_in_str([], Count, Count) :- !.
mirror_3_in_str([H1|[H2|[H3|T]]], CurCount, Count) :-
  (H1 = H3 ->
  CurCount1 is CurCount + 1;
  CurCount1 is CurCount),
  mirror_3_in_str([H2|[H3|T]], CurCount1, Count).
mirror_3_in_str(Str, Count) :- mirror_3_in_str(Str, 0, Count).

% ������� �������� (����� 0, ���� ����� ������ ������ 3)
avg_t8_10(Str, AVG) :-
  count_els(Str, Count),
  (Count < 3 ->
  AVG is 0;
  (mirror_3_in_str(Str, CountOfMirrors),
  FullCountOfMirrors is Count - 2,
  AVG is CountOfMirrors / FullCountOfMirrors)).

% ����� ������� �������
list_of_avg_t8_10([], List, List) :- !.
list_of_avg_t8_10([H|T], CurList, List) :-
  avg_t8_10(H, AVG),
  append(CurList, [AVG], CurList1),
  list_of_avg_t8_10(T, CurList1, List).
list_of_avg_t8_10(ListStr, List) :- list_of_avg_t8_10(ListStr, [], List).

% ���������
sort_strs_task8_10(ListStrs, NewListStrs) :-
  list_of_avg_t8_10(ListStrs, ListOfAVG),
  sort_strs_by_length(ListStrs, ListOfAVG, [], NewListStrs).

t8_10 :-
  see0,
  read_list_str(ListStr),
  list_of_avg_t8_10(ListStr, ListOfAVG),
  write(ListOfAVG),
  sort_strs_task8_10(ListStr, NewListStr),
  seen,
  tell0,
  write_list_str(NewListStr),
  told, !.