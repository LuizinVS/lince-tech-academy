import 'dart:collection';
import 'dart:math';

class GeradorDeNomes {
  final _random = Random();

  final _primeirosNomes = <String>[
    'Joao',
    'Maria',
    'Pedro',
    'Ana',
    'Lucas',
    'Julia',
    'Carlos',
    'Fernanda',
    'Rafael',
    'Beatriz',
  ];

  final _sobrenomes = <String>[
    'Silva',
    'Souza',
    'Oliveira',
    'Santos',
    'Pereira',
    'Costa',
    'Rodrigues',
    'Almeida',
    'Nascimento',
    'Lima',
  ];

  String gerarNomeAleatorio() {
    final primeiroNome =
        _primeirosNomes[_random.nextInt(_primeirosNomes.length)];
    final sobrenome = _sobrenomes[_random.nextInt(_sobrenomes.length)];
    return '$primeiroNome $sobrenome';
  }
}

class Pessoa {
  Pessoa(this.nomeCompleto);

  final String nomeCompleto;
}

class FilaDeMercado {
  final _fila = Queue<Pessoa>();
  final _geradorDeNomes = GeradorDeNomes();

  void entrarNaFila() {
    final pessoa = Pessoa(_geradorDeNomes.gerarNomeAleatorio());
    _fila.addLast(pessoa);
    print('${pessoa.nomeCompleto} entrou na fila');
  }

  void atenderProximo() {
    if (_fila.isEmpty) {
      return;
    }
    final pessoa = _fila.removeFirst();
    print('${pessoa.nomeCompleto} foi atendido(a)');
  }

  bool get estaVazia => _fila.isEmpty;
}

void main() {
  final filaDeMercado = FilaDeMercado();

  for (var i = 0; i < 10; i++) {
    filaDeMercado.entrarNaFila();
  }

  while (!filaDeMercado.estaVazia) {
    filaDeMercado.atenderProximo();
  }
}