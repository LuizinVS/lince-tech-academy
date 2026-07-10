import 'dart:math';

enum StatusItem {
  desejado,
  comprado,
  semEstoque,
}

class ItemDeCompra {
  ItemDeCompra(this.nome, this.quantidade);

  final String nome;
  final int quantidade;
  StatusItem status = StatusItem.desejado;
}

class ListaDeCompras {
  final _itens = <ItemDeCompra>[];

  void incluirItem(String nome, int quantidade) {
    _itens.add(ItemDeCompra(nome, quantidade));
  }

  List<ItemDeCompra> get itensComprados =>
      _itens.where((item) => item.status == StatusItem.comprado).toList();

  List<ItemDeCompra> get itensSemEstoque =>
      _itens.where((item) => item.status == StatusItem.semEstoque).toList();

  List<ItemDeCompra> get itensDesejados =>
      _itens.where((item) => item.status == StatusItem.desejado).toList();

  void marcarComoComprado(String nome) {
    final item = _itens.firstWhere((item) => item.nome == nome);
    item.status = StatusItem.comprado;
  }

  void marcarComoSemEstoque(String nome) {
    final item = _itens.firstWhere((item) => item.nome == nome);
    item.status = StatusItem.semEstoque;
  }

  void exibirItensDesejados() {
    for (final item in itensDesejados) {
      print('${item.nome} - ${item.quantidade}');
    }
  }

  ItemDeCompra? escolherItemPendenteAleatorio() {
    final pendentes = itensDesejados;
    if (pendentes.isEmpty) {
      return null;
    }
    final random = Random();
    return pendentes[random.nextInt(pendentes.length)];
  }

  void exibirProgresso() {
    print('Progresso: ${itensComprados.length}/${_itens.length}');
  }
}

void main() {
  final listaDeCompras = ListaDeCompras()
    ..incluirItem('Arroz', 2)
    ..incluirItem('Feijao', 1)
    ..incluirItem('Leite', 3);

  print('Itens desejados:');
  listaDeCompras.exibirItensDesejados();

  listaDeCompras.marcarComoComprado('Arroz');
  listaDeCompras.marcarComoComprado('Feijao');
  listaDeCompras.marcarComoSemEstoque('Leite');

  print('\nApos atualizacoes:');
  listaDeCompras.exibirProgresso();

  final itemPendente = listaDeCompras.escolherItemPendenteAleatorio();
  print(
    'Item pendente escolhido aleatoriamente: '
    '${itemPendente?.nome ?? "Nenhum item pendente"}',
  );
}