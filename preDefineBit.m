function [preBit,preSymbol] = preDefineBit(numberBitinSymbol, Ntime)
    m = 2^numberBitinSymbol;
    a = (1:m)';
    preBit = [];
    preSymbol = [];
    for i =1:Ntime
        preSymbol = [preSymbol; a(randperm(length(a)))];
    end
    for i = 1:length(preSymbol)
        bits = de2bi(preSymbol(i)-1,'left-msb',numberBitinSymbol);
        preBit = [preBit; bits'];
    end
end