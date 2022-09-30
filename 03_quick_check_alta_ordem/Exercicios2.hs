module Exercicios where

-- Função potencia, que recebe dois valores inteiros e retorna o
-- primeiro elevado ao segundo
--
potencia :: (Eq a, Num a) => a -> a -> a
potencia _ 0 = 1
potencia x y = x * potencia x (y-1)

-- Função concatena, que recebe duas strings e as retorna concatenadas
-- separadas por `" "` (espaço). C considere o operador de concatenação
-- `(++)`.
--
concatena :: String -> String -> String
concatena str1 str2 = str1 ++ " " ++ str2

-- Função chuveiro, que recebe o valor da resistência de um chuveiro
-- em Ohms, a corrente elétrica em ampéres (ambos inteiros) e devolve
-- uma string com o seguinte formato:
-- "Esse chuveiro tem uma potencia de {valor} Watts."
--
chuveiro :: Integer -> Integer -> String
chuveiro r c = "Esse chuveiro tem uma potencia de " ++ show (r * c^2) ++ " Watts."

-- Função mult3 n que retorne True caso a entrada seja múltiplo de 3 e False caso contrário.
--
mult3 :: Integer -> Bool
mult3 x = if x `mod` 3 == 0 then True else False

-- Função somaEhMult3, que recebe um dois valores inteiros e retorna se a soma é múltipla de 3
--
somaEhMult3 :: Integer -> Integer -> Bool
somaEhMult3 a b = if soma `mod` 3 == 0 then True else False
    where soma = a + b

-- Faça uma função desigualdadeTriangular a b c que recebe três
-- floats e decida se eles obedecem a desigualdade triangular.
--
desigualdadeTriangular :: (Ord a, Num a) => a -> a -> a -> Bool
desigualdadeTriangular a b c = if comp1 && comp2 && comp3 then True else False 
    where 
        comp1 = a <= b + c
        comp2 = b <= a + c
        comp3 = c <= a + b

-- Faça uma função todosTriangulares :: [Float] -> Float -> Float -> Bool
-- que determina se todos os números da primeira lista quando
-- combinados com os parâmetros b e c obedecem à desigualdade
-- triangular.
--
todosTriangulares :: [Float] -> Float -> Float -> Bool
todosTriangulares as b c = all (==True) [desigualdadeTriangular a b c | a <- as]

-- Similarmente, faça uma função
-- algumTriangular :: [Float] -> Float -> Float -> Bool
-- que determina se pelo menos um dos números da primeira lista
-- combinados com o segundo e terceiro parâmetros obedecem à
-- desigualdade triangular.
--
algumTriangular :: [Float] -> Float -> Float -> Bool
algumTriangular as b c = elem True [desigualdadeTriangular a b c | a <- as]

-- Faça uma função ehHexagonal n que determina se um número é hexagonal.
--
ehHexagonal :: Integer -> Bool
ehHexagonal n = ehInteiroHexagonal(teste)
    where
        teste = testeHexagonal n

ehInteiroHexagonal :: Float -> Bool
ehInteiroHexagonal x = x == fromInteger (round x)

testeHexagonal :: Integer -> Float
testeHexagonal n = (sqrt soma + 1) / 4
    where
        soma = fromIntegral (8 * n) + 1 :: Float

-- Faça uma função somaDigitosSeis que retorne todos os os números
-- entre 0 e 999 cujo resto da divisão da soma de seus dígitos por 7
-- seja 6.
--
somaDigitosSeis :: [Integer] 
somaDigitosSeis = [x | x <- [0,1..999], div7Resto6 (somaDigitos x) ]


somaDigitos :: Integer -> Integer
somaDigitos 0 = 0
somaDigitos n = digito + somaDigitos(divisao)
    where
        digito = n `mod` 10
        divisao = n `div` 10

div7Resto6 :: Integer -> Bool
div7Resto6 0 = False
div7Resto6 n = n `mod` 7 == 6


