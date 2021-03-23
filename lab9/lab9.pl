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
words_length_5_where_2_a(_, Count, 5, Word) :-
  Count = 2,
  write_str(Word), nl, !, fail.
words_length_5_where_2_a(_, _, 5, _) :- !, fail.
words_length_5_where_2_a(List, CurCount, CurLength, CurWord) :-
  in_list(List, El),
  (El = 97 ->
  CurCount1 is CurCount + 1;
  CurCount1 is CurCount),
  append(CurWord, [El], CurWord1),
  CurLength1 is CurLength + 1,
  words_length_5_where_2_a(List, CurCount1, CurLength1, CurWord1).
words_length_5_where_2_a(List) :- words_length_5_where_2_a(List, 0, 0, []).
