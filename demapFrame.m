function [outBit,location] = demapFrame(wave,numberBitinSymbol, codebook)
    numberSampleInSymbol = 6*numberBitinSymbol;
    lenFrame = floor(length(wave)/540);
    preSynWave = codebook(:,3);
    preSynWave = [preSynWave;preSynWave;preSynWave];
    fsyb = zeros(1,540);
    numberWaveform = 2^numberBitinSymbol;
    eg = zeros(numberWaveform,1);
    outBit = [];
    location = [];
    for idxFrame = 1:lenFrame
        if idxFrame == 1
            for i = 55:540
                syn = wave(i+(idxFrame-1)*540-54:i+(idxFrame-1)*540-1);
                if norm(syn) == 0;
                    continue;
                end
                syn = syn/norm(syn)*sqrt(3);
                fsyb(i) = 0.75*fsyb(i)+ 0.25* sum(syn.*preSynWave);
            end
        elseif idxFrame > 1
            for i = 1:540
                syn = [];
                for j = 1:3    
                syn1 = wave(i+(idxFrame-1)*540-54+(j-1)*18:i+(idxFrame-1)*540-1-54+j*18);
                syn1 = syn1/norm(syn1);
                syn = [syn; syn1];
                end
                if (i == 250 || i == 262) && idxFrame == 6
                    b=0;
                    
                end
                fsyb(i) = 0.99*fsyb(i)+ 0.01* sum(syn.*preSynWave);
            end
            
        end
        [~,loc] = max(abs(fsyb));
        location = [location; loc];
        dataWave = sign(fsyb(loc))*wave(540*(idxFrame-1)+loc:540*(idxFrame-1)+loc+485);
        for idxBit = 1:81/3
            signal =  dataWave((idxBit-1)*numberSampleInSymbol+1:idxBit*numberSampleInSymbol);
            signal = signal/norm(signal);
            for j = 1: numberWaveform
              eg(j) =  sum(signal.*codebook(:,j));
            end
            [~,loc] = max(eg);
            codebook(:,loc) = 0.75*codebook(:,loc)+0.25*signal;
            bits = de2bi(loc-1,'left-msb',numberBitinSymbol);
            outBit = [outBit; bits'];
        end
        
    end
end