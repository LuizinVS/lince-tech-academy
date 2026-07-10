import 'dart:math';

List<int> gerarListaAleatoria(int tamanho, int minimo, int maximo) {
  final random = Random();
  return List<int>.generate(
      tamanho, (_) => minimo + random.nextInt(maximo - minimo + 1));
}

void imprimirLista(List<int> lista) {
  if (lista.isEmpty) {
    print('Lista vazia');
    return;
  }
  print('Lista: ${lista.join(', ')}');
}

List<int> somarListas(List<int> lista1, List<int> lista2) {
  if (lista1.length != lista2.length) {
    return [];
  }
  return List<int>.generate(lista1.length, (i) => lista1[i] + lista2[i]);
}

void main() {
  final lista1 = gerarListaAleatoria(5, 0, 100);
  final lista2 = gerarListaAleatoria(5, 0, 100);

  imprimirLista(lista1);
  imprimirLista(lista2);

  for (var i = 0; i < lista1.length; i++) {
    print('${lista1[i]}+${lista2[i]}');
  }

  final listaFinal = somarListas(lista1, lista2);
  imprimirLista(listaFinal);
}