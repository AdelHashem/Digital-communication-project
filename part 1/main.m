clc;
clear all;
fs = 10000000;
Ns = 100000;
f=linspace(-fs/2,fs/2,Ns);
t=linspace(0,(1/fs)*Ns,Ns);% T Sec;

%% Generate square pulse 1
B = 100000;
T_dur = 2/B;
amp = 0.1;
square1 = PulseGen(t,T_dur,amp,[1 0]);
pulse1_fft = abs(fftshift(fft(square1)));

figure;
subplot(2,1,1)
plot(t,square1,'b','LineWidth',2); hold on
title('The pulse In Time')
grid on
xlim([0 T_dur*5])
ylim([0 0.3])
subplot(2,1,2)
plot(f,pulse1_fft,'b','LineWidth',2);hold on
title('The pulse In Freq')
grid on
ylim([-1 30])
xlim([-1/T_dur*6 1/T_dur*6])
%% Generate square pulse 2
square2 = PulseGen(t,T_dur,amp,[0 1]);
pulse2_fft = abs(fftshift(fft(square2)));

subplot(2,1,1)  % plot on the same figure
plot(t,square2,'r','LineWidth',2);hold off
subplot(2,1,2)
plot(f,pulse2_fft,'r','LineWidth',2); hold off

%% channel
Band_limited_Ch = 1.*(abs(f)<=B);
[pulse1_channel_freq,pulse1_channel_t] = ideal(square1,B,f);%effect on signal 1
[pulse2_channel_freq,pulse2_channel_t] = ideal(square2,B,f);%effect on signal 2

figure
%subplot(2,1,1)
plot(f,Band_limited_Ch,'b','LineWidth',2);
title('The Band Limited Channel in Freq Domain')
grid on
%subplot(2,1,2)
%plot(t,ifft(ifftshift(Band_limited_Ch)),'b','LineWidth',2);
%title('The Band Limited Channel in Time Domain')
%ylim([0 1/B])
%grid on

figure
subplot(2,1,1)
plot(t,pulse1_channel_t,'b','LineWidth',2);hold on
plot(t,pulse2_channel_t,'r','LineWidth',2);
xlim([0 T_dur*5])
title('Signal After The Channel In Time')
subplot(2,1,2)
plot(f,abs(pulse1_channel_freq),'b','LineWidth',2);hold on
plot(f,abs(pulse2_channel_freq),'r','LineWidth',2);
xlim([-1/T_dur 1/T_dur]*5)
ylim([0 50])
title('Signal After The Channel In Freq')