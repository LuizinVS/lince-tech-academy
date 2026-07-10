import 'dart:math';

void main() {
  final Random random = Random(); 

  final List<int> numeros = List.generate(50, (_) => random.nextInt(16));

  print('Lista original: ${numeros.join(' ; ')}');

  numeros.removeWhere((numero) => numero % 2 == 0);

  print('Lista atualizada: ${numeros.join(' ; ')}');
}