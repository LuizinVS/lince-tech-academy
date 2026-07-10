# Interação com IA - Tratamento de exceções

## Qual a diferença entre um erro e uma exceção em Dart?

**Estudante:** Qual a diferença entre um erro e uma exceção em Dart?

**IA:** Ótima pergunta para começar, porque essa distinção é a base de todo o tema! Em Dart, ambos herdam de uma classe raiz comum, mas representam situações bem diferentes:

- **`Error`** — representa **falhas de programação**, ou seja, bugs no código que, idealmente, deveriam ser corrigidos **antes** de o programa ir para produção. Exemplos: `RangeError` (acessar um índice fora dos limites de uma lista), `TypeError`, `NoSuchMethodError`.
- **`Exception`** — representa **situações excepcionais, mas esperadas**, que podem acontecer mesmo em um código correto, geralmente relacionadas a fatores externos. Exemplos: falha de conexão com a internet, arquivo não encontrado, dados inválidos vindos de um formulário.

A ideia central é: **erros normalmente não deveriam ser "tratados" com `try/catch` como solução definitiva** — o ideal é corrigir a causa raiz no código. Já **exceções são esperadas de acontecer em certas condições**, e faz todo sentido capturá-las e tratá-las adequadamente.

Exemplo:

```dart
// Error: bug de programação (índice inválido)
var lista = [1, 2, 3];
// print(lista[10]); // lançaria um RangeError

// Exception: situação esperada, mesmo com código correto
void verificarIdade(int idade) {
  if (idade < 0) {
    throw Exception('Idade não pode ser negativa');
  }
}
```

**Observações:**
Ficou bem mais claro que a diferença não é só técnica, mas também sobre **intenção**: erro é bug para corrigir, exceção é situação esperada para tratar. Ainda tenho dúvida sobre alguns casos limítrofes, onde não fica tão óbvio se algo deveria ser tratado como erro ou como exceção. Pretendo revisar exemplos de código com erros comuns (como acessar índice inválido) para reforçar essa diferença na prática.

---

## Em quais situações devo esperar encontrar um erro, e em quais devo esperar uma exceção?

**Estudante:** Em quais situações devo esperar encontrar um erro, e em quais devo esperar uma exceção?

**IA:** Pensando de forma prática, dá para separar em alguns cenários comuns:

**Situações que geralmente geram `Error` (bugs a corrigir):**
- Acessar um índice fora dos limites de uma lista (`RangeError`).
- Chamar um método que não existe em um objeto (`NoSuchMethodError`).
- Tentar usar um valor `null` onde não era esperado, sem a devida verificação.
- Fazer um cast de tipo inválido (`TypeError`).

**Situações que geralmente geram `Exception` (esperadas de tratar):**
- Fazer uma requisição de rede que pode falhar por instabilidade de conexão.
- Ler um arquivo que pode não existir no caminho informado.
- Converter uma `String` para número, quando o texto pode não ser um número válido (`FormatException`).
- Validar dados de entrada do usuário, onde valores inválidos são uma possibilidade normal do fluxo.

Uma boa forma de pensar: se a situação **só acontece por causa de um bug** no seu código, provavelmente é um `Error`. Se a situação **pode acontecer mesmo com o código certo**, por depender de fatores externos ou de dados variáveis, é mais provável que seja uma `Exception`.

Exemplo:

```dart
// Provável Exception: conversão de texto para número
try {
  var numero = int.parse('abc'); // lança FormatException
} catch (e) {
  print('Não foi possível converter: $e');
}
```

**Observações:**
Gostei de ver exemplos concretos de cada categoria, porque antes eu misturava um pouco os dois conceitos na cabeça. Ainda tenho dúvida sobre situações mais "cinzentas", onde talvez dependa de como o desenvolvedor decidiu modelar aquele erro. Pretendo prestar atenção nos tipos de exceção que aparecem quando eu testar conversões e validações simples.

---

## O que fazem os blocos 'try', 'catch' e 'finally' em Dart?

**Estudante:** O que fazem os blocos 'try', 'catch' e 'finally' em Dart?

**IA:** Esses três blocos trabalham juntos para lidar com exceções de forma organizada:

- **`try`** — envolve o trecho de código que **pode lançar uma exceção**. É onde você "tenta" executar algo que tem risco de falhar.
- **`catch`** — captura a exceção, caso ela aconteça dentro do `try`, permitindo que você trate o problema (exibindo uma mensagem, tomando uma ação alternativa, etc.), em vez de deixar o programa quebrar.
- **`finally`** — executa um bloco de código **sempre**, tenha ocorrido exceção ou não. É útil para ações de "limpeza", como fechar uma conexão ou liberar um recurso.

Um detalhe importante: se nenhuma exceção for lançada dentro do `try`, o bloco `catch` simplesmente não é executado, mas o `finally` (se existir) roda de qualquer forma.

Exemplo:

```dart
void processar(String valor) {
  try {
    var numero = int.parse(valor);
    print('Número processado: $numero');
  } catch (e) {
    print('Erro ao processar: $e');
  } finally {
    print('Processamento finalizado.');
  }
}
```

**Observações:**
Ficou claro que o `finally` roda independentemente do resultado, o que é útil para garantir que alguma ação sempre aconteça. Ainda tenho dúvida sobre em quais situações reais eu realmente precisaria de um `finally`, além do exemplo de "fechar recursos" que já ouvi falar. Pretendo testar um `try/catch/finally` simples, forçando tanto o caminho de sucesso quanto o de erro, para ver o `finally` sendo executado nos dois casos.

---

## Como posso capturar diferentes tipos de exceções usando 'catch'?

**Estudante:** Como posso capturar diferentes tipos de exceções usando 'catch'?

**IA:** O Dart permite capturar exceções de forma **específica**, usando a palavra-chave **`on`** combinada com `catch`, o que é uma boa prática quando você quer tratar tipos diferentes de exceção de formas diferentes:

- **`on TipoDeExcecao catch (e)`** — captura apenas aquele tipo específico de exceção.
- Você pode encadear **vários blocos `on`** para tratar diferentes tipos de forma separada.
- Um `catch` genérico (sem `on`) no final pode servir como uma captura "geral", para qualquer exceção não tratada especificamente antes.

Uma boa prática é **evitar capturar exceções de forma genérica demais logo de início** (como um único `catch` para tudo), especialmente quando você sabe quais tipos específicos podem ocorrer — isso ajuda a dar tratamentos mais adequados para cada situação.

Exemplo:

```dart
void converter(String valor) {
  try {
    var numero = int.parse(valor);
    print('Convertido: $numero');
  } on FormatException catch (e) {
    print('Formato inválido: $e');
  } on Exception catch (e) {
    print('Outra exceção: $e');
  }
}
```

**Observações:**
Não sabia que era possível encadear vários blocos `on` para tratar exceções diferentes de formas diferentes — imaginava que só existia um `catch` genérico para tudo. Ainda tenho dúvida sobre a ordem correta de organizar esses blocos quando existem tipos de exceção relacionados por herança. Pretendo testar capturar tipos diferentes de exceção separadamente para comparar com um `catch` único genérico.

---

## Em quais situações é útil usar o bloco 'finally'?

**Estudante:** Em quais situações é útil usar o bloco 'finally'?

**IA:** O `finally` é útil sempre que existe uma ação que **precisa acontecer independentemente do resultado** do bloco `try` — ou seja, tanto em caso de sucesso quanto de falha. Alguns exemplos comuns:

- **Liberar recursos**, como fechar um arquivo aberto ou encerrar uma conexão, garantindo que isso aconteça mesmo se algo der errado no meio do processo.
- **Restaurar um estado**, como reverter uma variável de "carregando" para "pronto", independentemente de a operação ter sido bem-sucedida ou não.
- **Registrar logs de finalização**, quando você quer saber que uma determinada operação terminou, com ou sem erro.

Um cuidado importante: o `finally` **não deve ser usado para tratar a exceção em si** — essa é a função do `catch`. O papel do `finally` é garantir que determinadas ações aconteçam, não decidir como lidar com o erro.

Exemplo:

```dart
bool carregando = true;

void buscarDados() {
  try {
    carregando = true;
    // lógica que pode lançar exceção
  } catch (e) {
    print('Erro ao buscar dados: $e');
  } finally {
    carregando = false; // sempre executado, com ou sem erro
  }
}
```

**Observações:**
Ficou mais claro que o `finally` tem um papel bem específico de "garantir que algo aconteça", e não de tratar o erro propriamente dito. Ainda tenho dúvida sobre cenários mais avançados, como o que acontece se o próprio bloco `finally` lançar uma exceção. Pretendo criar um exemplo simples simulando um estado de "carregando" para visualizar esse padrão descrito no exemplo.

---

## Por que eu precisaria lançar uma exceção em meu código?

**Estudante:** Por que eu precisaria lançar uma exceção em meu código?

**IA:** Lançar uma exceção (`throw`) é útil quando sua função **identifica uma situação inválida ou inesperada** e precisa **interromper a execução normal**, avisando quem chamou a função sobre o problema, em vez de continuar executando com dados incorretos ou retornar um valor "mentiroso" (como `-1` para indicar erro, o que pode confundir com um valor válido).

Alguns motivos comuns para lançar uma exceção:

- **Validar parâmetros de entrada**, garantindo que a função só continue se os dados fizerem sentido.
- **Sinalizar uma regra de negócio violada**, de forma explícita, em vez de deixar o problema passar despercebido.
- **Evitar que o programa continue em um estado inconsistente**, já que, ao lançar a exceção, a execução daquele trecho é interrompida imediatamente.

Um cuidado importante: **não abuse de exceções para controlar fluxo normal do programa** (como usar `throw`/`catch` no lugar de um simples `if`). Exceções devem representar situações **realmente excepcionais**, não decisões comuns de lógica.

Exemplo:

```dart
void definirIdade(int idade) {
  if (idade < 0) {
    throw ArgumentError('Idade não pode ser negativa: $idade');
  }
  print('Idade definida: $idade');
}
```

**Observações:**
Entendi bem o motivo de evitar retornar valores "mentirosos" como sinal de erro, preferindo lançar uma exceção explícita. Ainda tenho dúvida sobre o limite entre "isso é realmente excepcional" e "isso é só uma condição comum que um `if` resolveria". Pretendo revisar funções simples que eu já escrevi para ver se algum retorno de erro "disfarçado" poderia virar uma exceção lançada de forma explícita.

---

## Como posso personalizar mensagens de erro ao lançar exceções?

**Estudante:** Como posso personalizar mensagens de erro ao lançar exceções?

**IA:** Existem algumas formas de personalizar mensagens ao lançar exceções em Dart:

1. **Usando classes prontas do Dart**, como `Exception('mensagem personalizada')` ou `ArgumentError('mensagem personalizada')`, passando uma `String` explicando o problema.
2. **Criando uma classe de exceção personalizada**, implementando a interface `Exception`, o que permite adicionar campos extras além da mensagem (como um código de erro, por exemplo), deixando o tratamento mais específico para o seu contexto.

Uma boa prática é sempre **escrever mensagens claras e específicas**, que ajudem a entender rapidamente o que deu errado — evite mensagens genéricas como "erro" ou "algo deu errado", que não ajudam muito na hora de depurar o problema.

Exemplo de exceção personalizada:

```dart
class IdadeInvalidaException implements Exception {
  final String mensagem;
  IdadeInvalidaException(this.mensagem);

  @override
  String toString() => 'IdadeInvalidaException: $mensagem';
}

void verificarIdade(int idade) {
  if (idade < 0) {
    throw IdadeInvalidaException('A idade informada ($idade) é inválida.');
  }
}
```

**Observações:**
Não sabia que era possível criar uma classe de exceção personalizada implementando `Exception` — até agora eu só usava a classe genérica `Exception('mensagem')`. Ainda tenho dúvida sobre quando realmente vale a pena criar uma exceção personalizada em vez de usar as classes já prontas do Dart. Pretendo criar uma exceção personalizada simples só para entender melhor a estrutura, sem aplicar em nenhuma lógica real ainda.

---

## Quais são as melhores práticas para lançar exceções em Dart?

**Estudante:** Quais são as melhores práticas para lançar exceções em Dart?

**IA:** Aqui vão algumas boas práticas importantes nesse tema:

1. **Lance exceções específicas sempre que possível**, em vez de usar apenas `Exception` genérica — isso ajuda quem captura o erro a entender exatamente o que aconteceu.
2. **Escreva mensagens claras**, explicando o que causou o problema, e se possível, incluindo os valores envolvidos (como fizemos no exemplo anterior, mostrando a idade inválida na mensagem).
3. **Não capture uma exceção só para relançá-la sem fazer nada com ela.** Se você não vai tratar o problema de fato, muitas vezes é melhor deixar que a exceção suba naturalmente até quem sabe lidar com ela.
4. **Evite lançar exceções para fluxo de controle comum.** Reserve exceções para situações realmente excepcionais, não para decisões triviais que um `if/else` resolveria bem.
5. **Documente quando uma função pode lançar exceções**, principalmente se ela for usada por outras partes do código (ou por outras pessoas), para que quem for chamá-la saiba se precisa envolver a chamada em um `try/catch`.

Exemplo (documentação simples indicando possível exceção):

```dart
/// Lança [ArgumentError] se [idade] for negativa.
void definirIdade(int idade) {
  if (idade < 0) {
    throw ArgumentError('Idade não pode ser negativa');
  }
  print('Idade definida: $idade');
}
```

**Observações:**
Gostei da ideia de documentar quando uma função pode lançar exceção, já que isso ajuda bastante quem for usar essa função depois (inclusive eu mesmo, no futuro). Ainda tenho dúvida sobre até que ponto devo criar exceções específicas para cada situação, versus reutilizar classes já existentes do Dart. Pretendo praticar escrevendo pequenos comentários de documentação nas funções que lançam exceções, mesmo em códigos simples de estudo.

---

## Qual a diferença entre usar 'assert' e lançar uma exceção para verificar condições?

**Estudante:** Qual a diferença entre usar 'assert' e lançar uma exceção para verificar condições?

**IA:** Essa é uma diferença importante, porque os dois têm propósitos bem distintos:

- **`assert`** é uma ferramenta voltada para **verificações durante o desenvolvimento**, usada para capturar **bugs no próprio código** o quanto antes. Um detalhe fundamental: **`assert` só é executado em modo de debug** — em builds de produção (release), as chamadas de `assert` são **ignoradas completamente**, sem custo de performance.
- **Lançar uma exceção (`throw`)** funciona **em qualquer ambiente**, inclusive em produção, e é voltado para **situações que podem realmente acontecer durante o uso real do aplicativo**, não apenas durante o desenvolvimento.

Ou seja: `assert` é como uma "rede de segurança" só para quem está desenvolvendo e testando o código, enquanto exceções lidam com o comportamento real do programa em uso, incluindo por usuários finais.

Exemplo:

```dart
void calcularMedia(List<int> notas) {
  assert(notas.isNotEmpty, 'A lista de notas não deveria estar vazia (erro de programação)');

  if (notas.isEmpty) {
    throw ArgumentError('Não é possível calcular a média sem notas informadas.');
  }
  // cálculo da média aqui
}
```

**Observações:**
Não sabia que o `assert` era completamente ignorado em builds de produção — imaginava que ele funcionava sempre, como um `if` qualquer. Ainda tenho dúvida sobre até que ponto vale a pena usar `assert` e exceção juntos na mesma função, como no exemplo. Pretendo estudar mais sobre a diferença entre ambientes de debug e release no Dart para entender melhor esse comportamento do `assert`.

---

## Em quais situações o 'assert' é mais útil durante o desenvolvimento?

**Estudante:** Em quais situações o 'assert' é mais útil durante o desenvolvimento?

**IA:** O `assert` é especialmente útil para verificar **premissas internas do seu próprio código** — coisas que, se estiverem erradas, indicam um **bug de programação**, e não uma situação normal de uso. Algumas situações comuns:

- **Verificar parâmetros internos** que, pela lógica do próprio código, nunca deveriam ter um valor inválido (diferente de dados vindos de fora, como entrada do usuário, que merecem exceções de verdade).
- **Confirmar invariantes durante o desenvolvimento**, como "essa lista nunca deveria estar vazia neste ponto do código", ajudando a identificar rapidamente se alguma alteração futura quebrou essa expectativa.
- **Documentar suposições do código de forma executável**, já que um `assert` com uma boa mensagem também serve como uma forma de comunicar a outros desenvolvedores (ou a você mesmo, no futuro) o que se espera naquele ponto.

Um cuidado importante: **não use `assert` para validar dados externos** (como entrada de usuário ou resposta de uma API), já que, em produção, essas verificações simplesmente não seriam executadas — para esses casos, sempre prefira lançar exceções.

Exemplo:

```dart
void aplicarDesconto(double preco, double percentual) {
  assert(percentual >= 0 && percentual <= 100, 'Percentual deveria estar entre 0 e 100 (bug interno)');
  var precoFinal = preco - (preco * percentual / 100);
  print('Preço final: $precoFinal');
}
```

**Observações:**
Ficou mais claro que o `assert` serve para verificar suposições internas do código, e não dados que vêm de fora, como entrada do usuário. Ainda tenho dúvida sobre como reconhecer, na prática, se determinado parâmetro deveria ser validado com `assert` ou com uma exceção lançada de verdade. Pretendo revisar funções simples que eu já escrevi para identificar quais verificações fazem mais sentido como `assert` e quais deveriam ser exceções reais.

---

## Conclusões Gerais

Essa interação me ajudou a organizar melhor os conceitos de tratamento de erros e exceções em Dart. Os principais aprendizados foram:

- **`Error`** representa bugs de programação que deveriam ser corrigidos no código, enquanto **`Exception`** representa situações esperadas, mesmo em um código correto, geralmente ligadas a fatores externos.
- Os blocos **`try`, `catch` e `finally`** trabalham juntos: o `try` isola o código de risco, o `catch` trata a exceção, e o `finally` garante que determinadas ações aconteçam independentemente do resultado.
- É possível capturar **tipos específicos de exceção** usando `on TipoDeExcecao catch (e)`, o que permite tratamentos diferentes para cada situação, em vez de um `catch` genérico único.
- **Lançar exceções (`throw`)** é útil para sinalizar situações inválidas de forma explícita, evitando retornos "mentirosos" como sinal de erro — mas deve ser reservado para situações realmente excepcionais, não para fluxo de controle comum.
- É possível **personalizar mensagens de erro**, tanto usando classes prontas do Dart quanto criando **exceções personalizadas**, o que ajuda bastante na hora de depurar problemas.
- Boas práticas ao lançar exceções incluem: ser específico, escrever mensagens claras, não capturar exceções sem tratá-las de fato, e documentar quando uma função pode lançar exceções.
- O **`assert`** é uma ferramenta voltada exclusivamente para o **desenvolvimento**, sendo ignorado em builds de produção — por isso, nunca deve ser usado para validar dados externos, apenas para verificar suposições internas do próprio código.

De forma geral, o maior aprendizado foi perceber que tratamento de exceções em Dart não é apenas sobre "evitar que o programa quebre", mas sobre **comunicar intenções claras**: separar bugs de programação (erros e `assert`) de situações esperadas do mundo real (exceções), o que torna o código mais previsível e fácil de manter. Pretendo continuar praticando esses conceitos isoladamente, em pequenos trechos de código, antes de aplicá-los em lógicas mais complexas.
