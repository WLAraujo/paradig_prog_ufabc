-- Indica que é o módulo principal
module Main where

-- Assinatura da função principal
main :: IO ()
main = do
  putStrLn "hello world" -- Uso de função que imprime mensagem e quebra linha

----------------------------------------------------
-- Básico de funções e operações aritméticas 
----------------------------------------------------

-- Função de multiplicação
mult :: Int -> Int -> Int -- Chamamos essa definição de tipos de assinatura da função
mult x y = x * y -- Já aqui temos a definição do cálculo da função em si

-- Função que determina se é ímpar
impar :: Int -> Bool
impar n = n `mod` 2 == 1

-- Função que calcula quadrado
quadrado :: Num a => a -> a
quadrado n = n * n

----------------------------------------------------
-- Uso do where 
----------------------------------------------------

-- Função que devolve as raízes de segundo grau de uma função dados os coeficientes
raizes2Grau :: Floating a => a -> a -> a -> (a, a)
raizes2Grau a b c = (((-b) + sqrt(b * b - 4 * a * c)) / (2 * a),
                    ((-b) - sqrt(b * b - 4 * a * c)) / (2 * a))

-- Usando claúsula where para reorganizar a função acima
raizes2GrauV2 :: Floating a => a -> a -> a -> (a, a)
raizes2GrauV2 a b c = (x1, x2)
  where
    x1 = ((-b) + sqDelta) / (2 * a)
    x2 = ((-b) - sqDelta) / (2 * a)
    sqDelta = sqrt delta 
    delta = b * b - 4 * a * c

----------------------------------------------------
-- Uso de if/else
----------------------------------------------------

-- Função que cálcula valor absoluto usando if
abs :: (Num a, Ord a) => a -> a -- A restrição Ord indica que a é número de um conjunto ordenável
abs n = if n < 0 then -n else n

-- Também podemos aninhar ifs, como visto na seguinte função que devolve o sinal do número
signNum :: (Num a, Ord a) => a -> a
signNum n = if n < 0 
        then -1 
        else  if n == 0
              then 0
              else 1

-- Vamos cricar uma terceira versão da função que calcula raízes quadradas
raizes2GrauV3 :: (Floating a, Ord a) => a -> a -> a -> (a, a)
raizes2GrauV3 a b c = (x1, x2)
  where
    x1 = if delta >= 0 then ((-b) + sqDelta) / (2 * a) else 0
    x2 = if delta >= 0 then ((-b) - sqDelta) / (2 * a) else 0
    sqDelta = sqrt delta 
    delta = b * b - 4 * a * c

----------------------------------------------------
-- Guarded expressions
----------------------------------------------------

-- Para evitar o aninhamento de muitas expressões if podemos usar as Guarded Expressions
signNumV2 :: (Num a, Ord a) => a -> a
signNumV2 n
  | n < 0      = -1
  | n == 0     = 0
  | otherwise  = 1

----------------------------------------------------
-- Lançamento de erro
----------------------------------------------------

-- Vamos exemplificar o lançamento de um erro através da função de raízes negativas
raizes2GrauV4 :: (Floating a, Ord a) => a -> a -> a -> (a, a)
raizes2GrauV4 a b c = if delta < 0 then error "Delta negativo" else (x1, x2)
  where
    x1 = if delta >= 0 then ((-b) + sqDelta) / (2 * a) else 0
    x2 = if delta >= 0 then ((-b) - sqDelta) / (2 * a) else 0
    sqDelta = sqrt delta 
    delta = b * b - 4 * a * c

----------------------------------------------------
-- Pattern matches
----------------------------------------------------

-- Uma outra característica interessante da linguagem são os pattern matches 
-- Esses nós ajudam a identificar casos específicos de funções
-- Veja a função soma abaixo por exemplo
soma :: (Eq a, Num a) => a -> a -> a
soma 0 y = y
soma x 0 = x
soma x y = x + y

-- Mais um exemplo usando multiplicação

multi :: (Eq a, Num a) => a -> a -> a
multi 0 _ = 0
multi _ 0 = 0
multi 1 x = x
multi y 1 = y
multi y x = y * x

----------------------------------------------------
-- Funções lambdas/anônimas
----------------------------------------------------

-- Vamos ver alguns exemplos de funções lambda
multiplica = \x y -> x * y

----------------------------------------------------
-- Listas em haskell
----------------------------------------------------

-- Listas em haskell são listas ligadas, logo o custo de acesso é proporcional à posição

-- Operador de apontamento e construção de lista
-- Construção de listas usando operador de construção :
-- Para usar o operador cons o elemento final deve ser uma lista
lista1 = 1 : []
lista2 = 1 : 2 : 3 : []
lista3 = [1,2,3]
-- Construção de uma string como lista de caracteres
ola = 'o' : 'l' : 'a' : [] 

-- Haskell consegue inferir regras na construção de uma lista
-- Listas de números inteiros em haskel
umdez = [1..10]
-- Lista de todos números ímpares 
-- Lembrando que isso é possível devido à avaliação preguiçosa de haskell
-- Só estou limitando no 51 para não travar
impares = [1,3..51]

-- Para acessar um elemento de uma lista em haskell usamos o operador !!
ponta = umdez !! 0
-- Para acessar enésimo elemento de uma lista com avaliação preguiçosa 
cem = [0,1..] !! 100

-- Para usar apenas os n primeiros elementos de uma lista usamos o operador take
umvinte = take 20 [1,2..]

-- Já para excluir os n primeiros elementos de uma lista podemos usar o drop
cinquenta = drop 50 [1,2..100]

-- Para descobrirmos o tamanho de uma lista

-- Soma de todos os elementos da lista
somatorio = sum (take 5 [1,2..])

-- Multiplicação de todos os elementos da lista
fatorial = product (take 5 [1,2..])

-- CUIDADO: Existem funções que quando aplicadas precisam verificar a lista inteira
-- nunca use esse tipo de função sobre listas infinitas

-- Concatenação de listas
concatenadas = concat [[1,2,3],[4,5,6]]

----------------------------------------------------
-- Compresão de listas
----------------------------------------------------

-- Trata-se de definir uma lista não pelo seus elementos e sim por certas condições

-- Lista de números múltiplos de 6
-- x tal que x é par, menor que 100 e múltiplo de 6
mult6 :: [Int]
mult6 = [x | x <- [0,2..100], (x `mod` 6) == 0]

-- Veja que essa estrutura é muito útil para aplicar filtros

-- Criando função de concatenação de listas usando compresão
-- A entrada é uma lista de sublistas e para cada lista nos adicionamos o elemento
concatena :: [[a]] -> [a]
concatena xss = [ x | xs <- xss, x <- xs ]

-- Implementando a função length com list comprehension
-- A função soma os 1s de uma lista que verifica os elementos de uma lista
tamanho :: [a] -> Int
tamanho xs = sum [ 1 | x <- xs]

-- Pegar todos os divisores de um número
divisores :: Int -> [Int]
divisores n = [x | x <- [1..n], (n `mod` x) == 0]
-- Usando função acima para decidir se um número é primo
primo :: Int -> Bool
primo x = divisores x == [1,x]

----------------------------------------------------
-- Recursões
----------------------------------------------------

-- Nunca esqueça de definir o caso base

-- Usando recursão para calcular fatorial
fatorialRecursao :: Int -> Int
fatorialRecursao 0 = 1
fatorialRecursao x = fatorialRecursao(x-1) * x

-- Usando recursão para calcular mdc
mdc :: Int -> Int -> Int
mdc a 0 = 0
mdc a b = mdc b (a `mod` b)

-- Usando recursão para implementar soma de listas
somaLista :: Num a => [a] -> a
somaLista [] = 0
somaLista a = head a + somaLista (tail a)

-- Por fim, vamos implementar um quick sort
qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:lista) = 
  qsort menores ++ [x] ++ qsort maiores
  where
    menores = [elemento | elemento <- lista, elemento<x]
    maiores = [elemento | elemento <- lista, elemento>=x]