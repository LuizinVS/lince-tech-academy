import 'dart:math';

List<int> gerarNumeros(int tamanho, int minimo, int maximo) {
  final random = Random();
  return List<int>.generate(
      tamanho, (_) => minimo + random.nextInt(maximo - minimo + 1));
}

String converterParaBinario(int numero) {
  return numero.toRadixString(2);
}

String converterParaOctal(int numero) {
  return numero.toRadixString(8);
}

String converterParaHexadecimal(int numero) {
  return numero.toRadixString(16);
}

void main() {
  final numeros = gerarNumeros(15, 1, 5000);
  numeros.sort();

  for (final numero in numeros) {
    final binario = converterParaBinario(numero);
    final octal = converterParaOctal(numero);
    final hexadecimal = converterParaHexadecimal(numero);
    print(
        'decimal: $numero, binário: $binario, octal: $octal, hexadecimal: $hexadecimal');
  }
}