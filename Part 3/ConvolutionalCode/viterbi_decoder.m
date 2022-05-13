function [x] = viterbi_decoder(data, next, out, L,n)
states = 2^(L-1);
x = [];

current = 0;
next_zero = 0;
next_one = 0;

start = 1;
for i = 1:n:length(data)
    code = data(start:start+n-1);
    start = start + n;
    code_dec = bi2de(flip(code));
    next_zero = next(1,current +1);
    next_one = next(2,current+1);
    distance_zero = biterr(out(1,current+1),code_dec);
    distance_one = biterr(out(2,current+1),code_dec);
    if distance_zero > distance_one
        x = [x 1];
        current = next_one;
    elseif distance_zero < distance_one
        x = [x 0];
        current = next_zero;
    else %when they are the same distance
        %check the smallest distance for the 2 case
        dis1 =checkNext(data,next_zero,next, out,start,n);
        dis2 = checkNext(data,next_one,next, out,start,n);
        dis1 = dis1 + distance_zero;
        dis2 = dis2 + distance_one;
        if dis1 > dis2
             x = [x 1];
             current = next_one;
        else
            x = [x 0];
            current = next_zero;
        end
    end
    
end

end

function distance = checkNext(data,cur,next, out,start,n)
ditance_zero1 = 0;
ditance_one1 = 0;
if start < length(data)
next_zero1 = next(1,cur +1);
next_one1 = next(2,cur+1);
code = data(start:start+n-1);
start = start + n;
code_dec = bi2de(flip(code));
ditance_zero1 = biterr(out(1,cur+1),code_dec);
ditance_one1 = biterr(out(2,cur+1),code_dec);

if ditance_zero1 == ditance_one1
    cur = next_zero1;
    ditance_zero1 =checkNext(data,cur,next, out,start,n);
    cur = next_one1;
    ditance_one1 = checkNext(data,cur,next, out,start,n);
end
end
distance = min(ditance_zero1,ditance_one1);
end
