abstract class Animal {
  void comer();
  void beber();
}

class Cachorro extends Animal {
  @override
  void beber() {
    print('O animal esta bebendo.');
  }

  @override
  void comer() {
    print('O animal esta comendo.');
  }

  void latir() {
    print('O cachorro esta latindo.');
  }
}

void main() {
  final cachorro = Cachorro();

  cachorro.beber();
  cachorro.comer();
  cachorro.latir();
}