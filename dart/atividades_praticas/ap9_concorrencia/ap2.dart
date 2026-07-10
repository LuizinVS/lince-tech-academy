Future<void> baixarImagens(List<String> urls) async {
  print('Baixando imagens...');

  for (final url in urls) {
    await Future.delayed(Duration(seconds: 1));
    final nomeImagem = url.split('/').last;
    print('Imagem $nomeImagem baixada com sucesso!');
  }

  print('Download concluído!');
}

Future<void> main() async {
  List<String> urls = [
    'https://example.com/imagem1.jpg',
    'https://example.com/imagem2.jpg',
    'https://example.com/imagem3.jpg',
  ];
  await baixarImagens(urls);
}