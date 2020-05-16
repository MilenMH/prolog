has('ivan', has('car', characteristics('mercedes', color('red')))).
has('ivan', has('bank account', 220000)).
has('ivan', has('house', characteristics(260, 'in central London', 220000))).
has('ivan', has('yacht', 'atlantic')).

has('stoian', has('car', characteristics('volkswagen', color('blue')))).
has('stoian', has('bank account', 1800)).
has('stoian', has('flat', characteristics(80, 'in central Plovdiv', 120000))).

has('tosho', has('car', characteristics('mazda', color('yellow')))).
%has('tosho', has('bank account', 1)).

has('pesho', has('car', characteristics('mazda', color('red')))).
%has('pesho', has('bank account', 200)).

has('sasho', has('car', characteristics('audi', color('yellow')))).
%has('sasho', has('bank account', 2000)).

has('pepo', has('house', characteristics(160, 'in central Sofia', 120000))).
%has('pepo', has('bank account', 120000)).

ivan_has(X):-
    (   has(X,  has(Y, characteristics(Z, color(T)))),
    X = 'ivan',
    Y = 'car',
    write('Ivan has '),
    write(T),
    write(" "),
    write(Z),
    nl) 
    ; 
     (   has(X,  has(Y, Z)),
    X = 'ivan',
    Y = 'bank account',
    write('Ivan has '),
    write(Z),
    write(' in the '),
    write(Y),
    nl)
    ;   
    (has(X,  has(Y, characteristics(Z, T, U))),
    X = 'ivan',
    (   Y = 'house'; Y = 'flat' ),   
    write('Ivan has '),
    write(Z),
    write(' m2 '),
    write(Y),
    write(' '),
    write(T),
    write(', bought for '),
    write(U),
    nl)
    ;   
    (  has(X,  has(Y, Z)),
    X = 'ivan',
    Y = 'yacht',
    write('Ivan has '),
    write(Y),
    write(' - '),
    write(Z),
    nl)
    .

car_owner(X):-
    has(X,  has(Y, characteristics(_, color(_)))),
    write(X),
    Y = 'car'.

owner_and_car_brand(X):-
    has(X,  has(Y, characteristics(Z, color(T)))),
    Y = 'car',
    write(X),
    write(' has '),
    write(T),
    write(" "),
    write(Z).


two_owners_with_red_cars(FO, SO):-
    has(FO,  has('car', characteristics(_, color(CR)))),
    has(SO,  has('car', characteristics(_, color(CR)))),
    \+ (has(TO,  has('car', characteristics(_, color(CR)))), FO \= TO, SO \= TO),
    FO \= SO,
    CR = 'red',
    write(FO),
    write(' and '),
    write(SO),
    write(' have red cars'),
    !.

% ask how to remove duplicate results
two_owners_with_same_car_color(FO, SO):-
    has(FO,  has('car', characteristics(_, color(CR)))),
    has(SO,  has('car', characteristics(_, color(CR)))),
    \+ (has(TO,  has('car', characteristics(_, color(CR)))), FO \= TO, SO \= TO),
    FO \= SO,
    write(FO),
    write(' and '),
    write(SO),
    write(' have '),
	write(CR),
    write(' cars').
    
same_amount_of_money_in_the_bank_account(O):-
    (   has(O, has('house', characteristics(_, _, AFH)));has(O, has('flat', characteristics(_, _, AFH))) ),
    has(O, has('bank account', AIBA)),
    AFH = AIBA.

description_of_the_house_or_flat(O):-
    has(O,  has(Y, characteristics(Z, T, U))),
    (   Y = 'house'; Y = 'flat' ),   
    write(O),
    write(' has '),
    write(Z),
    write(' m2 '),
    write(Y),
    write(' '),
    write(T),
    write(', bought for '),
    write(U),
    nl.

owners_of_houses_larger_than_200_m2(O):-
    (   has(O, has('house', characteristics(S, _, _)));has(O, has('flat', characteristics(S, _, _))) ),
	S > 200.

which_is_rich(X):-
    has(X, has('car', characteristics(_, color(_)))),
	has(X, has('bank account', AFBA)),
	has(X, has('house', characteristics(_, _, AFH))),
	has(X, has('yacht', _)),
    AFH > 30000,
    AFBA > 200000.
    
highest_bank_acc(X, L):-
    highest_bank_acc_1(X, L).
	

highest_bank_acc_1(X, L):-
    write(L), write(' : List'), nl,
    write(X), write(' : X'), nl,
	has(_, has('bank account', AFBA)),
    X < AFBA,
    X \= AFBA,
    append(L, [X], R),
    highest_bank_acc_1(X, R).
    
    
%    has(_, has('bank account', AFBA)),
%    write('initial value - '), write(H), write(', bank acc - '), write(AFBA), nl,
%    append(L, [AFBA], R),
%    H < AFBA,
%    H \= AFBA,
%    write(L), write(' : List'), nl,
%    write(R), write(' : Result'), nl,
%    highest_bank_acc_1(AFBA, L).


max_list([X],X).

max_list([X,Y|T],MAX):-
	X>Y,
	max_list([X|T],MAX).

max_list([X,Y|T],MAX):-
      X=<Y,
      max_list([Y|T],MAX).