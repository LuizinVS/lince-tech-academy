DateTime adicionarDiasUteis(DateTime data, int diasUteis) {
  var diasAdicionados = 0;
  var novaData = data;

  while (diasAdicionados < diasUteis) {
    novaData = novaData.add(Duration(days: 1));
    final ehFimDeSemana =
        novaData.weekday == DateTime.saturday || novaData.weekday == DateTime.sunday;
    if (!ehFimDeSemana) {
      diasAdicionados++;
    }
  }

  return novaData;
}

String formatarData(DateTime data) {
  final dia = data.day.toString().padLeft(2, '0');
  final mes = data.month.toString().padLeft(2, '0');
  final ano = data.year.toString();
  return '$dia/$mes/$ano';
}

void main() {
  final dataAtual = DateTime.now();
  final dataCalculada = adicionarDiasUteis(dataAtual, 18);

  print('Data atual: ${formatarData(dataAtual)}');
  print('Data calculada: ${formatarData(dataCalculada)}');
}