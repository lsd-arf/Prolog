in_list([El|_], El).
in_list([_|T], El) :- in_list(T, El).

in_list_exclude([El|T], El, T).
in_list_exclude([H|T], El, [H|Tail]) :- in_list_exclude(T, El, Tail).

read_str(A, N) :-
  get0(X),
  r_str(X, A, [], N, 0).
r_str(10, A, A, N, N) :- !.
r_str(X, A, B, N, K) :-
  K1 is K + 1,
  append(B, [X], B1),
  get0(X1),
  r_str(X1, A, B1, N, K1).

write_str([]) :- !.
write_str([H|Tail]) :- put(H), write_str(Tail).

tell0 :- tell('C:/Users/Владислав/Desktop/Prolog/lab9/out.txt').

% Задание 1
% все размещения с повторениями по k элементов
build_all_razm_p :-
  read_str(A, _),
  read(K),
  b_a_rp(A, K, []).
		
b_a_rp(_, 0, Perm1) :- write_str(Perm1), nl, !, fail.
b_a_rp(A, N, Perm) :-
  in_list(A, El),
  N1 is N - 1,
  b_a_rp(A, N1, [El|Perm]).

% все перестановки
build_all_perm:-
  read_str(A, _),
  b_a_p(A, []).

b_a_p([], Perm1) :- write_str(Perm1), nl, !, fail.
b_a_p(A, Perm) :-
  in_list_exclude(A, El, A1),
  b_a_p(A1, [El|Perm]).

% все размещения по k элементов
build_all_razm:-
  read_str(A, _),
  read(K),
  b_a_r(A, K, []).

b_a_r(_, 0, Perm1) :- write_str(Perm1), nl, !, fail.
b_a_r(A, N, Perm) :-
  in_list_exclude(A, El, A1),
  N1 is N - 1,
  b_a_r(A1, N1, [El|Perm]).

% все подмножества
sub_set([], []).
sub_set([H|Sub_set], [H|Set]) :- sub_set(Sub_set, Set).
sub_set(Sub_set, [_|Set]) :- sub_set(Sub_set, Set).

pr_subset :-
  read_str(A, _),
  sub_set(B, A),
  write_str(B), nl, fail.

% все сочетания по k элементов
sochet([], 0, _) :- !.
sochet([H|Sub_set], K, [H|Set]) :-
  K1 is K - 1,
  sochet(Sub_set, K1, Set).
sochet(Sub_set, K, [_|Set]) :- sochet(Sub_set, K, Set).

pr_sochet :-
  read_str(A, _),
  read(K),
  sochet(B, K, A),
  write_str(B), nl, fail.

% все сочетания с повторениями
sochet_p([], 0, _) :- !.
sochet_p([H|Sub_set], K, [H|Set]) :-
  K1 is K - 1,
  sochet_p(Sub_set, K1, [H|Set]).
sochet_p(Sub_set, K, [_|Set]) :- sochet_p(Sub_set, K, Set).

pr_sochet_p :-
  read_str(A, _),
  read(K),
  sochet_p(B, K, A),
  write_str(B), nl, fail.

% Задание 2
% все слова длины 5, в которых ровно 2 буквы a
words_t2(_, Count, 5, Word) :-
  Count = 2,
  write_str(Word), nl, !, fail.
words_t2(_, _, 5, _) :- !, fail.
words_t2(List, CurCount, CurLength, CurWord) :-
  in_list(List, El),
  (El = 97 ->
  CurCount1 is CurCount + 1;
  CurCount1 is CurCount),
  append(CurWord, [El], CurWord1),
  CurLength1 is CurLength + 1,
  words_t2(List, CurCount1, CurLength1, CurWord1).
words_t2(List) :- words_t2(List, 0, 0, []).

t2 :-
  read_str(A, _),
  words_t2(A).

% Задание 3
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
  El = H; 
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

% все слова длины 5, в которых ровно 2 буквы a, остальные буквы не повторяются
words_t3(_, Count, 5, Word) :-
  Count = 2,
  rm_equals(Word, 97, WordNo97),
  uni_list(WordNo97, WordNo97),
  write_str(Word), nl, !, fail.
words_t3(_, _, 5, _) :- !, fail.
words_t3(List, CurCount, CurLength, CurWord) :-
  in_list(List, El),
  (El = 97 ->
  CurCount1 is CurCount + 1;
  CurCount1 is CurCount),
  append(CurWord, [El], CurWord1),
  CurLength1 is CurLength + 1,
  words_t3(List, CurCount1, CurLength1, CurWord1).
words_t3(List) :- words_t3(List, 0, 0, []).

t3 :-
  read_str(A, _),
  words_t3(A).

% Задание 4
% количество заданных элементов в листе
count_let_in_list([], _, Count, Count) :- !.
count_let_in_list([H|T], El, CurCount, Count) :-
  (H = El ->
  CurCount1 is CurCount + 1;
  CurCount1 is CurCount),
  count_let_in_list(T, El, CurCount1, Count).
count_let_in_list(List, El, Count) :- count_let_in_list(List, El, 0, Count).

% в листе есть буква, которая повторяется 2 раза
let_2_time(_, [], _) :- !, fail.
let_2_time(List, [UniH|UniT], El) :-
  count_let_in_list(List, UniH, Count),
  (Count = 2 ->
  (El = UniH, true);
  let_2_time(List, UniT, El)).

% все слова длины 5, в которых одна буква повторяется 2 раза, остальные буквы не повторяются
words_t4(_, 5, Word) :-
  uni_list(Word, Uni),
  let_2_time(Word, Uni, El),
  rm_equals(Word, El, WordNoEl),

  uni_list(WordNoEl, WordNoEl),
  write_str(Word), nl, !, fail.
words_t4(_, 5, _) :- !, fail.
words_t4(List, CurLength, CurWord) :-
  in_list(List, El),
  append(CurWord, [El], CurWord1),
  CurLength1 is CurLength + 1,
  words_t4(List, CurLength1, CurWord1).
words_t4(List) :- words_t4(List, 0, []).

t4 :-
  read_str(A, _),
  words_t4(A).

% Задание 5
% все слова длины 6, в которых 2 буквы повторяются 2 раза, остальные не повторяются
words_t5(_, 6, Word) :-
  uni_list(Word, Uni),
  let_2_time(Word, Uni, El1),
  rm_equals(Word, El1, WordNoEl1),

  uni_list(WordNoEl1, UniNoEl1),
  let_2_time(WordNoEl1, UniNoEl1, El2),
  rm_equals(WordNoEl1, El2, WordNoEl2),

  uni_list(WordNoEl2, WordNoEl2),
  write_str(Word), nl, !, fail.
words_t5(_, 6, _) :- !, fail.
words_t5(List, CurLength, CurWord) :-
  in_list(List, El),
  append(CurWord, [El], CurWord1),
  CurLength1 is CurLength + 1,
  words_t5(List, CurLength1, CurWord1).
words_t5(List) :- words_t5(List, 0, []).

t5 :-
  read_str(A, _),
  words_t5(A).

% Задание 6
% в листе есть буква, которая повторяется 3 раза
let_3_time(_, [], _) :- !, fail.
let_3_time(List, [UniH|UniT], El) :-
  count_let_in_list(List, UniH, Count),
  (Count = 3 ->
  (El = UniH, true);
  let_3_time(List, UniT, El)).

% все слова длины 7, в которых 1 буква повторяется 2 раза, 1 буква 3 раза, остальные не повторяются
words_t6(_, 7, Word) :-
  uni_list(Word, Uni),
  let_2_time(Word, Uni, El1),
  rm_equals(Word, El1, WordNoEl1),

  uni_list(WordNoEl1, UniNoEl1),
  let_3_time(WordNoEl1, UniNoEl1, El2),
  rm_equals(WordNoEl1, El2, WordNoEl2),

  uni_list(WordNoEl2, WordNoEl2),
  write_str(Word), nl, !, fail.
words_t6(_, 7, _) :- !, fail.
words_t6(List, CurLength, CurWord) :-
  in_list(List, El),
  append(CurWord, [El], CurWord1),
  CurLength1 is CurLength + 1,
  words_t6(List, CurLength1, CurWord1).
words_t6(List) :- words_t6(List, 0, []).

t6 :-
  read_str(A, _),
  words_t6(A).

% Задание 7
% все слова длины 9
% 2 буквы повторяются 2 раза
% 1 буква повторяется 3 раза
% остальные буквы не повторяются
words_t7(_, 9, Word) :-
  uni_list(Word, Uni),
  let_2_time(Word, Uni, El1),
  rm_equals(Word, El1, WordNoEl1),

  uni_list(WordNoEl1, UniNoEl1),
  let_2_time(WordNoEl1, UniNoEl1, El2),
  rm_equals(WordNoEl1, El2, WordNoEl2),

  uni_list(WordNoEl2, UniNoEl2),
  let_3_time(WordNoEl2, UniNoEl2, El3),
  rm_equals(WordNoEl2, El2, WordNoEl3),

  uni_list(WordNoEl3, WordNoEl3),
  write_str(Word), nl, !, fail.
words_t7(_, 9, _) :- !, fail.
words_t7(List, CurLength, CurWord) :-
  in_list(List, El),
  append(CurWord, [El], CurWord1),
  CurLength1 is CurLength + 1,
  words_t7(List, CurLength1, CurWord1).
words_t7(List) :- words_t7(List, 0, []).

t7 :-
  read_str(A, _),
  words_t7(A).

% Задание 8
% все слова длины 4, в которых больше 2 букв a
words_t8(_, Count, 4, Word) :-
  Count > 2,
  write_str(Word), nl, !, fail.
words_t8(_, _, 4, _) :- !, fail.
words_t8(List, CurCount, CurLength, CurWord) :-
  in_list(List, El),
  (El = 97 ->
  CurCount1 is CurCount + 1;
  CurCount1 is CurCount),
  append(CurWord, [El], CurWord1),
  CurLength1 is CurLength + 1,
  words_t8(List, CurCount1, CurLength1, CurWord1).
words_t8(List) :- words_t8(List, 0, 0, []).

t8 :-
  read_str(A, _),
  words_t8(A).

% Задание 9
% все слова длины 7, в которых больше 2 букв a
words_t9(_, Count, 7, Word) :-
  Count > 2,
  write_str(Word), nl, !, fail.
words_t9(_, _, 7, _) :- !, fail.
words_t9(List, CurCount, CurLength, CurWord) :-
  in_list(List, El),
  (El = 97 ->
  CurCount1 is CurCount + 1;
  CurCount1 is CurCount),
  append(CurWord, [El], CurWord1),
  CurLength1 is CurLength + 1,
  words_t9(List, CurCount1, CurLength1, CurWord1).
words_t9(List) :- words_t9(List, 0, 0, []).

t9 :-
  read_str(A, _),
  words_t9(A).

% Задание 10
% проверяем, 4 ли различных буквы в слове
check_4_letters_in_word([], [], 0) :- !.
check_4_letters_in_word(_, [], 0) :- !, fail.
check_4_letters_in_word(List, [UniH|UniT], Count) :-
  Count1 is Count - 1,
  rm_equals(List, UniH, List1),
  check_4_letters_in_word(List1, UniT, Count1).

% все слова длины 7, в которых ровно 4 различных буквы
words_t10(_, 7, Word) :-
  uni_list(Word, Uni),
  check_4_letters_in_word(Word, Uni, 4),

  write_str(Word), nl, !, fail.
words_t10(_, 7, _) :- !, fail.
words_t10(List, CurLength, CurWord) :-
  in_list(List, El),
  append(CurWord, [El], CurWord1),
  CurLength1 is CurLength + 1,
  words_t10(List, CurLength1, CurWord1).
words_t10(List) :- words_t10(List, 0, []).

t10 :-
  read_str(A, _),
  words_t10(A).

% Задание 11. Вариант 12.
% в листе есть буква, которая повторяется K раз
let_k_time(_, [], _, _) :- !, fail.
let_k_time(List, [UniH|UniT], K, El) :-
  count_let_in_list(List, UniH, Count),
  (Count = K ->
  (El = UniH, true);
  let_k_time(List, UniT, K, El)).

% все слова длины N
% a, b, c повторяются K раз
% d повторяется M раз
% остальные буквы не повторяются
words_t11(_, N, Word, N, K, M) :-
  uni_list(Word, Uni),
  let_k_time(Word, Uni, K, El1),
  El1 = 97,
  rm_equals(Word, El1, WordNoEl1),

  uni_list(WordNoEl1, UniNoEl1),
  let_k_time(WordNoEl1, UniNoEl1, K, El2),
  El2 = 98,
  rm_equals(WordNoEl1, El2, WordNoEl2),

  uni_list(WordNoEl2, UniNoEl2),
  let_k_time(WordNoEl2, UniNoEl2, K, El3),
  El3 = 99,
  rm_equals(WordNoEl2, El3, WordNoEl3),

  uni_list(WordNoEl3, UniNoEl3),
  let_k_time(WordNoEl3, UniNoEl3, M, El4),
  El4 = 100,
  rm_equals(WordNoEl3, El4, WordNoEl4),

  uni_list(WordNoEl4, WordNoEl4),
  write_str(Word), nl, !, fail.
words_t11(_, N, _, N, _, _) :- !, fail.
words_t11(List, CurLength, CurWord, N, K, M) :-
  in_list(List, El),
  append(CurWord, [El], CurWord1),
  CurLength1 is CurLength + 1,
  words_t11(List, CurLength1, CurWord1, N, K, M).
words_t11(List, N, K, M) :- words_t11(List, 0, [], N, K, M).

t11 :-
  write("Str -> "),
  read_str(A, _),
  write("N -> "),
  read(N),
  write("K -> "),
  read(K),
  write("M -> "),
  read(M),
  words_t11(A, N, K, M).