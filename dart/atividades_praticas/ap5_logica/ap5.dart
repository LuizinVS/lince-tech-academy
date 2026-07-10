import 'dart:math';

String descreverOpcao(int opcao) {
  final mensagens = <int, String>{
    0: 'Opcao invalida',
    1: 'Encontrado 1',
    2: 'Encontrado 2',
    3: 'Encontrado 3',
    4: 'Encontrado 4',
    5: 'Encontrado final',
  };

  return mensagens[opcao] ?? 'Opcao invalida';
}

void main() {
  final random = Random();
  final opcao = random.nextInt(6);

  print(descreverOpcao(opcao));
}