import 'dart:math';

enum GeneroMusical { rock, pop, jazz, samba, eletronica, sertanejo }

void main() {
  final random = Random();
  final generos = GeneroMusical.values;
  final generoEscolhido = generos[random.nextInt(generos.length)];

  print('Meu gênero musical preferido e o ${generoEscolhido.name}');
}