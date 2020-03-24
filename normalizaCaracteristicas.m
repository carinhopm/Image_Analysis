function [ X_norm ] = normalizaCaracteristicas( X )
    X_norm = X;

    for i=1:size(X,2)
       mu = ones(size(X,1),1).*mean(X(:,i));
       std = ones(size(X,1),1).*var(X(:,i));
       X_norm(:,i) = (X(:,i)-mu)./std;
    end

end

