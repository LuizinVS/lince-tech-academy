String descreverIdade(int? idade) {
  return idade?.toString() ?? 'idade nao informada';
}

void main() {
  final pessoas = <String, int?>{
    'Nelson': null,
    'Jane': null,
    'Jack': 16,
    'Rupert': 37,
    'Andy': 13,
    'Kim': 27,
    'Robert': 31,
  };

  pessoas.forEach((nome, idade) {
    print('$nome - ${descreverIdade(idade)}');
  });
}