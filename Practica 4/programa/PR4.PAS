   {$X-}  {$Q+}
   {$R+}  {$S+}

PROGRAM Pr4;
{Este programa servir  para traducir programas en lenguaje m quina. Adem s, se podran realizar
 diversas funciones, con memoria, con el propio programa, y con la pantalla, segun las indicaciones
 del menu, que se muestra al principio}
USES crt;
CONST
 NUM_FILAS = 15;
 NUM_COLUMNAS = 25;
 MAX_POSICIONES = 35;
 MAX_INSTRUCCIONES = 100;

TYPE
 TFilas = 1..NUM_FILAS;
 TColumnas = 1..NUM_COLUMNAS;
 TPantalla = ARRAY [TFilas, TColumnas] OF char;
 TIndice = 1..MAX_POSICIONES;
 TTamanio = 0..MAX_POSICIONES;
 TPosiciones = RECORD
                 posicion: integer;
                 valor: integer;
               end;
 TLista = ARRAY [TIndice] OF TPosiciones;
 TMemoria = RECORD
              lista: TLista;
              tamanio: TTamanio;
            end;
 TTipo = (sum, sub, store, R_copy, jumpz, jumpp, R_read, R_write);
 TInstrucciones = RECORD
                    tipo: TTipo;
                    OP1: Integer;
                    OP2: Integer;
                  end;
 TNumInstrucciones = 1..MAX_INSTRUCCIONES;
 TLongitud = 0..MAX_INSTRUCCIONES;
 TListaInstrucciones = ARRAY [TNumInstrucciones] OF TInstrucciones;
 TPrograma = RECORD
               Instrucciones: TListaInstrucciones;
               longitud: TLongitud;
             end;


VAR
 memoria: TMemoria;
 errorMemoria, errorPrograma: boolean;
 opcion: integer;
 pantalla: TPantalla;
 programa: TPrograma;


      PROCEDURE menu (var opcion: integer);
      {Este procedimiento muestra un men£ en pantalla,
       y almacena la opcion que introduce el usuario}
      {opcion[OUT]: Parametro de salida que almacenara, la opcion
       del menu correspondiente}
      VAR
       opcionUser: string [40];
       error: integer;
      BEGIN
        REPEAT
          Writeln;
          Writeln ('Por favor, elija una de las opciones que se muestran a continuacion.');
          Writeln;
          Writeln ('1.- Cargar Programa.');
          Writeln ('2.- Ejecutar Programa.');
          Writeln ('3.- Cargar Memoria.');
          Writeln ('4.- Guardar Memoria.');
          Writeln ('5.- Guardar Pantalla Virtual.');
          Writeln ('6.- Salir de la Aplicacion');
          Writeln;
          Readln (opcionUser);
          Val (opcionUser, opcion, error);
        UNTIL (opcion >= 1) AND (opcion <= 6) AND (error = 0);
      END;


      PROCEDURE InicializarPantalla (var pantalla: TPantalla);
      {Este procedimiento sirve para inicializar la pantalla}
      {pantalla[OUT]: parametro de salida que representa el estado de la pantalla}
      VAR
       N: TFilas;
       M: TColumnas;
      BEGIN
        FOR N:=1 TO NUM_FILAS DO
          FOR M:=1 TO NUM_COLUMNAS DO
            pantalla [N,M]:= ' ';
      END;


      PROCEDURE InicializarMemoria (var memoria: TMemoria);
      {Este procedimiento sirve para inicializar la memoria}
      {memoria[OUT]: parametro de salida que representa el estado de la memoria
       que hemos creado}
      BEGIN
        memoria.tamanio:= 0;
      END;


      PROCEDURE InicializarPrograma (var programa: TPrograma);
      {Este procedimiento sirve para inicializar el programa}
      {programa[OUT]: parametro de salida que representa el programa que tenemos}
      BEGIN
        programa.longitud:= 0;
      END;


      PROCEDURE InicializarErrores (var errorPrograma, errorMemoria: boolean);
      {Este procedimiento sirve para inicializar las variables que representan
       si hay errores o no al cargar el programa o la memoria}
      {errorPrograma[OUT]: parametro de salida que representa si hay algun error
       o no al cargar el programa}
      {errorMemoria[OUT]: parametro de salida que representa si hay algun error
       o no al cargar la memoria}
      BEGIN
        errorPrograma:= FALSE;
        errorMemoria:= FALSE;
      END;


      PROCEDURE pedirNombre (var nombre: string);
      {Este procedimiento sirve para pedirle al usuario un nombre de archivo}
      {nombre[OUT]: parametro de salida que almacenara el nombre introducido por el usuario}
      BEGIN
        ClrScr;
        writeln ('Por favor introduzca el nombre del fichero con el que desea actuar');
        Readln (nombre);
        ClrScr;
      END;


      PROCEDURE MensajeNoExiste;
      {Este procedimiento muestra en pantalla un mensaje}
      BEGIN
        writeln;
        writeln ('EL FICHERO INTRODUCIDO NO EXISTE');
        writeln;
      END;


      PROCEDURE MensajeExito;
      {Este procedimiento muestra un mensaje por pantalla}
      BEGIN
        Writeln;
        Writeln ('OPERACION REALIZADA CON EXITO');
        Writeln;
        Writeln;
      END;


      PROCEDURE MensajeNoCarga;
      {Este Procedimiento muestra un mensaje por pantalla}
      BEGIN
        Writeln;
        Writeln ('ERROR DE CARGA DE FICHERO. COMPRUEBE EL FICHERO Y VUELVA A INTENTARLO');
        Writeln;
        Writeln;
      END;


      PROCEDURE MensajeGuardaMal;
      {Este procedimiento muestra un mensaje por pantalla}
      BEGIN
        ClrScr;
        Writeln;
        Writeln ('INFORMACION NO GUARDADA. ESTADO DE LOS DATOS NO CORRECTOS');
        Writeln;
        Writeln;
      END;


      PROCEDURE MensajeNoEjecuta;
      {Este procedimiento muestra un mensaje por pantalla}
      BEGIN
        ClrScr;
        writeln;
        writeln;
        writeln ('NO SE PUDO EJECUTAR EL PROGRAMA. ESTADO DE LA MEMORIA O PROGRAMA INCORRECTOS.');
        writeln;
        writeln;
      END;


      PROCEDURE buscarPosicion (memoria: TMemoria; op: integer; var indice: TIndice; var encontrado: boolean);
      {Este procedimiento busca una posicion de memoria en la memoria antes de estar ordenada}
      {memoria[IN]: parametro de entrada que representa el estado de la memoria}
      {op[IN]: parametro de entrada que representa la posicion de memoria, que queremos buscar}
      {indice[OUT]: parametro de salida que representa el indice del array en el que se encuentra la posicion que buscamos}
      {encontrado[OUT]: parametro de salida que representa si se encuentra o no la posicion en cuestion}
      VAR
       I: integer;
      BEGIN
        I:= 1;
        encontrado:= FALSE;
        WHILE (not encontrado) AND (I <= memoria.tamanio) DO
          IF memoria.lista[I].posicion = op THEN
            encontrado:= TRUE
          ELSE
            I:= I+1;
        IF encontrado THEN
          indice:= I;
      END;


      PROCEDURE buscarPosicionOrd (memoria: TMemoria; op:integer; var indice:TIndice; var encontrado: boolean);
      {Este procedimiento busca una posicion de memoria en la memoria antes de estar ordenada}
      {memoria[IN]: parametro de entrada que representa el estado de la memoria}
      {op[IN]: parametro de entrada que representa la posicion de memoria, que queremos buscar}
      {indice[OUT]: parametro de salida que representa el indice del array en el que se encuentra la posicion que buscamos}
      {encontrado[OUT]: parametro de salida que representa si se encuentra o no la posicion en cuestion}
      VAR
       primero, ultimo, medio: integer;
      BEGIN
        encontrado:= FALSE;
        ultimo:= memoria.tamanio;
        primero:= 1;
        WHILE not encontrado AND (primero <= ultimo) DO
          begin
            medio:= (primero+ultimo) div 2;
            IF memoria.lista[medio].posicion = op THEN
              encontrado:= TRUE
            ELSE
              IF memoria.lista[medio].posicion < op THEN
                primero:= medio+1
              ELSE
                ultimo:= medio-1;
          end;
        IF encontrado THEN
          indice:= medio;
      END;


      PROCEDURE cargarMemoria (var memoria: TMemoria; var errorMemoria: boolean);
      {Este procedimiento sirve para cargar la memoria, desde un archivo a nuestra estructura de datos
       que representa la memoria}
      {memoria[OUT]: parametro de salida que representa el estado de la memoria}
      {errorMemoria[OUT]: parametro de salida que representa si hay o no un error en la memoria}
      VAR
       F: text;
       nombre: string;
       linea: string [40];
       I: TIndice;
       posicion, valor: integer;
       fallo: boolean;


            PROCEDURE obtenerValores (linea: string; var posicion, valor: integer; var fallo: boolean);
            {Este procedimiento sirve para trocear la linea leida del fichero en el que se almacena el
             contenido de la memoria, y obtener los distintos valores de las posiciones y sus respectivos
             valores}
            {linea[IN]: parametro de entrada que representa la linea leida en el fichero}
            {posicion[OUT]: parametro de salida que representa la posicion de memoria que corresponda}
            {valor[OUT]: parametro de salida que representa el valor dentro de una posicion de memoria}
            {fallo[OUT]: parametro de salida que representa si hay o no, un fallo al obtener los valores
             del fichero}
            VAR
             posic: integer;
             posit, value: string [15];
             error1, error2: integer;
            BEGIN
              posic:= pos (':', linea);
              posit:= copy (linea, 1, posic-1);
              value:= copy (linea, posic+1, (length (linea)) - posic);
              Val (posit, posicion, error1);
              Val (value, valor, error2);
              fallo:= (error1 <> 0) OR (error2 <> 0) OR (posicion < 0);
            END;


            PROCEDURE escribirMemoria (var memoria: TMemoria; posicion, valor: integer; var I:TIndice);
            {Este procedimiento sirve para escribir en memoria, ya sea una posicion y su valor,
             o solo el valor a una posicion ya existente}
            {memoria[OUT]: parametro de salida que representa el estado de la memoria}
            {posicion[IN]: parametro de entrada que representa la posicion de memoria que corresponda}
            {valor[IN]: parametro de entrada que representa el valor dentro de una posicion de memoria}
            {indice[OUT]: parametro de salida que representa el indice del array en el que se encuentra
             la posicion que buscamos}
            VAR
             indice: TIndice;
             encontrado: boolean;
            BEGIN
              indice:= 1;
              buscarPosicion (memoria, posicion, indice, encontrado);
              IF encontrado THEN
                memoria.lista[indice].valor:= valor
              ELSE
                begin
                  memoria.lista[I].posicion:= posicion;
                  memoria.lista[I].valor:= valor;
                  memoria.tamanio:= memoria.tamanio+1;
                  I:= I+1;
                end;
            END;


            PROCEDURE ordenarMemoria (var memoria: TMemoria);
            {Este procedimiento sirve para ordenar la memoria, segun
             sus posiciones, y de menor a mayor}
            {memoria[OUT]: parametro de salida que representa el estado de la memoria}
            VAR
             tmp: TPosiciones;
             I,J: TIndice;
            BEGIN
              FOR I:= 1 TO memoria.tamanio-1 DO
                FOR J:= memoria.tamanio DOWNTO I+1 DO
                  IF memoria.lista[J].posicion < memoria.lista[J-1].posicion THEN
                    begin
                      tmp:= memoria.lista[J];
                      memoria.lista[J]:= memoria.lista[J-1];
                      memoria.lista[J-1]:= tmp;
                    end;
            END;


      BEGIN
        pedirNombre (nombre);
        assign (F,nombre);
        {$I-}
        reset (F);
        {$I+}
        I:= 1;
        fallo:= FALSE;
        memoria.tamanio:= 0;
        IF ioResult <> 0 THEN
          begin
            errorMemoria:= TRUE;
            mensajeNoExiste;
          end
        ELSE
          begin
            WHILE (memoria.tamanio < MAX_POSICIONES) AND (not eof(F)) AND not errorMemoria DO
              begin
                readln (F, linea);
                obtenerValores (linea, posicion, valor, fallo);
                IF not fallo THEN
                  escribirMemoria (memoria, posicion, valor, I)
                ELSE
                  errorMemoria:= TRUE;
              end;
            close (F);
            ordenarMemoria (memoria);
            IF not errorMemoria THEN
              begin
                ClrScr;
                MensajeExito;
              end;
          end;
      END;


      PROCEDURE guardarMemoria (memoria: TMemoria);
      {Este procedimiento sirve para guardar la memoria desde la estructura de datos
       que hemos creado para representarla, a un fichero}
      {memoria[IN]: parametro de entrada que representa el estado de la memoria}
      VAR
       F: text;
       nombre: string;
       I: TIndice;
      BEGIN
        pedirNombre (nombre);
        assign (F, nombre);
        rewrite (F);
        FOR I:= 1 TO memoria.tamanio DO
          begin
            write (F, memoria.lista[I].posicion);
            write (F, ':');
            writeln (F, memoria.lista[I].valor);
          end;
        close (F);
      END;


      PROCEDURE GuardarPantalla (pantalla: TPantalla);
      {Este procedimiento sirve para guardar el estado de la pantalla, desde la estructura
       de datos que hemos utilizado para representarla, a un fichero}
      {pantalla[IN]: parametro de entrada que representa el estado de la pantalla}
      VAR
       F:Text;
       nombre: string;
       N: TFilas;
       M: TColumnas;
      BEGIN
        pedirNombre (nombre);
        assign (F, Nombre);
        rewrite (F);
        FOR N:=1 TO NUM_FILAS DO
          FOR M:=1 TO NUM_COLUMNAS DO
            IF M = NUM_COLUMNAS THEN
              Writeln (F, pantalla [N,M])
            ELSE
              Write (F, pantalla [N,M]);
        close (F);
      END;


      PROCEDURE CargarPrograma (var programa: TPrograma; var errorPrograma: boolean);
      {Este procedimiento sirve para cargar desde un archivo, un cierto programa,
       para almacenarlo en la estructura de datos que hemos creado para representar
       el programa}
      {programa[OUT]: parametro de salida que representa el programa que queremos ejecutar}
      {error[OUT]: parametro de salida que representa si se comete algun error o no, al
       llevar a cabo el proceso}
      VAR
       nombre: string;
       F: text;
       linea: string [40];
       tipo_Ins: TTipo;
       op1, op2: integer;
       fallo: boolean;

            PROCEDURE obtenerInstruccion (linea: string; var tipo_Ins: TTipo; var op1, op2: integer; var fallo: boolean);
            {Este procedimiento sirve para trocear la linea que leemos del archivo origen, y tras procesarla, obtener los
             valores correspondientes al tipo de instruccion y los operandos}
            {linea[IN]: parametro de entrada que representa la linea que leemos del fichero}
            {tipo_Ins[OUT]: parametro de salida que representa el tipo de instruccion que estamos leyendo}
            {op1[OUT]: parametro de salida que representa el primer operando de la instruccion}
            {op2[OUT]: parametro de salida que representa el segundo operando de la instruccion}
            {fallo[OUT]: parametro de salida que representa si hay o no, algun error, el realizar el procesamiento}
            VAR
             tipo: string [10];
             error1, error2: integer;
             error3: boolean;
             position1, position2: integer;
             oper1, oper2: string [10];


                  PROCEDURE Interpretar (tipo: string; var tipo_Ins: TTipo; var error3: boolean);
                  {Este Procedimiento sirve para realizar la conversion desde el tipo de instruccion
                   que se lee en el fichero en formato string, a un dato del tipo que hemos creado para
                   representar las diferentes instrucciones}
                  {tipo[IN]: parametro de entrada que representa el tipo de instruccion leido del fichero}
                  {tipo_Ins[OUT]: parametro de salida que representa el tipo de instruccion}
                  {error3[OUT]: parametro de salida que representa si hay o no algun error en el proceso}
                  BEGIN
                    IF (tipo = 'SUM') OR (tipo = 'sum') OR (tipo = 'Sum') THEN
                      tipo_Ins:= SUM
                    ELSE
                      IF (tipo = 'SUB') OR (tipo = 'sub') OR (tipo = 'Sub') THEN
                        tipo_Ins:= SUB
                      ELSE
                        IF (tipo = 'STORE') OR (tipo = 'store') OR (tipo = 'Store') THEN
                          tipo_Ins:= STORE
                        ELSE
                          IF (tipo = 'COPY') OR (tipo = 'copy') OR (tipo = 'Copy') THEN
                            tipo_Ins:= R_COPY
                          ELSE
                            IF (tipo = 'READ') OR (tipo = 'read') OR (tipo = 'Read') THEN
                              tipo_Ins:= R_READ
                            ELSE
                              IF (tipo = 'WRITE') OR (tipo = 'write') OR (tipo = 'Write') THEN
                                tipo_Ins:= R_WRITE
                              ELSE
                                IF (tipo = 'JUMPZ') OR (tipo = 'jumpz') OR (tipo = 'Jumpz') THEN
                                  tipo_Ins:= JUMPZ
                                ELSE
                                  IF (tipo = 'JUMPP') OR (tipo = 'jumpp') OR (tipo = 'Jumpp') THEN
                                    tipo_Ins:= JUMPP
                                  ELSE
                                    error3:= TRUE;
                  END;


            BEGIN
              error3:= FALSE;
              position1:= pos (' ', linea);
              tipo:= copy (linea, 1, position1-1);
              position1:= position1+2;
              position2:= pos (']', linea);
              oper1:= copy (linea, position1, position2-position1);
              Interpretar (tipo, tipo_Ins, error3);
              IF (tipo_Ins = SUM) OR (tipo_Ins = SUB) OR (tipo_Ins = R_COPY) OR (tipo_Ins = JUMPZ) OR (tipo_Ins = JUMPP) THEN
                begin
                  delete (linea, 1, position2+2);
                  oper2:= copy (linea, 1, length (linea)-1);
                end
              ELSE
                IF (tipo_Ins = STORE) THEN
                  begin
                    delete (linea, 1, position2+1);
                    oper2:= linea;
                  end;
              Val (oper1, op1, error1);
              Val (oper2, op2, error2);
              fallo:= (error1 <> 0) OR (error2 <> 0) OR error3 OR (op1 < 0);
            END;


            PROCEDURE escribePrograma (var programa: TPrograma; tipo_Ins: TTipo; op1, op2: integer);
            {Este procedimiento sirve para escribir los datos que leemos del fichero origen en los
             respectivos campos de la estructura de datos que hemos creado para representar el programa}
            {programa[OUT]: parametro de salida que representa el programa que tenemos almacenado}
            {tipo_Ins[IN]: parametro de entrada que representa el tipo de instruccion que sea}
            {op1[IN]: parametro de entrada que representa el primer operando de la instruccion}
            {op2[IN]: parametro de entrada que representa el segundo opernado de la instruccion}
            BEGIN
              programa.longitud:= programa.longitud+1;
              programa.instrucciones[programa.longitud].tipo:= tipo_Ins;
              programa.instrucciones[programa.longitud].op1:= op1;
              programa.instrucciones[programa.longitud].op2:= op2;
            END;

      BEGIN
        pedirNombre (nombre);
        assign (F, nombre);
        {$I-}
        reset (F);
        {$I+}
        programa.longitud:= 0;
        IF ioResult <> 0 THEN
          begin
            errorPrograma:= TRUE;
            MensajeNoExiste;
          end
        ELSE
          WHILE (programa.longitud < MAX_INSTRUCCIONES) AND (not eof(F)) AND (not errorPrograma) DO
            begin
              readln (F,linea);
              obtenerInstruccion (linea, tipo_Ins, op1, op2, fallo);
              IF not fallo THEN
                escribePrograma (programa, tipo_Ins, op1, op2)
              ELSE
                errorPrograma:= TRUE;
              IF not errorPrograma THEN
                begin
                  ClrScr;
                  MensajeExito;
                end;
            end;
      END;


      PROCEDURE ejecutarPrograma (programa: TPrograma; var memoria: TMemoria; var pantalla: TPantalla);
      {Este procedimiento sirve para ejecutar el programa que tenemos almacenado}
      {programa[IN]: parametro de entrada que representa el programa que tenemos}
      {memoria[OUT]: parametro de salida que representa el estado de la memoria}
      {pantalla[OUT]: parametro de salida que representa el estado de la pantalla}
      VAR
       I: TNumInstrucciones;
       vacia: boolean;
       fin: boolean;

            FUNCTION pantallaVacia (pantalla: TPantalla): boolean;
            {Este procedimiento sirve para comprobar si la pantalla esta vacia o no}
            {pantalla[IN]: parametro de entrada que representa el estado de la pantalla}
            {vacia[OUT]: parametro de salida que representa si la pantalla esta vacia o no}
            VAR
             I,J: integer;
             vacia: boolean;
            BEGIN
              vacia:= TRUE;
              I:= 1;
              WHILE vacia AND (I <= NUM_FILAS) DO
                begin
                  J:=1;
                  WHILE vacia AND (J <= NUM_COLUMNAS) DO
                    IF pantalla[I,J] <> ' ' THEN
                      vacia:= FALSE
                    ELSE
                      J:= J+1;
                  I:= I+1;
                end;
              pantallavacia:= vacia;
            END;


            PROCEDURE insertar (op1, op2: integer; var memoria: TMemoria; var indice1: TIndice);
            {Este procedimiento sirve para insertar en nuestra memoria, una posicion y su valor}
            {op1[IN]: parametro de entrada que representa la posicion de memoria}
            {op2[IN]: parametro de entrada que representa el valor de una posicion de memoria}
            {memoria[OUT]: parametro de salida que representa el estado de la memoria}
            {indice1[OUT]: parametro de salida que representa el indice del array en el que hacemos
             la insercion}
            VAR
             J, k: TIndice;
             encontrado: boolean;
            BEGIN
              encontrado:= FALSE;
              J:= 1;
              WHILE not encontrado AND (J <= memoria.tamanio) DO
                IF (op1 < memoria.lista[J].posicion) THEN
                  begin
                    encontrado:= TRUE;
                    indice1:= J;
                    FOR k:= memoria.tamanio DOWNTO indice1 DO
                      memoria.lista[k+1]:= memoria.lista[k];
                    memoria.lista[indice1].posicion:= op1;
                    memoria.lista[indice1].valor:= op2;
                    memoria.tamanio:= memoria.tamanio+1;
                  end
                ELSE
                  J:= J+1;
              IF not encontrado THEN
                begin
                  indice1:= memoria.tamanio+1;
                  memoria.lista[indice1].posicion:= op1;
                  memoria.lista[indice1].valor:= op2;
                  memoria.tamanio:= memoria.tamanio+1;
                end;
            END;


            PROCEDURE sumar (op1, op2: integer; var memoria: TMemoria);
            {Este procedimiento sirve para llevar a cabo la instruccion de suma}
            {op1[IN]: parametro de entrada que representa el primer operando de la instruccion}
            {op2[IN]: parametro de entrada que representa el segundo operando de la instruccion}
            {memoria[OUT]: parametro de salida que representa el estado de la memoria}
            VAR
             encontrado: boolean;
             indice1, indice2: TIndice;
            BEGIN
              buscarPosicionOrd (memoria, op1, indice1, encontrado);
              IF not encontrado THEN
                insertar (op1, 0, memoria, indice1);
              buscarPosicionOrd (memoria, op2, indice2, encontrado);
              IF not encontrado THEN
                insertar (op2, 0, memoria, indice2);
              memoria.lista[indice1].valor:= memoria.lista[indice1].valor + memoria.lista[indice2].valor;
            END;


            PROCEDURE restar (op1, op2: integer; var memoria: TMemoria);
            {Este procedimiento sirve para llevar a cabo la instruccion de resta}
            {op1[IN]: parametro de entrada que representa el primer operando de la instruccion}
            {op2[IN]: parametro de entrada que representa el segundo operando de la instruccion}
            {memoria[OUT]: parametro de salida que representa el estado de la memoria}
            VAR
             encontrado: boolean;
             indice1, indice2: TIndice;
            BEGIN
              buscarPosicionOrd (memoria, op1, indice1, encontrado);
              IF not encontrado THEN
                insertar (op1, 0, memoria, indice1);
              buscarPosicionOrd (memoria, op2, indice2, encontrado);
              IF not encontrado THEN
                insertar (op2, 0, memoria, indice2);
              memoria.lista[indice1].valor:= memoria.lista[indice1].valor - memoria.lista[indice2].valor;
            END;


            PROCEDURE storeMemoria (op1, op2: integer; var memoria: TMemoria);
            {Este procedimiento sirve para llevar a cabo la instruccion de store}
            {op1[IN]: parametro de entrada que representa el primer operando de la instruccion}
            {op2[IN]: parametro de entrada que representa el segundo operando de la instruccion}
            {memoria[OUT]: parametro de salida que representa el estado de la memoria}
            VAR
             encontrado: boolean;
             indice1: TIndice;
            BEGIN
              buscarPosicionOrd (memoria, op1, indice1, encontrado);
              IF not encontrado THEN
                insertar (op1, op2, memoria, indice1)
              ELSE
                memoria.lista[indice1].valor:= op2;
            END;


            PROCEDURE copyMemoria (op1, op2: integer; var memoria: TMemoria);
            {Este procedimiento sirve para llevar a cabo la instruccion de copy}
            {op1[IN]: parametro de entrada que representa el primer operando de la instruccion}
            {op2[IN]: parametro de entrada que representa el segundo operando de la instruccion}
            {memoria[OUT]: parametro de salida que representa el estado de la memoria}
            VAR
             encontrado1, encontrado2: boolean;
             indice1, indice2: TIndice;
            BEGIN
              encontrado1:= FALSE;
              encontrado2:= FALSE;
              buscarPosicionOrd (memoria, op1, indice1, encontrado1);
              IF not encontrado1 THEN
                insertar (op1, 0, memoria, indice1);
              buscarPosicionOrd (memoria, op2, indice2, encontrado2);
              IF not encontrado2 THEN
                insertar (op2, 0, memoria, indice2);
              memoria.lista[indice1].valor:= memoria.lista[indice2].valor;
            END;


            PROCEDURE jumpZero (op1: integer; op2: integer; memoria: TMemoria; programa: TPrograma;
                                var numInstruccion: TNumInstrucciones; var fin: boolean);
            {Este procedimiento sirve para llevar a cabo la instruccion de jumpz}
            {op1[IN]: parametro de entrada que representa el primer operando de la instruccion}
            {op2[IN]: parametro de entrada que representa el segundo operando de la instruccion}
            {memoria[IN]: parametro de entrada que representa el estado de la memoria}
            {numInstruccion[OUT]: parametro de salida que representa la instruccion a la que
             debemos saltar}
            VAR
             encontrado: boolean;
             indice1, indice2: TIndice;
            BEGIN
              buscarPosicionOrd (memoria, op1, indice1, encontrado);
              IF not encontrado THEN
                insertar (op1, 0, memoria, indice1);
              IF (memoria.lista[indice1].valor = 0) THEN
                begin
                  buscarPosicionOrd (memoria, op2, indice2, encontrado);
                  IF not encontrado THEN
                    insertar (op2, 0, memoria, indice2);
                  IF (memoria.lista[indice2].valor <= programa.longitud) THEN
                    numInstruccion:= memoria.lista[indice2].valor
                  ELSE
                    fin:= TRUE;
                end
              ELSE
                numInstruccion:= numInstruccion+1;
            END;


            PROCEDURE jumpBGE (op1: integer; op2: integer; memoria: TMemoria; programa: TPrograma;
                               var numInstruccion: TNumInstrucciones; var fin: boolean);
            {Este procedimiento sirve para llevar a cabo la instruccion de jumpp}
            {op1[IN]: parametro de entrada que representa el primer operando de la instruccion}
            {op2[IN]: parametro de entrada que representa el segundo operando de la instruccion}
            {memoria[IN]: parametro de entrada que representa el estado de la memoria}
            {numInstruccion[OUT]: parametro de salida que representa la instruccion a la que
             debemos saltar}
            VAR
             encontrado: boolean;
             indice1, indice2: TIndice;
            BEGIN
              buscarPosicionOrd (memoria, op1, indice1, encontrado);
              IF not encontrado THEN
                insertar (op1, 0, memoria, indice1);
              IF (memoria.lista[indice1].valor >= 0) THEN
                begin
                  buscarPosicionOrd (memoria, op2, indice2, encontrado);
                  IF not encontrado THEN
                    insertar (op2, 0, memoria, indice2);
                  IF (memoria.lista[indice2].valor <= programa.longitud) THEN
                    numInstruccion:= memoria.lista[indice2].valor
                  ELSE
                    fin:=TRUE;
                end
              ELSE
                numInstruccion:= numInstruccion+1;
            END;


            PROCEDURE readPantalla (op1: integer; pantalla: TPantalla; var memoria: TMemoria);
            {Este procedimiento sirve para llevar a cabo la instruccion de read}
            {op1[IN]: parametro de entrada que representa el primer operando de la instruccion}
            {pantalla[IN]: parametro de entrada que representa el estado de la pantalla}
            {memoria[OUT]: parametro de salida que representa el estado de la memoria}
            VAR
             encontrado1, encontrado2, encontrado3: boolean;
             indice1: TIndice;
             indiceFila: TIndice;
             indiceColumna: TIndice;
            BEGIN
              buscarPosicionOrd (memoria, op1, indice1, encontrado1);
              IF not encontrado1 THEN
                insertar (op1, 0, memoria, indice1);
              buscarPosicionOrd (memoria, 0, indicefila, encontrado2);
              buscarPosicionOrd (memoria, 1, indiceColumna, encontrado3);
              IF not encontrado2 THEN
                insertar (0, 0, memoria, indiceFila);
              IF not encontrado3 THEN
                insertar (1, 0, memoria, indiceColumna);
              memoria.lista[indice1].valor:= ord (pantalla [memoria.lista[indicefila].valor,
                                                            memoria.lista[indicecolumna].valor]);
            END;


            PROCEDURE writePantalla (op1: integer; memoria: TMemoria; var Pantalla: TPantalla);
            {Este procedimiento sirve para llevar a cabo la instruccion de write}
            {op1[IN]: parametro de entrada que representa el primer operando de la instruccion}
            {pantalla[OUT]: parametro de salida que representa el estado de la pantalla}
            {memoria[IN]: parametro de entrada que representa el estado de la memoria}
            VAR
             encontrado1, encontrado2, encontrado3: boolean;
             indice: TIndice;
             indiceFila: TIndice;
             indiceColumna: TIndice;
            BEGIN
              buscarPosicionOrd (memoria, op1, indice, encontrado1);
              buscarPosicionOrd (memoria, 0, indiceFila, encontrado2);
              buscarPosicionOrd (memoria, 1, indiceColumna, encontrado3);
              IF not encontrado1 THEN
                insertar (op1, 0, memoria, indice);
              IF not encontrado2 THEN
                insertar (0, 0, memoria, indiceFila);
              IF not encontrado3 THEN
                insertar (1, 0, memoria, indiceColumna);
              pantalla [memoria.lista[indiceFila].valor, memoria.lista[indiceColumna].valor]:=
                        chr (memoria.lista[indice].valor);
            END;


            PROCEDURE escribirPantalla (pantalla: TPantalla);
            {Este procedimiento sirve para escribir por pantalla el
             estado de la "nuestra" pantalla}
            {pantalla[IN]: parametro de entrada que representa el estado
             de la pantalla}
            VAR
             N:TFilas;
             M:TColumnas;
             x,y: integer;
            BEGIN
              ClrScr;
              Writeln;
              Writeln ('El estado final de la pantalla es: ');
              Writeln;
              y:= 5;
              FOR N:=1 TO NUM_FILAS DO
                begin
                  x:= 25;
                  FOR M:=1 TO NUM_COLUMNAS DO
                    begin
                      gotoXY (x,y);
                      IF M = NUM_COLUMNAS THEN
                        writeln (pantalla[N,M])
                      ELSE
                        write (pantalla[N,M]);
                      x:= x+1;
                    end;
                  y:= y+1;
                end;
              Writeln ('pulse INTRO para continuar');
              Readln;
              ClrScr;
            END;


      BEGIN
        fin:= FALSE;
        I:=1;
        WHILE (programa.longitud > 0) AND (I <= programa.longitud) AND not fin DO
          CASE programa.instrucciones[I].tipo OF
            SUM: begin
                   sumar (programa.instrucciones[I].op1, programa.instrucciones[I].op2, memoria);
                   I:= I+1;
                 end;
            SUB: begin
                   restar (programa.instrucciones[I].op1, programa.instrucciones[I].op2, memoria);
                   I:= I+1;
                 end;
            STORE: begin
                     storeMemoria (programa.instrucciones[I].op1, programa.instrucciones[I].op2, memoria);
                     I:= I+1;
                   end;
            R_COPY: begin
                      copyMemoria (programa.instrucciones[I].op1, programa.instrucciones[I].op2, memoria);
                      I:= I+1;
                    end;
            JUMPZ: jumpZero (programa.instrucciones[I].op1, programa.instrucciones[I].op2, memoria, programa, I, fin);
            JUMPP: jumpBGE (programa.instrucciones[I].op1, programa.instrucciones[I].op2, memoria, programa, I, fin);
            R_READ: begin
                      readPantalla (programa.instrucciones[I].op1, pantalla, memoria);
                      I:= I+1;
                    end;
            R_WRITE: begin
                       writePantalla (programa.instrucciones[I].op1, memoria, pantalla);
                       I:= I+1;
                     end;
          end;
        IF not pantallaVacia (pantalla) THEN
          escribirPantalla (pantalla)
        ELSE
          begin
            ClrScr;
            Writeln;
            Writeln ('EJECUCION REALIZADA. NO SE HA ESCRITO EN PANTALLA');
            Writeln;
            Writeln;
          end;
      END;


BEGIN
  ClrScr;
  InicializarPantalla (pantalla);
  InicializarMemoria (memoria);
  InicializarPrograma (programa);
  REPEAT
    InicializarErrores (errorPrograma, errorMemoria);
    menu (opcion);
    IF (opcion <> 6) THEN
      CASE opcion OF
        1: begin
             CargarPrograma (programa, errorPrograma);
             IF errorPrograma THEN
               begin
                 MensajeNoCarga;
                 InicializarPrograma (programa);
               end;
             end;
        2: IF not errorMemoria AND not errorPrograma AND (programa.longitud > 0) THEN
             EjecutarPrograma (programa, memoria, pantalla)
           ELSE
             MensajeNoEjecuta;
        3: begin
             CargarMemoria (memoria, errorMemoria);
             IF errorMemoria THEN
               begin
                 MensajeNoCarga;
                 InicializarMemoria (memoria);
               end;
           end;
        4: IF (memoria.tamanio <> 0) THEN
             begin
               GuardarMemoria (memoria);
               MensajeExito;
             end
           ELSE
             MensajeGuardaMal;
        5: begin
             GuardarPantalla (pantalla);
             mensajeExito;
           end;
      end;
    IF (opcion = 1) THEN
      InicializarPantalla (pantalla);
  UNTIL (opcion = 6)
END.