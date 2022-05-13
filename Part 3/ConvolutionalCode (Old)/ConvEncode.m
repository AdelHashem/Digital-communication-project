function [x] = ConvEncode(bits)
% c1 = m1 + m3 + m4 + m6        55
% c2 = m1 + m3 + m5 + m6        53
% c3 = m1 + m2 + m4 + m5 + m6   67



memory = [0 0 0 0 0 0];
out = zeros(1,3*length(bits));
count = 1;
for i = 1:length(bits)
memory(6) = memory(5); memory(5) = memory(4);
memory(4) = memory(3); memory(3) = memory(2);
memory(3) = memory(2); memory(2) = memory(1);
memory(1) = bits(i);

c1 = xor(memory(1),memory(3));
c1 = xor(c1,memory(4));
c1 = xor(c1,memory(6));
out(count) = c1;
count = count + 1;

c2 = xor(memory(1),memory(3));
c2 = xor(c2,memory(5));
c2 = xor(c2,memory(6));
out(count) = c2;
count = count + 1;

c3 = xor(memory(1),memory(2));
c3 = xor(c3,memory(4));
c3 = xor(c3,memory(5));
c3 = xor(c3,memory(6));
out(count) = c3;
count = count + 1;
end
x = out;
end