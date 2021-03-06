sub_posl([], _) :- !.
sub_posl(_, []) :- fail, !.
sub_posl([H|Sub_list], [H|List]) :- sub_posl(Sub_list, List), !.
sub_posl(Sub_list, [_|List]) :- sub_posl(Sub_list, List).

sub_set([], []).
sub_set([H|Sub_set], [H|Set]) :- sub_set(Sub_set, Set).
sub_set(Sub_set, [H|Set]) :- sub_set(Sub_set, Set).

in_list([El|_], El).
in_list([_|T], El) :- in_list(T, El).


sprava_next(A, B, [C]):-fail.
sprava_next(A, B, [A|[B|Tail]]).
sprava_next(A, B, [_|List]) :- sprava_next(A, B, List).

sleva_next(A, B, [C]) :- fail.
sleva_next(A, B, [B|[A|Tail]]).
sleva_next(A, B, [_|List]) :- sleva_next(A, B, List).

next_to(A, B, List) :- sprava_next(A, B, List).
next_to(A, B, List) :- sleva_next(A, B, List).

el_no(List, Num, El) :- el_no(List, Num, 1, El).
el_no([H|_], Num, Num, H) :- !.
el_no([_|Tail], Num, Ind, El) :- Ind1 is Ind + 1, el_no(Tail, Num, Ind1, El).

% Задание 1
pr_ein :- Houses = [_, _ ,_ ,_ ,_],

		in_list(Houses, [red, english, _, _, _]),
		in_list(Houses, [_, spanish, _, dog, _]),
		in_list(Houses, [green, _, coffee, _, _]),
		in_list(Houses, [_, ukrain, tea, _, _]),
		sprava_next([green, _, _, _, _], [white, _, _, _, _], Houses),
		in_list(Houses, [_, _, _, ulitka, old_gold]),
		in_list(Houses, [yellow, _, _, _, kool]),
		el_no(Houses, 3, [_, _, milk, _, _]),
		el_no(Houses, 1, [_, norway, _, _, _]),
		next_to([_, _, _, _, chester], [_, _, _, fox, _], Houses),
		next_to([_, _, _, _, kool],[_, _, _, horse, _], Houses),
		in_list(Houses, [_, _, orange, _, lucky]),
		in_list(Houses, [_, japan, _, _, parlament]),
		next_to([_, norway, _, _, _], [blue, _, _, _, _], Houses),

		in_list(Houses, [_, WHO1, water, _, _]),
		in_list(Houses, [_, WHO2, _, zebra, _]),
		write(Houses),
		write(WHO1), nl, write(WHO2).

% Задание 2, фамилия - цвет волос
pr_friends :- Friends = [_, _, _],

		in_list(Friends, [belokurov, _]),
		in_list(Friends, [chernov, _]),
		in_list(Friends, [rijov, _]),
		in_list(Friends, [_, white]),
		in_list(Friends, [_, black]),
		in_list(Friends, [_, red]),

		not(in_list(Friends, [belokurov, white])),
		not(in_list(Friends, [chernov, black])),
		not(in_list(Friends, [rijov, red])),

		write(Friends), !.

% Задание 3, имя - цвет платья - цвет туфель
pr_girls :- Girls = [_, _, _],

		in_list(Girls, [_, white, _]),
		in_list(Girls, [_, _, white]),
		in_list(Girls, [_, green, _]),
		in_list(Girls, [_, _, green]),
		in_list(Girls, [_, blue, _]),
		in_list(Girls, [_, _, blue]),
		in_list(Girls, [anya, _, _]),
		in_list(Girls, [natasha, _, green]),
		in_list(Girls, [valya, _, _]),

		not(in_list(Girls, [natasha, green, _])),
		not(in_list(Girls, [valya, white, white])),

		write(Girls), !.

% Задание 4, профессия - фамилия - флаг наличия братьев/сестёр - младший/средний/старший - на чьей сестре женат
pr_factory :- Factory = [_, _, _],

		in_list(Factory, [slesar, _, 0, 0, _]),
		in_list(Factory, [tokar, _, _, 1, _]),
		in_list(Factory, [svarschik, _, _, _, _]),
		in_list(Factory, [_, borisov, 1, _, _]),
		in_list(Factory, [_, ivanov, _, _, _]),
		in_list(Factory, [_, semenov, _, 2, borisov]),

		write(Factory), !.

% Задание 5, сосуд - напиток
pr_containers :- Containers = [_, _, _, _],

		in_list(Containers, [butylka, _]),
		in_list(Containers, [stakan, _]),
		in_list(Containers, [kuvshin, _]),
		in_list(Containers, [banka, _]),

		in_list(Containers, [_, moloko]),
		in_list(Containers, [_, limonad]),
		in_list(Containers, [_, kvas]),
		in_list(Containers, [_, voda]),

		not(in_list(Containers, [butylka, voda])),
		not(in_list(Containers, [butylka, moloko])),

		next_to([_, limonad], [kuvshin, _], Containers),
		next_to([_, limonad], [_, kvas], Containers),

		not(in_list(Containers, [banka, limonad])),
		not(in_list(Containers, [banka, voda])),

		next_to([banka, _], [stakan, _], Containers),
		next_to([banka, _], [_, moloko], Containers),

		write(Containers), !.

% Задание 6, фамилия - деятельность
pr_geniuses :- Geniuses = [_, _, _, _],

		in_list(Geniuses, [voronov, _]),
		in_list(Geniuses, [pavlov, _]),
		in_list(Geniuses, [levitskiy, _]),
		in_list(Geniuses, [saharov, _]),

		in_list(Geniuses, [_, dancer]),
		in_list(Geniuses, [_, artist]),
		in_list(Geniuses, [_, singer]),
		in_list(Geniuses, [_, writer]),

		not(in_list(Geniuses, [voronov, singer])),
		not(in_list(Geniuses, [levitskiy, singer])),

		not(in_list(Geniuses, [pavlov, writer])),
		not(in_list(Geniuses, [pavlov, artist])),

		not(in_list(Geniuses, [saharov, writer])),
		not(in_list(Geniuses, [voronov, writer])),

		write(Geniuses), !.

% Задание 7, место - имя - национальность - спорт
pr_universiade :- Universiade = [_, _, _],

		in_list(Universiade, [1, _, _, _]),
		in_list(Universiade, [2, _, _, _]),
		in_list(Universiade, [3, _, _, _]),

		in_list(Universiade, [_, michael, _, _]),
		in_list(Universiade, [_, saymon, _, _]),
		in_list(Universiade, [_, richard, _, _]),

		in_list(Universiade, [_, _, american, _]),
		in_list(Universiade, [_, _, israel, _]),
		in_list(Universiade, [_, _, australian, _]),

		in_list(Universiade, [_, _, _, cricket]),
		in_list(Universiade, [_, _, _, tennis]),
		in_list(Universiade, [_, _, _, basketball]),

		in_list(Universiade, [_, michael, _, basketball]),
		not(in_list(Universiade, [_, michael, american, _])),

		in_list(Universiade, [_, saymon, israel, _]),
		not(in_list(Universiade, [_, saymon, _, tennis])),

		in_list(Universiade, [1, _, _, cricket]),
		
		in_list(Universiade, [_, Name, australian, _]),
		in_list(Universiade, [_, richard, _, Sport]),

		write(Universiade), nl,
		write(Name), nl, write(Sport), !.

% Задание 8, имя - инструмент - камень - срок заточения
pr_gnomes :-
	Gnomes = [_, _, _, _, _],

	in_list(Gnomes, [_, _, _, 80]),
	in_list(Gnomes, [_, _, _, 131]),
	in_list(Gnomes, [_, _, _, 159]),
	in_list(Gnomes, [_, _, _, 176]),
	in_list(Gnomes, [_, _, _, 202]),

	in_list(Gnomes, [_, _, rubin, _]),
	in_list(Gnomes, [_, _, sapfir, _]),
	in_list(Gnomes, [_, _, almaz, _]),
	in_list(Gnomes, [_, _, izumrud, _]),
	in_list(Gnomes, [_, _, agat, _]),

	in_list(Gnomes, [_, kail, _, _]),
	in_list(Gnomes, [_, zastup, _, _]),
	in_list(Gnomes, [_, trubobur, _, _]),
	in_list(Gnomes, [_, kirka, _, _]),
	in_list(Gnomes, [_, molot, _, _]),

	in_list(Gnomes, [dryhly, _, _, _]),
	in_list(Gnomes, [brykly, _, _, _]),
	in_list(Gnomes, [figli, _, _, _]),
	in_list(Gnomes, [zvyakli, _, _, _]),
	in_list(Gnomes, [kvakli, _, _, _]),

	not(in_list(Gnomes, [_, kail, sapfir, _])),
	%sprava_next([_, _, sapfir, _], [_, kail, _, _], Gnomes),

	not(in_list(Gnomes, [_, _, almaz, 131])),
	%sprava_next([_, _, _, 131], [_, _, almaz, _], Gnomes),

	not(in_list(Gnomes, [brykly, trubobur, _, _])),
	%sprava_next([_, trubobur, _, _], [brykly, _, _, _], Gnomes),
	not(in_list(Gnomes, [brykly, _, izumrud, _])),
	not(in_list(Gnomes, [_, trubobur, izumrud, _])),
	in_list(Gnomes, [brykly, _, _, Sbrykly]),
	in_list(Gnomes, [_, _, izumrud, Sizumrud]),
	Sbrykly < Sizumrud,
	%sprava_next([brykly, _, _, _], [_, _, izumrud, _], Gnomes),

	not(in_list(Gnomes, [figli, _, izumrud, _])),
	in_list(Gnomes, [figli, _, _, Sfigli]),
	Sfigli < Sizumrud,
	not(in_list(Gnomes, [figli, _, _, 80])),
	%sprava_next([figli, _, _, _], [_, _, izumrud, _], Gnomes),

	not(in_list(Gnomes, [zvyakli, _, sapfir, _])),
	not(in_list(Gnomes, [zvyakli, _, agat, _])),
	%sprava_next([zvyakli, _, _, _], [_, _, agat, _], Gnomes),

	not(in_list(Gnomes, [kvakli, kirka, _, _])),
	not(in_list(Gnomes, [kvakli, molot, _, _])),
	in_list(Gnomes, [_, molot, almaz, _]),
	%sprava_next([_, kirka, _, _], [kvakli, _, _, _], Gnomes),
	%sprava_next([kvakli, _, _, _], [_, molot, _, _], Gnomes),

	write(Gnomes), !.