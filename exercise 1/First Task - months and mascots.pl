gem("saphire").
gem("pearl").
gem("rubin").

month("june").
month("july").
month("september").

meaning("wisdom").
meaning("health").
meaning("well-being").

rule_default(X,Y,Z):-month(X), gem(Y), meaning(Z).

rule_one(X,Y,Z):- rule_default(X,Y,Z), 
   (( X="september", Y\="pearl" , Y\="rubin");( X\="september" )).

rule_two(X,Y,Z):- rule_default(X,Y,Z),
    ((( X="july", Z\="wisdom" );( X\="july")),(( X="june", Z\="wisdom" );( X\="june")) ).

rule_three(X,Y,Z):- rule_default(X,Y,Z),
    ((Z\="health",Y="rubin");(Y\="rubin")).

rule_four(X,Y,Z):- rule_default(X,Y,Z),
    ((Z\="well-being",X="june");(X\="june")).

all_rules(X,Y,Z):-
    rule_one(X,Y,Z),
    rule_two(X,Y,Z),
    rule_three(X,Y,Z),
    rule_four(X,Y,Z).