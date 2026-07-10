import 'dart:math';

void main() {
  final Random random = Random(); 

  final List<int> numeros = List.generate(10, (_) => random.nextInt(101));

  for (var i = 0; i < numeros.length; i++) {
    print('Posição: $i, valor: ${numeros[i]}');
  }
}