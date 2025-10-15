function VisualizarVideo_ext(fichero)
% Muestra sobre una figura el video contenido en fichero especificado con
% entrada. Se muestra fra me a frame hasta completar el fichero o se emplee
% la rueda del ratón sobre la figura. Se puede pausar el video haciendo
% click sobre la figure, reanudansose al pulsar una tecla.
% Define las condiciones de finalización y pausa del programa, se invoca
% a la función 'Terminar' o 'Pausar' por medio del ratón.
global fin
umbral_mano = 300;
fin = 0;
f = figure;
f.ButtonDownFcn = @Pausar;
f.WindowScrollWheelFcn = @Terminar;
%--------------------------------------------------------------
v = VideoReader(fichero); % Abre el fichero y se posiciona sobre el
% primer frame, el objeto video se define
% sobre la variable 'v'
% Se ejecuta hasta que se complete en video o se cancele la ejecución.
while (not(fin) && hasFrame(v))
im1 = readFrame(v); %Lee el siguente frame del fichero.
im1g = double(rgb2gray(im1))/255;
im2 = readFrame(v); %Lee el siguente frame del fichero.
im2g = double(rgb2gray(im2))/255;
im = 1*abs(im2g-im1g);
imshow (im1);
mano = sum(sum(im)); %Aqui sumo todos los valores de la matriz restada
if mano > umbral_mano %Coloco un umbral para detectar la mano, la cual es
    %la suma de todos los pixeles de la imagen
    disp("Hay mano")
else
    disp("No hay mano")
end
drawnow;
end
close % cierra la ventana
end
function Pausar(~,~)
pause
end
function Terminar(~,~)
global fin
fin = 1;
end