{Programa que dibuja una escalera alineada a la derecha, a partir
 de los datos que el usuario introduce por teclado. Dichos datos ser n el
 n£mero de pelda¤os de la escalera, la anchura de cada pelda¤o y la altura
 de cada pelda¤o.}

PROGRAM UnoCMejor;
USES Crt;
CONST
  barra = '|';
VAR
numeroDePeldanios: integer;
ancho: integer;
alto: integer;

    {Procedimiento que dibuja la escalera final en panyalla}
    {numpeldanios[IN]: parametro de entrada que habr  almacenado el n£mero
     de pelda¤os que ha introducido el usuario}
    {anch[IN]: parametro de entrada que habr  almacenado el ancho que ha
     introducido el usuario}
    {alt[IN]: parametro de entrada que habr  almacenado la altura introducida
     por el usuario}
    PROCEDURE dibujaEscalera (numpeldanios: integer; anch: integer; alt: integer);
    VAR
     actual: integer;
     k: integer;
          {Procedimiento que dibuja un escalon}
          {numpeldanios[IN]: parametro de entrada que habr  almacenado el n£mero
           de pelda¤os que ha introducido el usuario}
          {anch[IN]: parametro de entrada que habr  almacenado el ancho que ha
           introducido el usuario}
          {alt[IN]: parametro de entrada que habr  almacenado la altura introducida
           por el usuario}
          {actual[IN]: parametro de entrada que representa el pelda¤o actual
           que se est  dibujando}
          PROCEDURE dibujaEscalon (numpeldanios: integer; anch: integer; alt: integer; actual: integer);
          VAR
           i: integer;


                {Procedimiento que dibuja las lineas de blancos y guiones
                 que forman la "superficie" del escalon}
                {numpeldanios[IN]: parametro de entrada que habr  almacenado el n£mero
                 de pelda¤os que ha introducido el usuario}
                {anch[IN]: parametro de entrada que habr  almacenado el ancho que ha
                 introducido el usuario}
                {actual[IN]: parametro de entrada que representa el pelda¤o actual
                 que se esta dibujando, siendo el primero el mas alto, y el ultimo
                 el mas bajo}
                PROCEDURE dibujaSuperficie (numpeldanios:  integer; anch: integer; actual: integer);
                VAR
                 j: integer;

                BEGIN
                  FOR j:=1 TO anch*(numpeldanios-actual) DO
                      write (' ');
                  FOR j:=1 TO anch*actual DO
                      write ('-');
                  Writeln;
                END;


          BEGIN
            dibujaSuperficie (numpeldanios, anch, actual);
            FOR i:=1 TO alt DO   { <---- Este bucle dibuja el alto del pelda¤o}
             begin
               write (barra: anch*(numpeldanios-actual)+1);
               write (barra: anch*actual-1);
               writeln;
             end;
            dibujaSuperficie (numpeldanios, anch, actual)
          END;


    BEGIN
      actual:= 1;
      FOR k:= 1 TO numpeldanios DO
        begin
          dibujaEscalon (numpeldanios, anch, alt, actual);
          actual:= actual + 1;
        end;
    END;

    {Procedimiento que solicita por pantalla los datos necesarios para
     realizar el dibujo de la escalera, y los almacena en sus
     correspondientes variables}
    {numpeldanios[OUT]: parametro de salida que almacena el numero de pelda¤os
     que se introducen por teclado}
    {anch[OUT]: parametro de salida que almacena el ancho de cada pelda¤o
     que se introducir  por teclado}
    {alt[OUT]: parametro de salida que almacena el alto que van a tener los
     pelda¤os. Este dato tambi‚n lo introduce el usuario por teclado}
    PROCEDURE pideDatosYLeelos (var numpeldanios: integer; var anch: integer; var alt: integer);
    BEGIN
      Writeln ('Introduzca el n£mero de pelda¤os que desea que tenga la escalera');
      Readln (numpeldanios);
      Writeln ('Introduzca el ancho de cada pelda¤o');
      Readln (anch);
      Writeln ('Introduzca el alto que tendr  cada pelda¤o');
      Readln (alt);
      Readln;
    END;

BEGIN
  ClrScr;
  pideDatosYLeelos (numeroDePeldanios, ancho, alto);
  dibujaEscalera (numeroDePeldanios, ancho, alto);
  REPEAT
  UNTIL Keypressed;
END.