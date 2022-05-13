clc;
clear all;
%%
N_bits = 10000;
bit_seq = GenerateBits(N_bits);
p_vec = linspace(0,0.5,500);
trellis = poly2trellis(6,[55 53 67]);

%% effect of P on the BER
sample = ConvEncode(bit_seq);
BER = zeros(1,length(p_vec));
for i =1:length(p_vec)
    rec_sample = BSC(sample,p_vec(i));
    decoded_bits = ConvDecode(rec_sample,trellis);
    BER(i) = ComputeBER(bit_seq,decoded_bits);
end
figure
plot(p_vec,BER,'g');
title('effect of P on the BER')
ylabel('BER')
xlabel('p')
