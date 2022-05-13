clc;
clear all;
%%
N_bits = 300;
bit_seq = GenerateBits(N_bits);
p_vec = linspace(0,0.5,5);
K = N_bits;
N = 1024;
%% effect of P on the BER 
packet = PolarEncode(bit_seq,K,N);

BER = zeros(1,length(p_vec));
for i =1:length(p_vec)
    rec_sample = BSC(packet,p_vec(i));
    rec_sample(rec_sample==1) = -1;    rec_sample(rec_sample==0) = 1; %PBSK
    decoded_bits = PolarDecode(rec_sample,K,N);
    %decoded_bits = PolarDecode2(rec_sample,K,N);
    BER(i) = ComputeBER(bit_seq,decoded_bits);
end
figure
plot(p_vec,BER,'g');
title('effect of P on the BER')
ylabel('BER')
xlabel('p')