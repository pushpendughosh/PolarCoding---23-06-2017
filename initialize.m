function initialize(N,K)

    %%creates an initialize a structure name PCvar%%
    global PCvar;
    global frozen;
    global decision;

    PCvar = struct('N', N, 'K', K, 'n', log2(N));
    decision = struct('LLval', zeros(1,2*N-1), 'BITS', zeros(2,N-1));
    frozen = polarizer(N,K); %polar code construction at the given design-SNR (default 0dB)
    
end

function position = polarizer(N,K)

    %%gives the positions where frozen bits are located : low capacity
    z = zeros(N,1);
    z(1) = -1;

    for lev=1:log2(N)
        B=2^lev;
        for j=1:B/2
            T = z(j); % log(z)
            z(B/2 + j) = 2*T; %  log(z^2)
            z(j) = log(2)+T+log(1-exp(T-log(2)));  %  log(2z - z^2)
        end
    end
    [~,indices] = sort(z,1,'ascend');  

    position = zeros(N,1);
    for j=1:K 
        position(indices(j)) = -1;
    end

end

