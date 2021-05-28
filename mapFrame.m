function wave = mapFrame(inBit,numberBitinSymbol,codebook)
    len = floor(length(inBit)/numberBitinSymbol);
    lenFrame = floor(length(inBit)/81);
    wave = [];
    for idxFrame = 1:lenFrame
        for idx = 1: 3
            wave = [wave ; codebook(:,3)];
        end
        for idx =1:27
           bits = inBit((idxFrame-1)*81+numberBitinSymbol*idx-numberBitinSymbol+1:(idxFrame-1)*81+numberBitinSymbol*idx);
           symbol = bi2de(bits','left-msb');
           wave = [wave ; codebook(:,symbol+1)];
        end
    end
end