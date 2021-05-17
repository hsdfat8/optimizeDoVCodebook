function outBit = demapCodebook(wave,numberBitinSymbol, codebook, Ntimes, preSymbol)
    numberSampleInSymbol = 6*numberBitinSymbol;
    if nargin > 3
        omega = 1/(Ntimes+1);
        codebook = 1/(Ntimes+1) * codebook;
        numberDefineSymbol = Ntimes*2^numberBitinSymbol;
        prewave = wave(1:numberDefineSymbol*numberSampleInSymbol);
        for idx = 1:numberDefineSymbol
            signal =  prewave((idx-1)*numberSampleInSymbol+1:idx*numberSampleInSymbol);
            signal = signal/norm(signal);
            codebook(:,preSymbol(idx)) = codebook(:,preSymbol(idx))+omega*signal;
        end
        wave = wave(1+length(prewave):end);
    end
    
    len = floor(length(wave)/numberSampleInSymbol);
    numberWaveform = 2^numberBitinSymbol;
    eg = zeros(numberWaveform,1);
    outBit = [];
    for idx = 1:len
       signal =  wave((idx-1)*numberSampleInSymbol+1:idx*numberSampleInSymbol);
       signal = signal/norm(signal);
       for j = 1: numberWaveform
          eg(j) =  sum(signal.*codebook(:,j));
       end
       [~,loc] = max(eg);
       bits = de2bi(loc-1,'left-msb',numberBitinSymbol);
       outBit = [outBit; bits'];
    end
end