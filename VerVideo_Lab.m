function VerVideo_Lab(fichero)
    v = VideoReader(fichero);

    f = figure;
    f.WindowScrollWheelFcn = @(~,~) close(f); 
    umbral_A_minimo = 0.026; %Valor de a en Lab para contar pixel
    %como posible perteneciente a una mano
    umbral_A_maximo = 0.09;
    umbral_pixeles_minimos = 5000; %Número de pixeles minimos para decir que
    %hay una mano en el video.

    while hasFrame(v)
        frame = readFrame(v);

        labImage = rgb2lab(frame);        
        a = labImage(:,:,2);  %Canal verde-rojo
        a_norm = double(a)/255;
        mascara = a_norm > umbral_A_minimo; %Buscar píxeles que superen el
        %umbral
        mascara_altos = a_norm < umbral_A_maximo;
        mascara = mascara & mascara_altos; %Haciendo una union de las dos mascaras
        %para quitar los pixeles de las chinchetas
        vector_pixeles_posibles=sum(mascara);
        suma_vector_pixeles_posibles = sum(vector_pixeles_posibles);
        
        a_norm(mascara) = a_norm(mascara) * 10;
        imshow(frame), title('Canal a')
        hold on;%Display del texto
        if suma_vector_pixeles_posibles > umbral_pixeles_minimos
            text(size(a_norm,2)/2, size(a_norm,1) + 20, 'MANO PRESENTE', ...
                'Color', 'red', 'FontSize', 16, 'FontWeight', 'bold', ...
                'HorizontalAlignment', 'center', 'VerticalAlignment', 'top');
        else
            text(size(a_norm,2)/2, size(a_norm,1) + 20, 'LIBRE → CONTAR', ...
                'Color', 'green', 'FontSize', 16, 'FontWeight', 'bold', ...
                'HorizontalAlignment', 'center', 'VerticalAlignment', 'top');
        end

        hold off;
        

        drawnow;
    end
end
