function [x] = viterbi_decoder2(data, next, out, L,n)
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
    distance_zero = biterr(de2bi(out(1,current+1),n),code);
    distance_one = biterr(de2bi(out(2,current+1),n),code);

    %when they are the same distance
        %check the smallest distance for the 2 case
        dis1 = checkNext(data,next_zero,next, out,start,n,3);
        dis2 = checkNext(data,next_one,next, out,start,n,3);
        dis1 = dis1 + distance_zero;
        dis2 = dis2 + distance_one;
        %dis1 =  distance_zero;
        %dis2 =  distance_one;
        if dis1 > dis2
             x = [x 1];
             current = next_one;
        else
            x = [x 0];
            current = next_zero;
        end
    
   
end

end

function distance = checkNext(data,cur,next, out,start,n,depth)
ditance_zero1 = 0;
ditance_one1 = 0;

if start < length(data)
   
next_zero1 = next(1,cur +1);
next_one1 = next(2,cur+1);
code = data(start:start+n-1);
start = start + n;
code_dec = bi2de(flip(code));
ditance_zero1 = biterr(de2bi(out(1,cur+1),n),code);
ditance_one1 = biterr(de2bi(out(2,cur+1),n),code);

if ((ditance_zero1 == ditance_one1) | (depth >= 0))
    depth = depth - 1;
    cur = next_zero1;
    ditance_zero1 =checkNext(data,cur,next, out,start,n ,depth);
    cur = next_one1;
    ditance_one1 = checkNext(data,cur,next, out,start,n ,depth);
end

end

distance = min(ditance_zero1,ditance_one1);
end
