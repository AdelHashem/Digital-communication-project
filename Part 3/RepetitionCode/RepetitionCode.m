clc;
clear all;
%%
N_bits = 10000;
bit_seq = GenerateBits(N_bits);
p_vec = linspace(0,0.5,500);


%% effect of P on the BER
r = .1;
L = ceil(1/r);
sample = GenerateSamples(bit_seq,L);
BER = zeros(1,length(p_vec));
for i =1:length(p_vec)
    rec_sample = BSC(sample,L,p_vec(i));
    decoded_bits = Decoder(rec_sample,L);
    BER(i) = ComputeBER(bit_seq,decoded_bits);
end
figure
plot(p_vec,BER,'g');
title('effect of P on the BER')
ylabel('BER')
xlabel('p')
%% effect of L on the BER
L_vec = 1:2:40;
p = 0.2;

BER = zeros(1,length(L_vec));
for i =1:length(L_vec)
    sample = GenerateSamples(bit_seq,L_vec(i));
    rec_sample = BSC(sample,L_vec(i),p);
    decoded_bits = Decoder(rec_sample,L_vec(i));
    BER(i) = ComputeBER(bit_seq,decoded_bits);
end
figure
plot(L_vec,BER,'r');
title('effect of L on the BER')
ylabel('BER')
xlabel('L')
