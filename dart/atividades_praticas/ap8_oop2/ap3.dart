abstract class Comestivel {
  void comer();
}

abstract class Dorminhoco {
  void dormir();
}

class Camelo implements Comestivel, Dorminhoco {
  @override
  void comer() {
    print('O camelo esta comendo.');
  }

  @override
  void dormir() {
    print('O camelo esta dormindo.');
  }
}

void main() {
  final camelo = Camelo();

  camelo.comer();
  camelo.dormir();
}