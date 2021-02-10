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

parent(eudokia_c, vladimir_c).
parent(ivan_c, vladimir_c).
parent(eudokia_c, alexander_c).
parent(ivan_c, alexander_c).
parent(eudokia_c, olga_k).
parent(ivan_c, olga_k).

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

child(X,Y):-parent(Y,X).
children(Y):-child(X,Y),write(X),write(" ").

mother(X,Y):-parent(X,Y),woman(X).
mother(X):-mother(Y,X),write(Y).

daughter(X,Y):-child(X,Y),woman(X).
daughter(X):-daughter(Y,X),write(Y).

brother(X,Y):-parent(Z,X),parent(Z,Y),man(X),man(Z),not(X=Y).
brothers(X):-brother(Y,X),write(Y),write(" "),fail.