function [x] = viterbi_decoder4(data, next, out, L,n)

N = length(data);
states = 2^(L-1);
trellis_m = zeros(states,N/n+1);
trellis_m(:) = 999 ;
trellis_m(1,1) = 0;
path = zeros(states,N/n+1); %save the last state before current one
path_direction = zeros(states,N/n+1); % to know what i/p made the transation
x = zeros(1,N/n);
next_points = [0];
start = 1;
for i = 1:length(trellis_m)-1
    input = data(start:start+n-1);
    input_dec = bi2de(flip(input));
    start = start + n;
    temp = [];
    %find(trellis_m(:,i) ~= 999)'
    for j = next_points +1
        current = j - 1;
        %when The Input is zero
        next_zero = next(1,current +1);
        distance_zero = biterr(out(1,current+1),input_dec); %Hamming Distance
        distance = distance_zero + trellis_m(current + 1,i);
        if trellis_m(next_zero + 1, i + 1 ) > distance %if it the shortest else dont update it enough
            trellis_m(next_zero + 1,i+1) = distance; 
            path(next_zero + 1,i+1) = current;
            path_direction(next_zero + 1,i+1) = 0;
            %if any(temp(:) ~= next_zero) || isempty(temp)
            temp = [temp next_zero];
            %end
        end
        
        %when The Input is One
        next_one = next(2,current+1);
        
        distance_one = biterr(out(2,current+1),input_dec); %Hamming Distance
        distance = distance_one + trellis_m(current + 1,i);
        if trellis_m(next_one+1,i + 1) > distance %if it the shortest else dont update it enough
            trellis_m(next_one+1,i + 1) = distance; 
            path(next_one + 1,i+1) = current;
            path_direction(next_one + 1,i+1) = 1;
            %if any(temp(:) ~= next_one) || isempty(temp)
                temp = [temp next_one];
            %end
            
        end
        
    end
    next_points = unique(temp);
end
% Decide The shortest path
[temp1,short] = min(trellis_m(:,N/n+1));

%traceback The shortest path

for i = length(trellis_m):-1:2
    x(i-1) = path_direction(short(1,1),i);
    short = path(short,i) + 1;
    
end
end