% Multiobjective artifical bee colony algorithm based on decomposition

function m = SelfRouletteWheelSelection(P)

    r = rand;
    
    C = cumsum(P);
    
    m = find(r<=C,1,'first');

end