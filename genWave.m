function waveform = genWave(a,n,f0,deltaf,fs)
    [q, m] = size(a);
    waveform = zeros(n,m);
    for i = 1:m
        for j = 1:n
            fj=f0;
            for u = 1: q
                waveform(j,i) = waveform(j,i) + a(u,i)*sin(2*pi*(j-1)*fj/fs);
                fj = f0 + u*deltaf;
            end
        end
        waveform(:,i)=waveform(:,i)/norm(waveform(:,i));
    end
end