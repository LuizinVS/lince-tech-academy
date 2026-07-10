import 'dart:math';

String letraDoAlfabeto(int numero) {
  return String.fromCharCode(64 + numero);
}

void main() {
  final random = Random();
  final numeros = List<int>.generate(5, (_) => 1 + random.nextInt(26));

  for (final numero in numeros) {
    print('Numero $numero -> Letra ${letraDoAlfabeto(numero)}');
  }
}