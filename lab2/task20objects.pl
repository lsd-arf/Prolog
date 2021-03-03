topic(pewdiepie, 0).
topic(labelcom, 0).
topic(it_boroda, 1).
topic(item, 1).
topic(shifu, 1).
topic(simple_code, 2).
topic(extreme_code, 2).
topic(alexei_navalny, 3).
topic(soloviev_live, 3).
topic(iskusstvo_harizmy, 4).
topic(pavel_bagryantsev, 4).
topic(vdud, 5).
topic(v_gostyah_u_gordona, 5).
topic(wylsacom, 6).
topic(ikakprosto, 6).
topic(kuplinov_play, 7).
topic(marmok, 7).
topic(a4, 8).
topic(melliart, 8).
topic(sobolev, 9).
topic(larin, 9).

subscribers(pewdiepie, 7).
subscribers(labelcom, 6).
subscribers(it_boroda, 2).
subscribers(item, 0).
subscribers(simple_code, 2).
subscribers(extreme_code, 1).
subscribers(alexei_navalny, 6).
subscribers(soloviev_live, 3).
subscribers(iskusstvo_harizmy, 4).
subscribers(pavel_bagryantsev, 3).
subscribers(vdud, 6).
subscribers(v_gostyah_u_gordona, 4).
subscribers(wylsacom, 6).
subscribers(ikakprosto, 4).
subscribers(kuplinov_play, 7).
subscribers(marmok, 7).
subscribers(a4, 7).
subscribers(melliart, 6).
subscribers(sobolev, 6).
subscribers(larin, 5).

date(pewdiepie, 1).
date(labelcom, 3).
date(it_boroda, 3).
date(item, 3).
date(simple_code, 3).
date(extreme_code, 1).
date(alexei_navalny, 2).
date(soloviev_live, 4).
date(iskusstvo_harizmy, 3).
date(pavel_bagryantsev, 1).
date(vdud, 2).
date(v_gostyah_u_gordona, 1).
date(wylsacom, 1).
date(ikakprosto, 2).
date(kuplinov_play, 1).
date(marmok, 0).
date(a4, 2).
date(melliart, 1).
date(sobolev, 2).
date(larin, 1).

instagram(pewdiepie, 0).
instagram(labelcom, 0).
instagram(it_boroda, 0).
instagram(item, 0).
instagram(simple_code, 1).
instagram(extreme_code, 1).
instagram(alexei_navalny, 0).
instagram(soloviev_live, 0).
instagram(iskusstvo_harizmy, 1).
instagram(pavel_bagryantsev, 0).
instagram(vdud, 0).
instagram(v_gostyah_u_gordona, 0).
instagram(wylsacom, 0).
instagram(ikakprosto, 0).
instagram(kuplinov_play, 0).
instagram(marmok, 0).
instagram(a4, 0).
instagram(melliart, 0).
instagram(sobolev, 0).
instagram(larin, 0).

telegram(pewdiepie, 1).
telegram(labelcom, 1).
telegram(it_boroda, 0).
telegram(item, 0).
telegram(simple_code, 0).
telegram(extreme_code, 0).
telegram(alexei_navalny, 0).
telegram(soloviev_live, 0).
telegram(iskusstvo_harizmy, 0).
telegram(pavel_bagryantsev, 0).
telegram(vdud, 0).
telegram(v_gostyah_u_gordona, 1).
telegram(wylsacom, 0).
telegram(ikakprosto, 0).
telegram(kuplinov_play, 1).
telegram(marmok, 1).
telegram(a4, 1).
telegram(melliart, 1).
telegram(sobolev, 1).
telegram(larin, 0).

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



pr :-
  question1(X1),
  question2(X2),
  question3(X3),
  question4(X4),
  question5(X5),
  topic(X, X1),
  subscribers(X, X2),
  date(X, X3),
  instagram(X, X4),
  telegram(X, X5),
  write(X).