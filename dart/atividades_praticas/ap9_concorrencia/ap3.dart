Future<void> contagemRegressiva(int inicio) async {
  for (var numero = inicio; numero > 0; numero--) {
    print(numero);
    await Future.delayed(Duration(seconds: 1));
  }
}

void main() async {
  print('Iniciando lançamento');
  await contagemRegressiva(5);
  print('Foguete lançado!');
}