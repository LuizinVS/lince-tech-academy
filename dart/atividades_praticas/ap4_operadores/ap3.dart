List<T> removerElemento<T>(List<T>? lista, T? elemento) {
  final listaSegura = lista ?? <T>[];
  return elemento == null
      ? List<T>.from(listaSegura)
      : (List<T>.from(listaSegura)..remove(elemento));
}

void main() {
  final numeros = [10, 20, 30, 40, 50];

  final semTrinta = removerElemento(numeros, 30);
  print('Lista original: ${numeros.join(', ')}');
  print('Lista sem o 30: ${semTrinta.join(', ')}');

  final semElementoNulo = removerElemento(numeros, null);
  print('Lista sem elemento informado: ${semElementoNulo.join(', ')}');

  final listaNulaSemElemento = removerElemento<int>(null, null);
  print('Lista nula tratada: ${listaNulaSemElemento.join(', ')}');

  final listaNulaComElemento = removerElemento<int>(null, 30);
  print('Lista nula com elemento tratada: ${listaNulaComElemento.join(', ')}');
}