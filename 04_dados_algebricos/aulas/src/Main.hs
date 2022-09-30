-- A palavra type cria um apelido para um tipo
-- A partir do momento que um type está definido ele existe para o nosso módulo
type Produto = (Integer, String, Double)
type Cliente = (Integer, String, Double)

-- Assim podemos usar esses tipos criados em funções de maneira mais definida e com maior valor semântico
atualizaPreco :: Produto -> Double -> Produto
atualizaPreco (idProduto, nome, preco) inflacao = (idProduto, nome, preco*(1+inflacao))

-- Também podemos criar funções auxiliares que extraem algo do tipo
preco :: Produto -> Double
preco (_, _, p) = p

-- Criando um dicionário (Array associativo) usando um tipo de dado algébrico
-- Trata-se de uma lista de tuplas
type Assoc k v = [(k,v)]

-- Podemos criar novos tipos de dados mesmo, não apenas apelidos para certas estruturas
-- Permite maior flexibilidade e capacidade de checagem em tempo de compilação
-- Existem algumas formas de criar esse tipo de dado: soma, produto, recursivo, etc

-- TIPO SOMA --------------------------------------------------------------------------------------
-- Trata-se da criação de tipos que são a união de diferentes valores
-- Booleanos são um tipo criado por soma

data Bool = False | True

-- Ou seja, criei um tipo que só pode possuir esses dois diferentes valores

data Direcao = Norte | Sul | Leste | Oeste
                deriving Show

-- `deriving Show` permite também usar esses valores como string além de uma possibilidade de Direcao
-- A primeira letra dos valores possíveis deve ser maiúsculas

-- Usando o Direcao vamos criar um apelido de tipo e uma função que use ambos
type Coord = (Int, Int)
type Passo = Coord -> Coord
para :: Direcao -> Passo
para Norte (x, y) = (x, y+1)
para Sul (x, y) = (x, y-1)
para Leste (x, y) = (x+1, y)
para Oeste (x, y) = (x-1, y)

-- TIPO PRODUTO -------------------------------------------------------------------------------------
-- O tipo produto envolve um construtor de nome livre que envelopa tipos
-- Por exemplo, segue um exemplo do tipo ponto que seriam dois valores Double

data Ponto = ConstPonto Double Double
              deriving Show

-- Na construção de ponto estamos falando que Ponto pode assumir qualquer valor no espaço Double x Double
-- Vamos contruir uma função que calcula a distância euclidiana entre dois pontos usando nosso tipo ponto

dist :: Ponto -> Ponto -> Double
dist (ConstPonto x y) (ConstPonto x' y') = sqrt $ (x - x')^2 + (y-y')^2 

-- MISTURANDO SOMA E PRODUTO --------------------------------------------------------------------------
-- Abaixo criamos um tipo forma que é resultado de Soma entre um Produto que define Circulo ou Retangulo
-- Ou seja, temos dois envelopadores que nada mais são que funções construtoras que envelopam um tipo de fato

data Forma = Circulo Ponto Double | Retangulo Ponto Double Double

-- Usando uma função vamos criar um quadrado usando o construtor Retangulo

quadrado :: Ponto -> Double -> Forma
quadrado p l = Retangulo p l l

-- TIPOS PARAMÉTRICOS ----------------------------------------------------------------------------------
-- Também podemos construir novos tipos usando parâmetros de tipo, isso é podemos parametrizar qual o tipo envelopado no construtor quando definimos o valor/objeto

data PontoParametrico a = MkPonto a a

-- Veja que esse novo tipo Ponto recebe qual o tipo que será envelopado quando definido um objeto que usa esse ponto, podendo ser Int, Double, Float ou outros

-- TIPO MAYBE ---------------------------------------------------------------------------------------------
-- Usado quando temos computações que podem falhar
-- data Maybe a = Nothing | Just a

-- Por exemplo, uma função que talvez devolva a cabeça de uma lista
maybeHead :: [a] -> Maybe a
maybeHead [] = Nothing
maybeHead (x:xs) = Just x

-- TIPO EITHER --------------------------------------------------------------------------------------------
-- Tipo que te devolve um ou outro tipo
-- data Either a b = Left a | Right b

-- Usando o either vamos criar uma função que retorna ou o resultado de uma divisão ou uma mensagem
eitherDiv :: Int -> Int -> Either String Int
eitherDiv _ 0 = Left "Divisão por  0"
eitherDiv m n = Right (m `div` n)

-- TIPO RECURSIVO -------------------------------------------------------------------------------------------
-- São tipos que se invocam quando definidos, por exemplo listas, já que cada elemento chama o próximo que é do mesmo tipo (recursão)
-- data List a = Empty | Cons a (Lista a)
-- Cons 1 (Cons 2 (Cons 3 Vazia)) = 1 : 2 : 3 : []

-- ÁLGEBRA DOS TIPOS -----------------------------------------------------------------------------------------

-- Tipo Void, que só tem o nome do tipo mas não possui valores
data Zero 

-- Tipo Unit, só possui um valor
data Um = Um 