 {$R+}         {$I+}          {$X-}
 {$S+}         {$Q+}

PROGRAM Pr2A;
{Programa que realiza una serie de tareas, segun la eleccion que haga el
 usuario de las opciones del men£}

USES Crt;
VAR
 opcion: integer;


     PROCEDURE menu (var opcion: integer);
     {Este procedimiento muestra un menu al usuario de las operaciones
      que puede seleccionar, para que el programa las realice}
     {opcion[OUT]: parametro de salida que guardar  la opcion que introduzca el usuario}
     VAR
      opcionUser: string;
      error: integer;
     BEGIN
       ClrScr;
       REPEAT
         Writeln ('1.- Evaluacion de la funcion');
         Writeln ('2.- Numero Combinatorio');
         Writeln ('3.- Nombres de Cartas');
         Writeln ('4.- Salir');
         Writeln ('Por favor, elija una de las opciones que se muestran y pulse INTRO');
         Readln (opcionUser);
         ClrScr;
         Val (opcionUser, opcion, error);
       UNTIL (opcion <= 4) AND (opcion >= 1) AND (error = 0);
     END;


     PROCEDURE EscribeError;
     {Este procedimiento se encarga de ecribir un mensaje por pantalla que informa
      al usuario de que los datos introducidos son incorrectos}
     BEGIN
         Writeln;
         Writeln ('***** ERROR: Datos NO VALIDOS *****');
         Writeln;
     END;


     PROCEDURE evaluaFuncion;
     {Este procedimiento realizara la evaluacion de la funcion f, calculando
      el valor de dicha funcion en el punto que introduzca el usuario}
     VAR
       x: real;
       resultado: real;


                PROCEDURE solicitaDatos (var x: real);
                {Este procedimiento solicita y lee el dato necesario para
                 evaluar la funcion}
                {x[OUT]: parametro de salida que almacenara el punto a evaluar}
                VAR
                 dato: String;
                 error: integer;
                BEGIN
                  REPEAT
                    Writeln ('Introduzca un n£mero real positivo, para');
                    Writeln ('evaluar la funcion en ese punto, y pulse INTRO');
                    Readln (dato);
                    Val (dato, x, error);
                    IF (error <> 0) OR (x < 0) THEN
                      escribeError;
                  UNTIL (error = 0) AND (x > 0);
                END;


                FUNCTION evalua (x: real): real;
                {Esta funci¢n se encarga de comprobar en qu‚ caso estamos
                 y realiza los calculos pertinentes}
                {x[IN]: parametro de entrada que simboliza el punto a evaluar}
                CONST
                 pi = 3.14159;
                VAR
                 radianes: real;
                BEGIN
                  IF (x >= 0) AND (x < 45) THEN
                       evalua:= sqr (x) - 5
                  ELSE
                    IF (x >= 45) AND (x < 180) THEN
                     begin
                       radianes:= x * pi / 180;
                       evalua:= x + sin (radianes)
                     end
                    ELSE
                      IF (x >= 180) AND (x < 360) THEN
                           evalua:= 3
                      ELSE
                           evalua:= sqr (x);
                END;



                PROCEDURE escribeDatos (resultado: real);
                {Este rpocedimiento escribe por pantalla el
                 resultado de la evaluaci¢n de la funcion}
                {resultado[OUT]: parametro de salida que
                almacena el resultado de la evaluacion}
                BEGIN
                  Writeln ('El resultado es: ', resultado:8:4);
                  Writeln;
                  Writeln ('Pulse tecla cualquiera para continuar');
                  Writeln;
                END;


     BEGIN
       ClrScr;
       solicitaDatos (x);
       resultado:= evalua (x);
       escribeDatos (resultado);
       REPEAT
       UNTIL Keypressed;
     END;



     PROCEDURE numerosCombinatorios;
     {Esta procedimiento se encargar  de calcular el n£mero combinatorio
      "x sobre y"}
     VAR
      num1, num2: integer;
      resultado: integer;



             PROCEDURE PideDatos (var num1, num2: integer);
             {Este procedimiento tiene como objetivo solicitar los datos necesarios
              y leerlos}
             {num1[OUT]: parametro de salida que representa el primero de los numeros
              el cual debe ser el mayor}
             {num2[OUT]: parametro de salida que representa el segundo de los numeros}
             VAR
              num1IN, num2IN: String;
              error1, error2: integer;
             BEGIN
               Writeln ('A continuacion se procedera a realizar los calculos.');
               Writeln ('Deber  introducir dos numeros enteros positivos');
               Writeln ('El primer numero introducido debe ser mayor que el segundo');
               Writeln ('para calcular el numero combinatrio "x sobre y".');
               REPEAT
                 Writeln ('Introduzca el primer numero y pulse INTRO');
                 Readln (num1IN);
                 Val (num1IN, num1, error1);
                 IF (error1 <> 0) OR (num1 < 0) THEN
                   escribeError;
               UNTIL (error1 = 0) AND (num1 > 0);
               REPEAT
                 Writeln ('Introduzca el segundo numero y pulse INTRO');
                 Readln (num2IN);
                 Val (num2IN, num2, error2);
                 IF (error2 <> 0) OR (num2 > num1) OR (num2 < 0) THEN
                   escribeError;
               UNTIL (error2 = 0) AND (num1 > num2) AND (num2 > 0);
             END;



             FUNCTION calculos (num1, num2:integer):integer;
             {Esta funcion realiza los calculos necesarios para hacer el numero combinatorio}
             {num1[IN]: parametro de entrada que representa el primero de los numeros
              el cual debe ser el mayor}
             {num2[IN]: parametro de entrada que representa el segundo de los numeros}


                      FUNCTION factorial (num: integer): longint;
                      {Esta funcion se encarga de calcular el factorial de un
                       numero}
                      {num[IN]: parametro de entrada que representa el numero
                       del cual queremos calcular su factorial}
                      VAR
                        k: integer;
                        resultado: longint;
                      BEGIN
                        resultado:= 1;
                        FOR k:= 1 TO num DO
                           resultado:= resultado * k;
                        factorial:= resultado;
                      END;


             BEGIN
               calculos:= factorial (num1) div (factorial (num2) * factorial (num1-num2));
             END;


             PROCEDURE muestraResultado (resultado: integer);
             {Este procedimiento muestra el resultado tras las
              operaciones realizadas}
             {resultado[IN]: parametro de entrada que almacena el numero combinatorio final}
             BEGIN
                Writeln ('El resultado es: ',resultado);
                Writeln;
                Writeln ('Pulse tecla cualquiera para continuar');
                Writeln;
             END;


     BEGIN
       ClrScr;
       pideDatos (num1,num2);
       resultado:= calculos (num1, num2);
       muestraResultado (resultado);
       REPEAT
       UNTIL Keypressed;
     END;


     PROCEDURE Cartas;
     {Este procedimiento identifica una carta de la baraja espa¤ola a partir
      del n£mero que ocupa en dicha baraja}
     VAR
      aux1, aux2: integer;


              PROCEDURE pideLeeYPrepara (var aux2, aux1: integer);
              {Este procedimiento solicita un numero, lo lee y
               realiza las operaciones oportunas para identificar
               la carta}
              {aux2[OUT]: parametro de salida que representa el numero
               introducido por el usuario, tras las modificaciones pertinentes
               que se le asigna al palo que corresponda}
              {aux1[OUT]: parametro de salida que es el resto de la division
               entera entre 10, del numero que mete el usuario}
              VAR
               num: integer;
               error: integer;
               numIN: String;
              BEGIN
                REPEAT
                  Writeln ('Introduzca un numero entero entre 1 y 40 y pulse INTRO');
                  Readln (numIN);
                  Val (numIN, num, error);
                  IF (error <> 0) OR (num > 40) OR (num < 1) THEN
                    escribeError;
                UNTIL (num > 0) AND (num <= 40) AND (error = 0);
                aux2:= (num-1) div 10;
                aux1:= num mod 10;
              END;


              PROCEDURE mostrarCarta (aux1: integer);
              {Este procedimiento escribe por pantalla la carta que ha
               introducid el usuario}
              {aux1[IN]: parametro de entrada que es el resto de la division
               entera entre 10, del numero que mete el usuario}
              BEGIN
                CASE aux1 OF
                 1: Write ('El as de ');
                 2: Write ('El dos de ');
                 3: Write ('El tres de ');
                 4: Write ('El cuatro de ');
                 5: Write ('El cinco de ');
                 6: Write ('El seis de ');
                 7: Write ('El siete de ');
                 8: Write ('La sota de ');
                 9: Write ('El caballo de ');
                 0: Write ('El rey de ');
                end;
              END;



              PROCEDURE mostrarPalo (aux2: integer);
              {Este procedimiento se encarga de mostrar el palo de la carta
               que ha introducido el usuario}
              {aux2[IN]: parametro de entrada que representa el numero
               introducido por el usuario, tras las modificaciones pertinentes
               que se le asigna al palo que corresponda}
              BEGIN
                CASE aux2 OF
                 0: Writeln ('oros');
                 1: Writeln ('copas');
                 2: Writeln ('espadas');
                 3: Writeln ('bastos');
                end;
              END;


              PROCEDURE mensajeFinal;
              {Este procedimiento muestra un mensaje final}
              BEGIN
                Writeln;
                Writeln ('Pulse tecla cualquiera para continuar');
                Writeln;
              END;


     BEGIN
       ClrScr;
       pideLeeYPrepara (aux2, aux1);
       Write ('La carta es ');
       mostrarCarta (aux1);
       mostrarPalo (aux2);
       mensajeFinal;
       REPEAT
       UNTIL Keypressed;
     END;


BEGIN
  ClrScr;
  menu (opcion);
  REPEAT
  IF opcion <> 4 THEN
    begin
        CASE opcion OF
          1: evaluafuncion;
          2: numerosCombinatorios;
          3: Cartas;
        end;
      menu (opcion);
    end;
  UNTIL opcion = 4;
END.