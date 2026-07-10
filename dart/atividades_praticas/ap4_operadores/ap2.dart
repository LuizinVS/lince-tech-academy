List<int> converterParaNumeros(List<String> textos) {
  return textos.map((texto) => int.tryParse(texto) ?? 0).toList();
}

void main() {
  final textos = [
    '10',
    '2XXL7',
    'JOJ0',
    '99',
    '381',
    'AD44',
    '47',
    '2B',
    '123',
    '78',
  ];

  final numeros = converterParaNumeros(textos);

  print('Lista convertida: ${numeros.join(', ')}');
}