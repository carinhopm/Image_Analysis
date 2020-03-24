function [ idColor ] = descriptorColor( img, mask )

img = rgb2hsv(img);
img_h = img(:,:,1);
img_s = img(:,:,2);
img_v = img(:,:,3);

img_h = img_h .* mask;
img_s = img_s .* mask;
imv_v = img_v .* mask;
%figure, imshow(img_h, []), title('Imagen con máscara');


% Eliminamos los píxeles con 0 (filtrados por la máscara).
H = (img_h~=0);
S = (img_s~=0);
V = (img_v~=0);

mediaH = mean(mean(H));
varH = var(var(H));
mediaS = mean(mean(S));
varS = var(var(S));
mediaV = mean(mean(V));
varV = var(var(V));

idColor = [mediaH varH mediaS varS mediaV varV];

%figure, imshow(H, []), title('Imagen con color');

end

