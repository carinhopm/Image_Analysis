function [centros, radios] = detectorCirculos(imagen)
    imagen_procesada = imagen;
    
    % Hacemos un filtrado paso bajo para mejorar el resultado
    % del detector de bordes
    imagen_procesada = rgb2gray(imagen_procesada);
    h_disk = fspecial('disk',4);
    imagen_procesada = imfilter(imagen_procesada, h_disk);
    
    % Detectamos los bordes de la imagen
    i_bordes = edge(imagen_procesada, 'Canny', 0.3); % antes 0.35, ->(I,method,threshold, 'both', 1)
   
    % figure, imshow(i_bordes, []);
        
    % Ponemos como radio máximo de búsqueda la mitad de la
    % dimensión más pequeña de la imagen. Asumiendo que el balón
    % quepa entero en la imagen, para ahorrar tiempo de cómputo.
    max_radii = (min(size(imagen,1), size(imagen,2)))/2;
        
    radii = 20:1:max_radii; % FIJAMOS AQUÍ EL RADIO DE LOS CÍRCULOS A DETECTAR
    h = circle_hough(i_bordes, radii, 'same', 'normalise');
    
    peaks = circle_houghpeaks(h, radii, 'nhoodxy', 3, 'nhoodr', 3, 'npeaks', 1);%nhoodxy 15, nhoodr 21
     
    centros = [];
    centros = [peaks(1,1) peaks(2,1)];
    radios = peaks(3,1);
    
    figure, imshow(imagen, []);

    hold on;
    for peak = peaks
       [x,y] = circlepoints(peaks(3));
       plot(x+peak(1),y+peak(2),'r-','LineWidth',3);
    end
    hold off
end
