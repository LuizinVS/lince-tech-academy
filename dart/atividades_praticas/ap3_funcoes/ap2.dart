import 'dart:math';

int funcaoA(int Function(int) funcaoParametro) {
  final random = Random();
  final primeiroResultado = funcaoParametro(random.nextInt(100));
  final segundoResultado = funcaoParametro(random.nextInt(100));
  return primeiroResultado + segundoResultado;
}

int funcaoB(int numero) {
  return numero * 2;
}

int funcaoC(int numero) {
  return numero + 10;
}

void main() {
  final resultadoA = funcaoA(funcaoB);
  final resultadoC = funcaoA(funcaoC);

  print('A(B) = $resultadoA');
  print('A(C) = $resultadoC');
}