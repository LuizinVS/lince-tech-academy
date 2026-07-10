import 'dart:math';

void main() {
  final pessoa = Pessoa();
  final fornecedores = <Fornecedor>[
    FornecedorDeBebidas(),
    FornecedorDeSanduiches(),
    FornecedorDeBolos(),
    FornecedorDeSaladas(),
    FornecedorDePetiscos(),
    FornecedorDeUltraCaloricos(),
  ];

  final random = Random();

  while (pessoa.precisaDeRefeicao) {
    final fornecedor = fornecedores[random.nextInt(fornecedores.length)];
    pessoa.refeicao(fornecedor);
  }

  pessoa.informacoes();
}

enum StatusCalorias {
  deficitExtremo,
  deficit,
  satisfeita,
  excesso,
}

class Produto {
  Produto(this.nome, this.calorias);

  final String nome;
  final int calorias;
}

abstract class Fornecedor {
  final _random = Random();

  List<Produto> get produtosDisponiveis;

  Produto fornecer() {
    return produtosDisponiveis[_random.nextInt(produtosDisponiveis.length)];
  }
}

class FornecedorDeBebidas extends Fornecedor {
  @override
  List<Produto> get produtosDisponiveis => <Produto>[
        Produto('Agua', 0),
        Produto('Refrigerante', 200),
        Produto('Suco de fruta', 100),
        Produto('Energetico', 135),
        Produto('Cafe', 60),
        Produto('Cha', 35),
      ];
}

class FornecedorDeSanduiches extends Fornecedor {
  @override
  List<Produto> get produtosDisponiveis => <Produto>[
        Produto('Sanduiche natural', 250),
        Produto('Sanduiche de frango', 400),
        Produto('Hot dog', 350),
        Produto('Misto quente', 300),
      ];
}

class FornecedorDeBolos extends Fornecedor {
  @override
  List<Produto> get produtosDisponiveis => <Produto>[
        Produto('Bolo de chocolate', 450),
        Produto('Bolo de cenoura', 380),
        Produto('Bolo de fuba', 320),
      ];
}

class FornecedorDeSaladas extends Fornecedor {
  @override
  List<Produto> get produtosDisponiveis => <Produto>[
        Produto('Salada de frutas', 120),
        Produto('Salada verde', 80),
        Produto('Salada caesar', 220),
      ];
}

class FornecedorDePetiscos extends Fornecedor {
  @override
  List<Produto> get produtosDisponiveis => <Produto>[
        Produto('Batata frita', 300),
        Produto('Pastel', 280),
        Produto('Coxinha', 250),
      ];
}

class FornecedorDeUltraCaloricos extends Fornecedor {
  @override
  List<Produto> get produtosDisponiveis => <Produto>[
        Produto('Pizza inteira', 1200),
        Produto('Hamburguer duplo', 900),
        Produto('Milk shake grande', 700),
      ];
}

class Pessoa {
  Pessoa() : _caloriasConsumidas = Random().nextInt(3000);

  int _caloriasConsumidas;
  int _refeicoesRealizadas = 0;

  StatusCalorias get status {
    if (_caloriasConsumidas <= 500) {
      return StatusCalorias.deficitExtremo;
    } else if (_caloriasConsumidas <= 1800) {
      return StatusCalorias.deficit;
    } else if (_caloriasConsumidas <= 2500) {
      return StatusCalorias.satisfeita;
    }
    return StatusCalorias.excesso;
  }

  bool get precisaDeRefeicao =>
      status == StatusCalorias.deficitExtremo ||
      status == StatusCalorias.deficit;

  void informacoes() {
    print('Calorias consumidas: $_caloriasConsumidas');
    print('Status: ${status.name}');
    print('Refeicoes realizadas: $_refeicoesRealizadas');
  }

  void refeicao(Fornecedor fornecedor) {
    final produto = fornecedor.fornecer();
    print('Consumindo ${produto.nome} (${produto.calorias} calorias)');

    _caloriasConsumidas += produto.calorias;
    _refeicoesRealizadas++;
  }
}