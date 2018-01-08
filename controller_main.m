%%% POLAR CODING %%%

%clear all;
tic;
clc;
pass=0;
maxiter=10;

for iter=1:maxiter
    
    display(maxiter-iter+1); %%countdown
   
    N=2048; K=1024;
    initialize(N,K);
    u= randi([0 1],K,1); %%message code
    x= encoder(u);
    y= 2*x-1 ; %% 1 -> 1 %% 0 -> -1 Amplify
    y_error = y + sqrt(1/2)*randn(N,1); %%gaussian error
    u_decoded= decoder(y_error); %%decoded message

    %%debugging%%  checks number of incorrect bits
    count=0;
    for i=1:K
        if(u(i)~=u_decoded(i))
            count=count+1;
        end
    end
    %%debugging%%  counts the no. of times the correct code is decoded
    if count==0
        pass=pass+1;
    end
    clc
    
end
fprintf('Success rate of code is %d percentage.\n',pass*100/maxiter);
toc;