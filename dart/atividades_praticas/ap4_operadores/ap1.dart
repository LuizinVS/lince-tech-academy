bool ehAnoBissexto(int ano) {
  return (ano % 4 == 0 && ano % 100 != 0) || (ano % 400 == 0);
}

void imprimirResultadoAnoBissexto(int ano) {
  final resultado = ehAnoBissexto(ano) ? 'eh' : 'nao eh';
  print('O ano $ano $resultado bissexto');
}

void main() {
  final anos = [2016, 1988, 2000, 2100, 2300, 1993];

  for (final ano in anos) {
    imprimirResultadoAnoBissexto(ano);
  }
}