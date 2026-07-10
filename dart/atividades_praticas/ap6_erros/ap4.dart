abstract class Arquivo {
  void abrir();
}

class ArquivoTexto implements Arquivo {
  final String _nome;

  ArquivoTexto(this._nome);

  @override
  void abrir() {
    try {
      simularLeituraDoArquivo(_nome);
      print('Arquivo $_nome aberto com sucesso');
    } catch (e) {
      throw Exception('Erro ao abrir o arquivo $_nome');
    }
  }
}

void simularLeituraDoArquivo(String nome) {
  if (nome.isEmpty) {
    throw Exception('Arquivo nao encontrado');
  }
}

String lerNomeArquivo() {
  return 'documento.txt';
}

void main() {
  try {
    late final String nomeArquivo;

    try {
      nomeArquivo = lerNomeArquivo();
    } catch (e) {
      print('Entrada invalida. Digite um nome valido.');
      return;
    }

    final arquivo = ArquivoTexto(nomeArquivo);

    try {
      arquivo.abrir();
    } catch (e) {
      rethrow;
    }
  } finally {
    print('Fim do programa');
  }
}