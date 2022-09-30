module Exercicios where

import           Definitions
import           Interpreter

data FaixaDeHorario = FaixaDeHorario Int Int Int deriving (Show, Read)

instance Eq FaixaDeHorario where
  FaixaDeHorario dia1 inicio1 fim1 == FaixaDeHorario dia2 inicio2 fim2 = 
    if (inicio1 == fim1) && (inicio2 == fim2) then True
    else if (dia1 == dia2) && (inicio1 == inicio2) && (fim1 == fim2) then True 
    else False

mkFaixa :: Int -> Int -> Int -> Maybe FaixaDeHorario
mkFaixa dia inicio fim = 
  if (dia < 0) || (inicio > 23) || (fim > 23) || (inicio < 0) || (fim < 0)
  then Nothing
  else Just (FaixaDeHorario dia inicio fim)

instance Semigroup FaixaDeHorario where
  (<>) (FaixaDeHorario dia1 inicio1 fim1) (FaixaDeHorario dia2 inicio2 fim2) =
    if (inicio1 == fim1) || (inicio2 == fim2) then FaixaDeHorario 0 0 0
    else if (dia1 == dia2) && ((inicio1 < fim1 && inicio2 < fim2) || (inicio1 > fim1 && inicio2 > fim2)) then FaixaDeHorario dia1 (maximum [inicio1,inicio2]) (minimum [fim1,fim2])
    else if (dia1 == dia2) then FaixaDeHorario dia1 (maximum [inicio1,inicio2]) (maximum [fim1,fim2])
    else if (dia1 == dia2+1) && (fim2 > inicio1) && (inicio2 > fim2) then FaixaDeHorario dia1 inicio1 (minimum [fim1,fim2])
    else if (dia1+1 == dia2) && (fim1 > inicio2) && (inicio1 > fim1) then FaixaDeHorario dia2 inicio2 (minimum [fim1,fim2])
    else FaixaDeHorario 0 0 0

instance Monoid FaixaDeHorario where
  mempty = (FaixaDeHorario 0 0 0)

haConflitos :: [FaixaDeHorario] -> Bool
haConflitos [] = False
haConflitos (faixa:faixas) = 
  if False `elem` listaConflitos
  then True
  else haConflitos faixas
  where
    listaConflitos = map (== (FaixaDeHorario 0 0 0)) listaInterseccoes
    listaInterseccoes = [faixa <> faixaLista | faixaLista <- faixas]

-- LAMBDA

triple, fst3, snd3, trd3 :: LambdaExpr
triple = Lambda "f" $ Lambda "s" $ Lambda "t" $ apply2 pair (Var "f") (apply2 pair (Var "s") (Var "t"))
 
fst3 = Lambda "p" $ Apply fst_ (Var "p")

snd3 = Lambda "p" $ Apply fst_ (Apply snd_ (Var "p"))

trd3 = Lambda "p" $ Apply snd_ (Apply snd_ (Var "p"))

data Arv = Vazia | No Arv Int Arv deriving (Show, Eq)

isArvVazia :: LambdaExpr
isArvVazia = Lambda "l" $
  apply2 (Var "l") (Lambda "h" $ Lambda "t" $ Lambda "d" false) true

toLambdaTree :: Arv -> LambdaExpr
toLambdaTree = undefined

runLambdaTree :: LambdaExpr -> Arv
runLambdaTree = undefined

searchLambdaTree :: LambdaExpr
searchLambdaTree = Lambda "f" $ Lambda "v" $ Lambda "a" $
  undefined

insertLambdaTree :: LambdaExpr
insertLambdaTree = Lambda "f" $ Lambda "v" $ Lambda "a" $
  undefined

mapLambdaTree :: LambdaExpr
mapLambdaTree = Lambda "f" $ Lambda "g" $ Lambda "a" $
  undefined
