clear;
clc;
load inBit.mat
inBit = randi([0 1],9000,1)
addpath D:\voice-compress\BKIC-pairphone\Matlab
numberBitinSymbol = 3;
Ntimes = 15;
[preBit,preSymbol] = preDefineBit(numberBitinSymbol, Ntimes);
codebook = OptimizeCodeBook(numberBitinSymbol);
% inBit= [preBit; inBit]; 
wave = mapCodebook(inBit,numberBitinSymbol,codebook);
prewave = mapCodebook(preBit,numberBitinSymbol,codebook);

outBit = demapCodebook(wave,numberBitinSymbol,codebook);
wave = [prewave; wave];
sum(abs(inBit-outBit))

waveTransmit = [zeros(540*10,1); wave*2^12; zeros(540*20,1); wave*2^13; zeros(540*10,1)];

waveTransmit = resample(waveTransmit,16,8);
writeBin(waveTransmit,'1.bin','short');

system('coder 0 1.bin 1.tx');
system('decoder 1.tx 1.rx')

waveTransmit = readBin('1.rx','short');
waveRecei = resample(waveTransmit,8,16);
cor = xcorr(waveRecei,wave);
[~,loc] = max(cor);
waveRecei = waveRecei(loc-length(waveRecei)+1:loc-length(waveRecei)+length(wave));
outBit = demapCodebook(waveRecei,numberBitinSymbol,codebook, Ntimes, preSymbol);


sum(abs(inBit-outBit))