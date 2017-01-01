 {$R+}       {$I+}         {$X-}
 {$S+}       {$Q+}
PROGRAM Pr2C;
{Este programa realiza distintas acciones relacionadas con el tratamiento de
 cadenas de caracteres. Dichas acciones se le presentan en un menu al usuario
 para que elija una opcion, y se realice la accion que corresponda}
USES Crt;
VAR
 opcion: integer;


           PROCEDURE menu (var opcion: integer);
           {Este procedimiento muestra por pantalla
            el menu de opciones}
           {opcion[OUT]: parametro de salida que
            guardara la opcion}
           VAR
            error: integer;
            opcionUser: String;
           BEGIN
             REPEAT
               ClrScr;
               Writeln ('1.- Contar palabras');
               Writeln ('2.- Distancia entre digitos');
               Writeln ('3.- Conteo de elementos');
               Writeln ('4.- Salir');
               Writeln ('Por favor, introduzca una de estas opciones');
               Readln (opcionUser);
               Val (opcionUser, opcion, error);
               Writeln;
             UNTIL (opcion <= 4) AND (opcion >= 1) AND (error = 0);
           END;


           PROCEDURE tratarLinea;
           {Este procedimiento cuenta el numero de palabras en una frase.
            Se entiende por palabra a la letra, o conjunto de ellas separadas
            por blancos (espacios)}
           VAR
            ch: char;
            contador: integer;



                      PROCEDURE inicializaYEscribe (var ch: char; var contador: integer);
                      {Este procedimiento escribe un mensaje de informacion en pantalla,
                       e inicializa las variables "ch" y "contador"}
                      {ch[OUT]: parametro de salida que representa el caracter que se
                       va leyendo}
                      {contador[OUT]: parametro de salida que representa el numero de
                       palabras que se van contando}
                      BEGIN
                        Writeln ('Introduzca una frase para contar el numero de palabras');
                        Writeln ('que tiene');
                        ch:= ' ';
                        contador:= 0;
                      END;



                      PROCEDURE desechaBlancosIniciales (var ch: char; var contador: integer);
                      {Este procedimiento se encarga de saltar los posibles
                       blancos al inicio de una frase}
                      {ch[IN-OUT]: parametro de entrada/salida que representa
                       el caracter que se va leyendo}
                      {contador[IN-OUT]: parametro de entrada/salida que
                       representa el numero de palabras que se van contando}
                      BEGIN
                        WHILE not eoln AND (ch = ' ') DO
                            read (ch);
                        contador:= contador + 1;
                      END;



                      PROCEDURE realizaConteo (var ch: char; var contador: integer);
                      {Este procedimiento procesa la frase caracter a carater y va
                       contando las palabras que encuentra}
                      {ch[OUT]: parametro de salida que representa el caracter
                       que se va leyendo}
                      {contador[IN-OUT]: parametro de entrada/salida que
                       representa el numero de palabras que se van contando}
                      BEGIN
                        WHILE not eoln DO
                          begin
                            read (ch);
                            IF ch = ' ' THEN
                             begin
                               WHILE not eoln AND (ch = ' ') DO
                                  read (ch);
                               contador:= contador + 1
                             end;
                          end;
                        IF (ch = ' ') THEN
                             contador:= contador - 1;
                        Writeln;
                      END;


           BEGIN
             ClrScr;
             inicializaYEscribe (ch, contador);
             desechaBlancosIniciales (ch, contador);
             realizaConteo (ch, contador);
             Writeln ('La frase tiene ', contador, ' palabras');
             Writeln;
             Writeln ('Pulse tecla cualquiera para continuar');
             Writeln;
             REPEAT
             UNTIL Keypressed;
           END;



           PROCEDURE contarElementos;
           {Este procedimiento cuenta los caracteres especiales, digitos y letras
            de una cadena de caracteres introducida por teclado}
           VAR
            cuentaletras: integer;
            cuentadigitos: integer;
            cuentacaracteres: integer;



                      PROCEDURE inicializaEInforma (var cuentaletras, cuentacaracteres, cuentadigitos: integer);
                      {Este procedimiento informa al usuario de lo que tiene que hacer, e inicializa las variables
                       que representan los respectivos contadores, de los tipos de carateres que sean}
                      {cuentaletras[OUT]: parametro de salida que actua de contador para las letras}
                      {cuentadigitos[OUT]: parametro de salida que actua de contador para los digitos}
                      {cuentacaracteres[OUT]: parametro de salida que actua de contador para los
                       caracteres especiales}
                      BEGIN
                        Writeln ('Introduzca una cadena de caracteres y contar‚,');
                        Writeln ('y mostrar‚ el numero de digitos, letras');
                        Writeln ('y caracteres especiales, que contiene');
                        cuentaletras:= 0;
                        cuentadigitos:= 0;
                        cuentacaracteres:= 0;
                      END;



                      PROCEDURE procesaCadena (var cuentaletras, cuentadigitos, cuentacaracteres: integer);
                      {Este procedimiento procesa la cadena y cuenta las letras, digitos y caracteres
                       especiales, que pudieran aparecer en ella}
                      {cuentaletras[IN-OUT]: parametro de entrada/salida que actua de contador para las letras}
                      {cuentadigitos[IN-OUT]: parametro de entrada/salida que actua de contador para los digitos}
                      {cuentacaracteres[IN-OUT]: parametro de entrada/salida que actua de contador para los
                       caracteres especiales}
                      VAR
                       ch: char;
                      BEGIN
                        WHILE not eoln DO
                         begin
                           read (ch);
                           CASE ch OF
                             '¤', 'a'..'z', 'A'..'Z': cuentaletras:= cuentaletras + 1;
                             '0'..'9': cuentadigitos:= cuentadigitos + 1;
                             ' ':
                             {en esta rama no se hace ninguna cuenta, ya que no se consideran los
                              espacios en blanco, ni como caracteres ni como caracteres especiales}
                           ELSE
                             cuentacaracteres:= cuentacaracteres + 1;
                           end;
                         end;
                      END;



                      PROCEDURE muestraResultados (cuentaletras, cuentadigitos, cuentacaracteres: integer);
                      {Este procedimiento escribe por pantalla los resultados obtenidos}
                      {cuentaletras[IN]: parametro de entrada que actua de contador para las letras}
                      {cuentadigitos[IN]: parametro de entrada que actua de contador para los digitos}
                      {cuentacaracteres[IN]: parametro de entrada que actua de contador para los
                       caracteres especiales}
                      BEGIN
                        Writeln;
                        Writeln ('El numero de letras que aparecen en la cadena es: ', cuentaletras);
                        Writeln;
                        Writeln ('El numero de digitos que aparecen en la cadena es: ', cuentadigitos);
                        Writeln;
                        Writeln ('El numero de caracteres especiales que aparecen en la cadena es: ', cuentacaracteres);
                        Writeln;
                        Writeln ('Pulse tecla cualquiera para continuar');
                        Writeln;
                        REPEAT
                        UNTIL Keypressed;
                      END;


           BEGIN
             ClrScr;
             inicializaEInforma (cuentaletras, cuentacaracteres, cuentadigitos);
             procesaCadena (cuentaletras, cuentadigitos, cuentacaracteres);
             muestraResultados (cuentaletras, cuentadigitos, cuentacaracteres);
             Writeln;
           END;


           PROCEDURE distanciaMedia;
           {Este procedimiento calcula la distancia media entre digitos contenidos
            en una cadena de caracteres introducida por el usuario}
           VAR
            media: integer;
            numDistancias: integer;
            distanciaMediaFinal: real;
            esDigito: boolean;
            ch: char;



                     PROCEDURE escribeEInicializa (var media, numDistancias: integer; var distanciaMediaFinal: real);
                     {Este procedimiento escribe un mensaje diciendole al usuario lo que debe hacer, e
                      inicializa las variables "media", "numDistancias" y "distanciaMedia"}
                     {media[OUT]: parametro de salida que representa las distancias entre digitos
                      acumuladas}
                     {numDistancias[OUT]: parametro de salida que representa el numero de distancias
                      que se procesan}
                     {distanciaMediaFinal[OUT]: parametro de salida que representa la distancia media entre
                      cada digito de la cadena}
                     BEGIN
                       Writeln ('Introduzca cadena de caracteres y calculare la distancia media entre cada digito');
                       media:= 0;
                       numDistancias:= 0;
                     END;


                     PROCEDURE buscaPrimerDigito (var ch: char; var esDigito: boolean);
                     {Este procedimiento se encarga de buscar el primer digito de la cadena,
                      terminando su funcion, cuando lo lee}
                     {ch[OUT]: parametro de salida que representa el caracter que
                      se va leyendo}
                     {esDigito[OUT]: parametro de salida que representa el valor
                      buleano de saber si un caracter es digito (true), o no (false)}
                     BEGIN
                       esDigito:= false;
                       WHILE not eoln AND not esDigito DO
                        begin
                          read (ch);
                          esDigito:= (ch = '0') OR (ch = '1') OR (ch = '2') OR (ch = '3') OR (ch = '4') OR (ch = '5')
                                     OR (ch = '6') OR (ch = '7') OR (ch = '8') OR (ch = '9');
                        end;
                     END;



                     FUNCTION procesaYCalcula (esDigito: boolean; ch: char; numDistancias: integer; media: integer): real;
                     {Este procedimiento procesa la cadena buscando digitos, y contando la distancias entre ellos.
                     Luego se calcula la media haciendo la division de las distancias acumuladas entre el numero de distancias}
                     {esDigito[IN]: parametro de entrada que representa el valor
                      buleano de saber si un caracter es digito (true), o no (false)}
                     {ch[IN]: parametro de entrada que representa el caracter que
                      se va leyendo}
                     {numDistancias[IN]: parametro de entrada que representa el numero de distancias
                      que se procesan}
                     {media[IN]: parametro de entrada que representa las distancias entre digitos
                      acumuladas}
                     VAR
                      distanciaActual: integer;
                      MediaFinal: real;
                     BEGIN
                       mediaFinal:= 0;
                       REPEAT
                         esDigito:= false;
                         distanciaActual:= 0;
                         WHILE not eoln AND not esDigito DO
                          begin
                            read (ch);
                            esDigito:= (ch = '0') OR (ch = '1') OR (ch = '2') OR (ch = '3') OR (ch = '4') OR (ch = '5')
                                       OR (ch = '6') OR (ch = '7') OR (ch = '8') OR (ch = '9');
                            distanciaActual:= distanciaActual + 1;
                          end;
                         IF esDigito THEN
                          begin
                            numDistancias:= numDistancias + 1;
                            media:= media + distanciaActual;
                            MediaFinal:= media/numDistancias;
                          end;
                       UNTIL eoln;
                       Writeln;
                       procesaYCalcula:= mediaFinal;
                     END;


                     PROCEDURE escribeMensajes (distanciaMediaFinal: real);
                     {Este  procedimiento escribe por pantalla el resultado
                      y un mensaje de informaci¢n}
                     {distanciaMediaFinal[IN]: parametro de entrada que representa la distancia
                      media entre cada digito de la cadena}
                     BEGIN
                       Writeln ('La distancia media entre digitos es: ', distanciaMediaFinal:7:2);
                       Writeln;
                       Writeln ('Pulse tecla cualquiera para continuar');
                       Writeln;
                     END;

           BEGIN
             ClrScr;
             escribeEInicializa (media, numDistancias, distanciaMediaFinal);
             buscaPrimerDigito (ch, esDigito);
             distanciaMediaFinal:= procesaYCalcula (esDigito, ch, numDistancias, media);
             escribeMensajes (distanciaMediaFinal);
             REPEAT
             UNTIL Keypressed;
           END;


BEGIN
  ClrScr;
  menu (opcion);
  REPEAT
    CASE opcion OF
     1: tratarlinea;
     2: distanciaMedia;
     3: contarElementos;
    end;
    IF opcion <> 4 THEN
        menu (opcion);
  UNTIL opcion = 4;
END.