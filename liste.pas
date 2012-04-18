(***********************************************************************)
(*            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE              *)
(*                    Version 2, December 2004                         *)
(*                                                                     *)
(* Copyright (C) 2012 Lithrein <lithrein.site@gmail.com>               *)
(*                                                                     *)
(* Everyone is permitted to copy and distribute verbatim or modified   *)
(* copies of this license document, and changing it is allowed as long *)
(* as the name is changed.                                             *)
(*                                                                     *)
(*            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE              *)
(*   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION   *)
(*                                                                     *)
(*  0. You just DO WHAT THE FUCK YOU WANT TO.                          *)
(***********************************************************************)

unit liste;

interface

type liste_int = ^cell;
     cell = record
         value : integer;
         next : liste_int;
     end;

    couple_liste = ^cpl_list;
    cpl_list = record
        fst : liste_int;
        snd : liste_int;
    end;

    cond    = function(x : integer) : boolean;
    int_int = function(x : integer) : integer;
    rel_ord = function(x,y : integer) : boolean;

(***********************************************)
(***   Il n'y a AUCUNE gestion des erreurs   ***)
(***********************************************)
{
    TODO : Liberer la memoire.
}


(* Fonctions primorsiales *)

{ Ajoute une la valeur `n' au debut de la liste `liste' }
function l_cons (n : integer ; tl : liste_int) : liste_int;
{ Retire le premier element de `liste' et le met dans `n' }
function l_pop (var n : integer ; liste : liste_int) : liste_int;
{ Vide la liste }
procedure l_clear (liste : liste_int);

(* Fonctions indispensables *)

{ Renvoie `true' si la liste est vide, `false' autrement }
function l_is_empty (liste : liste_int) : boolean;
{ Renvoie le premier element de la liste : O(1) }
function l_head (liste : liste_int) : integer;
{ Renvoie la liste privee de son premier element : O(1) }
function l_tail (liste : liste_int) : liste_int;
{ Renvoie le dernier element de la liste }
function l_last (liste : liste_int) : integer;
{ Renvoie la liste privee de son dernier element }
function l_init (liste : liste_int) : liste_int;
{ Renvoie le n-ieme element de la liste : O(n) }
function l_nth (liste : liste_int ; n : integer) : integer;
{ Calcule la longueur de la liste : O(n) }
function l_length (liste : liste_int) : integer;
{ Construit une nouvelle liste, la liste retournee de celle passee en parametre }
function l_rev (liste : liste_int) : liste_int;
{ Construit une copie de la liste }
function l_copy (liste : liste_int) : liste_int;
{ Concatene la `liste1' a la fin de la `liste2'}
function l_append (liste1, liste2 : liste_int) : liste_int;
{ Retire le j-ieme element de `liste` }
function l_remove (liste : liste_int ; j : integer ; var n : integer) : liste_int;

(* Fonction utilitaires  *)

{Genere la liste d'entiers [i..j] suivant le pas `p` }
function l_range_s (i, j, s : integer) : liste_int; 
{ Genere la liste d'entiers [i..j] O(j-i) }
function l_range (i, j : integer) : liste_int;
{ Melange la liste `liste`. O(n^2) }
function l_shuffle (liste : liste_int) : liste_int;
{ Fait la somme des elements de `liste` : O(n) }
function l_sum (liste : liste_int) : integer;
{ Fait le produit des element de `liste` : O(n) }
function l_prod (liste : liste_int) : integer;
{ Renvoie le maximum de `liste` : O(n) }
function l_max (liste : liste_int) : integer;
{ Renvoie le minimum de `liste` : O(n) }
function l_min (liste : liste_int) : integer;
{ Renvoie la liste qui contient les elements passant le filtre 'f' }
function l_filter (f : cond ; liste : liste_int) : liste_int;
{ Applique `f` a toute la liste }
function l_map (f : int_int ; liste : liste_int) : liste_int;
{ Applique `f` au element de `liste` qui respecte la consition `f2` }
function l_filter_map (f : int_int ; f2 : cond ; liste : liste_int) : liste_int;
{ Recupere les `i` premiers elements de `liste`. }
function l_truncate (liste : liste_int ; i : integer) : liste_int;

(* Fonctions sympas *)
{zip, unzip, foldl, foldr, para, hylo, ana, cata }
{ sous-liste max, min }
{ k-eme plus grand/petit}

(* Fonction de tri *)

{ Coupe la liste en deux sous-listes suivant la condition booleenne `f` }
function l_partition (f : cond ; liste : liste_int) : couple_liste;
{ Tri la liste suivant quick_sort }
function l_qsort (f : rel_ord ; liste : liste_int) : liste_int;
{ Tri de la liste suivant mergesort }
function l_mergesort (f : rel_ord ; liste : liste_int) : liste_int;

(* Fonction ensembliste *)
{ Determine l'ensemble associe a la liste. ie. sans doublon }
function l_set   (liste : liste_int) : liste_int;
{ Retourne l'ensemble des parties de la liste. }
(*function l_parts (liste : liste_int) : liste_int;*)
{ Retourne l'intersection de deux listes. }
function l_inter (liste1, liste2 : liste_int) : liste_int;
{ Retourne l'union de deux listes }
function l_union (liste1, liste2 : liste_int) : liste_int;
{ Retourne la liste1 privee des elements de la liste2 }
function l_minus (liste1, liste2 : liste_int) : liste_int;

(* Fonction(s) d'affichage(s) *)

{ Affiche `liste` }
procedure l_affiche (liste : liste_int);

implementation

function l_cons (n : integer ; tl : liste_int) : liste_int;
var hd : liste_int;
begin
        new(hd);

        hd^.value := n;
        hd^.next  := tl;

        l_cons := hd
end; { l_cons }


function l_pop (var n : integer ; liste : liste_int) : liste_int ;
var tl : liste_int;
begin
        n := liste^.value;
        tl := liste^.next;

        dispose(liste);

        l_pop := tl
end; { l_pop }

procedure l_clear (liste : liste_int);
var tmp : liste_int;
begin

    while liste <> nil do
    begin
        tmp := liste^.next;
        dispose(liste);
        liste := tmp;
    end;

end; { l_clear }

function l_is_empty (liste : liste_int) : boolean;
begin
        l_is_empty := (liste = nil)
end; { l_is_emty }

function l_head (liste : liste_int) : integer;
begin
        l_head := liste^.value;
end; { l_head }

function l_tail (liste : liste_int) : liste_int;
begin
        l_tail := liste^.next;
end; { l_tail }

function l_last (liste : liste_int) : integer;
var elem : integer;
begin
        while (not l_is_empty(liste)) do
                begin
                        elem := liste^.value;
                        liste := liste^.next;
                end;
       l_last := elem;
end; { l_last }

function l_init (liste : liste_int) : liste_int;
begin
    if l_is_empty(liste) then
            l_init := nil
    else if l_is_empty(liste^.next) then
            l_init := nil
    else
            l_init := l_cons(liste^.value, l_init(liste^.next))
end; { l_init }

function l_nth (liste : liste_int ; n : integer) : integer;
begin
    if n = 0 then l_nth := liste^.value
             else l_nth := l_nth(liste^.next, n - 1);
end; { l_nth }

function l_length (liste : liste_int) : integer;
var n : integer;
begin
        n := 0;
        while (not l_is_empty(liste)) do
                begin
                        n := n + 1;
                        liste := liste^.next;
                end;

        l_length := n
end; { l_length }

function l_rev (liste : liste_int) : liste_int;
var new_list : liste_int;
begin
        new_list := nil;
        while (not l_is_empty(liste)) do
                begin
                        new_list := l_cons(liste^.value, new_list);
                        liste := liste^.next;
                end;

       l_rev := new_list;
end; { l_rev }

function l_copy (liste : liste_int) : liste_int;
var new_list, deb : liste_int;
begin
(* TODO : Faire un truc mieux *)
    if liste = nil then
        l_copy := nil;

    new(new_list);
    deb := new_list; (* Pointeur de sauvegarde *)

    while (not l_is_empty(liste^.next)) do
    begin
        new_list^.value := liste^.value;
                
        liste := liste^.next;
        new(new_list^.next);
        new_list := new_list^.next;
    end;

    new_list^.value := liste^.value;
    new_list^.next := nil;

    l_copy := deb;
end; { l_copy }

function l_append (liste1, liste2 : liste_int) : liste_int;
var deb : liste_int;
    cpy : liste_int;
begin
        
    if liste1 = nil then l_append := liste2
    else if liste2 = nil then l_append := liste1
    else begin
        cpy := l_copy(liste1);
        deb := cpy;
        while (not l_is_empty(cpy^.next)) do
            cpy := cpy^.next;

        cpy^.next := liste2;
        l_append := deb;
    end;
end; { l_append }

function l_remove (liste : liste_int ; j : integer ; var n : integer) : liste_int;
var copie : liste_int;
    i     : integer;
begin
    copie := nil;
    i := 0;

   while (not l_is_empty(liste)) do
   begin
        if i <> j then
            copie := l_cons(liste^.value, copie)
        else
            n := liste^.value;

        i := i + 1;
        liste := liste^.next;
    end;

    l_remove := l_rev(copie);
end; { l_remove }

function l_range_s (i, j, s : integer) : liste_int; 
begin
    if (i <= j) then l_range_s := l_cons(i, l_range_s(i + s, j, s))
                else l_range_s := nil;
end; { l_range_s }

function l_range(i, j : integer) : liste_int;
begin
    l_range := l_range_s(i, j, 1);
end; { l_range }

(* Si l'on voulait une complexite en O(n), il faudrait passer
   par un tableau intermediaire. L'acces a un element serait 
   alors en O(1). *)
function l_shuffle (liste : liste_int) : liste_int;
var size : integer;
    alea : integer;
    tmp : integer;
    nouv_liste : liste_int;
begin
    nouv_liste := nil;
    size := l_length(liste);

    while size <> 0 do
    begin
        alea := random(size);
        liste := l_remove(liste, alea, tmp); 
        nouv_liste := l_cons(tmp, nouv_liste);
        size := size - 1;
    end;

    l_shuffle := nouv_liste;
end; { l_shuffle }

function l_sum (liste : liste_int) : integer;
var sum : integer;
begin
    sum := 0;

    while liste <> nil do
    begin
        sum := sum + liste^.value;
        liste := liste^.next;
    end;

    l_sum := sum;
end; { l_sum }

function l_prod (liste : liste_int) : integer;
var prod : integer;
begin
    prod := 1;

    while liste <> nil do
    begin
        prod := prod * liste^.value;
        liste := liste^.next;
    end;

    l_prod := prod;
end; { l_prod }

function l_max (liste : liste_int) : integer;
var max : integer;
begin
    max := liste^.value;

    while liste <> nil do
    begin
        if liste^.value > max then max := liste^.value;
        liste := liste^.next;
    end;

    l_max := max;
end; { l_max }

function l_min (liste : liste_int) : integer;
var min : integer;
begin
    min := liste^.value;

    while liste <> nil do
    begin
        if liste^.value < min then min := liste^.value;
        liste := liste^.next;
    end;

    l_min := min;
end; { l_min }

function l_filter (f : cond ; liste : liste_int) : liste_int;
var nouv_liste : liste_int;
begin
    nouv_liste := nil;

    while liste <> nil do
    begin
        if f(liste^.value) = true then
            nouv_liste := l_cons(liste^.value, nouv_liste);
        liste := liste^.next;
    end;

    l_filter := nouv_liste;
end; { l_filter }

function l_filter_map (f : int_int ; f2 : cond ; liste : liste_int) : liste_int;
begin
    if liste = nil then
        l_filter_map := nil
    else if f2(liste^.value) = true then
        l_filter_map := l_cons(f(liste^.value), l_filter_map(f, f2, liste^.next))
    else
        l_filter_map := l_filter_map(f, f2, liste^.next);
end; { l_filter_map }

function l_truncate (liste : liste_int ; i : integer) : liste_int;
begin
    if i = 0 then l_truncate := nil
             else l_truncate := l_cons(liste^.value, l_truncate(liste^.next, i - 1));
end; { l_truncate }

function l_map (f : int_int ; liste : liste_int) : liste_int;
begin
    if liste = nil then
        l_map := nil
    else
        l_map := l_cons(f(liste^.value), l_map(f, liste^.next));
end; { l_map }

function l_partition (f : cond ; liste : liste_int) : couple_liste;
var couple : couple_liste;
begin

    new(couple);
    couple^.fst := nil;
    couple^.snd := nil;

    while liste <> nil do
    begin
        if f(liste^.value) then
            couple^.fst := l_cons(liste^.value, couple^.fst)
        else
            couple^.snd := l_cons(liste^.value, couple^.snd);

        liste := liste^.next;
    end;

    l_partition := couple;
end; { l_partition }

function l_partition2 (f : rel_ord ; value : integer ; liste : liste_int) : couple_liste;
var couple : couple_liste;
begin
    new(couple);
    couple^.fst := nil;
    couple^.snd := nil;
    
    while liste <> nil do
    begin
        if f(liste^.value, value) then
            couple^.fst := l_cons(liste^.value, couple^.fst)
        else
            couple^.snd := l_cons(liste^.value, couple^.snd);

        liste := liste^.next;
    end;
    
    l_partition2 := couple; 
end; { l_partition2 }


function l_qsort (f : rel_ord ; liste : liste_int) : liste_int;
var partitions : couple_liste;
    l1, l2, res : liste_int;
begin
    
    if (liste = nil) or (liste^.next = nil) then
        res := liste
    else begin
        partitions := l_partition2(f, liste^.value, liste^.next);
        l1 := l_qsort(f, partitions^.fst);
        l2 := l_qsort(f, partitions^.snd);
        l1 := l_append(l1, l_cons(liste^.value, nil));
        res := l_append(l1, l2);
    end;

    l_qsort := res;
end; { l_qsort }

function l_couper (liste : liste_int) : couple_liste;
var bouts : couple_liste;
    i : integer;
begin
    new(bouts);
    bouts^.fst := nil;
    bouts^.snd := nil;
    i := 0;
    
    while liste <> nil do
    begin
        if (i mod 2 = 0) then
            bouts^.fst := l_cons(liste^.value, bouts^.fst)
        else
            bouts^.snd := l_cons(liste^.value, bouts^.snd);
        i := i + 1;
        liste := liste^.next;
    end;

    l_couper := bouts;
end; { l_couper }

function l_fusion (f : rel_ord ; l1, l2 : liste_int) : liste_int;
begin
    if l1 = nil then l_fusion := l2
    else if l2 = nil then l_fusion := l1
    else begin
        if f(l1^.value, l2^.value) then begin
            l_fusion := l_cons(l1^.value, l_fusion(f, l1^.next, l2))
        end else begin
            l_fusion := l_cons(l2^.value, l_fusion(f, l1, l2^.next));
        end;
    end;
end; { l_fusion }

function l_mergesort (f : rel_ord ; liste : liste_int) : liste_int;
var bouts : couple_liste;
begin
    if (liste = nil) or (liste^.next = nil) then
        l_mergesort := liste
    else begin
        bouts := l_couper(liste);
        bouts^.fst := l_mergesort(f, bouts^.fst);
        bouts^.snd := l_mergesort(f, bouts^.snd);
        l_mergesort := l_fusion(f, bouts^.fst, bouts^.snd);
    end;
end; { l_mergesort }

function l_gt (x, y : integer) : boolean;
begin
    l_gt := (x > y);
end; { l_gt }

function l_lt (x,y : integer) : boolean;
begin
    l_lt := (x < y);
end; { l_lt }

function l_set (liste : liste_int) : liste_int;
var nouv_liste : liste_int;
    sorted     : liste_int;
begin
    sorted := l_qsort(@l_gt, liste);
    nouv_liste := nil;

    while sorted <> nil do
    begin
        if (nouv_liste = nil) or (nouv_liste^.value <> sorted^.value) then
            nouv_liste := l_cons(sorted^.value, nouv_liste);

        sorted := sorted^.next;        
    end;

    dispose(sorted);
    l_set := nouv_liste;
end; { l_set }

{function l_parts (liste : liste_int) : liste_int;}

function l_inter (liste1, liste2 : liste_int) : liste_int;
var nouv_liste : liste_int;
    sorted1    : liste_int;
    sorted2    : liste_int;
begin
    sorted1 := l_qsort(@l_gt, liste1);
    sorted2 := l_qsort(@l_gt, liste2);
    nouv_liste := nil;
    
    while (sorted1 <> nil) and (sorted2 <> nil) do
    begin
        if sorted1^.value = sorted2^.value then begin
            nouv_liste := l_cons(sorted1^.value, nouv_liste);
            sorted1 := sorted1^.next;
            sorted2 := sorted2^.next
        end else if l_gt(sorted1^.value, sorted2^.value) then
            sorted1 := sorted1^.next
        else
            sorted2 := sorted2^.next;
    end;

    dispose(sorted1);
    dispose(sorted2);
    
    l_inter := nouv_liste;
end; { l_inter }

function l_union (liste1, liste2 : liste_int) : liste_int;
var nouv_liste : liste_int;
    sorted1    : liste_int;
    sorted2    : liste_int;
begin
    sorted1 := l_qsort(@l_gt, liste1);
    sorted2 := l_qsort(@l_gt, liste2);
    nouv_liste := nil;

    while (sorted1 <> nil) or (sorted2 <> nil) do
    begin
        if sorted1 = nil then begin
            nouv_liste := l_cons(sorted2^.value, nouv_liste);
            sorted2 := sorted2^.next
        end else if sorted2 = nil then begin
            nouv_liste := l_cons(sorted1^.value, nouv_liste);
            sorted1 := sorted1^.next
        end else if sorted1^.value = sorted2^.value then begin
            nouv_liste := l_cons(sorted1^.value, nouv_liste);
            sorted1 := sorted1^.next;
            sorted2 := sorted2^.next
        end else if l_gt(sorted1^.value, sorted2^.value) then begin
            nouv_liste := l_cons(sorted1^.value, nouv_liste);
            sorted1 := sorted1^.next
        end else begin
            nouv_liste := l_cons(sorted2^.value, nouv_liste);
            sorted2 := sorted2^.next
        end;
    end;

    dispose(sorted1);
    dispose(sorted2);
    l_union := nouv_liste;
end; { l_union }

function l_minus (liste1, liste2 : liste_int) : liste_int;
var nouv_liste : liste_int;
    sorted1    : liste_int;
    sorted2    : liste_int;
begin
    sorted1 := l_qsort(@l_gt, liste1);
    sorted2 := l_qsort(@l_gt, liste2);
    nouv_liste := nil;

    while (sorted1 <> nil) do
    begin
        if sorted2 = nil then begin
            nouv_liste := l_cons(sorted1^.value, nouv_liste);
            sorted1 := sorted1^.next;
        end else if l_gt(sorted2^.value, sorted1^.value) then begin
            nouv_liste := l_cons(sorted1^.value, nouv_liste);
            sorted1 := sorted1^.next;
        end else if l_gt(sorted1^.value, sorted2^.value) then begin
            nouv_liste := l_cons(sorted1^.value, nouv_liste);
            sorted1 := sorted1^.next;
        end else begin
            sorted1 := sorted1^.next;
            sorted2 := sorted2^.next;
        end;
    end;

    dispose(sorted1);
    dispose(sorted2);
    l_minus := nouv_liste;
end; { l_minus }

procedure l_affiche (liste : liste_int);
begin
        write('[');
        while (not l_is_empty(liste)) do
                begin
                        write(liste^.value,', ');
                        liste := liste^.next;
                end;
        (* #8 : backspace ; #13#10 : CRLF *)
        write(#8#8'] : liste_int'#13#10);
end; { l_affiche }

end. { liste }
