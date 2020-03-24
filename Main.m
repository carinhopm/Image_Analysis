close all
clear all
clc

directorio_imagenes = 'nuevas';


imagenes = dir(strcat(directorio_imagenes,'\*.jpg'));
Ximagenes = [];
Yimagenes = [];
total = length(imagenes);
tic
for i=1:total
    % Lee la imagen y la redimensiona
    path = strcat(directorio_imagenes,'\',imagenes(i).name);
    fprintf('Imagen %s \n', imagenes(i).name);
    
    M = imread(path);
    %Redimensionamos para que la mayor dimensi�n sea de 300px como m�ximo.
    if size(M,1) > size(M,2)
        M = imresize(M, [300 NaN]);
    else
        M = imresize(M, [NaN 300]);
    end
    
 
    Ximagenes(i,:) = ExtraeCaracteristicas(M);
    
    % Coloca las etiquetas de cada imagen
    if strncmp(imagenes(i).name,'b-',2) > 0
        Yimagenes(i,1) = 1;
    else
        Yimagenes(i,1) = 0;
    end
    
    % Para ofrecer algo de informaci�n
    pct = floor(i/total * 100);
    if mod(pct,2) == 0
       fprintf('>>Calculado el %d porciento. \n', pct); 
    end
    
end

% Normalizamos las caracter�sticas de las im�genes:
Ximagenes_norm = normalizaCaracteristicas(Ximagenes);

fprintf('Tiempo en extraer caracter�sticas: ');
toc

% �ndices para validaci�n cruzada
nfolds = 5; % con 5: 72.1%. con 3: 69.7%.
ntr = size(Ximagenes,1);
indices = indicesCV(5,ntr);

aciertos = zeros(length(nfolds),1);
pfa = zeros(length(nfolds),1);
pm = zeros(length(nfolds),1);
for iter_nfold=1:nfolds
    % Obtiene los �ndices para entrenar
    indices_train = find(indices ~= iter_nfold);
    indices_test = find(indices == iter_nfold);
    
    % Crea el subconjunto de entrenamiento para esta iteraci�n
    x_train = Ximagenes_norm(indices_train,:);
    y_train = Yimagenes(indices_train,:);
    
    % Crea el subconjunto de test para esta iteraci�n
    x_test = Ximagenes_norm(indices_test,:);
    y_test =  Yimagenes(indices_test,:);
    
    % Entrena el modelo a partir de las im�genes de entrenamiento
    modelo = fitcknn(x_train, y_train);
    
    % Clasifica las im�genes de test
    y = predict(modelo, x_test);
    
    % Calcula el �rea bajo la curva, la probabilidad de falsa alarma, y la
    % de p�rdida de esta iteraci�n
    aciertos(iter_nfold) = (sum(y==y_test))/length(y);
    pfa(iter_nfold) = (sum((y == 1) & (y_test == 0)) / sum(y_test == 0));
    pm(iter_nfold) = (sum((y == 0) & (y_test == 1)) / sum(y_test == 1));
        
end

% Calcula la tasa de aciertos media, la probabilidad de falsa alarma, y la
% de p�rdida
meanaciertos = mean(aciertos);
falsa_alarma = mean(pfa);
perdida = mean(pm);

fprintf('�rea bajo la curva: %f\n', meanaciertos);
fprintf('Probabilidad de falsa alarma: %f\n', falsa_alarma);
fprintf('Probabilidad de p�rdida: %f\n', perdida);

