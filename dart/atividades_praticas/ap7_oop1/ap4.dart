import 'dart:math';

class Pessoa {
  String _nome = '';
  int _idade = 0;
  double _altura = 0;

  String get nome => _nome;
  set nome(String valor) {
    _nome = valor;
  }

  int get idade => _idade;
  set idade(int valor) {
    if (valor >= 0) {
      _idade = valor;
    }
  }

  double get altura => _altura;
  set altura(double valor) {
    _altura = valor;
  }
}

void main() {
  final random = Random();
  final pessoa = Pessoa();

  pessoa.nome = 'Rafael';
  pessoa.idade = 1 + random.nextInt(100);
  pessoa.altura = 1.0 + random.nextDouble() * 1.3;

  print('Nome: ${pessoa.nome}');
  print('Idade: ${pessoa.idade}');
  print('Altura: ${pessoa.altura.toStringAsFixed(2)}');
}