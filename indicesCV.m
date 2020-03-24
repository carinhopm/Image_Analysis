function [indices] = indicesCV(numFolds,n)
%F�nci�n que devuelve los �ndices para una validaci�n cruzada con numFolds
%folds y n muestras de entrenamiento

%Muestras por fold
n_fold = floor(n/numFolds);

indices = zeros(n,1);

for i=1:(numFolds-1)
    indices((i-1)*n_fold + 1:i*n_fold) = i;
end

indices((numFolds-1)*n_fold + 1:end) = numFolds;

perm = randperm(n);
indices = indices(perm);