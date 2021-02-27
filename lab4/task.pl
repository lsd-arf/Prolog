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
sum_ls_down([H|T], CurSum, Sum) :- CurSum1 is CurSum + H, sum_ls_down(T, CurSum1, Sum).
sum_ls_down([H|T], Sum) :- sum_ls_down([H|T], 0, Sum).

% ������� 3
sum_ls_up([], 0) :- !.
sum_ls_up([H|T], Sum) :- sum_ls_up(T, Sum1), Sum is Sum1 + H.

% ������� 4
ls_num_el([H], El, CurNum, Num) :- ((H = El) -> Num is CurNum + 1; write("Such element isn\'t found")), !.
ls_num_el([H|T], El, CurNum, Num) :- CurNum1 is CurNum + 1, ((El = H) -> Num is CurNum1; ls_num_el(T, El, CurNum1, Num)).
ls_num_el([H|T], El, Num) :- ls_num_el([H|T], El, 0, Num).

% ������� 5
% ����� �������� � ������
ls_el_at_num([], _, _, _) :- write("Such element isn\'t found"), !.
ls_el_at_num([_], CurNum, Num, _) :- CurNum1 is CurNum + 1, CurNum1 < Num, write("Such element isn\'t found"), !.
ls_el_at_num([H|T], CurNum, Num, El) :- CurNum1 is CurNum + 1, ((CurNum1 is Num) -> El is H; ls_el_at_num(T, CurNum1, Num, El)).
ls_el_at_num([H|T], Num, El) :- ls_el_at_num([H|T], 0, Num, El).

% ������� 6
min_ls_up([H], CurMin, Min) :- (H < CurMin -> Min is H; Min is CurMin), !.
min_ls_up([H|T], CurMin, Min) :- (H < CurMin -> CurMin1 is H; CurMin1 is CurMin), min_ls_up(T, CurMin1, Min), Min is CurMin1.
min_ls_up([], _) :- write("List isn't exist"), fail, !.
min_ls_up([H], Min) :- Min is H, !.
min_ls_up([H|T], Min) :- min_ls_up(T, H, Min).

% ������� 7
min_ls_down([], Min, Min) :- !.
min_ls_down([H|T], CurMin, Min) :- (H < CurMin -> CurMin1 is H; CurMin1 is CurMin), min_ls_down(T, CurMin1, Min).
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
p([SubH|SubT], [H|T]) :- (SubH = H -> p(SubT, T); p([SubH|SubT], T)).

% ������� 12
rm_el([_|T], CurList, Num, Num, NewList) :- append_ls(CurList, T, NewList), !.
rm_el([H|T], CurList, CurNum, Num, NewList) :- append_ls(CurList, [H], CurList1), CurNum1 is CurNum + 1, rm_el(T, CurList1, CurNum1, Num, NewList).
rm_el(List, Num, NewList) :- rm_el(List, [], 1, Num, NewList).

% ������� 13
% ���������� ��������� � ������
count_els([], Num, Num) :- !.
count_els([_|T], CurNum, Num) :- CurNum1 is CurNum + 1, count_els(T, CurNum1, Num).

% �������� ���������� � �������� ���������
rm_equals(List, El, List) :- not(in_ls(List, El)), !.
rm_equals(List, El, NewList) :- ls_num_el(List, El, Num), rm_el(List, Num, List1), rm_equals(List1, El, NewList).