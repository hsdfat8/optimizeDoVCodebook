function out = mulenv(signal,env)
    env1 = [];
    while(length(env1)<length(signal))
        env2 = env + 0.4*max(env);
        env1 = [env1;env2];
    end
    out = env1(1:length(signal))/max(env).*signal;
end