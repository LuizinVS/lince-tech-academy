void main(){
  final String finalNome = 'Dart final';
  const constNome = 'Dart const';
  // nao podem ser modificadas depois de atribuidas

  final valor = getValor();
}

getValor() => "dart 10";

// podemos alterar o valor usando metodo, a variavel recebe o valor que esta contido no metodo, nao conhecendo o valor;
// const tem que conhecer o valor assim que inicia