-- Consulta 1: Total de inscritos por categoria;
-- O Anunciante deseja saber o total de inscritos por categoria para poder fazer uma análise
-- de qual categoria é mais popular e onde ele pode investir mais em propagandas.
-- Retorno esperado:
-- Categoria | Total de Inscritos
-- Comédia	 | 38840
-- Jogos     | 500397
-- Música    | 50061
SELECT cat.Nome AS Categoria, SUM(c.NumerodeInscritos) AS Total_de_Inscritos
FROM (
    SELECT DISTINCT c.Nome, c.NumerodeInscritos, v.categoria
    FROM CANAIS c
    JOIN VIDEOS v ON c.Nome = v.canal
) c
JOIN CATEGORIAS cat ON c.categoria = cat.Nome
GROUP BY cat.Nome
HAVING SUM(c.NumerodeInscritos) > 22000;

-- Consulta 2: Canais a serem monetizados;
-- O Youtube deseja identificar os canais que possuem mais de 1000 inscritos e mais de 2 video
-- para serem monetizados, para isso foi elaborada essa consulta.
-- Retorno esperado:
-- Canal        	| Numero de Inscritos
-- Aqueles Caras	| 38840
-- CazéTv       	| 12354
-- Podpah			| 50061
SELECT c.Nome AS Canal, c.NumerodeInscritos
FROM CANAIS c
JOIN VIDEOS v ON c.Nome = v.canal
WHERE c.NumerodeInscritos > 1000 AND (
    SELECT COUNT(*)
    FROM VIDEOS v2
    WHERE v2.canal = c.Nome
) > 2
GROUP BY c.Nome, c.NumerodeInscritos;

-- Consulta 3: Videos em destaque;
-- O Youtube deseja identificar os vídeos que possuem mais likes que a média de likes 
-- de sua categoria para destacá-los em uma retrospectiva,
-- para isso foi elaborada essa consulta.
-- Retorno esperado:
-- Nome                     | Likes | Media Likes
-- Copa do mundo 2002       | 1000  | 566.67
-- Jogando jogos antigos    | 100   | 53.33
-- Sweet child o mine       | 100   | 75
-- Bohemian Rhapsody        | 100   | 75
-- Stand-up comedy          | 100   | 75
-- Como programar em C      | 100   | 75
SELECT v.Nome, v.likes, avg_likes.media_likes
FROM VIDEOS v
JOIN CATEGORIAS cat ON v.categoria = cat.Nome
JOIN (
    SELECT v2.categoria, AVG(v2.likes) AS media_likes
    FROM VIDEOS v2
    GROUP BY v2.categoria
) avg_likes ON v.categoria = avg_likes.categoria
WHERE v.likes > avg_likes.media_likes;


-- Consulta 4: Canais com mais likes que a média de likes dos vídeos;
-- O Youtube deseja identificar os canais que possuem mais likes que a média de likes
-- dos vídeos para exibir na pagina inicial do usuário, para isso foi elaborada essa consulta.
-- Retorno esperado:
-- Canal       | Categoria | Numero de Inscritos
-- CazéTv      | Espotes   | 12354
SELECT DISTINCT c.Nome AS Canal, cat.Nome AS Categoria, c.NumerodeInscritos
FROM CANAIS c
JOIN VIDEOS v ON c.Nome = v.canal
JOIN CATEGORIAS cat ON v.categoria = cat.Nome
WHERE v.likes > (
    SELECT AVG(likes)
    FROM VIDEOS
);

-- Consulta 5: Usuários que não contribuíram em nenhuma live
-- Streamer deseja listar os usuários que não contribuíram em nenhuma live para fazer um incentivo
-- a contribuição e a interação com o canal, melhorando a qualidade do conteúdo.
-- Retorno esperado:
-- Username
-- CazéTv
-- LUAN GAMEPLAY
-- Podpah
SELECT u.Username
FROM CONTA u
WHERE NOT EXISTS (
    SELECT 1
    FROM CONTRIBUICOES c
    WHERE c.username = u.Username
);

-- Consulta 6: Categorias de vídeos que possuem pelo menos uma propaganda;
-- O Youtube Products deseja fazer um levantamento das categorias de vídeos que possuem propagandas
-- para poder anunciar seus produtos junto a outros anunciantes em vídeos já monetizados
-- evitando adicionar suas propagandas na sua plataforma em vídeos que não possuem propagandas.
-- Retorno esperado:
-- Categoria:
-- Esportes
-- Jogos
-- Música
-- Comédia
-- Técnologia
SELECT DISTINCT cat.Nome AS categoria
FROM CATEGORIAS cat
JOIN VIDEOS v ON v.categoria = cat.Nome
JOIN PROPAGANDAS p ON v.propagandas = p.Id;


-- Consultas com a visão:

CREATE VIEW PlaylistVideosComCanal AS
SELECT 
    p.Nome AS Playlist, 
    v.Nome AS Video, 
    v.likes, 
    v.canal, 
    v.categoria
FROM 
    PLAYLISTS p
JOIN 
    VIDEOS v ON p.videos = v.Nome;


-- Consulta 7: Canal de que possui videos de um patrocinador (Nike);
-- O youtube deseja identificar os canais que possuem vídeos de um patrocinador específico
-- para poder fazer uma análise de quais canais estão sendo patrocinados por um patrocinador (Nike)
-- Retorno esperado:
-- Canal
-- CazéTv
SELECT DISTINCT pvc.canal
FROM PlaylistVideosComCanal pvc
JOIN PATROCINIOS pat ON pvc.canal = pat.canal
WHERE pat.nome = ? AND pvc.categoria = ?;

-- Consulta 8: Total de produtos anunciados em uma playlist
-- O Youtube Products deseja identificar o total de produtos anunciados em uma playlist
-- Retorno esperado:
-- Playlist         | Categoria | Total de Produtos
-- Todos os Videos  | Esportes  | 236.86
SELECT 
    pvc.Playlist,
    pvc.categoria,
    SUM(yp.preco) AS TotalPrecoProdutos
FROM 
    PlaylistVideosComCanal pvc
JOIN 
    PRODUTOS_ANUNCIADOS pa ON pvc.canal = pa.canal
JOIN 
    YOUTUBE_PRODUCTS yp ON pa.Cod_produto = yp.Cod_produto
WHERE 
    pvc.Playlist = 'Todos os Videos'
    AND pvc.categoria = 'Esportes'   
GROUP BY 
    pvc.Playlist, pvc.categoria;