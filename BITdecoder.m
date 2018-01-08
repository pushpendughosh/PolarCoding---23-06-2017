function BITdecoder(latestartbit, i)
    global PCvar;
    global decision;

    N = PCvar.N;
    n = PCvar.n;

    if i==N  %no bits need to be updated
        return;
    elseif i<=(PCvar.N/2)
        decision.BITS(1,1) = latestartbit;
    else
        binary_i = dec2bin(i-1,n);
        for lastlevel = 1:n
            if binary_i(lastlevel) == '0'
                break;
            end
        end
        
        decision.BITS(2,1) = latestartbit;
        for level=1:lastlevel-2 
            start = 2^(level-1);
            till = 2^level -1 ;
            for index = start:till
                decision.BITS(2,till+2*(index-start)+1) = mod( decision.BITS(1,index)+decision.BITS(2,index), 2 );
                decision.BITS(2,till+2*(index-start)+2) = decision.BITS(2,index);
            end
        end
        level=lastlevel-1;
        start = 2^(level-1);
        till = 2^level -1 ;
        for index = start:till
            decision.BITS(1,till+2*(index-start)+1) = mod( decision.BITS(1,index)+decision.BITS(2,index), 2 );
            decision.BITS(1,till+2*(index-start)+2) = decision.BITS(2,index);
        end
    end

end