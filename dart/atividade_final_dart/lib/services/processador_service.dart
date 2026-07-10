import '../models/registro_clima.dart';

class ProcessadorService {
  const ProcessadorService({
    this.indiceTemperatura,
    this.indiceUmidade,
    this.indiceDirecaoVento,
    this.indiceFaixaHoraria,
  });

  final int? indiceTemperatura;
  final int? indiceUmidade;
  final int? indiceDirecaoVento;
  final int? indiceFaixaHoraria;

  Map<String, dynamic> processarTudo(
    List<RegistroClima> registros, {
    String? faixaHoraria,
  }) {
    return <String, dynamic>{
      'temperatura': <String, dynamic>{
        'mediaPorEstadoEAno': temperaturaMediaPorEstadoEAno(registros),
        'mediaPorEstadoEMes': temperaturaMediaPorEstadoEMes(registros),
        'maximaPorEstadoEAno': temperaturaMaximaPorEstadoEAno(registros),
        'maximaPorEstadoEMes': temperaturaMaximaPorEstadoEMes(registros),
        'minimaPorEstadoEAno': temperaturaMinimaPorEstadoEAno(registros),
        'minimaPorEstadoEMes': temperaturaMinimaPorEstadoEMes(registros),
        'mediaPorFaixaHoraria': faixaHoraria == null
            ? <String, double>{}
            : temperaturaMediaPorFaixaHoraria(registros, faixaHoraria),
      },
      'umidade': <String, dynamic>{
        'mediaPorEstadoEAno': umidadeMediaPorEstadoEAno(registros),
        'mediaPorEstadoEMes': umidadeMediaPorEstadoEMes(registros),
        'maximaPorEstadoEAno': umidadeMaximaPorEstadoEAno(registros),
        'maximaPorEstadoEMes': umidadeMaximaPorEstadoEMes(registros),
        'minimaPorEstadoEAno': umidadeMinimaPorEstadoEAno(registros),
        'minimaPorEstadoEMes': umidadeMinimaPorEstadoEMes(registros),
      },
      'direcaoVento': <String, dynamic>{
        'modaPorEstadoEAno': direcaoVentoModaPorEstadoEAno(registros),
        'modaPorEstadoEMes': direcaoVentoModaPorEstadoEMes(registros),
      },
    };
  }

  Map<String, Map<int, double>> temperaturaMediaPorEstadoEAno(
    List<RegistroClima> registros,
  ) {
    return _agruparNumericoPorEstadoEAno(
      registros: registros,
      extrairValor: (RegistroClima registro) => registro.temperaturaCelsius,
      calcular: _media,
    );
  }

  Map<String, Map<int, double>> temperaturaMediaPorEstadoEMes(
    List<RegistroClima> registros,
  ) {
    return _agruparNumericoPorEstadoEMes(
      registros: registros,
      extrairValor: (RegistroClima registro) => registro.temperaturaCelsius,
      calcular: _media,
    );
  }

  Map<String, Map<int, double>> temperaturaMaximaPorEstadoEAno(
    List<RegistroClima> registros,
  ) {
    return _agruparNumericoPorEstadoEAno(
      registros: registros,
      extrairValor: (RegistroClima registro) => registro.temperaturaCelsius,
      calcular: _maximo,
    );
  }

  Map<String, Map<int, double>> temperaturaMaximaPorEstadoEMes(
    List<RegistroClima> registros,
  ) {
    return _agruparNumericoPorEstadoEMes(
      registros: registros,
      extrairValor: (RegistroClima registro) => registro.temperaturaCelsius,
      calcular: _maximo,
    );
  }

  Map<String, Map<int, double>> temperaturaMinimaPorEstadoEAno(
    List<RegistroClima> registros,
  ) {
    return _agruparNumericoPorEstadoEAno(
      registros: registros,
      extrairValor: (RegistroClima registro) => registro.temperaturaCelsius,
      calcular: _minimo,
    );
  }

  Map<String, Map<int, double>> temperaturaMinimaPorEstadoEMes(
    List<RegistroClima> registros,
  ) {
    return _agruparNumericoPorEstadoEMes(
      registros: registros,
      extrairValor: (RegistroClima registro) => registro.temperaturaCelsius,
      calcular: _minimo,
    );
  }

  Map<String, double> temperaturaMediaPorFaixaHoraria(
    List<RegistroClima> registros,
    String faixaHoraria,
  ) {
    final Map<String, List<double>> agrupados = <String, List<double>>{};
    final int? horaDesejada = _parseHoraFaixa(faixaHoraria);

    for (final RegistroClima registro in registros) {
      if (horaDesejada != null && registro.dataHora.hour != horaDesejada) {
        continue;
      }

      agrupados.putIfAbsent(registro.estado, () => <double>[]);
      agrupados[registro.estado]!.add(registro.temperaturaCelsius);
    }

    return agrupados.map((String estado, List<double> valores) {
      return MapEntry<String, double>(estado, _media(valores));
    });
  }

  Map<String, Map<int, double>> umidadeMediaPorEstadoEAno(
    List<RegistroClima> registros,
  ) {
    return _agruparNumericoPorEstadoEAno(
      registros: registros,
      extrairValor: (RegistroClima registro) => registro.umidade,
      calcular: _media,
    );
  }

  Map<String, Map<int, double>> umidadeMediaPorEstadoEMes(
    List<RegistroClima> registros,
  ) {
    return _agruparNumericoPorEstadoEMes(
      registros: registros,
      extrairValor: (RegistroClima registro) => registro.umidade,
      calcular: _media,
    );
  }

  Map<String, Map<int, double>> umidadeMaximaPorEstadoEAno(
    List<RegistroClima> registros,
  ) {
    return _agruparNumericoPorEstadoEAno(
      registros: registros,
      extrairValor: (RegistroClima registro) => registro.umidade,
      calcular: _maximo,
    );
  }

  Map<String, Map<int, double>> umidadeMaximaPorEstadoEMes(
    List<RegistroClima> registros,
  ) {
    return _agruparNumericoPorEstadoEMes(
      registros: registros,
      extrairValor: (RegistroClima registro) => registro.umidade,
      calcular: _maximo,
    );
  }

  Map<String, Map<int, double>> umidadeMinimaPorEstadoEAno(
    List<RegistroClima> registros,
  ) {
    return _agruparNumericoPorEstadoEAno(
      registros: registros,
      extrairValor: (RegistroClima registro) => registro.umidade,
      calcular: _minimo,
    );
  }

  Map<String, Map<int, double>> umidadeMinimaPorEstadoEMes(
    List<RegistroClima> registros,
  ) {
    return _agruparNumericoPorEstadoEMes(
      registros: registros,
      extrairValor: (RegistroClima registro) => registro.umidade,
      calcular: _minimo,
    );
  }

  Map<String, Map<int, String>> direcaoVentoModaPorEstadoEAno(
    List<RegistroClima> registros,
  ) {
    return _agruparModaPorEstadoEAno(registros);
  }

  Map<String, Map<int, String>> direcaoVentoModaPorEstadoEMes(
    List<RegistroClima> registros,
  ) {
    return _agruparModaPorEstadoEMes(registros);
  }

  Map<String, Map<int, double>> _agruparNumericoPorEstadoEAno({
    required List<RegistroClima> registros,
    required double? Function(RegistroClima registro) extrairValor,
    required double Function(List<double> valores) calcular,
  }) {
    final Map<String, Map<int, List<double>>> agrupados =
        <String, Map<int, List<double>>>{};

    for (final RegistroClima registro in registros) {
      final double? valor = extrairValor(registro);
      if (valor == null) {
        continue;
      }

      final String estado = registro.estado;
      final int ano = registro.ano;

      agrupados.putIfAbsent(estado, () => <int, List<double>>{});
      agrupados[estado]!.putIfAbsent(ano, () => <double>[]);
      agrupados[estado]![ano]!.add(valor);
    }

    return _converterAgrupamentoNumerico(agrupados, calcular);
  }

  Map<String, Map<int, double>> _agruparNumericoPorEstadoEMes({
    required List<RegistroClima> registros,
    required double? Function(RegistroClima registro) extrairValor,
    required double Function(List<double> valores) calcular,
  }) {
    final Map<String, Map<int, List<double>>> agrupados =
        <String, Map<int, List<double>>>{};

    for (final RegistroClima registro in registros) {
      final double? valor = extrairValor(registro);
      if (valor == null) {
        continue;
      }

      final String estado = registro.estado;
      final int mes = registro.mes;

      agrupados.putIfAbsent(estado, () => <int, List<double>>{});
      agrupados[estado]!.putIfAbsent(mes, () => <double>[]);
      agrupados[estado]![mes]!.add(valor);
    }

    return _converterAgrupamentoNumerico(agrupados, calcular);
  }

  Map<String, Map<int, String>> _agruparModaPorEstadoEAno(
    List<RegistroClima> registros,
  ) {
    final Map<String, Map<int, Map<String, int>>> contagem =
        <String, Map<int, Map<String, int>>>{};

    for (final RegistroClima registro in registros) {
      final String estado = registro.estado;
      final int ano = registro.ano;
      final String valor = registro.direcaoVentoGraus.toStringAsFixed(1);

      contagem.putIfAbsent(estado, () => <int, Map<String, int>>{});
      contagem[estado]!.putIfAbsent(ano, () => <String, int>{});
      contagem[estado]![ano]![valor] = (contagem[estado]![ano]![valor] ?? 0) + 1;
    }

    return _converterAgrupamentoModa(contagem);
  }

  Map<String, Map<int, String>> _agruparModaPorEstadoEMes(
    List<RegistroClima> registros,
  ) {
    final Map<String, Map<int, Map<String, int>>> contagem =
        <String, Map<int, Map<String, int>>>{};

    for (final RegistroClima registro in registros) {
      final String estado = registro.estado;
      final int mes = registro.mes;
      final String valor = registro.direcaoVentoGraus.toStringAsFixed(1);

      contagem.putIfAbsent(estado, () => <int, Map<String, int>>{});
      contagem[estado]!.putIfAbsent(mes, () => <String, int>{});
      contagem[estado]![mes]![valor] = (contagem[estado]![mes]![valor] ?? 0) + 1;
    }

    return _converterAgrupamentoModa(contagem);
  }

  Map<String, Map<int, double>> _converterAgrupamentoNumerico(
    Map<String, Map<int, List<double>>> agrupados,
    double Function(List<double> valores) calcular,
  ) {
    final Map<String, Map<int, double>> resultado = <String, Map<int, double>>{};

    for (final MapEntry<String, Map<int, List<double>>> entradaEstado in agrupados.entries) {
      final Map<int, double> porTempo = <int, double>{};

      for (final MapEntry<int, List<double>> entradaAgrupamento in entradaEstado.value.entries) {
        porTempo[entradaAgrupamento.key] = calcular(entradaAgrupamento.value);
      }

      resultado[entradaEstado.key] = porTempo;
    }

    return resultado;
  }

  Map<String, Map<int, String>> _converterAgrupamentoModa(
    Map<String, Map<int, Map<String, int>>> contagem,
  ) {
    final Map<String, Map<int, String>> resultado = <String, Map<int, String>>{};

    for (final MapEntry<String, Map<int, Map<String, int>>> entradaEstado in contagem.entries) {
      final Map<int, String> porTempo = <int, String>{};

      for (final MapEntry<int, Map<String, int>> entradaAgrupamento in entradaEstado.value.entries) {
        porTempo[entradaAgrupamento.key] = _moda(entradaAgrupamento.value);
      }

      resultado[entradaEstado.key] = porTempo;
    }

    return resultado;
  }

  double _media(List<double> valores) {
    if (valores.isEmpty) {
      return 0;
    }

    return valores.reduce((double soma, double valor) => soma + valor) /
        valores.length;
  }

  double _maximo(List<double> valores) {
    if (valores.isEmpty) {
      return 0;
    }

    return valores.reduce((double atual, double valor) => valor > atual ? valor : atual);
  }

  double _minimo(List<double> valores) {
    if (valores.isEmpty) {
      return 0;
    }

    return valores.reduce((double atual, double valor) => valor < atual ? valor : atual);
  }

  String _moda(Map<String, int> contagem) {
    return contagem.entries
        .reduce((MapEntry<String, int> atual, MapEntry<String, int> proximo) {
      return proximo.value > atual.value ? proximo : atual;
    }).key;
  }

  int? _parseHoraFaixa(String faixaHoraria) {
    final RegExpMatch? correspondencia = RegExp(r'(\d{1,2})').firstMatch(faixaHoraria);
    if (correspondencia == null) {
      return null;
    }

    return int.tryParse(correspondencia.group(1)!.padLeft(2, '0'));
  }

}