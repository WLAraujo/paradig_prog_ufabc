-- Algoritmos Gulosos para Coloração em Grafos - Uma implementação funcional

-- Autores do projeto: Paulo Ricardo Cunha (11080312); Wesley Lima de Araujo (11201721514)
-- Link da apresentação: https://youtu.be/QgR0o5YqCxs

import Data.List
import Data.Maybe

-- Definindo arestas
data Aresta a = Aresta (a, a) deriving Show

-- Definindo operador de construção de aresta
(<-->) a b = Aresta (a, b)

-- Instanciando igualdade para arestas
instance Eq a => Eq (Aresta a) where
    (==) (Aresta (a1, b1)) (Aresta (a2, b2)) = (a1 == a2 && b1 == b2) || (a1 == b2 && a2 == b1)

-- Aqui criamos a estrutura grafo em si que é representado por uma lista de arestas
data Grafo a = Grafo [Aresta a] deriving Show

-- Função que produz lista de vértices baseado nas arestas do grafo
vertices :: Eq a => Grafo a -> [a]
vertices (Grafo arestas) = nub (concat [[a, b] | (Aresta (a, b)) <- arestas])

-- Função que devolve o vizinho de um determinado vértice dada uma aresta e tal vértice
vertice_vizinho :: Eq a => Aresta a -> a -> Maybe a
vertice_vizinho (Aresta (a, b)) vertice =
    if a == vertice then Just b
    else if b == vertice then Just a
    else Nothing

-- Função que mostra qual a vizinhança de um vértice usando a função acima
vizinhanca :: Eq a => Grafo a -> a -> [a]
vizinhanca (Grafo arestas) vertice = catMaybes([vertice_vizinho aresta vertice | aresta <- arestas])

-- Função que testa se dois vértices são adjacentes no grafo
adjacentes :: Eq a => Grafo a -> a -> a -> Bool
adjacentes (Grafo arestas) a b = elem (Aresta (a, b)) arestas

-- Função que verifica se um conjunto de vértices, já independente, é independente de um vértice
independente :: Eq a => Grafo a -> [a] -> a -> Bool
independente (Grafo arestas) conjunto vertice =
    not (elem True [adjacentes (Grafo arestas) elemento vertice | elemento <- conjunto])

-- Função auxiliar usada para alterar um valor numa lista dado um índice
trocar :: Int -> Int -> Int -> [Int] -> [Int]
trocar _ _ _ [] = []
trocar valor indice contador (x:xs) =
    if contador == indice then valor:xs
    else x:(trocar valor indice (contador + 1) xs)

-- Função que realiza de fato a coloração do algoritmo guloso
guloso_colorir :: (Eq a) => Grafo a -> [a] -> [Int] -> Int -> Int -> [Int]
guloso_colorir (Grafo arestas) ordem cores cor posicao =
    if (length ordem) == posicao then []
    else if independente (Grafo arestas) [ ordem!!indice | indice <- (elemIndices cor cores)] (ordem!!posicao) then cor:(guloso_colorir (Grafo arestas) ordem (trocar cor posicao 0 cores) 0 (posicao+1))
    else (guloso_colorir (Grafo arestas) ordem cores (cor+1) posicao)

-- Função que devolve a coloração gulosa de um grafo passado, serve como interface
guloso :: (Eq a) => Grafo a -> [a] -> [Int]
guloso (Grafo arestas) verts = guloso_colorir (Grafo arestas) verts (replicate (length verts) (-1)) 0 0

-- Função que retorna 1 se um determinado vértice já se encontra colorido caso não retorna 0. Os parâmetros são o grafo, o vértice e a coloração
vertice_colorido :: (Eq a) => Grafo a -> a -> [Int] -> Int
vertice_colorido (Grafo arestas) vertice coloracao =
    if (coloracao!!(fromJust(elemIndex vertice (vertices (Grafo arestas)))) /= -1) then 1
    else 0

-- Função que retorna a quantidade de vizinhos coloridos que um vértice possui
vizinhos_coloridos :: (Eq a) => Grafo a -> a -> [Int] -> Int
vizinhos_coloridos (Grafo arestas) vertice coloracao = foldl (+) 0 [vertice_colorido (Grafo arestas) vizinho coloracao | vizinho <- vizinhanca (Grafo arestas) vertice]

-- Função que devolve o grau de saturação de cada vértice no momento, passadas uma coloração parcial e um grafo
dsatur_grau :: (Eq a) => Grafo a -> [Int] -> [Int]
dsatur_grau (Grafo a) coloracao = [vizinhos_coloridos (Grafo a) vertice coloracao | vertice <- vertices (Grafo a)]

-- Função que colore um determinado vértice e devolve a coloracao após essa ação
dsatur_colorir :: (Eq a) => Grafo a -> [Int] -> Int -> [Int]
dsatur_colorir (Grafo a) coloracao cor = 
    if vertices_independentes == [] then dsatur_colorir (Grafo a) coloracao (cor+1)
    else trocar cor vertice_a_colorir 0 coloracao
    where 
        verts = vertices (Grafo a)
        vertices_a_colorir = elemIndices (-1) coloracao
        vertices_cor = [vertice | vertice <- verts, coloracao!!(fromJust(elemIndex vertice (vertices (Grafo a)))) == cor]
        vertices_independentes = [indice | indice <- vertices_a_colorir, independente (Grafo a) vertices_cor ((vertices (Grafo a))!!indice)]
        grau_independentes = [(dsatur_grau (Grafo a) coloracao)!!indice | indice <- vertices_independentes]
        maior_grau = elemIndex (maximum grau_independentes) grau_independentes
        vertice_a_colorir = vertices_independentes!!(fromJust(maior_grau))

-- Função que realiza as chamadas recursivas que constroem a coloração do grafo por grau de saturação
dsatur_construir :: (Eq a) => Grafo a -> [Int] -> [Int]
dsatur_construir (Grafo arestas) coloracao = 
    if (elemIndices (-1) coloracao) /= [] then dsatur_construir (Grafo arestas) (dsatur_colorir (Grafo arestas) coloracao 0)
    else coloracao 

-- Função que devolve a coloração após colorir o primeiro vértice que é um caso especial
dsatur_inicial :: (Eq a) => Grafo a -> a -> [Int]
dsatur_inicial (Grafo arestas) v_inicial = trocar 0 (fromJust(elemIndex v_inicial (vertices(Grafo arestas)))) 0 (replicate (length (vertices(Grafo arestas))) (-1))

-- Função que devolve a coloração gulosa de um grafo passado, serve como interface, também deve passar o vértice inicial da coloração
dsatur :: (Eq a) => Grafo a -> a -> [Int]
dsatur (Grafo arestas) v_inicial = dsatur_construir (Grafo arestas) (dsatur_inicial (Grafo arestas) v_inicial)