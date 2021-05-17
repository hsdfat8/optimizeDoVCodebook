function wave = mapCodebook(inBit,numberBitinSymbol,codebook)
    len = floor(length(inBit)/numberBitinSymbol);
    wave = [];
    for idx =1:len
       bits = inBit(numberBitinSymbol*idx-numberBitinSymbol+1:numberBitinSymbol*idx);
       symbol = bi2de(bits','left-msb');
       wave = [wave ; codebook(:,symbol+1)];
    end
end