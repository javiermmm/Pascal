Program UnoB;
Const
  NumEjecuciones = 3;
Var
  sumaDeNumeros : Integer;

{Este procedimiento se encarga de sumar tres numeros que se piden al usuario}
{suma[OUT]: parametro de salida que almacena el valor de la suma resultante}
Procedure SumaTresNumeros(var suma:Integer);
Var
  i, num : Integer;

    { Este procedimiento se encarga de pedir datos al usuario}
    { numero[OUT]: almacena el valor que ha introducido el usuario }
    Procedure LeerNumero (var numero : Integer);
      Begin
        Writeln('Introduzca un numero :');
        Readln(numero);
      End;

Begin
  suma:=0;
  For i:=1 To NumEjecuciones Do
    Begin
      LeerNumero(num);
      suma:=suma + num;
    End;
End;

  {Este procedimiento se encarga de mostrar los resultados
   de las operaciones al usuario}
  {resultado[IN]: valor que sera mostrado al usuario}
  Procedure MostrarResultados (resultado:Integer);

  Begin
    Writeln('*******************************************************');
    Writeln('La suma de los n£meros es = ', Resultado);
    Writeln('*******************************************************');
  End;

Begin
  sumaDeNumeros:=0;
  SumaTresNumeros(sumaDeNumeros);
  MostrarResultados(SumaDeNumeros);
  Readln;
  Readln;
End.