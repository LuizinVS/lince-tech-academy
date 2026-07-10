int somarComFor(List<int> numeros) {
  var soma = 0;
  for (final numero in numeros) {
    soma += numero;
  }
  return soma;
}

int somarComWhile(List<int> numeros) {
  var soma = 0;
  var indice = 0;
  while (indice < numeros.length) {
    soma += numeros[indice];
    indice++;
  }
  return soma;
}

int somarComRecursao(List<int> numeros, [int indice = 0]) {
  if (indice >= numeros.length) {
    return 0;
  }
  return numeros[indice] + somarComRecursao(numeros, indice + 1);
}

int somarComListaFold(List<int> numeros) {
  return numeros.fold(0, (soma, numero) => soma + numero);
}

void main() {
  final numeros = [10, 35, 999, 126, 95, 7, 348, 462, 43, 109];

  print('for: ${somarComFor(numeros)}');
  print('while: ${somarComWhile(numeros)}');
  print('recursão: ${somarComRecursao(numeros)}');
  print('lista: ${somarComListaFold(numeros)}');
}