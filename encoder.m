function d=encoder(message)

    global PCvar;
    global frozen;

    d = frozen; %loads all frozenbits, incl. -1
    d(frozen ~= 0) = message; % -1's will get replaced by message bits below
  
    n=PCvar.n;
    
    for i=1:n
        start = 2^(n+1-i);
        till = 2^(i-1);
        for j=1:till
            base = (j-1)*start;
            for l=1:start/2
                d(base+l)=mod(d(base+start/2+l)+d(base+l),2);
            end
        end
    end
%returns d itself
end