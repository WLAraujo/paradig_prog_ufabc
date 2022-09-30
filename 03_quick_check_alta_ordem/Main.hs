module Main where

import Test.QuickCheck

------------------------------------------------------------------
-- Quick Check ---------------------------------------------------
------------------------------------------------------------------

-- Para executar alguma função de property: quickCheck <nome_funcao>

-- Criando função que implementa o QuickSort
qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = qsort lhs ++ [x] ++ qsort rhs
  where
    lhs = [e | e <- xs, e < x]
    rhs = [e | e <- xs, e >= x]

-- Função que testa propriedade de ordenação
prop_ordenacao :: Ord a => [a] -> Bool
prop_ordenacao xs = qsort (qsort xs) == qsort xs

-- Função que testa propriedade de mesmo tamanho
prop_tamanho :: Ord a => [a] -> Bool
prop_tamanho xs = length (qsort xs) == length xs

-- Função que testa igualdade de mínimos
prop_minimo :: Ord a => [a] -> Property
prop_minimo xs =  not (null xs) ==> head (qsort xs) == minimum xs

------------------------------------------------------------------
-- Funções de alta ordem -----------------------------------------
------------------------------------------------------------------

-- Uma função é de alta ordem se ela recebe uma ou mais funções como parâmetro

-- Função que recebe como parâmetro uma função e uma instância dessa função
-- e retorna aplicação dessa função duas vezes sobre essa instância
duasVezes :: (a->a) -> a -> a
duasVezes f x = f (f x)

-- A função map é uma função de alta ordem que aplica uma mesma função a vários elementos
-- Implementação de uma função map
map_implementada :: (a->b) -> [a] -> [b]
map_implementada f xs = [f x | x <- xs]

-- Uma outra função de alta ordem é a função filter que recebe uma lista e uma condição
-- A filter devolve os elementos da lista que passam pela condição
-- Implementação de uma função filter
filter_implementada :: (a -> Bool) -> [a] -> [a]
filter_implementada cond xs = [x | x <- xs, cond x]

-- Geralmente usamos as funções map e filter em conjunto
somaQuadPares :: [Int] -> Int
somaQuadPares ns = sum(map (^2) (filter even ns))

main :: IO ()
main = do
  putStrLn "hello world"

