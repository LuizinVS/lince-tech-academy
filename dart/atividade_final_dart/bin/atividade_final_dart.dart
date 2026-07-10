import 'dart:io';

import 'package:yaansi/yaansi.dart';

import 'package:atividade_final_dart/models/registro_clima.dart';
import 'package:atividade_final_dart/services/leitor_csv_service.dart';
import 'package:atividade_final_dart/services/processador_service.dart';
import 'package:atividade_final_dart/utils/conversores.dart';

Future<void> main(List<String> arguments) async {
  try {
    print(
      'OLÁ, LEANDRO. QUE RELATÓRIO VOCÊ PRECISA?\n1 - TEMPERATURA\n2 - UMIDADE\n3 - DIREÇÃO DO VENTO',
    );
    stdout.write('DIGITE O NÚMERO DA OPÇÃO DESEJADA: ');

    final String? respostaOpcao = stdin.readLineSync();
    final int? opcaoSelecionada = int.tryParse(respostaOpcao?.trim() ?? '');

    if (opcaoSelecionada == null ||
        opcaoSelecionada < 1 ||
        opcaoSelecionada > 3) {
      print('Opção inválida.');
      return;
    }

    final LeitorCsvService leitorCsvService = LeitorCsvService();
    final List<RegistroClima> registros = await leitorCsvService
        .carregarDados();

    if (registros.isEmpty) {
      print('Nenhum registro foi encontrado para processar.');
      return;
    }

    final ProcessadorService processadorService = ProcessadorService(
      indiceTemperatura: 0,
      indiceUmidade: 1,
      indiceDirecaoVento: 2,
      indiceFaixaHoraria: 3,
    );

    String relatorioTexto;
    String nomeBaseArquivo;

    switch (opcaoSelecionada) {
      case 1:
        stdout.write('DIGITE A FAIXA HORÁRIA DESEJADA (OU ENTER PARA PULAR): ');
        final String faixaHoraria = stdin.readLineSync()?.trim() ?? '';
        relatorioTexto = _montarRelatorioTemperatura(
          processadorService,
          registros,
          faixaHoraria.isEmpty ? null : faixaHoraria,
        );
        nomeBaseArquivo = 'CLIMA';
        print(_colorirRelatorioTemperatura(relatorioTexto));
        break;
      case 2:
        relatorioTexto = _montarRelatorioUmidade(processadorService, registros);
        nomeBaseArquivo = 'UMIDADE';
        print(_colorirRelatorioUmidade(relatorioTexto));
        break;
      case 3:
        relatorioTexto = _montarRelatorioVento(processadorService, registros);
        nomeBaseArquivo = 'VENTO';
        print(_colorirRelatorioVento(relatorioTexto));
        break;
      default:
        print('Opção inválida.');
        return;
    }

    stdout.write('DESEJA SALVAR O RELATÓRIO EM ARQUIVO TXT? (S/N): ');
    final String respostaSalvar =
        stdin.readLineSync()?.trim().toUpperCase() ?? 'N';

    if (respostaSalvar == 'S') {
      final String nomeArquivo =
          '${nomeBaseArquivo}_${_formatarDataHora(DateTime.now())}.TXT';
      final File arquivo = File(
        '${Directory.current.path}${Platform.pathSeparator}$nomeArquivo',
      );
      await arquivo.writeAsString(relatorioTexto);
      print('Relatório salvo em ${arquivo.path}');
    }
  } on FileSystemException catch (erro) {
    print(erro.message);
  } catch (_) {
    print('Falha ao processar o relatório.');
  }
}

String _montarRelatorioTemperatura(
  ProcessadorService processadorService,
  List<RegistroClima> registros,
  String? faixaHoraria,
) {
  final Map<String, Map<int, double>> mediasCelsius = processadorService
      .temperaturaMediaPorEstadoEAno(registros);
  final Map<String, Map<int, double>> mediasCelsiusMes = processadorService
      .temperaturaMediaPorEstadoEMes(registros);
  final Map<String, Map<int, double>> maximasCelsius = processadorService
      .temperaturaMaximaPorEstadoEAno(registros);
  final Map<String, Map<int, double>> maximasCelsiusMes = processadorService
      .temperaturaMaximaPorEstadoEMes(registros);
  final Map<String, Map<int, double>> minimasCelsius = processadorService
      .temperaturaMinimaPorEstadoEAno(registros);
  final Map<String, Map<int, double>> minimasCelsiusMes = processadorService
      .temperaturaMinimaPorEstadoEMes(registros);
  final Map<String, double> mediaFaixaHoraria = faixaHoraria == null
      ? <String, double>{}
      : processadorService.temperaturaMediaPorFaixaHoraria(
          registros,
          faixaHoraria,
        );

  final Map<String, Map<int, double>> mediasFahrenheit =
      _converterMapaDuploNumerico(
        mediasCelsius,
        Conversores.celsiusParaFahrenheit,
      );
  final Map<String, Map<int, double>> mediasFahrenheitMes =
      _converterMapaDuploNumerico(
        mediasCelsiusMes,
        Conversores.celsiusParaFahrenheit,
      );
  final Map<String, Map<int, double>> maximasFahrenheit =
      _converterMapaDuploNumerico(
        maximasCelsius,
        Conversores.celsiusParaFahrenheit,
      );
  final Map<String, Map<int, double>> maximasFahrenheitMes =
      _converterMapaDuploNumerico(
        maximasCelsiusMes,
        Conversores.celsiusParaFahrenheit,
      );
  final Map<String, Map<int, double>> minimasFahrenheit =
      _converterMapaDuploNumerico(
        minimasCelsius,
        Conversores.celsiusParaFahrenheit,
      );
  final Map<String, Map<int, double>> minimasFahrenheitMes =
      _converterMapaDuploNumerico(
        minimasCelsiusMes,
        Conversores.celsiusParaFahrenheit,
      );
  final Map<String, Map<int, double>> mediasKelvin =
      _converterMapaDuploNumerico(mediasCelsius, Conversores.celsiusParaKelvin);
  final Map<String, Map<int, double>> mediasKelvinMes =
      _converterMapaDuploNumerico(
        mediasCelsiusMes,
        Conversores.celsiusParaKelvin,
      );
  final Map<String, Map<int, double>> maximasKelvin =
      _converterMapaDuploNumerico(
        maximasCelsius,
        Conversores.celsiusParaKelvin,
      );
  final Map<String, Map<int, double>> maximasKelvinMes =
      _converterMapaDuploNumerico(
        maximasCelsiusMes,
        Conversores.celsiusParaKelvin,
      );
  final Map<String, Map<int, double>> minimasKelvin =
      _converterMapaDuploNumerico(
        minimasCelsius,
        Conversores.celsiusParaKelvin,
      );
  final Map<String, Map<int, double>> minimasKelvinMes =
      _converterMapaDuploNumerico(
        minimasCelsiusMes,
        Conversores.celsiusParaKelvin,
      );
  final Map<String, double> faixaHorariaTexto = faixaHoraria == null
      ? <String, double>{}
      : mediaFaixaHoraria;

  return [
    'RELATÓRIO DE TEMPERATURA',
    '',
    _formatarMapaDuploNumerico('MÉDIA POR ESTADO/ANO - CELSIUS', mediasCelsius),
    _formatarMapaDuploNumerico(
      'MÉDIA POR ESTADO/MÊS - CELSIUS',
      mediasCelsiusMes,
    ),
    _formatarMapaDuploNumerico(
      'MÁXIMA POR ESTADO/ANO - CELSIUS',
      maximasCelsius,
    ),
    _formatarMapaDuploNumerico(
      'MÁXIMA POR ESTADO/MÊS - CELSIUS',
      maximasCelsiusMes,
    ),
    _formatarMapaDuploNumerico(
      'MÍNIMA POR ESTADO/ANO - CELSIUS',
      minimasCelsius,
    ),
    _formatarMapaDuploNumerico(
      'MÍNIMA POR ESTADO/MÊS - CELSIUS',
      minimasCelsiusMes,
    ),
    if (faixaHorariaTexto.isNotEmpty)
      _formatarMapaSimples('MÉDIA POR FAIXA HORÁRIA', faixaHorariaTexto),
    '',
    _formatarMapaDuploNumerico(
      'MÉDIA POR ESTADO/ANO - FAHRENHEIT',
      mediasFahrenheit,
    ),
    _formatarMapaDuploNumerico(
      'MÉDIA POR ESTADO/MÊS - FAHRENHEIT',
      mediasFahrenheitMes,
    ),
    _formatarMapaDuploNumerico(
      'MÁXIMA POR ESTADO/ANO - FAHRENHEIT',
      maximasFahrenheit,
    ),
    _formatarMapaDuploNumerico(
      'MÁXIMA POR ESTADO/MÊS - FAHRENHEIT',
      maximasFahrenheitMes,
    ),
    _formatarMapaDuploNumerico(
      'MÍNIMA POR ESTADO/ANO - FAHRENHEIT',
      minimasFahrenheit,
    ),
    _formatarMapaDuploNumerico(
      'MÍNIMA POR ESTADO/MÊS - FAHRENHEIT',
      minimasFahrenheitMes,
    ),
    '',
    _formatarMapaDuploNumerico('MÉDIA POR ESTADO/ANO - KELVIN', mediasKelvin),
    _formatarMapaDuploNumerico(
      'MÉDIA POR ESTADO/MÊS - KELVIN',
      mediasKelvinMes,
    ),
    _formatarMapaDuploNumerico('MÁXIMA POR ESTADO/ANO - KELVIN', maximasKelvin),
    _formatarMapaDuploNumerico(
      'MÁXIMA POR ESTADO/MÊS - KELVIN',
      maximasKelvinMes,
    ),
    _formatarMapaDuploNumerico('MÍNIMA POR ESTADO/ANO - KELVIN', minimasKelvin),
    _formatarMapaDuploNumerico(
      'MÍNIMA POR ESTADO/MÊS - KELVIN',
      minimasKelvinMes,
    ),
  ].where((String secao) => secao.trim().isNotEmpty).join('\n');
}

String _montarRelatorioUmidade(
  ProcessadorService processadorService,
  List<RegistroClima> registros,
) {
  final Map<String, Map<int, double>> mediasAno = processadorService
      .umidadeMediaPorEstadoEAno(registros);
  final Map<String, Map<int, double>> mediasMes = processadorService
      .umidadeMediaPorEstadoEMes(registros);
  final Map<String, Map<int, double>> maximasAno = processadorService
      .umidadeMaximaPorEstadoEAno(registros);
  final Map<String, Map<int, double>> maximasMes = processadorService
      .umidadeMaximaPorEstadoEMes(registros);
  final Map<String, Map<int, double>> minimasAno = processadorService
      .umidadeMinimaPorEstadoEAno(registros);
  final Map<String, Map<int, double>> minimasMes = processadorService
      .umidadeMinimaPorEstadoEMes(registros);

  return [
    'RELATÓRIO DE UMIDADE',
    '',
    _formatarMapaDuploNumerico('MÉDIA POR ESTADO/ANO', mediasAno),
    _formatarMapaDuploNumerico('MÉDIA POR ESTADO/MÊS', mediasMes),
    _formatarMapaDuploNumerico('MÁXIMA POR ESTADO/ANO', maximasAno),
    _formatarMapaDuploNumerico('MÁXIMA POR ESTADO/MÊS', maximasMes),
    _formatarMapaDuploNumerico('MÍNIMA POR ESTADO/ANO', minimasAno),
    _formatarMapaDuploNumerico('MÍNIMA POR ESTADO/MÊS', minimasMes),
  ].join('\n');
}

String _montarRelatorioVento(
  ProcessadorService processadorService,
  List<RegistroClima> registros,
) {
  final Map<String, Map<int, String>> modaAno = processadorService
      .direcaoVentoModaPorEstadoEAno(registros);
  final Map<String, Map<int, String>> modaMes = processadorService
      .direcaoVentoModaPorEstadoEMes(registros);

  return [
    'RELATÓRIO DE DIREÇÃO DO VENTO',
    '',
    _formatarMapaDuploTexto('MODA POR ESTADO/ANO', modaAno),
    _formatarMapaDuploTexto('MODA POR ESTADO/MÊS', modaMes),
  ].join('\n');
}

String _formatarMapaDuploNumerico(
  String titulo,
  Map<String, Map<int, double>> dados,
) {
  final StringBuffer buffer = StringBuffer();
  buffer.writeln(titulo);

  if (dados.isEmpty) {
    buffer.writeln('  SEM DADOS');
    return buffer.toString().trimRight();
  }

  for (final MapEntry<String, Map<int, double>> entradaEstado
      in dados.entries) {
    buffer.writeln('  ${entradaEstado.key}');
    for (final MapEntry<int, double> entradaValor
        in entradaEstado.value.entries) {
      buffer.writeln(
        '    ${entradaValor.key}: ${entradaValor.value.toStringAsFixed(2)}',
      );
    }
  }

  return buffer.toString().trimRight();
}

String _formatarMapaSimples(String titulo, Map<String, double> dados) {
  final StringBuffer buffer = StringBuffer();
  buffer.writeln(titulo);

  if (dados.isEmpty) {
    buffer.writeln('  SEM DADOS');
    return buffer.toString().trimRight();
  }

  for (final MapEntry<String, double> entrada in dados.entries) {
    buffer.writeln('  ${entrada.key}: ${entrada.value.toStringAsFixed(2)}');
  }

  return buffer.toString().trimRight();
}

String _formatarMapaDuploTexto(
  String titulo,
  Map<String, Map<int, String>> dados,
) {
  final StringBuffer buffer = StringBuffer();
  buffer.writeln(titulo);

  if (dados.isEmpty) {
    buffer.writeln('  SEM DADOS');
    return buffer.toString().trimRight();
  }

  for (final MapEntry<String, Map<int, String>> entradaEstado
      in dados.entries) {
    buffer.writeln('  ${entradaEstado.key}');
    for (final MapEntry<int, String> entradaValor
        in entradaEstado.value.entries) {
      buffer.writeln('    ${entradaValor.key}: ${entradaValor.value}');
    }
  }

  return buffer.toString().trimRight();
}

Map<String, Map<int, double>> _converterMapaDuploNumerico(
  Map<String, Map<int, double>> dados,
  double Function(double valor) conversor,
) {
  final Map<String, Map<int, double>> resultado = <String, Map<int, double>>{};

  for (final MapEntry<String, Map<int, double>> entradaEstado
      in dados.entries) {
    resultado[entradaEstado.key] = <int, double>{};
    for (final MapEntry<int, double> entradaValor
        in entradaEstado.value.entries) {
      resultado[entradaEstado.key]![entradaValor.key] = conversor(
        entradaValor.value,
      );
    }
  }

  return resultado;
}

String _colorirRelatorioTemperatura(String relatorio) {
  String Function(String)? corAtual;

  return relatorio
      .split('\n')
      .map((String linha) {
        if (linha.contains('CELSIUS')) {
          corAtual = red;
          return corAtual!(linha);
        }

        if (linha.contains('FAHRENHEIT')) {
          corAtual = yellow;
          return corAtual!(linha);
        }

        if (linha.contains('KELVIN')) {
          corAtual = blue;
          return corAtual!(linha);
        }

        if (corAtual != null &&
            linha.trim().isNotEmpty &&
            linha != 'RELATÓRIO DE TEMPERATURA') {
          return corAtual!(linha);
        }

        return linha;
      })
      .join('\n');
}

String _colorirRelatorioUmidade(String relatorio) {
  String Function(String)? corAtual;

  return relatorio
      .split('\n')
      .map((String linha) {
        final String conteudo = linha.trimLeft();

        if (conteudo.startsWith('MÉDIA')) {
          corAtual = green;
          return corAtual!(linha);
        }

        if (conteudo.startsWith('MÁXIMA')) {
          corAtual = red;
          return corAtual!(linha);
        }

        if (conteudo.startsWith('MÍNIMA')) {
          corAtual = blue;
          return corAtual!(linha);
        }

        if (corAtual != null &&
            linha.trim().isNotEmpty &&
            linha != 'RELATÓRIO DE UMIDADE') {
          return corAtual!(linha);
        }

        return linha;
      })
      .join('\n');
}

String _colorirRelatorioVento(String relatorio) {
  return yellow(relatorio);
}

String _formatarDataHora(DateTime dataHora) {
  String doisDigitos(int valor) => valor.toString().padLeft(2, '0');

  return '${dataHora.year}${doisDigitos(dataHora.month)}${doisDigitos(dataHora.day)}_${doisDigitos(dataHora.hour)}${doisDigitos(dataHora.minute)}${doisDigitos(dataHora.second)}';
}
