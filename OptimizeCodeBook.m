function waveform = OptimizeCodeBook(numberBitinSymbol)
    m = 2^numberBitinSymbol;                                 %Number of waveforms in codebook
    n = 6*numberBitinSymbol;                                 %Number of sample in each waveform
    fs = 8000;                              %Sampling Frequency
    DataRate = fs/n*log2(m)
    f0= 2*fs/2/n;                                %Base frequency 
    deltaf = fs/2/n;                            %Step of frequency
    q = m/2;                                 %Number of subcarrier
    a = eq_point_set(q-1,m);                %Surface packet
    % a = ones(q,m)
    % a = 2*rand(q,m)-1;
    waveform = genWave(a,n,f0,deltaf,fs);   %Gen waveform
    result = cosC(waveform);
    max(max(result))
end
% for i =1:m
%    figure;
%    plot(waveform(:,i));
% end