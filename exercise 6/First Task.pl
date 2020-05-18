% wolf goat cabbage farmer
% the goat and the cabbage cannot be in the same place without the farmer
% the wolf and the goat cannot be in the same place without the farmer 

% Run move_farm(((1, 1, 1, 1),(0, 0, 0, 0),1),[],Path).

valid_move(Position, Visited):-
    notMember(Position,Visited),
    positiveCount(Position),
    noEatingAnyone(Position).

positiveCount(((LeftWolf, LeftGoat, LeftCabbage, LeftFarmer), (RightWolf ,RightGoat, RightCabbage, RightFarmer),_)):-
     LeftWolf >=0,
     LeftGoat >=0,
     LeftCabbage >=0,
     LeftFarmer >=0,
     RightWolf >=0,
     RightGoat >=0,
     RightCabbage >=0,
     RightFarmer >=0.

%

left_goat_is_eaten(LeftGoat, LeftWolf, LeftFarmer):-
     LeftGoat >= 1,  
    LeftWolf >= 1, 
    LeftFarmer=<0.

right_goat_is_eaten(RightGoat, RightWolf, RightFarmer):-
    RightGoat >= 1,  
    RightWolf >= 1, 
    RightFarmer=<0.

left_cabbage_is_eaten(LeftGoat, LeftCabbage, LeftFarmer):-
    LeftGoat >= 1,  
    LeftCabbage >= 1, 
    LeftFarmer=<0.

right_cabbage_is_eaten(RightGoat, RightCabbage, RightFarmer):-
    RightGoat >= 1,  
    RightCabbage >= 1, 
    RightFarmer=<0.

noEatingAnyone(((LeftWolf, LeftGoat, LeftCabbage, LeftFarmer), (RightWolf ,RightGoat, RightCabbage, RightFarmer),_)):-
	  not(left_goat_is_eaten(LeftGoat, LeftWolf, LeftFarmer)),
      not(right_goat_is_eaten(RightGoat, RightWolf, RightFarmer)),
      not(left_cabbage_is_eaten(LeftGoat, LeftCabbage, LeftFarmer)),
      not(right_cabbage_is_eaten(RightGoat, RightCabbage, RightFarmer)).
%

notMember(X,L) :- 
    member(X,L), !, fail ; true.

move_goat_and_farmer(((LeftWolf, LeftGoat, LeftCabbage, LeftFarmer),(RightWolf ,RightGoat, RightCabbage, RightFarmer), BoatPosition), 
                  ((LeftWolf, NewLeftGoat, LeftCabbage, NewLeftFarmer),(RightWolf, NewRightGoat, RightCabbage, NewRightFarmer), NewBoatPosition)):-
    NewRightGoat is RightGoat + BoatPosition * 1,
    NewLeftGoat is LeftGoat - BoatPosition * 1,
    NewRightFarmer is RightFarmer + BoatPosition * 1,
    NewLeftFarmer is LeftFarmer - BoatPosition * 1,
    NewBoatPosition is BoatPosition * -1.
    
move_cabbage_and_farmer(((LeftWolf, LeftGoat, LeftCabbage, LeftFarmer),(RightWolf ,RightGoat, RightCabbage, RightFarmer), BoatPosition), 
                  ((LeftWolf, LeftGoat, NewLeftCabbage, NewLeftFarmer),(RightWolf, RightGoat, NewRightCabbage, NewRightFarmer), NewBoatPosition)):-
    NewRightCabbage is RightCabbage + BoatPosition * 1,
    NewLeftCabbage is LeftCabbage - BoatPosition * 1,
    NewRightFarmer is RightFarmer + BoatPosition * 1,
    NewLeftFarmer is LeftFarmer - BoatPosition * 1,
    NewBoatPosition is BoatPosition * -1.
    
move_wolf_and_farmer(((LeftWolf, LeftGoat, LeftCabbage, LeftFarmer),(RightWolf ,RightGoat, RightCabbage, RightFarmer), BoatPosition), 
                  ((NewLeftWolf, LeftGoat, LeftCabbage, NewLeftFarmer),(NewRightWolf, RightGoat, RightCabbage, NewRightFarmer), NewBoatPosition)):-
    NewRightWolf is RightWolf + BoatPosition * 1,
    NewLeftWolf is LeftWolf - BoatPosition * 1,
    NewRightFarmer is RightFarmer + BoatPosition * 1,
    NewLeftFarmer is LeftFarmer - BoatPosition * 1,
    NewBoatPosition is BoatPosition * -1.

move_farmer_only(((LeftWolf, LeftGoat, LeftCabbage, LeftFarmer),(RightWolf ,RightGoat, RightCabbage, RightFarmer), BoatPosition), 
                  ((LeftWolf, LeftGoat, LeftCabbage, NewLeftFarmer),(RightWolf, RightGoat, RightCabbage, NewRightFarmer), NewBoatPosition)):-
    NewRightFarmer is RightFarmer + BoatPosition * 1,
    NewLeftFarmer is LeftFarmer - BoatPosition * 1,
    NewBoatPosition is BoatPosition * -1.

move_farm(((0, 0, 0, 0),(1, 1, 1, 1), -1),_,[]):- 
    !.

move_farm(CurrentPosition, Visited, ['G & F'|RestOfPath]):-
    move_goat_and_farmer(CurrentPosition, NextPosition),
    valid_move(NextPosition, Visited),
    move_farm(NextPosition, [CurrentPosition|Visited], RestOfPath).

move_farm(CurrentPosition, Visited, ['C & F'|RestOfPath]):-
    move_cabbage_and_farmer(CurrentPosition, NextPosition),
    valid_move(NextPosition, Visited),
    move_farm(NextPosition, [CurrentPosition|Visited], RestOfPath).

move_farm(CurrentPosition, Visited, ['W & F'|RestOfPath]):-
    move_wolf_and_farmer(CurrentPosition, NextPosition),
    valid_move(NextPosition, Visited),
    move_farm(NextPosition, [CurrentPosition|Visited], RestOfPath).

move_farm(CurrentPosition, Visited, ['F'|RestOfPath]):-
    move_farmer_only(CurrentPosition, NextPosition),
    valid_move(NextPosition, Visited),
    move_farm(NextPosition, [CurrentPosition|Visited], RestOfPath).