int contarPalavras(String texto) {
  return texto.split(RegExp(r'\s+')).where((palavra) => palavra.isNotEmpty).length;
}

int contarFrases(String texto) {
  return texto.split('.').where((frase) => frase.trim().isNotEmpty).length;
}

int contarVogais(String texto) {
  const vogais = 'aeiou';
  return texto
      .toLowerCase()
      .split('')
      .where((caractere) => vogais.contains(caractere))
      .length;
}

String listarConsoantesEncontradas(String texto) {
  const vogais = 'aeiou';
  final letras = RegExp(r'[a-z]');
  final consoantes = texto
      .toLowerCase()
      .split('')
      .where((caractere) => letras.hasMatch(caractere) && !vogais.contains(caractere))
      .toSet()
      .toList();
  consoantes.sort();
  return consoantes.join(', ');
}

void main() {
  const paragrafo =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam venenatis nunc et posuere vehicula. Mauris lobortis quam id lacinia porttitor.';

  print('parágrafo: $paragrafo');
  print('Numero de palavras: ${contarPalavras(paragrafo)}');
  print('Tamanho do texto: ${paragrafo.length}');
  print('Numero de frases: ${contarFrases(paragrafo)}');
  print('Numero de vogais: ${contarVogais(paragrafo)}');
  print('Consoantes encontradas: ${listarConsoantesEncontradas(paragrafo)}');
}