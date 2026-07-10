void main(){

  double resultado = _getValorTotal(); //função custosa pois retorna algo nao utilizado
  //inicia por esse metodo, linha por linha

  print(_getValorTotal());
}

double _getValorTotal(){
  //chama essa função mesmo sem utilizar o retorno dela, por default
  return 100.0;
}