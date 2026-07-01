Me traga um exemplo do uso do método split() em dart.
 
 IA: 

    Método split() em Dart
    O método split() divide uma String em uma lista de substrings, com base em um separador informado.
    Exemplo básico
    dartvoid main() {
    String frase = "Dart é uma linguagem incrível";
    
    List<String> palavras = frase.split(' ');
    
    print(palavras);
    // Saída: [Dart, é, uma, linguagem, incrível]
    }
    Outros exemplos úteis
    Dividindo por vírgula (ex: CSV):
    dartString dados = "maçã,banana,laranja";
    List<String> frutas = dados.split(',');
    print(frutas); // [maçã, banana, laranja]
    Dividindo por múltiplos caracteres:
    dartString texto = "um--dois--tres";
    List<String> partes = texto.split('--');
    print(partes); // [um, dois, tres]
    Dividindo usando expressão regular (RegExp):
    dartString texto = "um, dois,   tres,quatro";
    List<String> partes = texto.split(RegExp(r',\s*'));
    print(partes); // [um, dois, tres, quatro]
    Separando cada caractere (string vazia como separador):
    dartString palavra = "Dart";
    List<String> letras = palavra.split('');
    print(letras); // [D, a, r, t]
    Observação
    Se o separador não for encontrado na string, split() retorna uma lista contendo a string original inteira:
    dartString s = "olá mundo";
    print(s.split(',')); // [olá mundo]

Quais as boas práticas em dart declarando variáveis? 

    IA: 

        Boas práticas para declarar variáveis em Dart

        Prefira final sempre que possível

        Se a variável não vai ser reatribuída, use final. Isso deixa o código mais previsível e evita bugs por mutação acidental.
        final nome = "Maria";
        final idade = 30;

        Use const para valores conhecidos em tempo de compilação

        const é ainda mais restritivo que final, o valor precisa ser constante desde a compilação. Ideal para valores fixos, como configurações ou widgets imutáveis no Flutter.
        const pi = 3.14159;
        const corPrimaria = Color(0xFF2196F3);

        Evite var quando não for necessário

        var é útil, mas seu uso indiscriminado pode deixar o código menos claro sobre a intenção. Prefira final quando o valor não muda, e var quando ele pode mudar ao longo do tempo.
        var contador = 0;
        contador++;

        Deixe o Dart inferir o tipo quando for óbvio

        O Dart tem inferência de tipos forte, então não é necessário declarar tipos redundantes.
        Redundante: final String nome = "João";
        Mais idiomático: final nome = "João";
        Mas declare o tipo explicitamente quando isso melhora a legibilidade, especialmente em parâmetros de função ou quando o valor não é óbvio.
        List<int> numeros = [];
        Map<String, dynamic> config = {};

        Use late com cautela

        late adia a inicialização, mas pode causar erro em tempo de execução se a variável for acessada antes de ser definida. Use só quando tiver certeza da inicialização.
        late String token;
        void iniciar() {
        token = "abc123";
        }

        Nomeie variáveis em lowerCamelCase

        Dart segue lowerCamelCase para variáveis e métodos, e UpperCamelCase para classes.
        Correto: quantidadeDeItens
        Evite: qtd_itens ou QuantidadeDeItens

        Evite variáveis globais mutáveis

        Prefira encapsular estado dentro de classes, funções ou providers, evitando efeitos colaterais difíceis de rastrear.

        Use nullable (?) só quando o valor realmente pode ser nulo

        O Dart tem null safety, então só declare tipos anuláveis quando fizer sentido semântico.
        String? apelido;
        String nome = "Ana";