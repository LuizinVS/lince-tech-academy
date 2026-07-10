Future<void> buscarDados() async {
  print('Iniciando busca de dados...');
  await Future.delayed(Duration(seconds: 1));
  print('Buscando dados...');
  await Future.delayed(Duration(seconds: 1));
  print('Busca de dados finalizada!');
}

void main() async {
  await buscarDados();
}