import 'dart:collection';

enum Naipe {
  paus('\u2663'),
  copas('\u2665'),
  espadas('\u2660'),
  ouros('\u2666');

  const Naipe(this.simbolo);

  final String simbolo;
}

class Carta {
  Carta(this.valor, this.naipe);

  final String valor;
  final Naipe naipe;

  @override
  String toString() => '$valor (${naipe.simbolo})';
}

class Baralho {
  final _cartas = Queue<Carta>();

  void empilhar(Carta carta) {
    _cartas.addFirst(carta);
  }

  Carta remover() {
    return _cartas.removeFirst();
  }

  bool get estaVazio => _cartas.isEmpty;
}

void main() {
  final baralho = Baralho()
    ..empilhar(Carta('A', Naipe.paus))
    ..empilhar(Carta('A', Naipe.copas))
    ..empilhar(Carta('A', Naipe.espadas))
    ..empilhar(Carta('A', Naipe.ouros));

  while (!baralho.estaVazio) {
    final carta = baralho.remover();
    print('Removendo carta: $carta');
  }
}