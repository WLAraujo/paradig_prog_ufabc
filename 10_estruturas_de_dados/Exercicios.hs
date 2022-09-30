module Exercicios where

import qualified Data.List.Zipper as Z

data Event a
  = ReplaceWith a
  | Forward Int
  | Backward Int
  deriving (Show)

data SnakesAndLadders
  = Path
  | Ladder
  | Snake
  deriving (Show, Eq)

class Eventable a where
  toEvents :: a -> [Event a]

instance Eventable SnakesAndLadders where
  toEvents Path   = []
  toEvents Ladder = [Forward 2]
  toEvents Snake  = [Backward 3]

-- | Helper function to make the game board
mkBoard :: [(Int, a)] -> [a]
mkBoard x = x >>= uncurry replicate

snlExampleBoard :: Z.Zipper SnakesAndLadders
snlExampleBoard =
  Z.fromList $
  mkBoard [(7, Path), (1, Ladder), (4, Path), (1, Snake), (2, Path)]

applyEvent :: Z.Zipper a -> Event a -> Z.Zipper a
applyEvent z e = 
  case e of
    ReplaceWith novo -> Z.replace novo z 
    Forward casas -> if (casas /= 0) && (not (Z.endp z)) then applyEvent (Z.right z) (Forward (casas-1)) else z
    Backward casas -> if (casas /= 0) && (not (Z.beginp z)) then applyEvent (Z.left z) (Backward (casas-1)) else z

applyEvents :: Z.Zipper a -> [Event a] -> Z.Zipper a
applyEvents z es = foldl applyEvent z es

applyDie :: Eventable a => Z.Zipper a -> Int -> Z.Zipper a
applyDie z n = 
  if (not (Z.endp (applyEvent z (Forward n)))) then applyEvents (applyEvent z (Forward n)) (toEvents (Z.cursor (applyEvent z (Forward n)))) else z

applyDice :: Eventable a => Z.Zipper a -> [Int] -> Z.Zipper a
applyDice z ns = foldl applyDie z ns

data TrilhaPacman
  = Vazio
  | Fruta
  | Biscoito
  | MeioBiscoito
  | Fantasma

instance Eventable TrilhaPacman where
  toEvents Vazio = []
  toEvents Fruta = [ReplaceWith Vazio, Forward 4]
  toEvents Biscoito = [ReplaceWith MeioBiscoito, Forward 2]
  toEvents MeioBiscoito = [ReplaceWith Vazio, Forward 2]
  toEvents Fantasma = [Backward 5]


