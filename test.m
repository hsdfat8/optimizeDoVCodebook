clear;
clc;
load inBit2.mat
load preBit2.mat
load preSymbol2.mat
load env
result = zeros(9,9);
for hon = 0:8
for vec = 0:8    
addpath D:\voice-compress\BKIC-pairphone\Matlab
numberBitinSymbol = 3;
Ntimes = 15;
% [preBit,preSymbol] = preDefineBit(numberBitinSymbol, Ntimes);

codebook = OptimizeCodeBook(numberBitinSymbol);
% inBit= [preBit; inBit]; 
wave = mapCodebook(inBit,numberBitinSymbol,codebook);
prewave = mapCodebook(preBit,numberBitinSymbol,codebook);

outBit = demapCodebook(wave,numberBitinSymbol,codebook);
wave = [prewave; wave];
sum(abs(inBit-outBit))

waveTransmit = [zeros(540*10,1); wave*2^12; zeros(540*20,1); wave*2^13; zeros(540*10,1)];
waveTransmit = mulenv(waveTransmit,env);

waveTransmit = resample(waveTransmit,16,8);
writeBin(waveTransmit,'1.in','short');

system(['coder ' num2str(hon) ' 1.in 1.ec']);
system('decoder 1.ec 1.dc');

system(['coder ' num2str(vec) ' 1.dc 1.ec1']);
system('decoder 1.ec1 1.dc2');
%%
waveRecei = readBin('1.dc2','short');
waveRecei = resample(waveRecei,8,16);

%     waveRecei1 = waveRecei(i*length(waveTransmit)/2+1:i*length(waveTransmit)/2+length(waveTransmit)/2);
    cor = xcorr(waveRecei,wave);
    [~,loc] = max(abs(cor));
    loc = loc;
    waveRecei1 = waveRecei(loc+1-length(waveRecei):loc+length(wave)-length(waveRecei));
    outBit = demapCodebook(waveRecei1,numberBitinSymbol,codebook, Ntimes, preSymbol);



dif = outBit - inBit;
result(hon+1,vec+1) = sum(abs(dif))/1800
end
end