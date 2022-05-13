clc;
clear all;
%%
N_bits = 1000;
n = 3;                            %number of out
L = 7;                            %Number of shift Reg
bit_seq = GenerateBits(N_bits);
p_vec = linspace(0,0.5,5);
trellis = poly2trellis(L,[133 171 165]);
[next_states, outputs] = Trellis_Gen(L,[133 171 165]);

%% effect of P on the BER
sample = ConvEncode(bit_seq,n, next_states, outputs);
BER = zeros(1,length(p_vec));
BER2 = zeros(1,length(p_vec));
for i =1:length(p_vec)
    rec_sample = BSC(sample,p_vec(i));
    decoded_bits = ConvDecode(rec_sample,trellis);
    decoded_bits2 =viterbi_decoder3(rec_sample, next_states, outputs, L,n);
    BER(i) = ComputeBER(bit_seq,decoded_bits);
    BER2(i) = ComputeBER(bit_seq,decoded_bits2);
end
figure
plot(p_vec,BER,'g');
title('effect of P on the BER Matlab viterbi')
ylabel('BER')
xlabel('p')


figure
plot(p_vec,BER2,'g');
title('effect of P on the BER my viterbi')
ylabel('BER')
xlabel('p')
