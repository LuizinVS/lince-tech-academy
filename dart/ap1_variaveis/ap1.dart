void main() {
   var nome = 'Luiz Vinicius';
   var sobrenome = 'Marcelo Mariath';
   var idade = 21;
   var ativo = true;
   var peso = 88.00;
   var nacionalidade = 'Brasileiro';

   print("Nome completo : $nome $sobrenome");
   print("Idade: $idade (${idade >= 18 ? "maior de idade" : "menor de idade"})");
   print("Situação: ${ativo == true ? "Ativo" : "Inativo"}");
   print("Peso: $peso");
   print("Nacionalidade: ${nacionalidade.isNotEmpty ? nacionalidade : "Não informada"}");
}