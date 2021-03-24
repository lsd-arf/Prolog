% Задание 1
max(X, Y, Z) :- X >= Y, Z is X, !.
max(_, Y, Z) :- Z is Y.

% Задание 2
max(X, Y, U, Z) :- X >= Y, X >= U, Z is X, !.
max(_, Y, U, Z) :- Y >= U, Z is Y, !.
max(_, _, U, Z) :- Z is U.

% Задание 3
% рекурсия вверх
fact(0, 1) :- !.
fact(N, X) :- N1 is N - 1, fact(N1, X1), X is X1 * N.

% Задание 4
% рекурсия вниз
fact(0, CurX, CurX) :- !.
fact(N, CurX, X) :- CurX1 is CurX * N, N1 is N - 1, fact(N1, CurX1, X).
factN(N, X) :- fact(N, 1, X).

% Задание 5
fib(1, 1) :- !.
fib(2, 1) :- !.
fib(N, X) :- N1 is N - 1, N2 is N - 2, fib(N1, X1), fib(N2, X2), X is X1 + X2.

% Задание 6
fib(1, _, CurX2, CurX2) :- !.
fib(2, _, CurX2, CurX2) :- !.
fib(N, CurX1, CurX2, X) :- CurX3 is CurX1 + CurX2, N1 is N - 1, fib(N1, CurX2, CurX3, X).
fibN(N, X) :- fib(N, 1, 1, X).

% Задание 7
sumOfDigits(0, 0) :- !.
sumOfDigits(Num, Sum) :- Mod is Num mod 10, Num1 is Num div 10, sumOfDigits(Num1, Sum1), Sum is Sum1 + Mod.

% Задание 8
sumOfDigits(0, CurSum, CurSum) :- !.
sumOfDigits(Num, CurSum, Sum) :- Mod is Num mod 10, Num1 is Num div 10, CurSum1 is CurSum + Mod, sumOfDigits(Num1, CurSum1, Sum).
sumOfDigitsN(Num, Sum) :- sumOfDigits(Num, 0, Sum).

% Задание 9
minDigit(Min, Min) :- Min div 10 =:= 0, !.
minDigit(Num, Min) :- Min2 is Num mod 10, Num1 is Num div 10, minDigit(Num1, Min1), (Min1 < Min2 -> Min is Min1; Min is Min2).

% Задание 10
minDigit(0, 10, 0) :- !.
minDigit(0, CurMin, CurMin) :- !.
minDigit(Num, CurMin, Min) :- CurMin1 is Num mod 10, Num1 is Num div 10, (CurMin1 < CurMin -> CurMin2 is CurMin1; CurMin2 is CurMin), minDigit(Num1, CurMin2, Min).
minDigitN(Num, Min) :- minDigit(Num, 10, Min).

% Задание 11
% рекурсия вверх
countDigits(Num, Count) :- Num < 3, Count is 1, !.
countDigits(Num, Count) :- Num >= 3, Num < 10, Count is 0, !.
countDigits(Num, Count) :- Mod is Num mod 10, Num1 is Num div 10, countDigits(Num1, Count1), (Mod < 3 -> Count is Count1 + 1; Count is Count1).

% рекурсия вниз
countDigits(Num, CurCount, Count) :- Num < 3, Count is CurCount + 1, !.
countDigits(Num, CurCount, Count) :- Num >= 3, Num < 10, Count is CurCount, !.
countDigits(Num, CurCount, Count) :- Mod is Num mod 10, Num1 is Num div 10, (Mod < 3 -> CurCount1 is CurCount + 1; CurCount1 is CurCount), countDigits(Num1, CurCount1, Count).
countDigitsN(Num, Count) :- countDigits(Num, 0, Count).

% Задание 12
% НОД чисел
nodNums(Num1, Num1, Num1, Num1) :- !.
nodNums(_, _, 1, 1) :- !.
nodNums(Num1, Num2, CurNod, Nod) :- Num1 mod CurNod =:= 0, Num2 mod CurNod =:= 0, Nod is CurNod, !.
nodNums(Num1, Num2, CurNod, Nod) :- CurNod1 is CurNod - 1, nodNums(Num1, Num2, CurNod1, Nod).
nodNumsN(Num1, Num2, Nod) :- (Num1 > Num2 -> nodNums(Num1, Num2, Num2, Nod); nodNums(Num1, Num2, Num1, Nod)).

% Проверка на простоту
simpleNum(_, 1, 1) :- !.
simpleNum(Num, CurDel, Del) :- not(Num mod CurDel =:= 0), CurDel1 is CurDel - 1, simpleNum(Num, CurDel1, Del).
simpleNumN(1) :- !.
simpleNumN(Num) :- CurDel is Num - 1, simpleNum(Num, CurDel, _).

% Количество делителей
countDels(_, 0, CurCount, CurCount) :- !.
countDels(Num, CurDel, CurCount, Count) :- (Num mod CurDel =:= 0 -> CurCount1 is CurCount + 1; CurCount1 is CurCount), CurDel1 is CurDel - 1, countDels(Num, CurDel1, CurCount1, Count).
countDelsN(Num, Count) :- countDels(Num, Num, 0, Count).

% Задание 13
colatz(1, 1) :- !.
colatz(2, 2) :- !.
colatz(X, N) :- X > 2, X mod 2 =:= 0, X1 is (X // 2), X =\= 1, colatz(X1, R), N is R + 1.
colatz(X, N) :- X > 2, X mod 2 =\= 0, X1 is (3 * X + 1), X =\= 1, colatz(X1, R), N is R + 1.

colatzN(Max, Max, 10000) :- !.
% N -текущая длина цепочки, Max - максимальная
colatzN(Max, MaxN, Num) :- Num1 is (Num + 1), colatz(Num1, N), (N > Max -> Max1 is N, colatzN(Max1, MaxN, Num1); colatzN(Max, MaxN, Num1)).
colatzN1(Max, MaxN, Num):- colatzN(Max, MaxN, Num), write(MaxN).

% Задание 14
% рекурсия вверх
sumOfDels(_, CurDel, 0) :- CurDel < 4, !.
sumOfDels(Num, CurDel, Sum) :- CurDel1 is CurDel - 1, sumOfDels(Num, CurDel1, Sum1), ((Num mod CurDel =:= 0, not(simpleNumN(CurDel))) -> Sum is Sum1 + CurDel; Sum is Sum1).
sumOfDelsU(Num, Sum) :- sumOfDels(Num, Num, Sum).

% рекурсия вниз
sumOfDels(_, CurDel, CurSum, CurSum) :- CurDel < 4, !.
sumOfDels(Num, CurDel, CurSum, Sum) :- CurDel1 is CurDel - 1, ((Num mod CurDel =:= 0, not(simpleNumN(CurDel))) -> CurSum1 is CurSum + CurDel; CurSum1 is CurSum), sumOfDels(Num, CurDel1, CurSum1, Sum).
sumOfDelsD(Num, Sum) :- sumOfDels(Num, Num, 0, Sum).

% Задание 15 % Пример: (10, X) % Ответ: 3 % Числа: 4, 6, 8
% блок: сумма простых цифр числа
sumOfSimpleDigits(0, CurSum, CurSum) :- !.
sumOfSimpleDigits(Num, CurSum, Sum) :- Mod is Num mod 10, Num1 is Num div 10, (simpleNumN(Mod) -> CurSum1 is CurSum + Mod; CurSum1 is CurSum), sumOfSimpleDigits(Num1, CurSum1, Sum).
sumOfSimpleDigitsN(Num, Sum) :- sumOfDigits(Num, 0, Sum).

% блок: взаимно простые числа
coprimeNums(Num1, Num2) :- nodNumsN(Num1, Num2, Nod), Nod = 1.

% блок: общая задача
countNumsT15(_, 0, CurCount, CurCount) :- !.
countNumsT15(Num, CurDel, CurCount, Count) :- 
((
not(Num mod CurDel =:= 0), 
not(coprimeNums(Num, CurDel)), 
sumOfSimpleDigitsN(Num, SumOfSD),
coprimeNums(SumOfSD, CurDel)
) -> CurCount1 is CurCount + 1; CurCount1 is CurCount
), CurDel1 is CurDel - 1,
countNumsT15(Num, CurDel1, CurCount1, Count).
countNumsT15N(Num, Count) :- countNumsT15(Num, Num, 0, Count).

% Задание 16
% бегаем по сумме (Sum = неуд условию, t16f2 ->)
t16f1(CurSum, Sum) :-
  CurSum1 is CurSum + 2,
  (simpleNumN(CurSum) ->
  t16f1(CurSum1, Sum);
  ((t16f2(CurSum, 1, Simple),
  Simple \= -1) ->
  t16f1(CurSum1, Sum);
  Sum = CurSum)), !.

% бегаем по простым (если t16f3 = false, вызываем также t16f2 + 2
t16f2(CurSum, CurSimple, Simple) :-
  CurSimple1 is CurSimple + 2,
  (CurSimple >= CurSum ->
  Simple = -1;
  (simpleNumN(CurSimple) ->
  ((t16f3(CurSum, CurSimple, 1, Square),
  Square \= -1) ->
  Simple = CurSimple;
  t16f2(CurSum, CurSimple1, Simple));
  t16f2(CurSum, CurSimple1, Simple))), !.

% бегаем по квадратам чисел
t16f3(CurSum, CurSimple, CurSquare, Square) :-
  CurSquare1 is CurSquare + 1,
  LocalSum is CurSimple + 2 * CurSquare * CurSquare,
  (CurSum = LocalSum ->
  Square = CurSquare;
  (CurSum < LocalSum ->
  Square = -1;
  t16f3(CurSum, CurSimple, CurSquare1, Square))), !.

t16 :-
  writeln("Wait 1 min..."),
  t16f1(1, X),
  write("Answer => "),
  write(X).