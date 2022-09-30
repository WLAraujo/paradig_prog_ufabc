module Exercicios where

-- | Exercício 1. Implemente instâncias de Functor, Applicative e
-- Monad para o tipo `QuemSeImporta`.

data QuemSeImporta a = QuemSeImporta deriving (Eq, Show)

instance Functor QuemSeImporta where
    fmap f QuemSeImporta = QuemSeImporta

instance Applicative QuemSeImporta where
    pure _ = QuemSeImporta
    QuemSeImporta <*> _ = QuemSeImporta


instance Monad QuemSeImporta where
    QuemSeImporta >>= _ = QuemSeImporta

-- | Exercício 2. Implemente instâncias de Functor, Applicative e
-- Monad para o tipo `Caixa`.

newtype Caixa a = Caixa a deriving (Eq, Show)

instance Functor Caixa where
    fmap f (Caixa a) = Caixa (f a)

instance Applicative Caixa where
    pure a = Caixa a
    Caixa a <*> Caixa b = Caixa (a b)

instance Monad Caixa where
    Caixa a >>= f = f a 

-- | Exercício 3. Implemente a função `azul`. O seu comportamento pode
-- ser inferido da sua assinatura dada abaixo.

azul :: Monad m => m (m a) -> m a
azul mma = mma >>= (\ma -> ma >>= (\a -> return a))

-- | Exercício 4. Implemente a função `amarelo`. O seu comportamento
-- pode ser inferido da sua assinatura dada abaixo.

amarelo :: Monad m => (a -> b) -> m a -> m b
amarelo f ma = ma >>= (\a -> return (f a)) 

-- | Exercício 5. Implemente a função `vermelho`. O seu comportamento
-- pode ser inferido da sua assinatura dada abaixo

vermelho :: Monad m => (a -> b -> c) -> m a -> m b -> m c
vermelho f ma mb = ma >>= (\a -> mb >>= (\b -> return (f a b)))

-- | Exercício 6. Implemente a função `verde`. O seu comportamento
-- pode ser inferido da sua assinatura dada abaixo

verde :: Monad m => m a -> m (a -> b) -> m b
verde ma mf = mf >>= (\f -> ma >>= (\a -> return (f a)))

-- | Exercício 7. Implemente a função `laranja`. O seu comportamento
-- pode ser inferido da sua assinatura dada abaixo. Dica, use
-- recursão.

laranja :: Monad m => [m a] -> m [a]
laranja = undefined

-- | Exercício 8. Implemente a função `roxo`. O seu comportamento
-- pode ser inferido da sua assinatura dada abaixo. Dica, use
-- a funçao `laranja` e `amarelo`.

roxo :: Monad m => [a] -> (a -> m b) -> m [b]
roxo = undefined

-- | Exercício 9. Quase todas as funções com nomes de cores acima
-- estão disponíveis na biblioteca padrão do Haskell. Você consegue
-- identificá-las?
{-
Com base em pesquisas das assinaturas no Hoogle foi possível identificar que:
* Azul => Função join (https://hoogle.haskell.org/?hoogle=Monad%20m%20%3D%3E%20m%20(m%20a)%20-%3E%20m%20a)
* Amarelo => Função lift (https://hoogle.haskell.org/?hoogle=Monad%20m%20%3D%3E%20(a%20-%3E%20b)%20-%3E%20m%20a%20-%3E%20m%20b)
* Vermelho => Função liftM2 (https://hackage.haskell.org/package/base-4.17.0.0/docs/Control-Monad.html#v:liftM2)
* Verde => Função ap (https://hoogle.haskell.org/?hoogle=ap&scope=set%3Astackage)

-}