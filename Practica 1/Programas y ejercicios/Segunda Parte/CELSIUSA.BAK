{Programa que convierte de grados celsius a grados farenheit, y muestra
 una tabla con las conversiones de los grados comprendidos entre -15 y
 +15 grados celsius, en intervalos de 0.5 grados y en forma de tabla}

PROGRAM CelsiusAFarenheit;
USES Crt;
VAR
 celsius : real;


        {Funci¢n que realiza el calculo de la conversion}
        {celsius[IN]: parametro de entrada que recibe la funcion para realizar
         la conversi¢n, y que representa y almacena los grados celsius
         introducidos por teclado}

        FUNCTION conversion (celsius: real): real;
        VAR
         farenheit : real;

        BEGIN
          farenheit:= (9/5) * celsius + 32;
          conversion:= farenheit;
        END;


       {Procedimiento que muestra por pantalla el resultado
        de los calculos de la conversion}
       {gradosCelsius[IN]: par metro de entrada que almacena el resultado
        que se va a mostrar}

       PROCEDURE muestraDatos (gradosCelsius: real);
       BEGIN
         Writeln ('Los grados celsius introducidos son equivalentes');
         Writeln ('a ', conversion (gradosCelsius):7:3, ' grados Farenheit');
       END;


       {Procedimiento que solicita y lee los grados requeridos al usuario}
       {gradosCel[OUT]: parametro de salida que almacena los grados
        introducidos por teclado}

       PROCEDURE leeDatos (var gradosCel: real);

       BEGIN
         Writeln ('Introduzca una cantidad de grados celsius, y los ');
         Writeln ('convertir‚ a grados Farenheit');
         Readln (gradosCel);
       END;


       {Procedimiento que imprime por pantalla la tabla de conversiones
        que va desde -15 a 15 grados celsius}

       PROCEDURE tabla (celsius: real);
       VAR
        grados: real;

       BEGIN
         Writeln ('*********************************************');
         Writeln ('*     Celsius      *      Farenheit         *');
         Writeln ('*********************************************');
         grados:= -15.0;
         WHILE (grados >= -15)  AND  (grados <= -6) DO
          BEGIN
            Writeln ('*    ', grados:7:2,'       *     ',conversion (grados):7:3, '            *');
            grados:= grados + 0.5;
          END;
         Writeln;
         Readln;
         WHILE (grados >= -5.5)  AND  (grados <= 4.5) DO
          BEGIN
            Writeln ('*    ', grados:7:2,'       *     ',conversion (grados):7:3, '            *');
            grados:= grados + 0.5;
          END;
         Writeln;
         Readln;
         WHILE (grados >= 5)  AND  (grados <= 15) DO
          BEGIN
            Writeln ('*    ', grados:7:2,'       *     ',conversion (grados):7:3, '            *');
            grados:= grados + 0.5;
          END;
       END;


       {Procedimiento que informa al usuario del funcionamiento del
        programa mediante escritura en pantalla}

       PROCEDURE informacion;
       BEGIN
         Writeln;
         Writeln ('A continuacion se mostrara una tabla con las conversiones ');
         Writeln ('desde -15 hasta 15 grados celsius a grados farenheit.');
         Writeln ('Pulse INTRO para continuar, despues de cada tramo de tabla');
         Writeln;
         Readln;
       END;
BEGIN
  ClrScr;
  leeDatos (celsius);
  muestraDatos (celsius);
  informacion;
  tabla (celsius);
  Writeln;
  Writeln ('Pulse una tecla para finalizar');
  REPEAT
  UNTIL Keypressed;
END.