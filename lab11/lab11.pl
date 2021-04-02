:- dynamic topic/2.
:- dynamic subs/2.
:- dynamic date/2.
:- dynamic inst/2.
:- dynamic teleg/2.

read_str(A) :-
  get0(X),
  r_str(X, A, []).
r_str(10, A, A) :- !.
r_str(X, A, B) :-
  append(B, [X], B1),
  get0(X1),
  r_str(X1, A, B1).

topic_r(X, Y) :-
  repeat,
  (topic(X, Y) ->
  (nl, write(X),
  nl, write(Y),
  write("."),
  retract(topic(X, Y)));
  X = nil, Y = nil).

subs_r(X, Y) :-
  repeat,
  (subs(X, Y) ->
  (nl, write(X),
  nl, write(Y),
  write("."),
  retract(subs(X, Y)));
  X = nil, Y = nil).

date_r(X, Y) :-
  repeat,
  (date(X, Y) ->
  (nl, write(X),
  nl, write(Y),
  write("."),
  retract(date(X, Y)));
  X = nil, Y = nil).

inst_r(X, Y) :-
  repeat,
  (inst(X, Y) ->
  (nl, write(X),
  nl, write(Y),
  write("."),
  retract(inst(X, Y)));
  X = nil, Y = nil).

teleg_r(X, Y) :-
  repeat,
  (teleg(X, Y) ->
  (nl, write(X),
  nl, write(Y),
  write("."),
  retract(teleg(X, Y)));
  X = nil, Y = nil).

prTell :-
  tell('C:/Users/Владислав/Desktop/Prolog/lab11/topic.txt'), topic_r(X1, _), X1 = nil, told,
  tell('C:/Users/Владислав/Desktop/Prolog/lab11/subs.txt'),  subs_r(X2, _),  X2 = nil, told,
  tell('C:/Users/Владислав/Desktop/Prolog/lab11/date.txt'),  date_r(X3, _),  X3 = nil, told,
  tell('C:/Users/Владислав/Desktop/Prolog/lab11/inst.txt'),  inst_r(X4, _),  X4 = nil, told,
  tell('C:/Users/Владислав/Desktop/Prolog/lab11/teleg.txt'), teleg_r(X5, _), X5 = nil, told.

prSee :-
  see('C:/Users/Владислав/Desktop/Prolog/lab11/topic.txt'), get0(Sym1), read_data(Sym1, 1), seen,
  see('C:/Users/Владислав/Desktop/Prolog/lab11/subs.txt'),  get0(Sym2), read_data(Sym2, 2), seen,
  see('C:/Users/Владислав/Desktop/Prolog/lab11/date.txt'),  get0(Sym3), read_data(Sym3, 3), seen,
  see('C:/Users/Владислав/Desktop/Prolog/lab11/inst.txt'),  get0(Sym4), read_data(Sym4, 4), seen,
  see('C:/Users/Владислав/Desktop/Prolog/lab11/teleg.txt'), get0(Sym5), read_data(Sym5, 5), seen.

read_data(-1, _) :- !.
read_data(_, Flag) :-
  read_str(Lang),
  name(X, Lang),
  read(Y),
  (
    Flag = 1 ->
    asserta(topic(X, Y));
    (
      Flag = 2 ->
      asserta(subs(X, Y));
      (
        Flag = 3 ->
        asserta(date(X, Y));
        (
          Flag = 4 ->
          asserta(inst(X, Y));
          asserta(teleg(X, Y))
        )
      )
    )
  ),
  get0(Sym),
  read_data(Sym, Flag).

question1(X1) :- write("What is the topic of the channel?"), nl,
				write("0. Entertainment"), nl,
				write("1. IT"), nl,
				write("2. Programming"), nl,
				write("3. Politics"), nl,
				write("4. Motivation"), nl,
				write("5. Interview+"), nl,
				write("6. Technologies"), nl,
				write("7. Games"), nl,
				write("8. Children\'s content"), nl,
				write("9. Mixed content"), nl,
				read(X1).

question2(X2) :- write("How many subscribers are on the channel?"), nl,
				write("0. From 0 to 100\'000"), nl,
				write("1. From 100\'000 to 200\'000"), nl,
				write("2. From 200\'000 to 500\'000"), nl,
				write("3. From 500\'000 to 1\'000\'000"), nl,
				write("4. From 1\'000\'000 to 2\'000\'000"), nl,
				write("5. From 2\'000\'000 to 5\'000\'000"), nl,
				write("6. From 5\'000\'000 to 10\'000\'000"), nl,
				write("7. More than 10\'000\'000"), nl,
				read(X2).

question3(X3) :- write("When was the channel created?"), nl,
				write("0. Before 2010"), nl,
				write("1. From 2010 to 2012"), nl,
				write("2. From 2013 to 2015"), nl,
				write("3. From 2016 to 2018"), nl,
				write("4. From 2019 to 2021"), nl,
				read(X3).

question4(X4) :- write("Does this channel have Instagram?"), nl,
				write("0. Yes"), nl,
				write("1. NO"), nl,
				read(X4).

question5(X5) :- write("Does this channel have Telegram?"), nl,
				write("0. Yes"), nl,
				write("1. NO"), nl,
				read(X5).

% альтернатива (устаревшая функция)
addBlogger(Blogger, X1, X2, X3, X4, X5) :-
  append('C:/Users/Владислав/Desktop/Prolog/lab11/topic.txt'),
  nl, write(Blogger), nl, write(X1), write("."), told,

  append('C:/Users/Владислав/Desktop/Prolog/lab11/subs.txt'),
  nl, write(Blogger), nl, write(X2), write("."), told,

  append('C:/Users/Владислав/Desktop/Prolog/lab11/date.txt'),
  nl, write(Blogger), nl, write(X3), write("."), told,

  append('C:/Users/Владислав/Desktop/Prolog/lab11/inst.txt'),
  nl, write(Blogger), nl, write(X4), write("."), told,

  append('C:/Users/Владислав/Desktop/Prolog/lab11/teleg.txt'),
  nl, write(Blogger), nl, write(X5), write("."), told.

pr :-
  prSee,
  question1(X1),
  question2(X2),
  question3(X3),
  question4(X4),
  question5(X5),
  (topic(X, X1),
  subs(X, X2),
  date(X, X3),
  inst(X, X4),
  teleg(X, X5),
  write(X);
  (write("Blogger -> "),
  read(Blogger),
  asserta(topic(Blogger, X1)),
  asserta(subs(Blogger, X2)),
  asserta(date(Blogger, X3)),
  asserta(inst(Blogger, X4)),
  asserta(teleg(Blogger, X5)),
  prTell, nl,
  write("Blogger was added!")
  %addBlogger(Blogger, X1, X2, X3, X4, X5)
  )).