function y = clasifica(directorio_train, Ytrain, directorio_test)

img_train = dir(directorio_train);
img_test = dir(directorio_test);

for i=1:length(img_train)
    M = imread([directorio_train '/' img_train(i).name]);
    M = imresize(M, [500 NaN]);
    Xtrain(:,i) = ExtraeCaracteristicas(M);
end

W = EntrenaClasificador(Xtrain, Ytrain);

for i=1:length(img_test)
    M = imread([directorio_test '/' img_test(i).name]);
    Xtest(:,i) = ExtraeCaracteristicas(M);
end

y = Clasificacion(Xtest, W);

end

