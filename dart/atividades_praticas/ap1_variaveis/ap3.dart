import 'dart:math';

void main() {
  final Random random = Random();

  int numero1 = random.nextInt(100) + 1;
  int numero2 = random.nextInt(100) + 1;

  print("Antes da troca:");
  print("numero1 = $numero1");
  print("numero2 = $numero2");

  int auxiliar = numero1;
  numero1 = numero2;
  numero2 = auxiliar;

  print("\nDepois da troca:");
  print("numero1 = $numero1");
  print("numero2 = $numero2");
}