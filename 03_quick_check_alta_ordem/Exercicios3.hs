module Exercicios where

-- | Crie uma função `contaDigitos xs` que recebe uma lista de `Int`s e retorna quantos dígitos aquele inteiro tem em sua representação decimal
contaDigitos :: Int -> Int
contaDigitos 0 = 0
contaDigitos n = 1 + contaDigitos (n `div` 10)

-- | Usando map, crie uma função `contaVariosDigitos xs` que recebe uma lista de `Int`s e retorna quantos dígitos cada inteiro
-- | tem em sua representação decimal.
contaVariosDigitos :: [Int] -> [Int]
contaVariosDigitos xs = map contaDigitos xs

-- | Defina a função `quantosSatisfazem f xs` que retorne, como `Int`, a quantidade de elementos em `xs` que satisfazem o
-- | predicado `f`. A lista nem sempre terá um elemento que satisfaz o predicado.
quantosSatisfazem :: (a -> Bool) -> [a] -> Int
quantosSatisfazem _ [] = 0
quantosSatisfazem f (x:xs) = 
    if f x == True 
    then 1 + quantosSatisfazem f xs 
    else 0 + quantosSatisfazem f xs 

-- | Crie uma função `censuraNomes pessoas` que recebe uma lista de pessoas no formato de tupla `(String, Int)`,
-- | representando (Nome, Idade), e retorna uma lista de nomes com a condição de que os menores de idade (`idade < 18`) tem seus nomes trocados por "CENSURADO".
censuraNomes :: [(String, Int)] -> [String]
censuraNomes tuplasNomes = [censura tupla | tupla <- tuplasNomes]

censura :: (String, Int) -> String
censura tupla = 
    if snd tupla >= 18 
    then fst tupla
    else "CENSURADO" 

-- | Usando a mesma representação de pessoa do exercício anterior, crie uma função que retorne os nomes apenas das pessoas maiores de idade.
nomesMaiores :: [(String, Int)] -> [String]
nomesMaiores tuplasNomes = [censura tupla | tupla <- tuplasNomes, snd tupla >= 18]

-- | Crie uma função `validaExtensoes arquivos` que recebe uma lista com o "tipos de arquivo" (conforme os exemplos) e retorna uma lista contendo apenas as extensões válidas.
-- | Assuma que o "tipo de arquivo" será sempre uma única palavra minúscula, e considere como vogais apenas a-e-i-o-u.
validaExtensoes :: [String] -> [String]
validaExtensoes arquivos = [removeVogais arquivo | arquivo <- arquivos, length (removeVogais arquivo) == 3]

removeVogais :: String -> String
removeVogais "" = ""
removeVogais extensao = [caractere | caractere <- extensao, (fromEnum caractere) `notElem` [97, 101, 105, 111, 117], (fromEnum caractere) >= 97, (fromEnum caractere) <= 122]

-- | Crie uma função `todosMaiores as bs`. Essa função recebe duas listas de inteiros e retorna se todos os elementos de `as` são maiores que seus correspondentes em `bs`.
todosMaiores :: [Int] -> [Int] -> Bool
todosMaiores [] _ = True
todosMaiores _ [] = True
todosMaiores (a:as) (b:bs) =
    if a > b 
    then todosMaiores as bs
    else False 
    
-- | Crie uma função `removeDuplicadosConsecutivos xs` que recebe uma lista `xs` e remove os elementos que são iguais ao seu vizinho anterior,
-- | de forma a não termos nenhuma repetição consecutiva.
removeDuplicadosConsecutivos :: Eq a => [a] -> [a]
removeDuplicadosConsecutivos [] = []
removeDuplicadosConsecutivos [x] = [x]
removeDuplicadosConsecutivos (x:xs) =
    if x == (head xs)
    then removeDuplicadosConsecutivos xs
    else x:(removeDuplicadosConsecutivos xs)

-- | Crie uma função `pessoaMaisVelha pessoas` que receba uma lista de pessoas (usando a representação de tuplas) e retorne o nome da mais velha.
-- | No caso de empate, a pessoa que apareceu primeiro deve prevalecer. Assuma que a lista nunca estará vazia.
pessoaMaisVelha :: [(String, Int)] -> String
pessoaMaisVelha pessoas = fst pessoaMaiorIdade
    where
        pessoaMaiorIdade = head [(nome,idadePessoa) | (nome,idadePessoa) <- pessoas, (idadePessoa==maiorIdade)]
        maiorIdade = maximum listaIdades
        listaIdades = [snd pessoa | pessoa <- pessoas]

-- | Crie uma função `validaDescontos descontos` que recebe uma lista de descontos (conforme o exemplo) e retorna se essa lista é válida ou não.
validaDescontos :: [Int] -> Bool
validaDescontos [] = False
validaDescontos descontos = 
    if porcentagemPaga < 50
    then False
    else True
    where
        porcentagemPaga = foldr (*) 100 porcentgensDecimaisPagas
        porcentgensDecimaisPagas = [(/) (fromIntegral valorInteiro) 100 | valorInteiro <- porcentagensPagas]
        porcentagensPagas = [100 - valor | valor <- descontos]

