import 'dart:math';

int somaPares(int limite) {
  var soma = 0;
  for (var numero = 0; numero <= limite; numero += 2) {
    soma += numero;
  }
  return soma;
}

void main() {
  final random = Random();
  final numero = 100 + random.nextInt(901);
  final soma = somaPares(numero);

  print('A soma dos números pares entre 0 e $numero e $soma');
}