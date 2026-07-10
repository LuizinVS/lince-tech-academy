void validarNumeroPar(int numero) {
  if (numero.isOdd) {
    throw Exception('Entrada inválida. Insira apenas números pares.');
  }
}

void processarNumero(int numero) {
  try {
    validarNumeroPar(numero);
    print('Entrada correta, você inseriu um número par.');
  } catch (e) {
    print(e);
  }
}

void main() {
  processarNumero(8);
  processarNumero(7);
}