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
  final numeros = [3, 17, 23, 49, 328, 1358, 21, 429, 12, 103, 20021];
  numeros.sort();

  for (final numero in numeros) {
    final binario = converterParaBinario(numero);
    final octal = converterParaOctal(numero);
    final hexadecimal = converterParaHexadecimal(numero);
    print(
        'decimal: $numero, binário: $binario, octal: $octal, hexadecimal: $hexadecimal');
  }
}