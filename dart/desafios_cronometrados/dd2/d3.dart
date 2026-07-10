class Musica {
  Musica(this.titulo, this.artista, this.album, this.duracaoEmSegundos);

  final String titulo;
  final String artista;
  final String album;
  final int duracaoEmSegundos;
}

class Biblioteca {
  final _musicas = <Musica>[];

  void adicionarMusica(Musica musica) {
    _musicas.add(musica);
  }

  int get numeroDeMusicas => _musicas.length;

  double get tempoTotalEmHoras {
    final totalSegundos = _musicas.fold<int>(
      0,
      (soma, musica) => soma + musica.duracaoEmSegundos,
    );
    return totalSegundos / 3600;
  }

  void imprimirMusicas() {
    for (final musica in _musicas) {
      print('${musica.titulo} - ${musica.artista} (${musica.album})');
    }
  }

  List<Musica> buscarPorTitulo(String titulo) {
    return _musicas
        .where(
          (musica) => musica.titulo.toLowerCase() == titulo.toLowerCase(),
        )
        .toList();
  }

  List<Musica> buscarPorArtista(String artista) {
    return _musicas
        .where(
          (musica) => musica.artista.toLowerCase() == artista.toLowerCase(),
        )
        .toList();
  }

  List<Musica> buscarPorAlbum(String album) {
    return _musicas
        .where(
          (musica) => musica.album.toLowerCase() == album.toLowerCase(),
        )
        .toList();
  }
}

void main() {
  final biblioteca = Biblioteca()
    ..adicionarMusica(
      Musica('Bohemian Rhapsody', 'Queen', 'A Night at the Opera', 355),
    )
    ..adicionarMusica(Musica('Imagine', 'John Lennon', 'Imagine', 183))
    ..adicionarMusica(Musica('Billie Jean', 'Michael Jackson', 'Thriller', 294))
    ..adicionarMusica(
      Musica('Hotel California', 'Eagles', 'Hotel California', 391),
    )
    ..adicionarMusica(
      Musica('Stairway to Heaven', 'Led Zeppelin', 'Led Zeppelin IV', 482),
    );

  print('Musicas cadastradas:');
  biblioteca.imprimirMusicas();

  print('\nNumero de musicas: ${biblioteca.numeroDeMusicas}');
  print(
    'Tempo total em horas: ${biblioteca.tempoTotalEmHoras.toStringAsFixed(2)}',
  );

  print('\nBusca por titulo "Imagine":');
  for (final musica in biblioteca.buscarPorTitulo('Imagine')) {
    print('${musica.titulo} - ${musica.artista}');
  }

  print('\nBusca por artista "Queen":');
  for (final musica in biblioteca.buscarPorArtista('Queen')) {
    print('${musica.titulo} - ${musica.artista}');
  }

  print('\nBusca por album "Thriller":');
  for (final musica in biblioteca.buscarPorAlbum('Thriller')) {
    print('${musica.titulo} - ${musica.artista}');
  }
}