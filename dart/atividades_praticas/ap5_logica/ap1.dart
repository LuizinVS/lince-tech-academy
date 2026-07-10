List<int> numerosImpares(int limite) {
  return List<int>.generate(limite + 1, (i) => i).where((n) => n.isOdd).toList();
}

void main() {
  final impares = numerosImpares(10);

  for (final numero in impares) {
    print('Impar: $numero');
  }
}