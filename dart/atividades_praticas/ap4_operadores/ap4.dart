int calcularPercentualDesconto(num valorOriginal, num valorComDesconto) {
  return (((valorOriginal - valorComDesconto) / valorOriginal) * 100).round();
}

void imprimirDesconto(num valorOriginal, num valorComDesconto) {
  final percentual = calcularPercentualDesconto(valorOriginal, valorComDesconto);
  print(
      'O produto custava $valorOriginal reais, foi vendido por $valorComDesconto reais. O desconto dado foi $percentual%.');
}

void main() {
  imprimirDesconto(10, 7);
}