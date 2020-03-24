function [modelo] = EntrenaClasificador(Xtrain, etiquetas)

% Entrenamos el clasificador con SVM
modelo = svmtrain(Xtrain,etiquetas);

end

