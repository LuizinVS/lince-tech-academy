import 'dart:math';

List<int> gerarRaios(int tamanho, int minimo, int maximo) {
  final random = Random();
  return List<int>.generate(
      tamanho, (_) => minimo + random.nextInt(maximo - minimo + 1));
}

double calcularArea(int raio) {
  return pi * raio * raio;
}

double calcularPerimetro(int raio) {
  return 2 * pi * raio;
}

void main() {
  final raios = gerarRaios(10, 1, 100);

  for (final raio in raios) {
    final area = calcularArea(raio).toStringAsFixed(2);
    final perimetro = calcularPerimetro(raio).toStringAsFixed(2);
    print('Raio: $raio, area: $area, perímetro: $perimetro');
  }
}