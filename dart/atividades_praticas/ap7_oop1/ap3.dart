class Produto {
  final String nome;
  final double preco;

  Produto(this.nome, this.preco);

  double desconto(double percentual) {
    return preco - (preco * percentual / 100);
  }
}

void main() {
  final produtos = [
    Produto('Teclado Mecanico', 250.00),
    Produto('Monitor 27 Polegadas', 1200.00),
    Produto('Mouse Sem Fio', 89.90),
    Produto('Cadeira Gamer', 899.90),
    Produto('Headset Bluetooth', 349.90),
  ];

  for (final produto in produtos) {
    final precoComDesconto = produto.desconto(15);
    print(
        'Novo preço do produto ${produto.nome} (com desconto) ${precoComDesconto.toStringAsFixed(2)}');
  }
}