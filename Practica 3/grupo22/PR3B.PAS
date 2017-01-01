  {$R+}      {$I+}         {$X-}
  {$S+}      {SQ+}

PROGRAM Pr3B;
{Programa que da una serie de opciones, para visualizar saltos del caballo del
 ajedrez, de distintas formas}
USES Crt;
CONST
 N = 8;
 caballo1 = chr (1);
 caballo2 = chr (2);

TYPE
 Tfilas = 1..N;
 TColumnas = 1..N;
 TTablero = ARRAY [Tfilas, TColumnas] OF string [3];

VAR
 Tablero: TTablero;
 opcion: integer;
 numIntentos: integer;


      PROCEDURE menu (var opcion: integer);
      {Este procedimiento muestra una serie de opciones para que el usuario
       elija la que quiera, controlando que el dato introducido por teclado
       sea valido}
      {opcion[OUT]: parametro de salida que va a almacenar la opcion
       introducida, y validada}
      VAR
       opcionUser: string [2];
       {esta variable representa la opcion que mete el usuario, representada
        en una cadena}
       error: integer;
       {esta variable almacenara la posicion del string "opcionUser", en la
        que exista el error; siendo 0 si no existiera dicho error}


                 PROCEDURE Bienvenida;
                 {Este procedimiento explica brevemente el funcionamiento del programa}
                 BEGIN
                   Writeln ('Este programa muestra en pantalla un tablero de ajedrez (8x8),');
                   Writeln ('con un caballo saltando segun la opcion elegida en el menu.');
                   Writeln ('El usuario puede interrumpir la ejecucion del programa, por');
                   Writeln ('voluntad propia pulsando cualquier tecla en el momento que crea');
                   Writeln ('oportuno, exceptuando el menu, en el que se deber  elegir "Salir".');
                   Writeln;
                 END;


      BEGIN
        REPEAT
          Clrscr;
          Writeln;
          Bienvenida;
          Writeln ('Por favor, elija una de las siguientes modalidades.');
          Writeln;
          Writeln ('1.- Saltar por el tablero con sucesivos movimientos,');
          Writeln ('    hasta que no se pueda mover mas.');
          Writeln ('2.- Saltos aleatorios.');
          Writeln ('3.- Competicion de dos caballos.');
          Writeln ('4.- Salir.');
          Readln (opcionUser);
          Val (opcionUser, opcion, error);
        UNTIL (error = 0) AND (opcion >= 1) AND (opcion <= 4)
      END;


      PROCEDURE MensajeFinal;
      {Este procedimiento muestra un breve mensaje final al usuario}
      BEGIN
        Writeln;
        Writeln;
        Writeln ('Pulse tecla cualquier para finalizar');
      END;


      PROCEDURE mostrarTiempo (horas, minutos, segundos: integer);
      {Este procedimiento muestra el contador del tiempo en pantalla}
      {horas[IN]: parametro de entrada que almacena las horas}
      {minutos[IN]: parametro de entrada que almacena los minutos}
      {segundos[IN]: parametro de entrada que almacena los segundos}
      BEGIN
        gotoXY (27, 3);
        IF (segundos >= 0) AND (segundos <= 9) AND (minutos <= 9) AND (minutos >= 0) THEN
          write ('0',horas, ':','0',minutos, ':', '0',segundos)
        ELSE
          IF (minutos >= 0) AND (minutos <= 9) AND (segundos >= 10) THEN
            write ('0',horas, ':', '0', minutos, ':', segundos)
          ELSE
            IF (minutos >= 10) AND (segundos <= 9) AND (segundos >= 0) THEN
              write ('0',horas, ':',minutos, ':', '0',segundos)
            ELSE
              write ('0',horas, ':', minutos, ':', segundos)
      END;


      PROCEDURE avanzarTiempo (var minutos, segundos: integer);
      {Este procedimiento se emplea para avanzar el "reloj" del programa}
      {minutos[OUT]: parametro de salida que almacena los minutos totales
       transcurridos}
      {segundos[OUT]: parametro de salida que almacena los segundos
       transcurridos (al llegar a 59 vuelve a cero)}
      BEGIN
        IF (segundos <= 58) THEN
          segundos:= segundos+1
        ELSE
          begin
            segundos:= 0;
            minutos:= minutos +1;
          end;
      END;


      PROCEDURE Inicializa (var Tablero: TTablero; var horas, minutos, segundos, numIntentos: integer);
      {Este procedimiento inicializa el tablero, poniendo un blanco en todas
       las casillas, salvo en la de coordenadas (1,1), que pone un caracter especial}
      {Tablero[OUT]: parametro de salida que va a almacenar el tablero ya
       inicializado}
      {horas[OUT]: parametro de salida que representa las horas}
      {minutos[OUT]: parametro de salida que representa los minutos}
      {segundos[OUT]: parametro de salida que representa los segundos}
      {numIntentos[OUT]: parametro de salida que reresenta el n£mero de
       intentos de salto que realiza el caballo}
      VAR
       F: Tfilas;
       C: TColumnas;
      BEGIN
        FOR f:= 1 TO N DO
          FOR c:= 1 TO N DO
            tablero [f,c]:= ' ';
        Tablero [1,1]:= caballo1;
        horas:= 0;
        minutos:= 0;
        segundos:= 0;
        numIntentos:= 0;
      END;


      PROCEDURE MuestraTablero (Tablero: TTablero);
      {Este procedimiento mostrara el tablero, de manera "pr ctica" en forma
       de cuadricula, por pantalla}
      {Tablero[IN]: parametro de entrada que representa el tablero que se
       desea escribir}
      VAR
       f: Tfilas;
       c: Tcolumnas;
       x: integer;
       y: integer;


           PROCEDURE lineasHorizontales;
           {Este procedimiento dibuja en la pantalla, las lineas
            horizontales del tablero}
           VAR
            f,c,x,y: integer;

           BEGIN
             Y:=5;
             FOR f:= 1 to N+1 DO
             begin
               x:= 24;
               FOR c:= 1 to N*3+1 DO
                 begin
                   gotoXY (x,y);
                   write (Chr(196));
                   x:=x+1;
                 end;
                y:=y+2;
             end;
           END;


           PROCEDURE lineasVerticales;
           {Este procedimiento dibuja las lineas verticales
            del tablero, asi como las intersecciones}
           VAR
            f,c,x,y: integer;


                     PROCEDURE dibujalineas;
                     {Este procedimiento dibuja las lineas verticales}
                     VAR
                      f,c,x,y: integer;
                     BEGIN
                       y:= 24;
                       FOR f:= 1 TO N+1 DO
                         begin
                           x:= 6;
                           FOR c:= 1 TO N DO
                             begin
                               gotoXY (y,x);
                               write (chr(179));
                               x:=x+2;
                             end;
                           y:= y+3;
                         end;
                     END;


                     PROCEDURE DibujaIntersecciones;
                     {Este procedimiento dibuja las intersecciones}
                     VAR
                      f,c,x,y: integer;
                     BEGIN
                       y:= 24;
                       FOR f:= 1 TO N+1 DO
                         begin
                           x:= 5;
                           FOR c:= 1 TO N+1 DO
                             begin
                               gotoXY (y,x);
                               write (chr(197));
                               x:=x+2;
                             end;
                           y:= y+3;
                         end;
                     END;


           BEGIN
             DibujaLineas;
             DibujaIntersecciones;
           END;


      BEGIN
        Y:=6;
        lineasHorizontales;
        lineasVerticales;
        FOR f:= 1 TO N DO
          begin
            X:=25;
            FOR c:= 1 TO N DO
              begin
                gotoXY (x,y);
                write (tablero [f, c]);
                X:= X+3;
              end;
            Y:= Y+2;
          end;
        Delay (250);
      END;


      FUNCTION casillaDestinoValida (numMovimiento: integer; fila: TFilas; columna: TColumnas): boolean;
      {Esta funcion calcula si la casilla a la que se va a mover el caballo es valida, es decir, si se
       encuentra dentro de los limites del tablero}
      {numMovimiento[IN]: parametro de entrada que representa el numero de movimiento que se realiza}
      {fila[IN]: parametro de entrada que representa la fila en la que se encuentra el caballo en este
       momento}
      {columna[IN]: parametro de entrada que representa la columna en la que se encuentra el caballo
       en este momento}
      VAR
       Valida: boolean;
      BEGIN
        CASE numMovimiento OF
          1: Valida:= (fila+1 <= N) AND (fila+1 >= 1) AND
                                    (columna+2 <= N) AND (columna+2 >= 1);
          2: Valida:= (fila+2 <= N) AND (fila+2 >= 1) AND
                                    (columna+1 <= N) AND (columna+1 >= 1);
          3: Valida:= (columna-1 <= N) AND (columna-1 >= 1) AND
                                    (fila+2 <= N) AND (fila+2 >= 1);
          4: Valida:= (columna-2 <= N) AND (columna-2 >= 1) AND
                                    (fila+1 <= N) AND (fila+1 >= 1);
          5: Valida:= (fila-1 <= N) AND (fila-1 >= 1) AND
                                    (columna-2 <= N) AND (columna-2 >= 1);
          6: Valida:= (fila-2 <= N) AND (fila-2 >= 1) AND
                                    (columna-1 <= N) AND (columna-1 >= 1);
          7: Valida:= (fila-2 <= N) AND (fila-2 >= 1) AND
                                    (columna+1 <= N) AND (columna+1 >= 1);
          8: Valida:= (fila-1 <= N) AND (fila-1 >= 1) AND
                                    (columna+2 <= N) AND (columna+2 >= 1);
        end;
        casillaDestinoValida:= Valida;
      END;


      FUNCTION casillaDestinoVacia (Tablero: TTablero; numMovimiento: integer; fila: TFilas; columna: TColumnas): boolean;
      {Esta funci¢n calcula si la casilla a la que se mover  el caballo esta vacia o no}
      {Tablero[IN]: parametro de entrada que representa la situacion actual del tablero}
      {numMovimiento[IN]: parametro de entrada que representa el movimiento que se pretende realizar}
      {fila[IN]: parametro de entrada que representa la fila en la que se encuentra en este momento el caballo}
      {columna[IN]: parametro de entrada que representa la columna en la que se encuentra el caballo en este momento}
      VAR
       Vacia: boolean;
      BEGIN
        CASE numMovimiento OF
          1: Vacia:= (Tablero [fila+1, columna+2] = ' ');
          2: Vacia:= (Tablero [fila+2, columna+1] = ' ');
          3: Vacia:= (Tablero [fila+2, columna-1] = ' ');
          4: Vacia:= (Tablero [fila+1, columna-2] = ' ');
          5: Vacia:= (Tablero [fila-1, columna-2] = ' ');
          6: Vacia:= (Tablero [fila-2, columna-1] = ' ');
          7: Vacia:= (Tablero [fila-2, columna+1] = ' ');
          8: Vacia:= (Tablero [fila-1, columna+2] = ' ');
        end;
        casillaDestinoVacia:= Vacia;
      END;


      PROCEDURE eligeMovimiento (caballo: char; numMovimiento: integer; var numeroDeSalto: integer; var fila: Tfilas;
                                 var columna: Tcolumnas; var Tablero:TTablero; var numIntentos: integer);
      {Este procedimiento contabiliza los intentos de salto del caballo, y realiza los mismos}
      {caballo[IN]: parametro de entrada que representa el caballo con el que se van a realizar los saltos}
      {numMovimiento[IN]: parametro de entrada que indica el numero de movimiento que hay que realizar}
      {numeroDeSalto[OUT]: parametro de salida que devolvera el numero de salto que se ha hecho}
      {fila[IN-OUT]: parametro de entrada/salida que guarda la fila en la que estamos}
      {columna[IN-OUT]: parametro de entrada/salida que guarda la columna en la que estamos}
      {Tablero[OUT]: parametro de salida que devuelve el estado del tablero, despues de las modificaciones
       que se hayan realizado}
      {numIntentos[OUT]: parametro de salida que devuelve el numero de intentos que realiza el caballo al
       realizar el salto}


        PROCEDURE saltar (caballo: char; numMovimiento: integer; var fila: TFilas; var columna: TColumnas;
                          var numeroDeSalto: integer; var tablero: TTablero);
        {Este procedimiento realiza el salto propiamente dicho "moviendo" el caballo por el tablero}
        {caballo[IN]: parametro de entrada que representa el caballo con el que se van a realizar los saltos}
        {numMovimiento[IN]: parametro de entrada que indica el numero de movimiento que hay que realizar}
        {fila[IN-OUT]: parametro de entrada/salida que guarda la fila en la que estamos}
        {columna[IN-OUT]: parametro de entrada/salida que guarda la columna en la que estamos}
        {numeroDeSalto[OUT]: parametro de salida que devolvera el numero de salto que se ha hecho}
        {Tablero[OUT]: parametro de salida que devuelve el estado del tablero, despues de las modificaciones
         que se hayan realizado}
        VAR
         numSalto: string [2];
         {Esta variable contendra el numero de salto, pero en formato cadena, despues de haberlo convertido
          desde "numeroDeSalto".}


           PROCEDURE nuevaCasilla (numMovimiento: integer; var fila: TFilas; var columna: TColumnas);
           {Este procedimiento calcula la casilla de destino del tablero, segun el movimiento que
            se haga}
           {numMovimiento[IN]: parametro de entrada que representa el numero de movimiento que se
            va a realizar}
           {fila[IN-OUT]: parametro de entrada/salida, que se actualiza segun la casilla a la que
            nos movamos}
           {columna[IN-OUT]: parametro de entrada/salida, que se actualiza segun la casilla a la que
            nos movamos}
           BEGIN
             CASE numMovimiento OF
               1: begin
                    fila:= fila+1;
                    columna:= columna+2;
                  end;
               2: begin
                    fila:= fila+2;
                    columna:= columna+1;
                  end;
               3: begin
                    columna:= columna-1;
                    fila:= fila+2;
                  end;
               4: begin
                    columna:= columna-2;
                    fila:= fila+1;
                  end;
               5: begin
                    fila:= fila-1;
                    columna:= columna-2;
                  end;
               6: begin
                    fila:= fila-2;
                    columna:= columna-1;
                  end;
               7: begin
                    fila:= fila-2;
                    columna:= columna+1;
                  end;
               8: begin
                    fila:= fila-1;
                    columna:= columna+2;
                  end;
             end;
           END;


        BEGIN
          IF casillaDestinoValida (numMovimiento, fila, columna) AND
             casillaDestinoVacia (Tablero, numMovimiento, fila, columna) THEN
            begin
              str (numeroDeSalto, numSalto);
              Tablero [fila,columna]:= numSalto;
              nuevaCasilla (numMovimiento, fila, columna);
              Tablero [fila, columna]:= caballo;
              numeroDeSalto:= numeroDeSalto + 1;
            end;
        END;


      BEGIN
        IF caballo = caballo1 THEN
          numIntentos:= numIntentos + 1;
        saltar (caballo, numMovimiento, fila, columna, numeroDeSalto, Tablero);
      END;


      FUNCTION PosibilidadDeSalto (fila:Tfilas; columna: Tcolumnas; Tablero: TTablero): boolean;
      {Esta funcion evalua si es posible realizar un salto con el caballo, segun el movimiento
       que se pretenda hacer}
      {fila[IN]: parametro de entrada que contiene la fila en la que estamos}
      {columna[IN]: parametro de entrada que contiene la columna en la que estamos}
      {Tablero[IN]: parametro de entrada que contiene la situacion actual del tablero}
      VAR
       movimientos1_2: boolean;
       movimientos3_4: boolean;
       movimientos5_6: boolean;
       movimientos7_8: boolean;


      BEGIN
        movimientos1_2:= (casilladestinoValida (1, fila, columna) AND casillaDestinoVacia (Tablero, 1, fila, columna)) OR
                         (casilladestinoValida (2, fila, columna) AND casillaDestinoVacia (Tablero, 2, fila, columna));
        movimientos3_4:= (casilladestinoValida (3, fila, columna) AND casillaDestinoVacia (Tablero, 3, fila, columna)) OR
                         (casilladestinoValida (4, fila, columna) AND casillaDestinoVacia (Tablero, 4, fila, columna));
        movimientos5_6:= (casilladestinoValida (5, fila, columna) AND casillaDestinoVacia (Tablero, 5, fila, columna)) OR
                         (casilladestinoValida (6, fila, columna) AND casillaDestinoVacia (Tablero, 6, fila, columna));
        movimientos7_8:= (casilladestinoValida (7, fila, columna) AND casillaDestinoVacia (Tablero, 7, fila, columna)) OR
                         (casilladestinoValida (8, fila, columna) AND casillaDestinoVacia (Tablero, 8, fila, columna));
        PosibilidadDeSalto:= movimientos1_2 OR movimientos3_4 OR movimientos5_6 OR movimientos7_8;
      END;


      PROCEDURE modo1 (tablero:TTablero; numIntentos: integer);
      {Este procedimiento realiza las tareas necesarias, para llevar a cabo
       la modalidad 1 del enunciado}
      {tablero[IN]: parametro de entrada que representa el tablero de ajedrez}
      {numIntentos[IN]: parametro de entrada que representa el numero de intentos
       que hace el caballo antes de saltar}
      VAR
       horas, minutos, segundos: integer;

                     PROCEDURE Movimientos (var Tablero: TTablero; horas, minutos, segundos, numIntentos: integer);
                     {Este procedimiento realiza sucesivos movimientos del caballo,
                      siguiendo un orden y comprobando que se pueda realizar el salto
                      correspondiente}
                     {Tablero[IN-OUT]: parametro de entrada/salida que representa el
                      tablero en el que realizamos los movimientos}
                     {horas[IN]: parametro de entrada que representa las horas}
                     {minutos[IN]: parametro de entrada que representa los minutos}
                     {segundos[IN]: parametro de entrada que representa los segundos}
                     {numIntentos[IN]: parametro de entrada que representa el numero de
                      intentos de salto que realiza el caballo al moverse}
                     VAR
                      fila: Tfilas;
                      columna: TColumnas;
                      numMovimiento: integer;
                      numeroDeSalto: integer;
                      saltoPosible: boolean;


                            FUNCTION compruebaSalto (numMovimiento: integer; fila: TFilas;
                                                     columna: TColumnas; Tablero: TTablero): boolean;
                            {Esta funcion comprueba si se puede realizar un movimiento en concreto}
                            {numMovimiento[IN]: parametro de entrada que representa el numero de movimiento que se
                             quiere comprobar}
                            {fila[IN]: parametro de entrada que representa la fila en la que se encuentra el caballo
                             en este momento}
                            {columna[IN]: parametro de entrada que representa la columna en la que se encuentra el
                             caballo, actualmente}
                            {Tablero[IN]: parametro de entrada que representa la situacion actual del tablero}
                            BEGIN
                              CASE numMovimiento OF
                                1: compruebaSalto:= casilladestinoValida (1, fila, columna) AND
                                                    casillaDestinoVacia (Tablero, 1, fila, columna);
                                2: compruebaSalto:= casilladestinoValida (2, fila, columna) AND
                                                    casillaDestinoVacia (Tablero, 2, fila, columna);
                                3: compruebaSalto:= casilladestinoValida (3, fila, columna) AND
                                                    casillaDestinoVacia (Tablero, 3, fila, columna);
                                4: compruebaSalto:= casilladestinoValida (4, fila, columna) AND
                                                    casillaDestinoVacia (Tablero, 4, fila, columna);
                                5: compruebaSalto:= casilladestinoValida (5, fila, columna) AND
                                                    casillaDestinoVacia (Tablero, 5, fila, columna);
                                6: compruebaSalto:= casilladestinoValida (6, fila, columna) AND
                                                    casillaDestinoVacia (Tablero, 6, fila, columna);
                                7: compruebaSalto:= casilladestinoValida (7, fila, columna) AND
                                                    casillaDestinoVacia (Tablero, 7, fila, columna);
                                8: compruebaSalto:= casilladestinoValida (8, fila, columna) AND
                                                    casillaDestinoVacia (Tablero, 8, fila, columna);
                              end;
                            END;


                     BEGIN
                       fila:= 1;
                       columna:= 1;
                       numeroDeSalto:= 0;
                       REPEAT
                         numMovimiento:=1;
                         REPEAT
                           saltoPosible:= compruebaSalto (numMovimiento, fila, columna, Tablero);
                           numMovimiento:= numMovimiento+1;
                         UNTIL saltoPosible OR (numMovimiento = 9);
                         IF saltoPosible THEN
                           begin
                             numMovimiento:= numMovimiento-1;
                             eligeMovimiento (caballo1, numMovimiento, numeroDeSalto, fila, columna, Tablero, numIntentos);
                             IF (numIntentos mod 4) = 0 THEN
                               avanzarTiempo (minutos, segundos);
                             mostrarTiempo (horas, minutos, segundos);
                             muestraTablero (Tablero);
                           end;
                       UNTIL not PosibilidadDeSalto (fila, columna, Tablero) OR Keypressed;
                     END;


      BEGIN
        ClrScr;
        Inicializa (Tablero, horas, minutos, segundos, numIntentos);
        mostrarTiempo (horas, minutos, segundos);
        MuestraTablero (Tablero);
        Movimientos (Tablero, horas, minutos, segundos, numIntentos);
        MensajeFinal;
        REPEAT
        UNTIL Keypressed;
      END;


      PROCEDURE modo2 (Tablero:TTablero; numIntentos: integer);
      {Este procedimiento efectuara las operaciones necesarias para
       llevar a cabo los objetivos de la segunda modalidad del enunciado}
      {tablero[IN]: parametro de entrada que representa el tablero de ajedrez}
      {numIntentos[IN]: parametro de entrada que representa el numero de intentos
       que hace el caballo antes de saltar}
      VAR
       horas, minutos, segundos: integer;


                     PROCEDURE MovAleatorio (var Tablero: Ttablero; horas, minutos, segundos, numIntentos: integer);
                     {Este procedimiento genera el movimiento aleatorio
                      de un caballo por el tablero}
                     {horas[IN]: parametro de entrada que representa las horas}
                     {minutos[IN]: parametro de entrada que representa los minutos}
                     {segundos[IN]: parametro de entrada que representa los segundos}
                     {numIntentos[IN]: parametro de entrada que representa el numero de
                      intentos de salto que realiza el caballo al moverse}
                     VAR
                      fila: Tfilas;
                      columna: Tcolumnas;
                      numMovimiento: integer;
                      numeroDeSalto: integer;
                     BEGIN
                       ClrScr;
                       fila:=1;
                       columna:=1;
                       numeroDeSalto:= 0;
                       REPEAT
                         numMovimiento:= Random (8) + 1 ;
                         eligeMovimiento (caballo1, numMovimiento, numeroDeSalto, fila, columna, Tablero, numIntentos);
                         IF (numIntentos mod 4) = 0 THEN
                               avanzarTiempo (minutos, segundos);
                         mostrarTiempo (horas, minutos, segundos);
                         muestraTablero (Tablero);
                       UNTIL not PosibilidadDeSalto (fila, columna, Tablero) OR Keypressed;
                     END;


      BEGIN
        ClrScr;
        Inicializa (Tablero, horas, minutos, segundos, numIntentos);
        mostrarTiempo (horas, minutos, segundos);
        MuestraTablero (Tablero);
        MovAleatorio (Tablero, horas, minutos, segundos, numIntentos);
        MensajeFinal;
        REPEAT
        UNTIL Keypressed;

      END;


      PROCEDURE modo3 (Tablero: TTablero; numIntentos: integer);
      {Este procedimiento efectuara las operaciones necesarias para
       conseguir los objetivos que se proponen como tercera modalidad
       en el enunciado}
      {tablero[IN]: parametro de entrada que representa el tablero de ajedrez}
      {numIntentos[IN]: parametro de entrada que representa el numero de intentos
       que hace el caballo antes de saltar}
      VAR
       horas, minutos, segundos: integer;


                     PROCEDURE DosCaballos (var Tablero: TTablero; horas, minutos, segundos, numIntentos: integer);
                     {Este procedimiento realiza los movimientos aleatorios
                      de dos caballos, representados por los dos primeros caracteres de
                      la tabla ASCII extendida; y muestra por pantalla el numero de saltos
                      que da cada uno y segun estos saltos muestra en un mensaje cual es el ganador}
                     {horas[IN]: parametro de entrada que representa las horas}
                     {minutos[IN]: parametro de entrada que representa los minutos}
                     {segundos[IN]: parametro de entrada que representa los segundos}
                     {numIntentos[IN]: parametro de entrada que representa el numero de
                      intentos de salto que realiza el caballo al moverse}
                     VAR
                      fila1, fila2: Tfilas;
                      columna1, columna2: Tcolumnas;
                      numMovimiento: integer;
                      numeroDeSalto1, numeroDeSalto2: integer;

                     BEGIN
                       ClrScr;
                       fila1:=1;
                       columna1:=1;
                       fila2:= N;
                       columna2:= N;
                       numeroDeSalto1:= 0;
                       numeroDeSalto2:= 0;
                       REPEAT
                         numMovimiento:= Random (8) + 1;
                         eligeMovimiento (caballo2, numMovimiento, numeroDeSalto2, fila2, columna2, Tablero, numIntentos);
                         numMovimiento:= Random (8) + 1;
                         eligeMovimiento (caballo1, numMovimiento, numeroDeSalto1, fila1, columna1, Tablero, numIntentos);
                         IF (numIntentos mod 4) = 0 THEN
                           avanzarTiempo (minutos, segundos);
                         mostrarTiempo (horas, minutos, segundos);
                         muestraTablero (Tablero);
                       UNTIL (not PosibilidadDeSalto (fila1, columna1, Tablero)) AND
                             (not PosibilidadDeSalto (fila2, columna2, Tablero)) OR Keypressed;
                       Writeln;
                       Writeln;
                       Writeln;
                       Writeln ('El numero de Saltos que da ', caballo1, ' es: ', numeroDeSalto1);
                       Writeln;
                       Writeln ('El numero de Saltos que da ', caballo2, ' es: ', numeroDeSalto2);
                       Writeln;
                       IF numeroDeSalto1 > numeroDeSalto2 THEN
                         Writeln ('El caballo ganador es: ', caballo1)
                       ELSE
                         IF numeroDeSalto1 < numeroDeSalto2 THEN
                           Writeln ('El caballo ganador es: ', caballo2)
                         ELSE
                           Writeln (' Hay empate');
                       Writeln;
                     END;


      BEGIN
        ClrScr;
        Inicializa (Tablero, horas, minutos, segundos, numIntentos);
        Tablero [N,N]:= caballo2;
        mostrarTiempo (horas, minutos, segundos);
        MuestraTablero (Tablero);
        DosCaballos (Tablero, horas, minutos, segundos, numIntentos);
        MensajeFinal;
        REPEAT
        UNTIL Keypressed;
      END;



BEGIN
  ClrScr;
  randomize;
  menu (opcion);
  REPEAT
    IF opcion <> 4 THEN
      begin
        CASE opcion OF
          1: Modo1 (Tablero, numIntentos);
          2: Modo2 (Tablero, numIntentos);
          3: Modo3 (Tablero, numIntentos);
        end;
        ClrScr;
        menu (opcion);
      end;
  UNTIL opcion = 4;
END.