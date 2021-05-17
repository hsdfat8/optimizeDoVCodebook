function result = cosC(waveform)
    [~,m] = size(waveform);
    result = zeros(m,m);
    for i = 1:m
        for j = i+1:m
           result(i,j) = sum(waveform(:,j).*waveform(:,i));  
        end
    end
end