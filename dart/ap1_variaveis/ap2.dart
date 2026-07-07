void main (){
  const double n1 = 7.0;
  const double n2 = 8.0;
  const double n3 = 5.3;
  const double n4 = 9.7;

  final double media = (n1 + n2 + n3 + n4) / 4;

  print(
    'A media entre [ $n1 , $n2 , $n3 , $n4 ] = ${media.toStringAsFixed(1)}',
  );

}