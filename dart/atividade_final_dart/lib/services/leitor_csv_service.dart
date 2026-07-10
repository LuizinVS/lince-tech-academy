import 'dart:convert';
import 'dart:io';

import '../models/registro_clima.dart';

class LeitorCsvService {
	static const String _diretorioBase = 'C:/CLIMA/SENSORES';
	static const String _mensagemSemArquivos =
			'Falha ao extrair informações, nenhum arquivo encontrado.';
	static const String _mensagemFalhaLeitura = 'Falha na leitura de um arquivo.';
	static const int _anoFixo = 2024;

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
					final _MetadadosArquivo metadados = _extrairMetadadosDoNome(arquivo.path);
					final String conteudo = await arquivo.readAsString(encoding: latin1);
					final List<String> linhas = conteudo.split(RegExp(r'\r?\n'));

					if (linhas.length <= 1) {
						continue;
					}

					for (final String linha in linhas.skip(1)) {
						if (linha.trim().isEmpty) {
							continue;
						}

						final List<String> colunas = linha
								.split(',')
								.map((String valor) => valor.trim())
								.toList();

						if (colunas.length != 8) {
							continue;
						}

						final int dia = int.parse(colunas[1]);
						final int hora = int.parse(colunas[2]);

						registros.add(
							RegistroClima.fromCsv(
								estado: metadados.estado,
								dataHora: DateTime(
									_anoFixo,
									metadados.mes,
									dia,
									hora,
								),
								temperaturaCelsius: double.parse(colunas[3].replaceAll(',', '.')),
								umidade: double.parse(colunas[4].replaceAll(',', '.')),
								velocidadeVentoMs: double.parse(colunas[6].replaceAll(',', '.')),
								direcaoVentoGraus: double.parse(colunas[7].replaceAll(',', '.')),
							),
						);
					}
				} catch (e, stackTrace) {
					print('Error: $e, $stackTrace');
					rethrow;
				}
			}

			return registros;
		} on FileSystemException {
			rethrow;
		} catch (e, stackTrace) {
			print('Error: $e, $stackTrace');
			rethrow;
		}
	}

	_MetadadosArquivo _extrairMetadadosDoNome(String caminhoArquivo) {
		final String nomeArquivo = caminhoArquivo.split(RegExp(r'[\\/]')).last;
		final List<String> partes = nomeArquivo.split('_');

		if (partes.length != 3) {
			throw FileSystemException(_mensagemFalhaLeitura, caminhoArquivo);
		}

		final String estado = partes[0].toUpperCase();
		final int ano = int.parse(partes[1]);
		final int mes = int.parse(partes[2].split('.').first);

		if (ano != _anoFixo || (estado != 'SP' && estado != 'SC')) {
			throw FileSystemException(_mensagemFalhaLeitura, caminhoArquivo);
		}

		return _MetadadosArquivo(estado: estado, mes: mes);
	}
}

class _MetadadosArquivo {
	const _MetadadosArquivo({
		required this.estado,
		required this.mes,
	});

	final String estado;
	final int mes;
}
