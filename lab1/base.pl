man(grigory_g).
man(ivan_c).
man(anatoly_n).
man(vladimir_c).
man(alexander_c).
man(andrei_k).
man(vladislav_c).
man(sergei_n).
man(victor_t).
man(alexei_k).

woman(galina_g).
woman(eudokia_c).
woman(valentina_a).
woman(ludmila_g).
woman(natalia_c).
woman(svetlana_c).
woman(olga_k).
woman(olga_m).
woman(irina_o).
woman(anna_t).
woman(anastasia_c).
woman(elena_c).
woman(elena_k).
woman(ekaterina_n).
woman(elizaveta_t).
woman(marina_k).

parent(galina_g, valentina_a).
parent(grigory_g, valentina_a).
parent(galina_g, ludmila_g).
parent(grigory_g, ludmila_g).
parent(galina_g, natalia_c).
parent(grigory_g, natalia_c).

parent(sergei_n, anatoly_n).
parent(ekaterina_n, anatoly_n).

parent(eudokia_c, vladimir_c).
parent(ivan_c, vladimir_c).
parent(eudokia_c, alexander_c).
parent(ivan_c, alexander_c).
parent(eudokia_c, olga_k).
parent(ivan_c, olga_k).

parent(victor_t, svetlana_c).
parent(elizaveta_t, svetlana_c).

parent(alexei_k, andrei_k).
parent(marina_k, andrei_k).

parent(anatoly_n, olga_m).
parent(ludmila_g, olga_m).

parent(natalia_c, vladislav_c).
parent(vladimir_c, vladislav_c).
parent(natalia_c, irina_o).
parent(vladimir_c, irina_o).

parent(alexander_c, anna_t).
parent(svetlana_c, anna_t).
parent(alexander_c, anastasia_c).
parent(svetlana_c, anastasia_c).
parent(alexander_c, elena_c).
parent(svetlana_c, elena_c).

parent(olga_k, elena_k).
parent(andrei_k, elena_k).

c_write(X):-write(X),write(" ").

child(X,Y):-parent(Y,X).
children(Y):-child(X,Y),c_write(X),fail.

mother(X,Y):-parent(X,Y),woman(X).
mother(X):-mother(Y,X),write(Y).

daughter(X,Y):-child(X,Y),woman(X).
daughter(X):-daughter(Y,X),write(Y).

brother(X,Y):-parent(Z,X),parent(Z,Y),man(X),man(Z),not(X=Y).
brothers(X):-brother(Y,X),c_write(Y),fail.

husband(X,Y):-parent(X,Z),parent(Y,Z),man(X),not(X=Y).
husband(X):-husband(Y,X),write(Y).

grand_pa(X,Y):-parent(X,Z),parent(Z,Y),man(X).
grand_pas(X):-grand_pa(Y,X),c_write(Y),fail.

b_s(X,Y):-parent(Z,X),parent(Z,Y),man(Z),not(X=Y).
b_s(X):-b_s(Y,X),c_write(Y),fail.

grand_da(X,Y):-daughter(X,Z),child(Z,Y).
grand_dats(X):-grand_da(Y,X),c_write(Y),fail.

grand_pa_and_son(X,Y):-( grand_pa(X,Y),man(Y) )|( grand_pa(Y,X),man(X) ).

grand_ma_and_da(X,Y):-( grand_da(X,Y),woman(Y) )|( grand_da(Y,X),woman(X) ).