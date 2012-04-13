program test;

uses liste;

function carre (x : integer) : integer;
begin
    carre := x*x;
end;

function f (x : integer) : boolean;
begin
    f := x >= 50;
end;

function f1 (x, y : integer) : boolean;
begin
    f1 := (x < y);
end;

function f2 (x, y : integer) : boolean;
begin
    f2 := (x > y);
end;

var l, list, rev_list : liste_int;
begin
    list := l_cons(1, l_cons(1, l_cons(5, l_cons(8, l_cons(6, l_cons(9, l_cons(4, l_cons(7, l_cons(5, l_cons(3, nil))))))))));
    rev_list := l_rev(list);

    write('list = ');        l_affiche(list);
    write('rev_list = ');    l_affiche(rev_list);

    write('tail(list) = ');  l_affiche(l_tail(list));
    write('init(list) = ');  l_affiche(l_init(list));

    writeln('last(list) = ', l_last(list));
    writeln('head(list) = ', l_head(list));

    writeln('max = ', l_max(list));
    writeln('min = ', l_min(list));
    write('carre(list) = '); l_affiche(l_map(@carre, list));
    l := l_map(@carre, list);
    
   write('tri rapide = '); l_affiche(l_qsort(@f2, l));
   write('tri fusion = '); l_affiche(l_mergesort(@f2, l));

   write('set = '); l_affiche(l_set(list));
   write('[1..10] n [5..15] = '); l_affiche(l_inter(l_range(1, 10), l_range(5, 15)));
   write('[1..10] u [5..15] = '); l_affiche(l_union(l_range(1, 10), l_range(5, 15)));
   write('[1..15] \ [5..10] = '); l_affiche(l_minus(l_range(1, 15), l_range(5, 10)));

    write('shuffle [1..20] = '); l_affiche(l_shuffle(l_range(1, 20)));
end.
