function LLvalupdate(i)
    
    global PCvar;
    global decision;
    
    n = PCvar.n;

    if i==1
        nextlevel=n;
    else
        i_bin = dec2bin(i-1,n);
        for llevel = 1:n
            if i_bin(llevel) == '1'
                break;
            end
        end
        start = 2^(llevel-1);
        till = 2^(llevel) -1;
        for index = start:till
            decision.LLval(index) = lowcalc(decision.BITS(1,index),decision.LLval(till+2*(index-start)+1),decision.LLval(till+2*(index-start)+2));
        end
        nextlevel = llevel-1;
    end

    %%Up_likelihood calculation till root%%
    for lev = nextlevel :-1: 1
        start = 2^(lev-1);
        till = 2^lev - 1;
        for index = start:till
            decision.LLval(index) = upcalc(decision.LLval(till+2*(index-start)+1),decision.LLval(till+2*(index-start)+2));
        end
    end
    
end

function llr = lowcalc(up_value, up, low)
    llr= low - (up_value*2-1)*up;
end

function llr = upcalc(llr1,llr2)

    num = max(llr1+llr2,0)+log(1+exp(-abs(llr1+llr2))) ;
    den = max(llr1,llr2)+log(1+exp(-abs(llr1-llr2)));
    
    llr=num-den;
end

