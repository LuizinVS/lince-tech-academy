# Interação com IA - Orientação a Objetos parte 2

## O que significa 'sobrescrever' um método em Dart e por que eu faria isso?

**Estudante:** O que significa 'sobrescrever' um método em Dart e por que eu faria isso?

**IA:** Sobrescrever (ou "override") um método significa **redefinir, em uma subclasse, um comportamento que já existe em uma classe pai**, dando uma implementação diferente (e mais específica) para aquele método.

Você faria isso quando:

- A **implementação padrão** herdada da classe pai **não é adequada** para aquela subclasse específica.
- Você quer que **objetos de tipos diferentes respondam de formas diferentes** à mesma chamada de método — esse é justamente o conceito de **polimorfismo**, que mencionamos antes.

Em Dart, é uma boa prática usar a anotação **`@override`** acima do método sobrescrito. Ela não é obrigatória para o código funcionar, mas ajuda o compilador (e quem está lendo o código) a confirmar que aquele método realmente está sobrescrevendo algo da classe pai — e alerta caso você cometa um erro de digitação no nome do método.

Exemplo:

```dart
class Animal {
  void emitirSom() {
    print('Som genérico de animal');
  }
}

class Cachorro extends Animal {
  @override
  void emitirSom() {
    print('Au au!');
  }
}
```

**Observações:**
Ficou claro que sobrescrever não é "duplicar" o método, mas sim substituir o comportamento herdado por algo mais específico daquela subclasse. Ainda tenho dúvida sobre o que acontece exatamente se eu esquecer o `@override` — se o código ainda funciona normalmente ou se isso muda algo. Pretendo criar uma hierarquia simples de classes só para praticar sobrescrever um método e comparar o comportamento antes e depois.

---

## Como posso chamar o método original de uma classe pai em um método sobrescrito?

**Estudante:** Como posso chamar o método original de uma classe pai em um método sobrescrito?

**IA:** Para isso, o Dart oferece a palavra-chave **`super`**, que permite acessar membros (métodos ou atributos) da classe pai a partir da subclasse. Isso é útil quando você quer **complementar** o comportamento original, em vez de substituí-lo completamente.

Um cenário comum: o método sobrescrito faz uma ação adicional, mas ainda quer aproveitar parte da lógica já implementada na classe pai, evitando duplicar código.

Exemplo:

```dart
class Animal {
  void emitirSom() {
    print('Som genérico de animal');
  }
}

class Cachorro extends Animal {
  @override
  void emitirSom() {
    super.emitirSom(); // chama o comportamento original da classe pai
    print('Au au!');
  }
}
```

Um cuidado importante: **use `super` apenas quando realmente quer combinar os dois comportamentos.** Se a subclasse deve ter um comportamento completamente diferente do pai, não há necessidade de chamar `super` dentro do método sobrescrito.

**Observações:**
Entendi bem o papel do `super` para complementar (e não apenas substituir) o comportamento herdado, o que evita duplicar lógica que já existe na classe pai. Ainda tenho dúvida sobre a ordem ideal de chamar `super` — antes ou depois da lógica nova — e se isso muda dependendo do contexto. Pretendo testar chamar `super` em posições diferentes dentro do método sobrescrito para ver como isso afeta a ordem da saída no console.

---

## Como posso criar um getter para acessar um atributo privado de uma classe?

**Estudante:** Como posso criar um getter para acessar um atributo privado de uma classe?

**IA:** Um **getter** é um método especial que permite **ler o valor de um atributo** através de uma sintaxe parecida com o acesso direto a uma propriedade, mesmo que o valor real esteja armazenado em um atributo privado (com underline `_`).

Em Dart, você declara um getter usando a palavra-chave **`get`**, seguida do nome que será usado para acessá-lo (sem parênteses na hora de usar, diferente de um método comum).

Isso é útil para **expor um valor de leitura** sem permitir alteração direta do atributo de fora da classe, mantendo o controle sobre como (e se) aquele valor pode ser modificado.

Exemplo:

```dart
class ContaBancaria {
  double _saldo;

  ContaBancaria(this._saldo);

  double get saldo => _saldo; // getter
}

void main() {
  var conta = ContaBancaria(100);
  print(conta.saldo); // acessa como propriedade, sem parênteses
}
```

**Observações:**
Ficou claro que um getter permite acessar um valor privado "como se fosse" um atributo público, sem parênteses na chamada, o que achei uma sintaxe interessante. Ainda tenho dúvida sobre quando um getter poderia fazer algum cálculo extra além de simplesmente retornar o valor armazenado. Pretendo criar um getter simples que retorne um valor calculado (não apenas o atributo puro) para entender melhor essa flexibilidade.

---

## Em quais situações é melhor usar getters e setters em vez de acessar atributos diretamente?

**Estudante:** Em quais situações é melhor usar getters e setters em vez de acessar atributos diretamente?

**IA:** Getters e setters (métodos de leitura e escrita, respectivamente) são especialmente úteis quando você precisa de **algum controle sobre o acesso** a um atributo, algo que o acesso direto não oferece. Algumas situações comuns:

- **Validar valores antes de atribuí-los**, usando um `setter` para garantir que o dado seja válido antes de efetivamente alterar o atributo interno.
- **Calcular um valor derivado**, usando um `getter` que retorna algo baseado em outros atributos, sem a necessidade de armazenar esse valor calculado separadamente.
- **Proteger o estado interno do objeto**, permitindo leitura mas não escrita direta (um `getter` sem `setter` correspondente), ou vice-versa, dependendo da necessidade.
- **Manter compatibilidade**, permitindo mudar a forma como o dado é armazenado internamente, sem afetar quem já usa aquele atributo de fora da classe (já que a "interface pública" continua igual).

Um cuidado importante: **não crie getters e setters "vazios" só por padrão**, sem necessidade real, quando um atributo público simples já resolveria bem a situação — isso adicionaria complexidade desnecessária ao código.

Exemplo:

```dart
class Produto {
  double _preco;

  Produto(this._preco);

  double get preco => _preco;

  set preco(double novoPreco) {
    if (novoPreco < 0) {
      throw ArgumentError('Preço não pode ser negativo');
    }
    _preco = novoPreco;
  }
}
```

**Observações:**
Ficou bem claro o papel do `setter` em validar dados antes de realmente alterar o atributo interno, algo que o acesso direto não permitiria fazer. Ainda tenho dúvida sobre quando realmente vale a pena criar esse controle, versus quando estou "engessando" o código sem necessidade real. Pretendo revisar classes simples que eu já criei para ver se algum atributo público faria mais sentido como um par de getter/setter.

---

## O que é uma 'classe abstrata' e como ela difere de uma classe normal?

**Estudante:** O que é uma 'classe abstrata' e como ela difere de uma classe normal?

**IA:** Uma **classe abstrata** é uma classe que **não pode ser instanciada diretamente** — ou seja, você não pode fazer `MinhaClasseAbstrata()` para criar um objeto dela diretamente. Ela serve como uma **base** para outras classes, definindo uma estrutura comum que as subclasses devem seguir.

Principais diferenças em relação a uma classe normal:

- É declarada com a palavra-chave **`abstract`** antes de `class`.
- Pode conter **métodos sem implementação** (chamados de métodos abstratos), que **obrigam** as subclasses a fornecerem sua própria implementação.
- Também pode conter métodos **com implementação completa**, que serão herdados normalmente pelas subclasses, assim como em uma herança comum.

Uma boa prática é usar classes abstratas quando você quer **garantir que certas subclasses implementem determinados métodos**, sem se preocupar com uma implementação genérica que não faria sentido na classe base.

Exemplo:

```dart
abstract class Forma {
  double calcularArea(); // método abstrato, sem implementação

  void exibirDescricao() {
    print('Esta forma tem área de ${calcularArea()}'); // método concreto
  }
}

class Quadrado extends Forma {
  double lado;
  Quadrado(this.lado);

  @override
  double calcularArea() => lado * lado;
}
```

**Observações:**
Ficou claro que uma classe abstrata pode misturar métodos totalmente abertos (abstratos) com métodos já implementados, o que achei interessante. Ainda tenho dúvida sobre quantos métodos abstratos seria razoável ter em uma única classe base antes de ficar difícil de implementar em todas as subclasses. Pretendo criar uma classe abstrata simples com um método abstrato e um método concreto, só para fixar essa combinação.

---

## Quando devo usar classes abstratas em vez de classes concretas?

**Estudante:** Quando devo usar classes abstratas em vez de classes concretas?

**IA:** Boa pergunta de continuidade! A escolha depende principalmente de **se aquela classe faz sentido existir sozinha, como um objeto completo**, ou se ela serve apenas como uma **base conceitual** para outras classes mais específicas.

Use uma **classe abstrata** quando:

- A classe representa um **conceito genérico** que só faz sentido através de suas subclasses mais específicas (por exemplo, "Forma Geométrica" sozinha não tem uma área definida, mas "Quadrado" e "Círculo" têm).
- Você quer **garantir um contrato mínimo** de comportamento entre várias subclasses relacionadas, obrigando-as a implementar certos métodos.

Use uma **classe concreta** (normal) quando:

- Ela representa algo que **faz sentido existir por si só**, sem depender de ser especializada por outra classe.
- Não há necessidade de forçar múltiplas implementações diferentes daquele comportamento.

Um cuidado importante: **evite criar classes abstratas "por precaução"**, sem uma necessidade real de múltiplas implementações — isso pode adicionar complexidade desnecessária a um design que poderia ser mais simples.

Exemplo (comparação conceitual):

```dart
// Faz sentido como classe abstrata: conceito genérico
abstract class MeioDeTransporte {
  void mover();
}

// Faz sentido como classe concreta: algo completo por si só
class Endereco {
  String rua;
  String cidade;
  Endereco(this.rua, this.cidade);
}
```

**Observações:**
Ficou mais claro que a decisão gira em torno de "esse conceito faz sentido sozinho ou só através de especializações?". Ainda tenho dúvida sobre casos intermediários, onde talvez uma classe pudesse ser tanto abstrata quanto concreta, dependendo de como o sistema crescer no futuro. Pretendo pensar em dois ou três exemplos do dia a dia e tentar classificar mentalmente se fariam mais sentido como classe abstrata ou concreta.

---

## O que é 'herança' em Dart e como ela funciona?

**Estudante:** O que é 'herança' em Dart e como ela funciona?

**IA:** Herança é o mecanismo que permite que uma classe (chamada de **subclasse**) **reutilize atributos e métodos** de outra classe (chamada de **classe pai** ou **superclasse**), usando a palavra-chave **`extends`**.

Com herança, a subclasse:

- **Recebe automaticamente** todos os métodos e atributos públicos (e também protegidos por convenção, dentro da mesma biblioteca) da classe pai.
- Pode **adicionar novos atributos e métodos** próprios, específicos daquela subclasse.
- Pode **sobrescrever métodos** já existentes na classe pai, como vimos anteriormente.

Um cuidado importante: em Dart, uma classe só pode **herdar de uma única classe pai** (herança simples, não múltipla). Para comportamentos que vêm de "várias fontes", normalmente se usa uma combinação de herança com interfaces (que veremos a seguir) ou mixins (um tema um pouco mais avançado).

Exemplo:

```dart
class Veiculo {
  String marca;
  Veiculo(this.marca);

  void ligar() {
    print('$marca ligado.');
  }
}

class Carro extends Veiculo {
  int numeroPortas;

  Carro(String marca, this.numeroPortas) : super(marca);
}
```

**Observações:**
Ficou claro que herança serve para reaproveitar comportamento comum entre classes relacionadas, mas que o Dart permite herdar de apenas uma classe por vez. Ainda tenho dúvida sobre como o construtor da subclasse se conecta exatamente com o construtor da classe pai (o uso de `super(marca)` no exemplo). Pretendo estudar com mais calma essa parte da inicialização de construtores em hierarquias de herança antes de criar hierarquias próprias mais elaboradas.

---

## Qual a diferença entre herança e composição?

**Estudante:** Qual a diferença entre herança e composição?

**IA:** Essa é uma reflexão importante sobre **como relacionar classes entre si**. Ambas são formas de reaproveitar comportamento, mas com abordagens bem diferentes:

- **Herança** representa uma relação do tipo **"é um"** (por exemplo, "Cachorro é um Animal"). A subclasse herda diretamente a estrutura da classe pai.
- **Composição** representa uma relação do tipo **"tem um"** (por exemplo, "Carro tem um Motor"). Em vez de herdar, uma classe **contém uma instância de outra classe** como um de seus atributos, delegando parte do comportamento para esse objeto interno.

Um princípio bastante conhecido na orientação a objetos é: **"prefira composição a herança"**, especialmente quando a relação entre as classes não é claramente do tipo "é um". Isso porque herança cria um acoplamento mais forte e rígido entre as classes, enquanto composição costuma ser mais flexível para mudanças futuras.

Exemplo:

```dart
// Composição: Carro "tem um" Motor
class Motor {
  void ligar() => print('Motor ligado');
}

class Carro {
  final Motor motor; // Carro contém um Motor
  Carro(this.motor);

  void ligar() {
    motor.ligar(); // delega o comportamento para o objeto interno
  }
}
```

**Observações:**
Ficou claro que a diferença central está em pensar "é um" (herança) versus "tem um" (composição), o que ajuda bastante a decidir como modelar a relação entre duas classes. Ainda tenho dúvida sobre até que ponto devo preferir composição por padrão, mesmo em casos onde herança pareceria natural à primeira vista. Pretendo, ao criar novas classes relacionadas, tentar descrever a relação entre elas em palavras antes de decidir entre herança e composição.

---

## O que é uma 'interface' em Dart e como ela define um contrato de comportamento?

**Estudante:** O que é uma 'interface' em Dart e como ela define um contrato de comportamento?

**IA:** Aqui vale um esclarecimento importante sobre o Dart: **não existe uma palavra-chave `interface` separada** como em algumas outras linguagens. Em Dart, **qualquer classe pode servir como uma interface implicitamente**, definindo um **contrato de comportamento** que outras classes devem seguir.

Uma interface, nesse sentido, define **quais métodos e propriedades uma classe deve ter**, sem necessariamente fornecer a implementação desses métodos (embora isso dependa de como a classe original foi escrita). O objetivo é garantir que diferentes classes, mesmo sem relação de herança entre si, sigam o **mesmo conjunto de comportamentos esperados**.

Isso é especialmente útil quando você quer que **classes completamente diferentes** compartilhem um mesmo comportamento em comum, sem forçar uma relação de herança "é um" entre elas.

Exemplo (definindo o contrato através de uma classe comum, que servirá como interface):

```dart
class Reproduzivel {
  void reproduzir() {} // define o contrato esperado
}
```

Essa classe `Reproduzivel` pode ser usada como uma interface por qualquer outra classe, através da palavra-chave `implements`, que veremos com mais detalhes a seguir.

**Observações:**
Achei curioso que o Dart não tenha uma palavra-chave própria para interface, e que qualquer classe possa servir para esse propósito. Ainda tenho dúvida sobre quando vale a pena criar uma classe só para servir como interface (sem nunca ser instanciada diretamente), versus quando ela também pode ser usada normalmente. Pretendo revisar esse conceito junto com classes abstratas, já que os dois parecem se relacionar bastante.

---

## Como uma classe pode implementar uma interface?

**Estudante:** Como uma classe pode implementar uma interface?

**IA:** Para isso, o Dart usa a palavra-chave **`implements`**. Quando uma classe implementa outra (usada como interface), ela se compromete a **fornecer sua própria implementação de todos os métodos** definidos naquela interface — diferente da herança, aqui **nada é herdado automaticamente**, apenas o "contrato" é assumido.

Alguns pontos importantes:

- Uma classe pode **implementar várias interfaces ao mesmo tempo**, separadas por vírgula, algo que não é possível com herança simples (`extends`).
- Se você esquecer de implementar algum método exigido pela interface, o **compilador avisa** que a implementação está incompleta.

Exemplo:

```dart
class Reproduzivel {
  void reproduzir() {}
}

class Musica implements Reproduzivel {
  @override
  void reproduzir() {
    print('Reproduzindo música...');
  }
}
```

**Observações:**
Ficou claro que `implements` obriga a classe a fornecer sua própria implementação de tudo, sem herdar nada automaticamente, o que é bem diferente do `extends`. Ainda tenho dúvida sobre boas práticas ao decidir quantas interfaces uma única classe deveria implementar ao mesmo tempo. Pretendo criar uma classe simples implementando uma interface pequena, só com um ou dois métodos, para fixar essa sintaxe.

---

## Qual a diferença entre herança e implementação de interfaces?

**Estudante:** Qual a diferença entre herança e implementação de interfaces?

**IA:** Essa é uma continuação natural do que vimos até agora! A diferença central está em **o que é herdado** e **quantas relações são permitidas**:

- **Herança (`extends`)** — a subclasse **herda a implementação** dos métodos da classe pai (a não ser que sobrescreva), além de poder reaproveitar atributos já prontos. Só é permitida **uma única herança** por classe.
- **Implementação de interface (`implements`)** — a classe assume um **contrato**, mas precisa **implementar tudo do zero**, sem herdar nenhuma implementação pronta. É possível **implementar várias interfaces ao mesmo tempo**.

Uma forma simples de resumir: herança é sobre **reaproveitar comportamento pronto**, enquanto implementação de interface é sobre **garantir compatibilidade de contrato**, mesmo entre classes sem relação direta de "família".

Exemplo (comparação lado a lado):

```dart
class Animal {
  void emitirSom() => print('Som genérico');
}

class Reproduzivel {
  void reproduzir() {}
}

// Herda comportamento de Animal, e também segue o contrato de Reproduzivel
class Papagaio extends Animal implements Reproduzivel {
  @override
  void reproduzir() {
    print('Repetindo frase...');
  }
}
```

**Observações:**
Ficou bem mais claro que a diferença não é só sintática, mas sobre reaproveitar comportamento (herança) versus garantir um contrato (interface), podendo até combinar os dois na mesma classe, como no exemplo. Ainda tenho dúvida sobre até que ponto vale a pena combinar `extends` e `implements` na mesma classe sem deixar o design confuso. Pretendo praticar criando uma classe que combine os dois conceitos, de forma bem simples, para visualizar essa combinação funcionando.

---

## Quais cenários devo usar métodos estáticos em vez de métodos de instância?

**Estudante:** Quais cenários devo usar métodos estáticos em vez de métodos de instância?

**IA:** Métodos **estáticos** (declarados com a palavra-chave **`static`**) pertencem **à classe em si**, e não a uma instância específica dela. Isso significa que você pode chamá-los **sem precisar criar um objeto** daquela classe.

Alguns cenários comuns onde métodos estáticos fazem sentido:

- **Funções utilitárias** relacionadas ao conceito da classe, mas que **não dependem do estado de uma instância específica** (por exemplo, uma função que converte unidades de medida).
- **Contadores ou informações compartilhadas entre todas as instâncias** da classe, como quantas instâncias já foram criadas.
- **Métodos de "fábrica" simples** que ajudam a criar objetos daquela classe (embora, para casos mais elaborados, um construtor `factory`, como vimos antes, costuma ser mais adequado).

Um cuidado importante: **evite usar métodos estáticos apenas para "economizar" a criação de um objeto**, quando o método realmente deveria depender do estado de uma instância. Métodos estáticos não têm acesso a atributos de instância (não estáticos) da classe.

Exemplo:

```dart
class Conversor {
  static double celsiusParaFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }
}

void main() {
  print(Conversor.celsiusParaFahrenheit(25)); // chamado sem criar instância
}
```

**Observações:**
Ficou claro que métodos estáticos fazem mais sentido quando a lógica não depende de um estado específico de um objeto, como no exemplo de conversão de unidades. Ainda tenho dúvida sobre a linha entre "isso deveria ser estático" e "isso deveria ser um método de instância normal", em casos mais ambíguos. Pretendo revisar funções utilitárias que eu já escrevi soltas para ver se alguma faria mais sentido dentro de uma classe, como método estático.

---

## Como posso acessar um método estático sem criar uma instância da classe?

**Estudante:** Como posso acessar um método estático sem criar uma instância da classe?

**IA:** O acesso a um método estático é feito diretamente através do **nome da classe**, seguido do operador ponto (`.`) e do nome do método — sem precisar (e sem poder) criar um objeto daquela classe primeiro para isso.

Isso é justamente o que diferencia um método estático de um método de instância comum: enquanto métodos de instância exigem `objeto.metodo()`, métodos estáticos usam `NomeDaClasse.metodo()`.

Um erro comum de quem está começando é **tentar acessar um método estático através de uma instância** (`objeto.metodoEstatico()`), o que geralmente gera um aviso ou erro, já que o método não pertence àquela instância específica, e sim à classe como um todo.

Exemplo:

```dart
class Matematica {
  static int dobro(int valor) => valor * 2;
}

void main() {
  print(Matematica.dobro(5)); // acesso correto: pelo nome da classe
}
```

**Observações:**
Ficou bem claro que o acesso via nome da classe é o que diferencia visualmente um método estático de um método de instância, o que ajuda bastante a identificar isso ao ler código de outras pessoas. Ainda tenho dúvida sobre se existe algum cenário em que faça sentido ter um método estático e outro de instância com o mesmo nome na mesma classe. Pretendo criar uma classe simples só com métodos estáticos utilitários para praticar essa forma de chamada.

---

## O que são 'enumeradores' em Dart e para que servem?

**Estudante:** O que são 'enumeradores' em Dart e para que servem?

**IA:** Enumeradores (`enum`) são um tipo especial usado para representar **um conjunto fixo e conhecido de valores possíveis**, tornando o código mais expressivo e seguro do que usar, por exemplo, números ou textos soltos para representar essas opções.

Alguns benefícios importantes:

- **Segurança de tipos**: o compilador garante que só é possível atribuir um dos valores definidos no `enum`, evitando valores inválidos "digitados errado".
- **Legibilidade**: `StatusPedido.pendente` é muito mais claro do que, por exemplo, usar o número `1` para representar a mesma ideia.
- **Facilidade de manutenção**: se for necessário adicionar um novo valor possível, isso fica centralizado em um único lugar (a definição do `enum`).

Como vimos na conversa sobre `switch`, usar `enum` com `switch` também ajuda o compilador a alertar se algum valor possível não foi tratado.

Exemplo:

```dart
enum StatusPedido { pendente, emAndamento, concluido }

void exibirStatus(StatusPedido status) {
  print('Status atual: $status');
}

void main() {
  exibirStatus(StatusPedido.pendente);
}
```

**Observações:**
Ficou claro que `enum` ajuda a evitar valores "soltos" (como números ou textos digitados manualmente) para representar opções fixas, tornando o código mais seguro. Ainda tenho dúvida sobre os recursos mais avançados de `enum` em Dart, como a possibilidade de adicionar métodos e atributos dentro dele (algo que ouvi falar, mas não vimos em profundidade aqui). Pretendo criar um `enum` simples para representar algumas opções fixas de um contexto qualquer, só para praticar a sintaxe básica.

---

## Em quais situações é melhor usar enumeradores em vez de constantes?

**Estudante:** Em quais situações é melhor usar enumeradores em vez de constantes?

**IA:** Essa é uma comparação importante! Embora seja possível representar opções fixas usando `const` (como uma lista de `String`s constantes, por exemplo), `enum` costuma ser a escolha mais adequada quando:

- **As opções formam um conjunto fechado e bem definido**, que não deveria receber valores fora dessa lista específica — o `enum` garante isso em tempo de compilação, enquanto `const String` não impede que alguém passe qualquer outro texto por engano.
- **Você quer aproveitar recursos como `switch` exaustivo**, onde o compilador pode alertar sobre casos não tratados, algo que não acontece da mesma forma com constantes soltas.
- **A legibilidade e a intenção do código são prioridade**, já que `enum` deixa claro, só pela definição, quais são exatamente todas as opções possíveis, centralizadas em um único lugar.

Por outro lado, **constantes simples (`const`)** ainda fazem sentido para valores fixos que não representam um "conjunto de opções relacionadas", como um valor numérico único (`const limiteMaximo = 100`) que não tem essa ideia de "uma entre várias opções".

Exemplo comparativo:

```dart
// Menos seguro: qualquer String pode ser passada por engano
const String statusPendente = 'pendente';
const String statusConcluido = 'concluido';

void processar(String status) {
  // nada impede de passar um valor não previsto, como 'invalido'
}

// Mais seguro: conjunto fechado de valores, garantido pelo compilador
enum Status { pendente, concluido }

void processarEnum(Status status) {
  // só é possível passar um dos valores definidos no enum
}
```

**Observações:**
Ficou claro que o principal ganho do `enum` sobre constantes soltas é a garantia, em tempo de compilação, de que só valores válidos podem ser usados. Ainda tenho dúvida sobre casos intermediários, onde talvez um conjunto de constantes já fosse suficiente sem a necessidade de um `enum` completo. Pretendo revisar códigos que já escrevi usando `String`s soltas para representar opções fixas, e avaliar se algum caso faria mais sentido como `enum`.

---

## Conclusões Gerais

Essa interação me ajudou a avançar bastante no entendimento de orientação a objetos em Dart, complementando os conceitos iniciais de classes e construtores. Os principais aprendizados foram:

- **Sobrescrever métodos** (`@override`) permite que subclasses redefinam comportamentos herdados, e a palavra-chave **`super`** possibilita reaproveitar parte da lógica original da classe pai.
- **Getters e setters** oferecem controle sobre a leitura e escrita de atributos, sendo especialmente úteis para validação de dados e cálculo de valores derivados, sem expor o estado interno diretamente.
- **Classes abstratas** não podem ser instanciadas diretamente e servem como base para subclasses, podendo combinar métodos abstratos (sem implementação) com métodos concretos.
- **Herança (`extends`)** permite reaproveitar implementação de uma única classe pai, enquanto **composição** representa uma relação "tem um", geralmente preferida quando a relação não é claramente "é um".
- Em Dart, **qualquer classe pode servir como interface**, e a palavra-chave **`implements`** obriga a classe a fornecer sua própria implementação do contrato, sem herdar nada automaticamente — sendo possível implementar várias interfaces ao mesmo tempo.
- **Métodos estáticos** pertencem à classe, não a uma instância, sendo úteis para funcionalidades utilitárias que não dependem do estado de um objeto específico.
- **Enumeradores (`enum`)** representam conjuntos fixos e fechados de valores, trazendo mais segurança de tipos do que constantes soltas, especialmente quando combinados com `switch`.

De forma geral, o maior aprendizado foi perceber como esses conceitos se conectam entre si — sobrescrita, herança, interfaces e classes abstratas trabalham juntos para permitir um design mais flexível e seguro, enquanto métodos estáticos e enumeradores ajudam a organizar comportamentos e valores que não dependem diretamente de instâncias específicas. Pretendo continuar praticando cada conceito isoladamente, com classes simples, antes de tentar combiná-los em hierarquias mais elaboradas.
