function componentes = ExtraeCaracteristicas(img)

    [centro radio] = detectorCirculos(img);

    mask = zeros(size(img,1), size(img,2));
    %Obtenemos el circulo a insertar en la máscara
    circulo = [centro(1,:) (radio-5)];
    mask = insertShape(mask,'FilledCircle',circulo,'color','white');
    mask = im2bw(mask, 0);

    componentes = [];
    componentes = descriptorColor(img,mask);
    componentes = [componentes descriptorLineas(img, mask)];
end

