module Exercicios where

data Request a = Loading | Error | Success a 
                    deriving (Show, Eq)

instance Functor Request where
    fmap _ Error = Error
    fmap _ Loading = Loading
    fmap f (Success a) = Success (f a)

instance Applicative Request where
    pure = Success
    Error <*> _ = Error
    _ <*> Error = Error
    Loading <*> _ = Loading
    _ <*> Loading = Loading
    Success a <*> Success b = Success (a b)

instance Monad Request where
    return = Success
    Error >>= _ = Error
    Loading >>= _ = Loading
    Success a >>= requisicao = requisicao a 

data Bolso a = Um a | Dois a a | Tres a a a 
                deriving (Show)

instance Functor Bolso where
    fmap f (Um a) = Um (f a)
    fmap f (Dois a b) = Dois (f a) (f b)
    fmap f (Tres a b c) = Tres (f a) (f b) (f c)

instance Eq a => Eq (Bolso a) where
    (Um a) == (Um b) = a == b
    (Um a) == (Dois _ b) = a == b
    (Um a) == (Tres _ _ b) = a == b
    (Dois _ a) == (Um b) = a == b
    (Dois _ a) == (Dois _ b) = a == b
    (Dois _ a) == (Tres _ _ b) = a == b
    (Tres _ _ a) == (Um b) = a == b
    (Tres _ _ a) == (Dois _ b) = a == b
    (Tres _ _ a) == (Tres _ _ b) = a == b

instance Applicative Bolso where
    pure = Um
    Um f <*> b = fmap f b 
    Dois _ f <*> b = fmap f b 
    Tres _ _ f  <*> b = fmap f b 

instance Monad Bolso where
    return = Um
    Um a >>= f = f a
    Dois _ a >>= f = f a
    Tres _ _ a >>= f = f a

type Nome = String
type Peso = Double
type Altura = Double
type IMC = Double

imc :: [(Maybe Nome, Maybe Peso, Maybe Altura)] -> [Maybe IMC]
imc [] = []
imc ((nome, peso, altura):xs) = undefined


