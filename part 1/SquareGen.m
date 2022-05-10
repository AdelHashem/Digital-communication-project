function x = SquareGen(t,dur,fs,amp,start)
  % t      : time
  % dur    : Duration of the square pulse in seconds
  % fs     :

ts = 1/fs;
NSq = round(dur/ts);
square = zeros(1,NSq*2);
if start == 0
    square(NSq+1:end) = amp * ones(1,NSq);
else
    square(1:NSq) = amp * ones(1,NSq);
end

vector = zeros(1,length(t));

start = 1;
endd = NSq * 2;
while endd < length(t)
    vector(start : endd) = square;
        start = start + NSq*2 ;
        endd = endd + NSq*2;
end
for i = 1 : round(length(t) / NSq * 2) - 1
        
end
x = vector;
    
        
    
