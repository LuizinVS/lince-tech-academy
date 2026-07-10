# Interação com IA - Concorrência

## O que é um Future em Dart e como ele me ajuda a lidar com tarefas que levam tempo?

**Estudante:** O que é um Future em Dart e como ele me ajuda a lidar com tarefas que levam tempo?

**IA:** Ótimo tema para começar! Um **`Future`** representa um **valor que ainda não está disponível agora, mas que estará em algum momento no futuro** — por isso o nome. Ele é usado para lidar com operações que **levam tempo para serem concluídas**, como buscar dados de uma API, ler um arquivo, ou aguardar uma resposta de banco de dados.

A grande vantagem é que, ao usar um `Future`, seu programa **não fica travado esperando** aquela operação terminar — ele pode continuar executando outras coisas enquanto a tarefa demorada acontece "em segundo plano", e só reage quando o resultado estiver pronto.

Um `Future` pode terminar de duas formas:

- **Com sucesso**, entregando um valor do tipo especificado (`Future<int>`, `Future<String>`, etc.).
- **Com erro**, caso algo dê errado durante a operação (falaremos mais sobre isso adiante).

Exemplo simples (usando `Future.delayed` para simular uma tarefa demorada):

```dart
Future<String> buscarDados() {
  return Future.delayed(Duration(seconds: 2), () => 'Dados carregados');
}

void main() async {
  print('Buscando dados...');
  var resultado = await buscarDados();
  print(resultado);
}
```

**Observações:**
Ficou claro que um `Future` é basicamente uma "promessa" de um valor que vai chegar depois, o que ajuda o programa a não travar esperando tarefas demoradas. Ainda tenho dúvida sobre o que exatamente acontece "por trás dos panos" enquanto o `Future` está sendo processado. Pretendo testar esse exemplo simples com `Future.delayed` para visualizar na prática esse comportamento de espera sem travar o programa.

---

## O que significam os termos 'assíncrono' e 'síncrono'?

**Estudante:** O que significam os termos 'assíncrono' e 'síncrono'?

**IA:** Essa distinção é fundamental para entender por que `Future` existe:

- **Código síncrono** executa **uma instrução de cada vez, em ordem**, e cada linha **espera a anterior terminar** antes de continuar. Se uma operação demora, o programa **fica parado** esperando ela terminar antes de seguir em frente.
- **Código assíncrono** permite que uma operação demorada **seja "disparada" e o programa continue executando outras coisas**, sem ficar bloqueado esperando. Quando o resultado da operação demorada fica pronto, o código correspondente é executado, mas sem travar o restante do programa nesse meio tempo.

Em Dart, a palavra-chave **`async`** marca uma função como assíncrona (permitindo o uso de `await` dentro dela), e **`await`** pausa a execução **daquela função específica** até que o `Future` correspondente termine — mas sem travar o restante do programa, apenas aquele trecho de código que depende do resultado.

Exemplo:

```dart
// Síncrono: cada linha espera a anterior
void exemploSincrono() {
  print('Início');
  print('Meio');
  print('Fim');
}

// Assíncrono: usa await para esperar o Future, sem travar tudo
Future<void> exemploAssincrono() async {
  print('Início');
  await Future.delayed(Duration(seconds: 1));
  print('Depois da espera');
}
```

**Observações:**
Ficou bem mais claro que "assíncrono" não significa "tudo acontece ao mesmo tempo", mas sim que o programa não fica travado esperando uma tarefa específica terminar. Ainda tenho dúvida sobre a diferença exata entre "o programa não trava" e "as coisas acontecem em paralelo de verdade" — parece que são conceitos relacionados, mas não iguais. Pretendo comparar os dois exemplos (síncrono e assíncrono) rodando lado a lado para sentir a diferença na prática.

---

## O que acontece se um Future falhar e como posso lidar com esse erro?

**Estudante:** O que acontece se um Future falhar e como posso lidar com esse erro?

**IA:** Quando um `Future` falha, isso significa que, em vez de entregar um valor de sucesso, ele **lança uma exceção**, indicando que algo deu errado durante aquela operação assíncrona (por exemplo, falha de conexão com a internet).

Existem duas formas principais de lidar com esse erro:

1. **Usando `try/catch` junto com `await`**, dentro de uma função `async` — a forma mais parecida com o tratamento de exceções que já vimos em código síncrono.
2. **Usando o método `.catchError()`** diretamente na cadeia do `Future`, sem necessariamente usar `await`.

Um cuidado importante: **se um `Future` falhar e você não tratar esse erro de nenhuma forma**, isso pode gerar uma exceção não capturada, que aparece no console e, dependendo do contexto (como em um app Flutter), pode até quebrar a experiência do usuário.

Exemplo:

```dart
Future<String> buscarDadosComFalha() {
  return Future.delayed(Duration(seconds: 1), () {
    throw Exception('Falha ao buscar dados');
  });
}

Future<void> executar() async {
  try {
    var resultado = await buscarDadosComFalha();
    print(resultado);
  } catch (e) {
    print('Erro capturado: $e');
  }
}
```

**Observações:**
Ficou claro que erros em `Future` funcionam de forma parecida com exceções comuns, especialmente quando uso `try/catch` junto com `await`. Ainda tenho dúvida sobre quando faz mais sentido usar `.catchError()` em vez de `try/catch`, já que os dois parecem resolver o mesmo problema de formas diferentes. Pretendo testar simular uma falha proposital em um `Future`, só para ver o erro sendo capturado das duas formas diferentes.

---

## Existe uma forma de executar várias tarefas assíncronas em paralelo?

**Estudante:** Existe uma forma de executar várias tarefas assíncronas em paralelo?

**IA:** Sim! Quando você precisa **iniciar várias operações assíncronas ao mesmo tempo**, em vez de esperar uma terminar para só então começar a próxima, o Dart oferece o método **`Future.wait()`**.

Ele recebe uma **lista de Futures** e retorna um único `Future` que só é concluído **quando todos os Futures da lista terminarem**. Isso é bem diferente de usar vários `await` em sequência, um atrás do outro, que faria as tarefas serem executadas de forma **sequencial**, e não em paralelo.

Um cuidado importante: se **qualquer um** dos Futures da lista falhar, o `Future.wait()` também falha (a menos que você configure um tratamento específico para isso), então vale a pena pensar em como lidar com erros individuais de cada tarefa, dependendo da necessidade.

Exemplo:

```dart
Future<String> tarefaA() =>
    Future.delayed(Duration(seconds: 1), () => 'Tarefa A concluída');

Future<String> tarefaB() =>
    Future.delayed(Duration(seconds: 2), () => 'Tarefa B concluída');

Future<void> executarEmParalelo() async {
  var resultados = await Future.wait([tarefaA(), tarefaB()]);
  print(resultados); // [Tarefa A concluída, Tarefa B concluída]
}
```

**Observações:**
Ficou claro que `Future.wait()` é a ferramenta certa quando quero rodar tarefas assíncronas ao mesmo tempo, em vez de uma depois da outra. Ainda tenho dúvida sobre como lidar de forma mais granular quando apenas uma das tarefas da lista falha, sem que isso derrube o resultado das outras que deram certo. Pretendo comparar o tempo total de execução usando `await` sequencial versus `Future.wait()`, para visualizar a diferença de performance.

---

## Em quais situações devo usar Futures em meu código Dart?

**Estudante:** Em quais situações devo usar Futures em meu código Dart?

**IA:** `Future` é indicado sempre que sua função envolve uma **operação que não é instantânea**, ou seja, que depende de algo externo ou de um processamento que leva tempo. Algumas situações comuns:

- **Requisições de rede**, como buscar dados de uma API.
- **Leitura e escrita de arquivos**, especialmente arquivos grandes ou operações de I/O (entrada/saída).
- **Consultas a bancos de dados**, que geralmente não retornam o resultado instantaneamente.
- **Operações que dependem de temporizadores**, como esperar um tempo determinado antes de continuar (`Future.delayed`).

Um cuidado importante: **não é necessário usar `Future` para tudo.** Operações que são **rápidas e não dependem de fatores externos** (como um simples cálculo matemático) não precisam ser assíncronas — transformar tudo em `Future` sem necessidade só adicionaria complexidade desnecessária ao código.

Exemplo (situação onde faz sentido usar Future, de forma ilustrativa):

```dart
Future<String> buscarNomeUsuario(int id) {
  // Simulando uma operação que dependeria de uma fonte externa
  return Future.delayed(Duration(seconds: 1), () => 'Usuário $id');
}
```

**Observações:**
Ficou claro que `Future` faz sentido especificamente para operações que dependem de algo externo ou que levam tempo real para acontecer, e não para qualquer cálculo do dia a dia. Ainda tenho dúvida sobre onde fica o limite entre "isso é rápido o suficiente para ser síncrono" e "isso já merece ser assíncrono". Pretendo revisar situações reais (como chamadas de API) para reforçar esse padrão de uso do `Future`.

---

## Quais cuidados devo tomar não usando await em funções Future?

**Estudante:** Quais cuidados devo tomar não usando await em funções Future?

**IA:** Boa pergunta, porque esse é um erro comum de quem está começando com programação assíncrona! Se você **chama uma função que retorna um `Future`, mas não usa `await`** (nem trata o resultado de outra forma, como `.then()`), alguns problemas podem acontecer:

- **O código continua executando sem esperar o resultado**, o que pode causar comportamento inesperado se as próximas linhas dependerem daquele valor, que ainda não estará disponível.
- **Erros dentro do `Future` podem passar despercebidos**, já que, sem `await` (ou tratamento explícito do erro), a exceção pode não ser capturada da forma esperada, aparecendo apenas como um aviso no console, sem interromper o fluxo do programa.
- Muitas IDEs e o próprio analisador do Dart costumam **alertar sobre "Futures não aguardados"** (`unawaited_futures`), justamente para evitar esse tipo de problema silencioso.

Se você realmente **não precisa esperar** o resultado daquele `Future` (por exemplo, uma ação de log que não afeta o restante da lógica), é uma boa prática **deixar isso explícito**, por exemplo, usando a função `unawaited()` do pacote `package:meta`, para comunicar que essa decisão foi intencional, e não um esquecimento.

Exemplo do problema:

```dart
Future<void> executar() async {
  buscarDados(); // esqueceu do await, não espera o resultado
  print('Isso pode rodar antes de buscarDados() terminar');
}

Future<void> buscarDados() async {
  await Future.delayed(Duration(seconds: 2));
  print('Dados buscados');
}
```

**Observações:**
Não sabia que esquecer o `await` poderia fazer erros passarem despercebidos, sem interromper o fluxo do programa como eu esperaria de uma exceção comum. Ainda tenho dúvida sobre quando realmente é intencional não usar `await`, e como comunicar isso de forma clara no código. Pretendo testar esquecer o `await` de propósito em um exemplo simples, só para observar a ordem inesperada de execução no console.

---

## Como lidar com erros usando Future?

**Estudante:** Como lidar com erros usando Future?

**IA:** Recapitulando e aprofundando um pouco o que vimos antes, existem basicamente duas abordagens principais para tratar erros em `Future`, dependendo do estilo de código que você está usando:

1. **Com `async`/`await` e `try/catch`** — a abordagem mais parecida com o tratamento de exceções tradicional, sendo geralmente mais legível para quem está começando, especialmente quando há várias etapas assíncronas em sequência.
2. **Com encadeamento usando `.then()` e `.catchError()`** — uma abordagem mais "funcional", onde você define o que fazer com o resultado (`.then()`) e o que fazer em caso de erro (`.catchError()`), sem necessariamente usar `await`.

Uma boa prática é **escolher um estilo predominante no seu código** e manter certa consistência, em vez de misturar `await` com `.then()` na mesma função, o que pode deixar o código mais confuso de acompanhar.

Exemplo comparando as duas abordagens:

```dart
Future<String> buscarDadosComFalha() {
  return Future.delayed(Duration(seconds: 1), () {
    throw Exception('Falha ao buscar dados');
  });
}

// Abordagem com async/await e try/catch
Future<void> comTryCatch() async {
  try {
    var resultado = await buscarDadosComFalha();
    print(resultado);
  } catch (e) {
    print('Erro (try/catch): $e');
  }
}

// Abordagem com then/catchError
void comThenCatchError() {
  buscarDadosComFalha()
      .then((resultado) => print(resultado))
      .catchError((erro) => print('Erro (catchError): $erro'));
}
```

**Observações:**
Ficou claro que existem dois estilos válidos para tratar erros em `Future`, e que o importante é manter consistência, sem misturar os dois no mesmo trecho de código. Ainda tenho dúvida sobre qual estilo é mais recomendado no ecossistema Dart/Flutter de forma geral, ou se isso é mais uma questão de preferência pessoal. Pretendo praticar reescrevendo o mesmo tratamento de erro nas duas formas, para decidir qual estilo acho mais natural para mim.

---

## Conclusões Gerais

Essa interação me ajudou a entender os conceitos fundamentais de concorrência com `Future` em Dart. Os principais aprendizados foram:

- Um **`Future`** representa um valor que estará disponível no futuro, permitindo lidar com operações demoradas sem travar o restante do programa.
- A diferença entre **código síncrono e assíncrono** está em esperar cada instrução terminar antes de seguir, versus permitir que operações demoradas aconteçam sem bloquear o fluxo principal.
- Erros em `Future` podem ser tratados com **`try/catch`** (junto com `await`) ou com **`.catchError()`**, e erros não tratados podem passar despercebidos, exigindo atenção redobrada.
- **`Future.wait()`** permite executar várias tarefas assíncronas **em paralelo**, sendo mais eficiente do que aguardar cada uma sequencialmente quando elas são independentes entre si.
- `Future` deve ser usado para operações que **realmente dependem de tempo ou de fatores externos** (rede, arquivos, banco de dados), não sendo necessário para cálculos rápidos e simples.
- **Esquecer o `await`** em uma função que retorna `Future` pode causar comportamento inesperado e erros silenciosos, sendo importante usar ferramentas como `unawaited()` quando essa omissão for intencional.
- Existem dois estilos principais para lidar com o resultado (e erros) de um `Future`: **`async`/`await` com `try/catch`**, ou **encadeamento com `.then()`/`.catchError()`** — o importante é manter consistência ao escolher um estilo.

De forma geral, o maior aprendizado foi perceber que trabalhar com `Future` exige uma mudança de raciocínio em relação ao código síncrono tradicional, prestando atenção especial em como e quando os erros são tratados, e em quando realmente vale a pena esperar (`await`) ou disparar tarefas em paralelo. Pretendo continuar praticando esses conceitos isoladamente, com pequenos exemplos simulando espera e falhas, antes de aplicá-los em código assíncrono mais complexo.
