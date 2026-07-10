import 'dart:math';

double calcularArea(num raio) {
  return pi * raio * raio;
}

double calcularPerimetro(num raio) {
  return 2 * pi * raio;
}

void main() {
  final raios = <num>[5, 8, 12, 7.3, 18, 2, 25];

  for (final raio in raios) {
    final area = calcularArea(raio).toStringAsFixed(2);
    final perimetro = calcularPerimetro(raio).toStringAsFixed(2);
    print('Raio: $raio, area: $area, perímetro: $perimetro.');
  }
}