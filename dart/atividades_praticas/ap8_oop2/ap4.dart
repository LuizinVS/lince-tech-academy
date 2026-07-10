import 'dart:math';

abstract class Calculadora {
  static int dobro(int numero) {
    return numero * 2;
  }
}

void main() {
  final random = Random();
  final numero = random.nextInt(10000);
  final resultado = Calculadora.dobro(numero);

  print('O dobro do número $numero e: $resultado');
}