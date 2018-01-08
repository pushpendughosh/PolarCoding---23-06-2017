function u=decoder(y)

    global PCvar;
    global frozen;
    global decision;
    
    N=PCvar.N;

    %%initializing likelihood PCvar
    decision.LLval = 0;
    initialLR = -y; 
    decision.LLval(N:2*N-1) = initialLR;

    bit = zeros(N,1);
    
    for j=1:N
        i = 1+bitreverse(j-1,PCvar.n) ; %% decides which bit position is to be be decoded
        LLvalupdate(i);
            
        if (frozen(i) == -1)
            if (decision.LLval(1) <= 0)
                bit(i) = 1;
            else
                bit(i) = 0;
            end
        else
            bit(i) = frozen(i); %%At frozen bits, the value of frozen bit goes
        end
        
        BITdecoder(bit(i),i); %%bits are decided
    end
    u = bit ( frozen ~= 0); %%Final message is on unfrozen bits
end