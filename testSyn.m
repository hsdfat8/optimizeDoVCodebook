clear;
clc;
load env

addpath D:\voice-compress\BKIC-pairphone\Matlab
% inBit = randi([0 1],30*81,1);
load inBit4.mat
numberBitinSymbol = 3;
Ntimes = 15;
% [preBit,preSymbol] = preDefineBit(numberBitinSymbol, Ntimes);

codebook = OptimizeCodeBook(numberBitinSymbol);
% inBit= [preBit; inBit]; 
wave = mapFrame(inBit,numberBitinSymbol,codebook);
wave = [2*rand(400,1)-1; wave];
wave = mulenv(wave,env);
% waveTransmit = [zeros(540*10,1); wave*2^12; zeros(540*20,1); wave*2^13; zeros(540*10,1)];
waveTransmit = -wave/max(wave)*2^14;
[outBit,location] = demapFrame(waveTransmit,numberBitinSymbol, codebook);
sum(abs(inBit-outBit))
