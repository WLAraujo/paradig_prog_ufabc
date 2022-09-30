# paradig_prog_ufabc
Repositório com códigos da disciplina de Paradigmas de Programação ofertada pela Universidade Federal do ABC (UFABC). A disciplina foi ofertada em Haskell.

## Sobre Haskell

* Surgiu em 1990 com o objetivo de ser uma linguagem puramente funcional
* Por muito tempo considerada uma linguagem puramente acadêmica
* Atualmente é utilizado em várias empresas
* Códigos em Haskell são concisos e declarativos
* Não existe o conceito de variável, apenas nomes e declarações (imutabilidade)
* Devido ao conceito de imutabilidade laços de repetição não existem
* Amplo uso de funções recursões
* Pode trabalhar com funções de alta ordem, ou seja, funções que recebem funções como parâmetros
* O código só é executado quando ele é requisitado (avaliação preguiçosa)

# Criando projeto Haskell

Usamos o stack na criação de projetos haskell, que é uma ferramenta para criar projetos haskell e gerenciar suas dependências. Para criar um projeto haskell num diretório basta digitar:

`stack new <nome_projeto> simple`

E assim é criada uma estrutura de projeto haskell baseada num modelo chamado de `simple`.

Para compilar/executar o seu código use:

`stack run`

Caso queira só compilar use:

`stack build`

Nesse curso estamos usando o GHC-Glorious Haskell Compiler.

Caso deseje usar o interpretador interativo de Haskell (GHCI) digite:

`stack ghci`

## Detalhes da linguagem

* O nome das funções deve começar com letra minúscula
* A identação define os blocos de código, semelhante a Python
* Comentário de uma linha: `--`
* Comentários de múltiplas linhas: `{- <comentário> -}`
* Tipos básicos de dados: `Int`, `Bool`, `Char`, `String`, `Integer`, `Float`, `Double`
* Também temos listas definidas entre `[]` e com elementos separados por `,`
* Uma lista de elementos tipo `T` é do tipo `[T]`
* Para definir um tipo usamo `::`, que lê-se "é do tipo"
* Operadores lógicos: `&&`, `||` e `not`
* Tuplas de elementos são definidas entre `()`
* Tuplas de tamanho 1 não são permitidas
* Funções são mapas de argumentos de um tipo para outro
* Por exemplo, uma função com n argumentos que devolve um `Int` é declarada `func :: Bool -> ... -> Int`

## Testando com QuickCheck

Para realizar testes funcionais nas nossas funções podemos usar a biblioteca `QuickCheck`, que acaba dando uma extensão ao poder de testes por casos. Com essa biblioteca podemos estabelecer regras de saída das nossas funções, por exemplo, a saída de um algoritnmo que ordena uma lista é uma lista de mesmo tamanho mas ordenada. Com essas regras o `QuickCheck` pode criar instâncias aleatórias e testar por exemplos indo além de instâncias conhecidas por nós. Para incluir essa biblioteca no nosso projeto temos que adicioná-la ao nosso projeto no `.cabal`.