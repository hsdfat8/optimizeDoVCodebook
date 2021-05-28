clear;
clc;

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

% system(['coder ' num2str(hon) ' 1.in 1.ec']);
% system('decoder 1.ec 1.dc');
% 
% system(['coder ' num2str(vec) ' 1.dc 1.ec1']);
% system('decoder 1.ec1 1.dc2');
%%
er = 0;
for i = 1: 11
waveRecei1 = readBin('D:\voice-compress\GD\data\new method\vina\2.rx','short');
% waveRecei = resample(waveRecei,8,16);
%     i= 3;
    waveRecei = waveRecei1(5000+i*length(waveTransmit)/2+1:5000+i*length(waveTransmit)/2+length(waveTransmit)/2);
    cor = xcorr(waveRecei,wave);
    [~,loc] = max(abs(cor));
    waveRecei2 = waveRecei(loc+1-length(waveRecei):loc+length(wave)-length(waveRecei));
    outBit = demapCodebook(waveRecei2,numberBitinSymbol,codebook, Ntimes, preSymbol);

dif = outBit - inBit;
er = er +sum(abs(dif))
end