import 'dart:math';

void main() {
  final Random random = Random(); 

  final List<int> numeros = List.generate(50, (_) => 10 + random.nextInt(12));

  print('Lista original: ${numeros.join(' ; ')}');

  final List<int> unicos = numeros.toSet().toList();

  print('Itens únicos: ${unicos.join(' ; ')}');
}