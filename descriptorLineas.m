function [ idLineas ] = descriptorLineas( img, mask )

   ihsv = rgb2hsv(img);
   s = ihsv(:,:,2);
   img_gray = im2double(s);
   img_m = img_gray .*mask;
   
   img_m = medfilt2(img_m, [ 5 5 ]);
   i_bordes = edge(img_m, 'Canny');
    %s = ihsv(:,:,2);
    %img_m = medfilt2(img_m, [5 5]);
%     v = [-1 0 1; -1 0 1; -1 0 1];
%     h = [-1 -1 -1; 0 0 0; 1 1 1];
    
   [gmag gdir] = imgradient(i_bordes);
   direcciones = gdir(gdir~=0);
   % figure, imshowpair(gmag, gdir, 'montage');
   [N,edges] = histcounts(direcciones, 8, 'Normalization', 'probability');
   % figure, histogram(direcciones,8,'Normalization','probability');
    
%     [idLineas,edges] = histcounts(gdir, 8);

    %img_h = imfilter(img_m, h);
%     figure, imshow(img_h);
%     img_v = imfilter(img_m, v);
%     figure, imshow(img_v);
%     bw_h = im2bw(img_h, 0.5);
%     bw_v = im2bw(img_v, 0.5);
%     s = bw_h + bw_v;
%     s(s == 2) = 1;
%     figure, imshow(s);
    
%     img_h = imfilter(img_m, h);
%     figure, imshow(img_h,[]), title('paso alto');
%     img_v = imfilter(img_m, v);
%     img_m = img_h + img_v;
%     img_m = edge(img_m, 'Canny', 0.2);
%     figure, imshow(img_m);
   
% %    % img_m = imsharpen(img_m);
% %    img_b = edge(img_filt, 'Canny');
% %    figure, imshow(img_b, []), title('Imagen de bordes');
%    h = 
%    f = fspecial('gaussian', [15 15]);
%    % f = [1/9 1/9 1/9, 1/9 1/9 1/9, 1/9 1/9 1/9];
%    img_filt = filter2(f, img_m, 'same');
%    figure, imshow(img_filt, []), title('Imagen filtrada');
%    
%    [featureVector,hogVisualization] = extractHOGFeatures(img_filt);
% %    figure;
% %    imshow(img_filt);
% %    figure;
% %    plot(featureVector);
   
   idLineas = N;

end

