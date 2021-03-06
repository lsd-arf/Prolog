% ������� 1
% ��������� 2 ������
append_ls([], X, X).
append_ls([H|T1], X, [H|T2]) :- append_ls(T1, X, T2).

% ������ ������
read_ls(N, L) :- read_ls(N, 0, [], L), !.
read_ls(N, N, L, L) :- !.
read_ls(N, CurN, CurL, L) :- 
  CurN1 is CurN + 1, 
  read(X), 
  append_ls(CurL, [X], CurL1), 
  read_ls(N, CurN1, CurL1, L).

% ������� ������
write_ls([]) :- !.
write_ls([H|T]) :- 
  write(H), 
  write(" "), 
  write_ls(T).

% ������� 2
sum_ls_down([], Sum, Sum) :- !.
sum_ls_down([H|T], CurSum, Sum) :- 
  CurSum1 is CurSum + H, 
  sum_ls_down(T, CurSum1, Sum).
sum_ls_down([H|T], Sum) :- sum_ls_down([H|T], 0, Sum).

% ������� 3
sum_ls_up([], 0) :- !.
sum_ls_up([H|T], Sum) :- 
  sum_ls_up(T, Sum1), 
  Sum is Sum1 + H.

% ������� 4
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

% ������� 5
% ����� �������� � ������
ls_el_at_num([], _, _, _) :- write("Such element isn\'t found"), !.
ls_el_at_num([H|T], CurNum, Num, El) :- 
  CurNum1 is CurNum + 1, 
  ((CurNum1 is Num) -> 
  El is H; 
  ls_el_at_num(T, CurNum1, Num, El)).
ls_el_at_num(List, Num, El) :- ls_el_at_num(List, 0, Num, El).

% ������� 6
min_ls_up([H], CurMin, Min) :- 
  (H < CurMin -> 
  Min is H; 
  Min is CurMin), !.
min_ls_up([H|T], CurMin, Min) :- 
  (H < CurMin -> 
  CurMin1 is H; 
  CurMin1 is CurMin), 
  min_ls_up(T, CurMin1, Min), 
  Min is CurMin1.
min_ls_up([], _) :- write("List isn't exist"), fail, !.
min_ls_up([H], Min) :- Min is H, !.
min_ls_up([H|T], Min) :- min_ls_up(T, H, Min).

% ������� 7
min_ls_down([], Min, Min) :- !.
min_ls_down([H|T], CurMin, Min) :- 
  (H < CurMin -> 
  CurMin1 is H; 
  CurMin1 is CurMin), 
  min_ls_down(T, CurMin1, Min).
min_ls_down([H|T], Min) :- min_ls_down(T, H, Min).

% ������� 8
app8 :-
  write("���������� ��������� -> "),
  read(N), N =\= 0,
  write("������ -> "),
  read_ls(N, List),
  min_ls_down(List, Min),
  write("����������� ������� => "),
  write(Min), !.
app8 :-
  write("������ ������").

% ������� 9
% ���� �� ������� � ������
in_ls([H|_], H) :- !.
in_ls([_|T], El) :- in_ls(T, El).

% ������� 10
rev_ls([], InvList, InvList) :- !.
rev_ls([H|T], CurList, InvList) :- rev_ls(T, [H|CurList], InvList).
rev_ls(List, InvList) :- rev_ls(List, [], InvList).

% ������� 11
p([], _) :- !.
p([SubH|SubT], [H|T]) :- 
  (SubH = H -> 
  p(SubT, T); 
  p([SubH|SubT], T)).

% ������� 12
rm_el([_|T], CurList, Num, Num, NewList) :- append_ls(CurList, T, NewList), !.
rm_el([H|T], CurList, CurNum, Num, NewList) :- 
  append_ls(CurList, [H], CurList1), 
  CurNum1 is CurNum + 1, 
  rm_el(T, CurList1, CurNum1, Num, NewList).
rm_el(List, Num, NewList) :- rm_el(List, [], 1, Num, NewList).

% ������� 13
% �������� ���������� � �������� ���������
rm_equals(List, El, List) :- not(in_ls(List, El)), !.
rm_equals(List, El, NewList) :- 
  ls_num_el(List, El, Num), 
  rm_el(List, Num, List1), 
  rm_equals(List1, El, NewList).

% ������� 14
uni_els([]) :- !.
uni_els([H|T]) :- 
  not(in_ls(T, H)), 
  uni_els(T).

% ������� 15
uni_list([], []) :- !.
uni_list([H|T], List) :- 
  rm_equals(T, H, RmList), 
  uni_list(RmList, List1), 
  append_ls([H], List1, List).

% ������� 16
count_equals([], _, Count, Count) :- !.
count_equals([H|T], El, CurCount, Count) :- 
  (H = El -> 
  CurCount1 is CurCount + 1; 
  CurCount1 is CurCount), 
  count_equals(T, El, CurCount1, Count).
count_equals(List, El, Count) :- count_equals(List, El, 0, Count).

% ������� 17
% ���������� ��������� � ������
count_els([], Count, Count) :- !.
count_els([_|T], CurCount, Count) :- 
  CurCount1 is CurCount + 1, 
  count_els(T, CurCount1, Count).
count_els(List, Count) :- count_els(List, 0, Count).

% ������� 18, ������� 12
% ������ 11
find_el1([H|T], El) :- 
  rm_equals([H|T], H, [NewH|NewT]), 
  count_els([NewH|NewT], Count), 
  (Count = 1 -> 
  El is NewH; 
  El is H).
find_el2([H|T], El) :- 
  (in_ls(T, H) -> 
  find_el2(T, El); 
  El is H).

% ������ 12
% ������������ �������
max_ls_down([], Max, Max) :- !.
max_ls_down([H|T], CurMax, Max) :- 
  (H > CurMax -> 
  CurMax1 is H; 
  CurMax1 is CurMax), 
  max_ls_down(T, CurMax1, Max).
max_ls_down([H|T], Max) :- max_ls_down(T, H, Max).

% �������� ������ �� ������ (������ � �������)
get_ls_before(_, Num, Num, List, List) :- !.
get_ls_before([H|T], CurNum, Num, CurList, NewList) :- 
  append_ls(CurList, [H], CurList1),
  CurNum1 is CurNum + 1,
  get_ls_before(T, CurNum1, Num, CurList1, NewList).
get_ls_before(List, Num, NewList) :- get_ls_before(List, 0, Num, [], NewList).

% �������� ������ ����� ������ (������ � �������)
get_ls_after(List, Num, ListAfter) :- 
  Num1 is Num - 1, 
  get_ls_before(List, Num1, ListBefore), 
  append_ls(ListBefore, ListAfter, List).

% �������� ������ ����� �������� (��� ���)
get_ls_between(List, Num1, Num2, ListBetween) :- 
  get_ls_before(List, Num1, ListBefore),
  append_ls(ListBefore, ListAfter, List),
  Num22 is Num2 - Num1 - 1,
  get_ls_before(ListAfter, Num22, ListBetween).

rev_between(List, NewList) :- 
  min_ls_down(List, Min),
  max_ls_down(List, Max),
  ls_num_el(List, Min, Nmin),
  ls_num_el(List, Max, Nmax),
  (
  Nmin = Nmax ->
  append_ls(List, [], NewList);
  (
  Nmin < Nmax ->
  get_ls_before(List, Nmin, ListBefore),
  get_ls_after(List, Nmax, ListAfter),
  get_ls_between(List, Nmin, Nmax, ListBetween);
  (
  get_ls_before(List, Nmax, ListBefore),
  get_ls_after(List, Nmin, ListAfter),
  get_ls_between(List, Nmax, Nmin, ListBetween)
  )
  ),
  rev_ls(ListBetween, RevList),
  append_ls(ListBefore, RevList, ListBB),
  append_ls(ListBB, ListAfter, NewList)
  ).

% ������ 22
% ���������� ���� �� ��������� �� ���������
ls_interval([], _, _, List, List) :- !.
ls_interval([H|T], A, B, CurList, NewList) :- 
  ((H > A, H < B) -> 
  append_ls(CurList, [H], CurList1), 
  ls_interval(T, A, B, CurList1, NewList); 
  ls_interval(T, A, B, CurList, NewList)).
ls_interval(List, A, B, NewList) :- ls_interval(List, A, B, [], NewList).

ls_interval_count_min(List, A, B, Count) :-
  ls_interval(List, A, B, NewList),
  min_ls_down(NewList, Min),
  count_equals(NewList, Min, Count).

% ������ 24
two_max_els(List, Max1, Max2) :- 
  max_ls_down(List, Max1),
  ls_num_el(List, Max1, Num1),
  rm_el(List, Num1, NewList),
  max_ls_down(NewList, Max2).

% ������ 33
ls_alternate([], 1) :- !.
ls_alternate([], 0) :- !.
ls_alternate([H|T], Flag) :-
  ((Flag = 0, H < 0) ->
  ls_alternate(T, 1);
  ((Flag = 1, H > 0) ->
  ls_alternate(T, 0); 
  fail)).
ls_alternate([H|T]) :- 
  (H < 0 -> 
  ls_alternate(T, 1); 
  ls_alternate(T, 0)).

% ������ 36
% �������� ������ �������� �������
% ����� ����� fail, �.� � ��������� ������ X = 0, � ��� ���
ls_first_odd([], 0) :- write("List hasn\'t odd elements"), fail, !.
ls_first_odd([H|T], El) :- (H mod 2 =\= 0 -> El is H; ls_first_odd(T, El)).

max_odd_ls_down([], Max, Max) :- !.
max_odd_ls_down([H|T], CurMax, Max) :- 
  ((H > CurMax, H mod 2 =\= 0) -> 
  CurMax1 is H; 
  CurMax1 is CurMax), 
  max_odd_ls_down(T, CurMax1, Max).
max_odd_ls_down(List, Max) :-
  ls_first_odd(List, El),
  max_odd_ls_down(List, El, Max).

% ������ 42
% ������� �������������� ���������
ls_avg(List, Avg) :-
  sum_ls_down(List, Sum),
  count_els(List, Count),
  Avg is Sum / Count.

els_less_avg([], _, List, List) :- !.
els_less_avg([H|T], Avg, CurList, NewList) :-
  (H < Avg ->
  append_ls(CurList, [H], CurList1),
  els_less_avg(T, Avg, CurList1, NewList);
  els_less_avg(T, Avg, CurList, NewList)).
els_less_avg(List, NewList) :-
  ls_avg(List, Avg),
  els_less_avg(List, Avg, [], NewList).

% ������ 48
% �������, ������� ����������� ���������� ����� ���
ls_el_maxcount(_, [], _, El, El) :- !.
ls_el_maxcount(List, [UniH|UniT], Count, CurEl, El) :-
  count_equals(List, UniH, CountEquals),
  (CountEquals > Count ->
  CurEl1 is UniH, Count1 is CountEquals;
  CurEl1 is CurEl, Count1 is Count),
  ls_el_maxcount(List, UniT, Count1, CurEl1, El).
ls_el_maxcount(List, El) :-
  uni_list(List, [UniH|UniT]),
  count_equals(List, UniH, CountEquals),
  ls_el_maxcount(List, UniT, CountEquals, UniH, El).

ls_with_nums([], _, _, _, List, List) :- !.
ls_with_nums([H|T], El, CurNum, Count, CurList, NewList) :-
  CurNum1 is CurNum + 1,
  (El = H ->
  append_ls(CurList, [CurNum1], CurList1);
  append_ls(CurList, [], CurList1)),
  ls_with_nums(T, El, CurNum1, Count, CurList1, NewList).
ls_with_nums(List, NewList) :-
  ls_el_maxcount(List, El),
  count_els(List, Count),
  ls_with_nums(List, El, 0, Count, [], NewList).

% ������ 60
el_div_num_and_1_time(_, [], _, List, List) :- !.
el_div_num_and_1_time(List, [H|T], CurNum, CurList, NewList) :-
  CurNum1 is CurNum + 1,
  ((H mod CurNum1 =:= 0,
  count_equals(List, H, 1)) ->
  append_ls(CurList, [H], CurList1);
  append_ls(CurList, [], CurList1)),
  el_div_num_and_1_time(List, T, CurNum1, CurList1, NewList).
el_div_num_and_1_time(List, NewList) :- el_div_num_and_1_time(List, List, 0, [], NewList).