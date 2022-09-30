module Atividade01
    ( mult3,
    mult8,
    mult83,
    ehPrimo,
    bissextos,
    lastNBissextos,
    stringToIntegers,
    ex8,
    subtrair,
    dobro,
    quad,
    aniversario,
    cumprimentar
    ) where

{-Exercício 01: Faça uma função {mult3 n} que retorne True caso a entrada seja múltiplo de 3 e False caso contrário.-}
mult3 :: (Eq x, Num x, Integral x) => x -> Bool
mult3 0 = False
mult3 n = 
    if n `mod` 3 == 0 then True
    else False


{-Exercício 02: Faça uma função {mult8 n} que retorne True caso a entrada seja múltiplo de 8 e False caso contrário.-}
mult8 :: (Eq x, Num x, Integral x) => x -> Bool
mult8 0 = False
mult8 n = 
    if n `mod` 8 == 0 then True
    else False


{-Exercício 03: Faça uma função {mult83 x} que retorne True caso a entrada seja múltiplo de 3 e 8 e False caso contrário.-}
mult83 :: (Eq x, Num x, Integral x) => x -> Bool
mult83 0 = False
mult83 n = 
    if (mult3 n) && (mult8 n) then True 
    else False

{-Exercício 04: Faça uma função {ehPrimo n} que determina se um número é primo..-}
ehPrimo :: Integral a => a -> Bool
ehPrimo 0 = False
ehPrimo 1 = False
ehPrimo (-1) = False
ehPrimo n =
    if divisores == [1,n] then True
    else False        
    where
        divisores = [x | x <- [1..n], (n `mod` x) == 0] 

{-Exercício 05: Faça uma função {bissextos} que retorne todos os anos bissextos até 2020, começando pelo ano 1584.-}
bissextos :: [Integer]
bissextos = [x | x <- [1584,1585..2020], ((x `mod` 4) == 0 && (x `mod` 100) /= 0) || (x `mod` 400) == 0]

{-Exercício 06: Faça uma função {lastNBissextos n} que encontre os N últimos anos bissextos.-}
lastNBissextos :: Int -> [Integer]
lastNBissextos 0 = []
lastNBissextos n = drop ((length bissextos) - n) bissextos

{-Exercício 7: Faça uma função {stringToIntegers s} que recebe uma string s contendo somente números (e.g. ``01234") e devolva uma lista com os dígitos em formato Integer.-}
stringToIntegers :: String -> [Integer]
stringToIntegers str = [ charToInt x | x <- str]

charToInt :: Char -> Integer
charToInt '0' = 0
charToInt '1' = 1
charToInt '2' = 2
charToInt '3' = 3
charToInt '4' = 4
charToInt '5' = 5
charToInt '6' = 6
charToInt '7' = 7
charToInt '8' = 8
charToInt '9' = 9

{-Exercício 08: Faça uma funcao {ex8 x}  retorne True caso a entrada seja maior que -1 E (menor que 300 OU múltiplo de 6), e False caso contrário.-}
ex8 :: (Eq x, Num x, Integral x) => x -> Bool
ex8 n =
    if (n > -1) && ((n < 300)||(n `mod` 8 == 0)) then True
    else False

{-Exercício 10:-}
subtrair :: Int -> Int -> Int
subtrair a b = a - b

dobro :: Int -> Int
dobro a = 2 * a

quad :: Int -> Int
quad a = a^2

cumprimentar :: String -> String
cumprimentar nome = "Olá " ++ nome
    
aniversario :: Int -> String
aniversario ano = "Você fará " ++ show idade ++ " anos em 2022!"
    where
        idade = 2022 - ano 