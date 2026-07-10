class Retangulo {
  final double largura;
  final double altura;

  Retangulo(this.largura, this.altura);

  double calcularArea() {
    return largura * altura;
  }
}

void main() {
  final retangulo = Retangulo(9.999999, 10.0);

  print('Area do retângulo: ${retangulo.calcularArea()}');
}