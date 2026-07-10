import 'dart:math' as math;

abstract class FormaGeometrica {
  FormaGeometrica(this.nome);

  final String nome;

  double get area;
  double get perimetro;
}

class Circulo extends FormaGeometrica {
  Circulo(String nome, this.raio) : super(nome);

  final double raio;

  @override
  double get area => math.pi * math.pow(raio, 2);

  @override
  double get perimetro => 2 * math.pi * raio;
}

class Retangulo extends FormaGeometrica {
  Retangulo(String nome, this.altura, this.largura) : super(nome);

  final double altura;
  final double largura;

  @override
  double get area => altura * largura;

  @override
  double get perimetro => (altura * 2) + (largura * 2);
}

class Quadrado extends Retangulo {
  Quadrado(String nome, double lado) : super(nome, lado, lado);
}

class TrianguloEquilatero extends FormaGeometrica {
  TrianguloEquilatero(String nome, this.lado) : super(nome);

  final double lado;

  @override
  double get area => (math.sqrt(3) / 4) * math.pow(lado, 2);

  @override
  double get perimetro => lado * 3;
}

class TrianguloRetangulo extends FormaGeometrica {
  TrianguloRetangulo(String nome, this.catetoA, this.catetoB) : super(nome);

  final double catetoA;
  final double catetoB;

  double get hipotenusa =>
      math.sqrt(math.pow(catetoA, 2) + math.pow(catetoB, 2));

  @override
  double get area => (catetoA * catetoB) / 2;

  @override
  double get perimetro => catetoA + catetoB + hipotenusa;
}

class PentagonoRegular extends FormaGeometrica {
  PentagonoRegular(String nome, this.lado) : super(nome);

  final double lado;

  @override
  double get area => (5 * math.pow(lado, 2)) / (4 * math.tan(math.pi / 5));

  @override
  double get perimetro => lado * 5;
}

class HexagonoRegular extends FormaGeometrica {
  HexagonoRegular(String nome, this.lado) : super(nome);

  final double lado;

  @override
  double get area => (3 * math.sqrt(3) / 2) * math.pow(lado, 2);

  @override
  double get perimetro => lado * 6;
}

class ComparadorFormasGeometricas {
  FormaGeometrica maiorArea(FormaGeometrica formaA, FormaGeometrica formaB) {
    return formaA.area >= formaB.area ? formaA : formaB;
  }

  FormaGeometrica maiorPerimetro(
    FormaGeometrica formaA,
    FormaGeometrica formaB,
  ) {
    return formaA.perimetro >= formaB.perimetro ? formaA : formaB;
  }
}

void main() {
  final comparador = ComparadorFormasGeometricas();

  final formas = <FormaGeometrica>[
    Circulo('Circulo A', 3),
    Circulo('Circulo B', 8),
    Retangulo('Retangulo A', 4, 3),
    Retangulo('Retangulo B', 19, 11),
    Quadrado('Quadrado A', 5),
    TrianguloEquilatero('Triangulo Equilatero A', 6),
    TrianguloRetangulo('Triangulo Retangulo A', 3, 4),
    PentagonoRegular('Pentagono Regular A', 5),
    HexagonoRegular('Hexagono Regular A', 4),
  ];

  var maiorAreaAtual = formas.first;
  var maiorPerimetroAtual = formas.first;

  for (final forma in formas.skip(1)) {
    maiorAreaAtual = comparador.maiorArea(maiorAreaAtual, forma);
    maiorPerimetroAtual = comparador.maiorPerimetro(maiorPerimetroAtual, forma);
  }

  print(
    'A maior area e ${maiorAreaAtual.area.toStringAsFixed(2)} '
    'e pertence a ${maiorAreaAtual.nome}',
  );

  print(
    'O maior perimetro e ${maiorPerimetroAtual.perimetro.toStringAsFixed(2)} '
    'e pertence a ${maiorPerimetroAtual.nome}',
  );
}