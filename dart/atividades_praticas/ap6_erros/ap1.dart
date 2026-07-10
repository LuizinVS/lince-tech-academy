int converterParaInteiro(String entrada) {
  return int.parse(entrada);
}

void processarEntrada(String entrada) {
  try {
    final numero = converterParaInteiro(entrada);
    print('Numero digitado: $numero');
  } catch (e) {
    print('Entrada invalida. Insira apenas números inteiros.');
  }
}

void main() {
  processarEntrada('9999');
  processarEntrada('abc');
}