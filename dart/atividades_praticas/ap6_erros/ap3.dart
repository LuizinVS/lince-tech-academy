import 'dart:math';

abstract class Forma {
  double calcularArea();
}

class Retangulo implements Forma {
  final double _base;
  final double _altura;

  Retangulo(this._base, this._altura) {
    if (_base <= 0 || _altura <= 0) {
      throw Exception(
          'Dimensões inválidas, informe apenas valores positivos maiores que zero');
    }
  }

  @override
  double calcularArea() {
    return _base * _altura;
  }
}

void main() {
  final random = Random();
  final base = random.nextInt(100).toDouble();
  final altura = random.nextInt(100).toDouble();

  try {
    final retangulo = Retangulo(base, altura);
    final area = retangulo.calcularArea();
    print('Area do retângulo: ${area.toStringAsFixed(2)}');
  } catch (e) {
    print(e);
  }
}