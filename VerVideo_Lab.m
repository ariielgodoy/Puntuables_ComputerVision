function VerVideo_Lab(fichero)
    v = VideoReader(fichero);

    f = figure;
    f.WindowScrollWheelFcn = @(~,~) close(f); 
    umbral_A_minimo = 0.026; %Valor de a en Lab para contar pixel
    %como posible perteneciente a una mano
    umbral_A_maximo = 0.09
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
        mascara = mascara & mascara_altos;
        vector_pixeles_posibles=sum(mascara);
        suma_vector_pixeles_posibles = sum(vector_pixeles_posibles);
        if (suma_vector_pixeles_posibles>umbral_pixeles_minimos)
            disp("Mano")
        else
            disp("No hay mano")
        end
        a_norm(mascara) = a_norm(mascara) * 10;
        imshow(a_norm), title('Canal a')

        drawnow
    end
end
