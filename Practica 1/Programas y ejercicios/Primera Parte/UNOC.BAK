Program UnoC;
{Dibuja escalones o bloques en pantalla dependiendo de los }
{valores introducidos por teclado}

Var
  numPeldanios, anchura, altura : Integer;

  {Este procedimiento se encarga de pintar una escalera en la pantalla}
  {peldanios[IN]: numero de peldanios que tiene la escalera}
  {alto[IN]: alto de cada uno de los peldanios de la escalera}
  {ancho[IN]: ancho de cada uno de los peldanios de la escalera}
  Procedure Escalera(peldanios,alto,ancho:integer);
  Var
    i:integer;

    {Este procedimiento se encarga de generar un peldanio en la pantalla}
    {cual[IN]: numero de peldanio que se va a pintar de la escalera}
    {alt[IN]: altura del peldanio}
    {anch[IN]: anchura del peldanio}
    Procedure ladrillo(cual,alt,anch:integer);
    Var
      i,j:integer;
    Begin
      For i:=1 To anch*cual Do write('-'); Writeln;
      For j:=1 To alt Do
        begin
          write('|');
          writeln('|':anch*cual-1);
        end;
      For i:=1 To anch*cual do write('-'); Writeln;
    End;

  Begin
    For i:=1 To peldanios Do
      ladrillo (i,alto,ancho);
  End;

Begin
  Writeln('Introduzca numero de pelda¤os :');
  Readln(NumPeldanios);
  Writeln('Introduzca altura de cada pelda¤o :');
  Readln(Altura);
  Writeln('Introduzca anchura de cada pelda¤o :');
  Readln(anchura);
  escalera(NumPeldanios,Altura,Anchura);
  Readln;
End.