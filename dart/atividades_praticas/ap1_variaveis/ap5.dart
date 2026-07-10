class Pessoa {
  final String nome;
  final String sobrenome;
  final int idade;
  final bool ativo;
  final double peso;
  final String nacionalidade;

  const Pessoa({
    required this.nome,
    required this.sobrenome,
    required this.idade,
    required this.ativo,
    required this.peso,
    required this.nacionalidade,
  });

  @override
  String toString() {
    return '''
Nome completo: $nome $sobrenome
Idade: $idade (${idade >= 18 ? "maior de idade" : "menor de idade"})
Situação: ${ativo ? "Ativo" : "Inativo"}
Peso: $peso
Nacionalidade: ${nacionalidade.isNotEmpty ? nacionalidade : "Não informada"}
''';
  }
}

void main() {
  const pessoa = Pessoa(
    nome: 'Luiz Vinicius',
    sobrenome: 'Marcelo Mariath',
    idade: 21,
    ativo: true,
    peso: 88.0,
    nacionalidade: 'Brasileiro',
  );

  print(pessoa);
}