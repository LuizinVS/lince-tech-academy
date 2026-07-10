import 'dart:math';

class Figurinha {
  Figurinha(this.codigo, this.nome);

  final int codigo;
  final String nome;
}

class ListaDeFigurinhas {
  static final List<Figurinha> todas = List<Figurinha>.generate(
    20,
    (indice) => Figurinha(indice + 1, 'Figurinha ${indice + 1}'),
  );
}

class PacoteDeFigurinhas {
  PacoteDeFigurinhas() : figurinhas = _sortear();

  final List<Figurinha> figurinhas;

  static List<Figurinha> _sortear() {
    final random = Random();
    final todas = ListaDeFigurinhas.todas;
    return List<Figurinha>.generate(
      4,
      (_) => todas[random.nextInt(todas.length)],
    );
  }
}

class Album {
  final _figurinhasColadas = <int, Figurinha>{};
  final _figurinhasRepetidas = <Figurinha>[];

  bool get estaCompleto =>
      _figurinhasColadas.length == ListaDeFigurinhas.todas.length;

  void adicionarPacote(PacoteDeFigurinhas pacote) {
    for (final figurinha in pacote.figurinhas) {
      if (_figurinhasColadas.containsKey(figurinha.codigo)) {
        _figurinhasRepetidas.add(figurinha);
      } else {
        _figurinhasColadas[figurinha.codigo] = figurinha;
      }
    }
  }

  int get numeroDeRepetidas => _figurinhasRepetidas.length;

  void imprimirAlbum() {
    final codigosOrdenados = _figurinhasColadas.keys.toList()..sort();
    for (final codigo in codigosOrdenados) {
      final figurinha = _figurinhasColadas[codigo]!;
      print('${figurinha.codigo} - ${figurinha.nome}');
    }
  }
}

void main() {
  final album = Album();

  while (!album.estaCompleto) {
    final pacote = PacoteDeFigurinhas();
    album.adicionarPacote(pacote);
  }

  print('Numero de figurinhas repetidas: ${album.numeroDeRepetidas}');
  album.imprimirAlbum();
}