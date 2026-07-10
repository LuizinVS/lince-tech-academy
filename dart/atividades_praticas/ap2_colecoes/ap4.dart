void main() {
  final Map<String, List<String>> cidadesPorEstado = {
    'SC': ['Gaspar', 'Blumenau', 'Florianopolis'],
    'PR': ['Curitiba', 'Cascavel', 'Foz do Iguaçu'],
    'SP': ['Sao Paulo', 'Guarulhos', 'Campinas'],
    'MG': ['Belo Horizonte', 'Juiz de Fora', 'Berlinda'],
  };

  print('Estados: ${cidadesPorEstado.keys.join(' ; ')}');

  final List<String> cidadesSC = List.of(cidadesPorEstado['SC']!)..sort();
  print('Cidades de SC: ${cidadesSC.join(' ; ')}');

  final List<MapEntry<String, String>> todasCidades = [];
  for (final entrada in cidadesPorEstado.entries) {
    for (final cidade in entrada.value) {
      todasCidades.add(MapEntry(cidade, entrada.key));
    }
  }

  todasCidades.sort((a, b) => a.key.compareTo(b.key));

  for (final par in todasCidades) {
    print('${par.key} - ${par.value}');
  }
}