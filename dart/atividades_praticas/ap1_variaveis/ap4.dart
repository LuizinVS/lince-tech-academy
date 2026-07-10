import 'dart:math';

void main() {
  final Random random = Random();

  int numero1 = random.nextInt(100) + 1;
  int numero2 = random.nextInt(100) + 1;

  double resultado = numero1 / numero2;

  int parteInteira = resultado.truncate();
  double parteDecimal = resultado - parteInteira;

  print("Número 1: $numero1");
  print("Número 2: $numero2");
  print("Resultado da divisão: $resultado");
  print("Parte inteira: $parteInteira");
  print("Parte decimal: ${parteDecimal.toStringAsFixed(6)}");
}