class ContaBancaria {
  final String titular;
  double saldo;

  ContaBancaria(this.titular, {this.saldo = 0});

  void depositar(double valor) {
    saldo += valor;
  }

  void sacar(double valor) {
    saldo -= valor;
  }

  void imprimirSaldo() {
    print('Saldo atual: ${saldo.toStringAsFixed(2)}');
  }
}

void main() {
  final conta = ContaBancaria('Fernanda', saldo: 5000);

  conta.depositar(4999.99);
  conta.sacar(0);

  conta.imprimirSaldo();
}