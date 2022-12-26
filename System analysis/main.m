%% main

clear
clc
close all

%variables
N=10;
l=2048;
file='mass_spring.mat';
labeln=[2 5 20]% for block numbers
labell=[512 1024 4096]% for block length
noise=0.5;
noise1=0;

%deal 
[Hyx,Gsxx,gamma2xy,SNR,f]=deal_FRF(N,l,file, noise1);
[Hyx_extranoise,Gsxx_extranoise,gamma2xy_extranoise,SNR_extranoise,f]=deal_FRF(N,l,file, noise);
f_block=f(1:l/2+1);
%% basic
figure(1);
plot_withnoise(Hyx,Gsxx,gamma2xy,SNR,f,l,'b');
figure(2);
plot_withnoise(Hyx_extranoise,Gsxx_extranoise,gamma2xy_extranoise,SNR_extranoise,f,l,'r');

%% ------------------mobility
figure('Name','mobility');
tiledlayout(1,2);
nexttile
j=1i;
Ymob=Hyx(2:end)./(j*2*pi*f_block(2:end));
semilogx(f_block(2:end),20*log10(abs(Ymob)));
hold on
semilogx(f_block(2:end),20*log10(real(Ymob)));
grid on
hold off
title('(a)');
xlabel('Frequency in Hz');
ylabel('Mobility in dB re. 1m/Ns');
legend('absolute value','real part')
nexttile
%figure('Name','mobility angle');
semilogx(f_block(2:end),angle(Ymob));
title('(b)');
xlabel('Frequency in Hz');
ylabel('Mobility in dB re. 1m/Ns');
grid on
%%-------------------

%% differnt block number
[~,~,gamma2xy2,~,f]=deal_FRF(labeln(2),l,file,noise1);
[~,~,gamma2xy3,~,f]=deal_FRF(labeln(3),l,file,noise1);
[~,~,gamma2xy1,~,f]=deal_FRF(labeln(1),l,file,noise1);
%f_block=f(1:l/2+1);
% [Hyx5,Gsxx,gamma2xy5,SNR5,f]=deal_FRF(20,l,file);
plot_blon(gamma2xy1,gamma2xy2,gamma2xy3,f_block,labeln);

%% differnt block length
[~,~,gamma2xy4,~,~]=deal_FRF(N,labell(1),file,noise1);
[~,~,gamma2xy5,~,~]=deal_FRF(N,labell(2),file,noise1);
[~,~,gamma2xy6,~,~]=deal_FRF(N,labell(3),file,noise1);
f=0;
plot_blol(gamma2xy4,gamma2xy5,gamma2xy6,f,labell);
