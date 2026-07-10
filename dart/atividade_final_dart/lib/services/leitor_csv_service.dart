import 'dart:io';

import '../models/registro_clima.dart';

class LeitorCsvService {
	static const String _diretorioBase = 'C:/CLIMA/SENSORES';
	static const String _mensagemSemArquivos =
			'Falha ao extrair informações, nenhum arquivo encontrado.';
	static const String _mensagemFalhaLeitura = 'Falha na leitura de um arquivo.';

	Future<List<RegistroClima>> carregarDados() async {
		final Directory diretorio = Directory(_diretorioBase);

		try {
			if (!await diretorio.exists()) {
				throw FileSystemException(_mensagemSemArquivos, diretorio.path);
			}

			final List<FileSystemEntity> entidades = await diretorio
					.list(followLinks: false)
					.where((FileSystemEntity entidade) =>
							entidade is File && entidade.path.toLowerCase().endsWith('.csv'))
					.toList();

			if (entidades.isEmpty) {
				throw FileSystemException(_mensagemSemArquivos, diretorio.path);
			}

			final List<RegistroClima> registros = <RegistroClima>[];

			for (final FileSystemEntity entidade in entidades) {
				try {
					final File arquivo = entidade as File;
					final String estado = _extrairEstadoDoNome(arquivo.path);
					final List<String> linhas = await arquivo.readAsLines();

					if (linhas.length <= 1) {
						continue;
					}

					for (final String linha in linhas.skip(1)) {
						if (linha.trim().isEmpty) {
							continue;
						}

						final List<String> colunas = linha.split(',').map((String valor) => valor.trim()).toList();
						if (colunas.length != 5) {
							continue;
						}

						registros.add(
							RegistroClima.fromCsv(
								estado: estado,
								dataHora: DateTime.parse(colunas[0]),
								temperaturaCelsius: double.parse(colunas[1].replaceAll(',', '.')),
								umidade: double.parse(colunas[2].replaceAll(',', '.')),
								velocidadeVentoMs: double.parse(colunas[3].replaceAll(',', '.')),
								direcaoVentoGraus: double.parse(colunas[4].replaceAll(',', '.')),
							),
						);
					}
				} catch (_) {
          throw FileSystemException(_mensagemFalhaLeitura, diretorio.path);
				}
			}

			return registros;
		} on FileSystemException {
			rethrow;
		} catch (_) {
      throw FileSystemException(_mensagemFalhaLeitura, diretorio.path);
		}
	}

	String _extrairEstadoDoNome(String caminhoArquivo) {
		final String nomeArquivo = caminhoArquivo.split(RegExp(r'[\\/]')).last;
		final RegExp expressao = RegExp(
			r'^(SP|SC)_\d{4}_\d{2}\.csv$',
			caseSensitive: false,
		);
		final RegExpMatch? correspondencia = expressao.firstMatch(nomeArquivo);

    if (correspondencia == null) {
			throw FileSystemException(_mensagemFalhaLeitura, caminhoArquivo);
    }

		return correspondencia.group(1)!.toUpperCase();
  }
}
