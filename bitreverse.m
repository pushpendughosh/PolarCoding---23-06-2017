function reverse = bitreverse(j,n)
% Resverses the order of bits Eg: 11010001 --> 10001011
    reverse=zeros(length(j),1);

    for i=1:length(j)
        reverse(i) = bin2dec(flipper(dec2bin(j(i),n))); %%predifened MATLAB function bin2dec : converts binary number to decimal
                                                                %%dec2bin : converts decimal to binary number                                                          
    end
end

function y = flipper(x)
%%reverse a vector
    y = x(end:-1:1);
end
