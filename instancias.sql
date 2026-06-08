-- DELETAR TODAS TABELAS A SEREM CRIADAS: --

DROP TABLE IF EXISTS CONTA;
DROP TABLE IF EXISTS CANAIS;
DROP TABLE IF EXISTS INSCRICOES;
DROP TABLE IF EXISTS COMENTARIOS;
DROP TABLE IF EXISTS YOUTUBE_PRODUCTS;
DROP TABLE IF EXISTS PRODUTOS_ANUNCIADOS;
DROP TABLE IF EXISTS ANUNCIANTES;
DROP TABLE IF EXISTS PATROCINIOS;
DROP TABLE IF EXISTS PROPAGANDAS;
DROP TABLE IF EXISTS VIDEOS;
DROP TABLE IF EXISTS LIVE;
DROP TABLE IF EXISTS PLAYLIST_NAME;
DROP TABLE IF EXISTS PLAYLISTS;
DROP TABLE IF EXISTS CATEGORIAS;
DROP TABLE IF EXISTS CONTRIBUICOES;

-- DROP VIEWs

DROP VIEW if EXISTS PlaylistVideosComCanal;


------------------------------------
-- CRIAR TABELAS DO BANCO DE DADOS -
------------------------------------

CREATE TABLE CONTA
(Username varchar(20) NOT NULL PRIMARY KEY,
senha varchar(35) NOT NULL,
email varchar(100) NOT NULL
);

CREATE TABLE CANAIS
(Nome varchar(20) NOT NULL PRIMARY KEY,
NumerodeInscritos INT,
NumerodeVisualizacao INT,
conta varchar(20) NOT NULL,
playlists varchar(50),
produtos INT,
comentarios INT,
live INT,
contribuicoes INT,
FOREIGN KEY (conta) REFERENCES CONTA(Nome),
FOREIGN KEY (playlists) REFERENCES PLAYLISTS(Nome),
FOREIGN KEY (produtos) REFERENCES YOUTUBE_PRODUCTS(Cod_produto),
FOREIGN KEY (comentarios) REFERENCES COMENTARIOS(Id),
FOREIGN KEY (contribuicoes) REFERENCES CONTRIBUICOES(Id)
);

CREATE TABLE INSCRICOES
(username varchar(20) NOT NULL,
canal varchar(20) NOT NULL,
PRIMARY KEY (username, canal),
FOREIGN KEY (username) REFERENCES CONTA(Username),
FOREIGN KEY (canal) REFERENCES CANAIS(nome)
);

CREATE TABLE COMENTARIOS
(Id INT PRIMARY KEY,
texto varchar(200) NOT NULL,
likes int,
username varchar(20) NOT NULL,
video varchar(50),
FOREIGN KEY (username) REFERENCES CANAIS(nome)
FOREIGN KEY (video) REFERENCES VIDEOS(Nome)
);

CREATE TABLE YOUTUBE_PRODUCTS
(Cod_produto INT NOT NULL PRIMARY KEY,
preco float NOT NULL
);

CREATE TABLE PRODUTOS_ANUNCIADOS
(Cod_produto NOT NULL,
canal varchar(20) NOT NULL,
PRIMARY KEY (Cod_produto, canal),
FOREIGN KEY (Cod_produto) REFERENCES YOUTUBE_PRODUCTS(Cod_produto),
FOREIGN KEY (canal) REFERENCES CANAIS(nome)
);

CREATE TABLE ANUNCIANTES
(Nome varchar(25) NOT NULL PRIMARY KEY,
cnpj varchar(14) NOT NULL
);

CREATE TABLE PATROCINIOS
(Id INT NOT NULL PRIMARY KEY,
custo float NOT NULL,
nome varchar(25) NOT NULL,
canal varchar(20) NOT NULL,
FOREIGN KEY (nome) REFERENCES ANUNCIANTES(Nome),
FOREIGN KEY (canal) REFERENCES CANAIS(nome)
);

CREATE TABLE PROPAGANDAS
(Id INT NOT NULL PRIMARY KEY,
conversao float,
autor varchar(25) NOT NULL,
video varchar(50),
FOREIGN KEY (autor) REFERENCES ANUNCIANTES(Nome),
FOREIGN KEY (video) REFERENCES VIDEO(Nome)
);

CREATE TABLE VIDEOS
(Nome varchar(50) NOT NULL PRIMARY KEY,
likes int,
canal varchar(20) NOT NULL,
categoria varchar(50),
propagandas INT, 
FOREIGN KEY (canal) REFERENCES CANAIS(nome),
FOREIGN KEY (categoria) REFERENCES CATEGORIAS(Nome),
FOREIGN KEY (propagandas) REFERENCES PROPAGANDAS(Id)
);

CREATE TABLE LIVE
(Nome varchar(50) NOT NULL PRIMARY KEY,
duracao time,
espectadores int,
username varchar(20),
contribuicoes INT,
FOREIGN KEY (username) REFERENCES CANAIS(nome),
FOREIGN KEY (contribuicoes) REFERENCES CONTRIBUICOES(Id)
);

CREATE TABLE PLAYLIST_NAME
(Nome varchar(50) NOT NULL PRIMARY KEY,
descricao varchar(200)
);

CREATE TABLE PLAYLISTS
(Nome varchar(50) NOT NULL,
videos varchar(50) NOT NULL,
PRIMARY KEY (Nome, videos),
FOREIGN KEY (Nome) REFERENCES PLAYLIST_NAME(Nome) on delete cascade,
FOREIGN KEY (videos) REFERENCES VIDEOS(Nome) on delete cascade
);

CREATE TABLE CATEGORIAS
(Nome varchar(50) NOT NULL PRIMARY KEY,
descricao varchar(200)
);

CREATE TABLE CONTRIBUICOES
(Id INT NOT NULL PRIMARY KEY,
username varchar(20) NOT NULL,
live varchar(50) NOT NULL, 
valor float NOT NULL,
FOREIGN KEY (username) REFERENCES CANAIS(nome),
FOREIGN KEY (live) REFERENCES LIVE(Nome)
);

-- INSERIR DADOS NAS TABELAS --

-- CONTA: (Username,senha,email,videos,playlist,produtos,comentarios,live,contribuicoes) --

insert into CONTA values ('AquelesCaras', 'Cripto@!#5874', 'aquelescarascontact@gmail.com');
insert into CONTA values ('CazéTv', 'TvnaCaze258', 'contatocazetv@gmail.com');
insert into CONTA values ('Podpah', 'Podpah@!#9988777', 'podpahcontatos@gmail.com');
insert into CONTA values ('BruninZor', '244466666', 'Brinocontatos@gmail.com');
insert into CONTA values ('LUAN GAMEPLAY', 'canaldoLu', 'luanzin@yahoo.com.br');
insert into CONTA values ('joao', '123', 'joao.vitor@gmail.com');

-- CANAIS: (nome, numero de inscritos, numero de visualizações, conta, playlist, produtos, comentarios, live, contribuicoes)
insert into CANAIS values ('Aqueles Caras', 38840, 1231321, 'Aqueles Caras', NULL, NULL, NULL, false, NULL);
insert into CANAIS values ('CazéTv', 12354, 454864, 'CazéTv', NULL, NULL, NULL, false, NULL);
insert into CANAIS values ('Podpah', 50061, 465413, 'Podpah', NULL, NULL, NULL, false, NULL);
insert into CANAIS values ('BruninZor', 156000, 2255755, 'BruninZor', NULL, NULL, NULL, false, NULL);
insert into CANAIS values ('LUAN GAMEPLAY', 500397, 9841231, 'LUAN GAMEPLAY', NULL, NULL, NULL, true, NULL);
insert into CANAIS values ('joao', 1, 256, 'joao', NULL, NULL, NULL, false, NULL);


-- Inscrições: (username, canal) --

INSERT INTO INSCRICOES values ('Aqueles Caras', 'CazéTv');
INSERT INTO INSCRICOES values ('Aqueles Caras', 'Podpah');
INSERT INTO INSCRICOES values ('Aqueles Caras', 'BruninZor');
INSERT INTO INSCRICOES values ('CazéTv', 'Aqueles Caras');
INSERT INTO INSCRICOES values ('CazéTv', 'Podpah');
INSERT INTO INSCRICOES values ('BruninZor', 'Aqueles Caras');
INSERT INTO INSCRICOES values ('BruninZor', 'CazéTv');
INSERT INTO INSCRICOES values ('Podpah', 'Aqueles Caras');
INSERT INTO INSCRICOES values ('Podpah', 'CazéTv');
INSERT INTO INSCRICOES values ('Podpah', 'BruninZor');
INSERT INTO INSCRICOES values ('joao', 'Aqueles Caras');
INSERT INTO INSCRICOES values ('joao', 'CazéTv');
INSERT INTO INSCRICOES values ('joao', 'Podpah');
INSERT INTO INSCRICOES values ('joao', 'BruninZor');
INSERT INTO INSCRICOES values ('joao', 'LUAN GAMEPLAY');

-- COMENTARIOS: (Id,texto,likes,username,nome) --

insert into COMENTARIOS values (1, 'Sobrou isso pro brasileiro... Vê vídeos antigos da seleção brasileira. Viramos todos santistas', 46, 'joao', 'Stand-up comedy');
insert into COMENTARIOS values (2, 'Pensar que o jogo mais duro dessa copa foi justamente nas quartas de finais, depois foi mamão com açúcar para o título.', 27, 'joao', 'Copa do Mundo 2006');
insert into COMENTARIOS values (3, 'Muito legal o video, ansioso pelo próximo!', 1007, 'BruninZor','Bohemian Rhapsody');
insert into COMENTARIOS values (4, 'Muito bom!', 10, 'joao', 'Fly with me');
insert into COMENTARIOS values (5, 'Adorei!', 5, 'joao','Como programar em C');

-- YOUTUBE_PRODUCTS: (Cod_produto,preco) --

insert into YOUTUBE_PRODUCTS values (1, 9.99);
insert into YOUTUBE_PRODUCTS values (2, 4.99);
insert into YOUTUBE_PRODUCTS values (3, 19.95);
insert into YOUTUBE_PRODUCTS values (4, 34.90);
insert into YOUTUBE_PRODUCTS values (5, 49.99);
insert into YOUTUBE_PRODUCTS values (6, 49.99);
insert into YOUTUBE_PRODUCTS values (7, 59.99);
insert into YOUTUBE_PRODUCTS values (8, 58.99);
insert into YOUTUBE_PRODUCTS values (9, 49.99);
insert into YOUTUBE_PRODUCTS values (10, 72.00);

-- PRODUTOS_ANUNCIADOS: (Cod_produto,canal) --

INSERT INTO PRODUTOS_ANUNCIADOS VALUES (1, 'Aqueles Caras');
INSERT INTO PRODUTOS_ANUNCIADOS VALUES (2, 'Aqueles Caras');
INSERT INTO PRODUTOS_ANUNCIADOS VALUES (3, 'CazéTv');
INSERT INTO PRODUTOS_ANUNCIADOS VALUES (4, 'Podpah');
INSERT INTO PRODUTOS_ANUNCIADOS VALUES (5, 'BruninZor');
INSERT INTO PRODUTOS_ANUNCIADOS VALUES (6, 'LUAN GAMEPLAY');
INSERT INTO PRODUTOS_ANUNCIADOS VALUES (7, 'joao');
INSERT INTO PRODUTOS_ANUNCIADOS VALUES (8, 'CazéTv');
INSERT INTO PRODUTOS_ANUNCIADOS VALUES (9, 'Podpah');
INSERT INTO PRODUTOS_ANUNCIADOS VALUES (10, 'BruninZor');

-- ANUNCIANTES: (Nome,cnpj) --

insert into ANUNCIANTES values ('Coca-Cola', '123456789012');
insert into ANUNCIANTES values ('Nike', '987654321098');
insert into ANUNCIANTES values ('Adidas', '5468741396855');
insert into ANUNCIANTES values ('Ifood', '56159678423119');

-- PATROCINIOS: (Id,custo,nome,canal) --

insert into PATROCINIOS values (1, 1000.00, 'Coca-Cola', 'Aqueles Caras');
insert into PATROCINIOS values (2, 5500.00, 'Nike', 'CazéTv');
insert into PATROCINIOS values (3, 800.00, 'Adidas', 'Aqueles Caras');
insert into PATROCINIOS values (4, 1500.00, 'Ifood', 'Podpah');

-- PROPAGANDAS: (Id,conversao,autor,video) --

insert into PROPAGANDAS values (1, 200.00, 'Coca-Cola', 'Aqueles Caras');
insert into PROPAGANDAS values (2, 100.00, 'Adidas', 'Aqueles Caras');
insert into PROPAGANDAS values (3, 100.00, 'Nike', 'CazéTv');
insert into PROPAGANDAS values (4, 100.00, 'Ifood', 'Podpah');

-- VIDEOS: (Nome,likes,canal,categoria,propagandas) --
insert into VIDEOS values ('Copa do Mundo 2002', 1000, 'CazéTv', 'Esportes', 1);
insert into VIDEOS values ('Copa do Mundo 2006', 500, 'CazéTv', 'Esportes', 2);
INSERT INTO VIDEOS values ('React Gols rodada 31 | CazéTv', 677, 'CazéTv', 'Esportes', 1);
insert into VIDEOS values ('Comparando jogos de hoje em dia', 50, 'LUAN GAMEPLAY', 'Jogos', 1);
insert into VIDEOS values ('ZERANDO Outer Wilds', 10, 'LUAN GAMEPLAY', 'Jogos', 3);
insert into VIDEOS values ('Sweet child o mine', 100, 'Podpah', 'Música', 2);
insert into VIDEOS values ('Stairway to Heaven', 50, 'Podpah', 'Música', 3);
insert into VIDEOS values ('Bohemian Rhapsody', 100, 'Podpah', 'Música', 4);
insert into VIDEOS values ('Fly with me', 50, 'Podpah', 'Música', 1);
insert into VIDEOS values ('Stand-up comedy', 100, 'Aqueles Caras', 'Comédia', 1);
insert into VIDEOS values ('Stand-up comedy 2', 50, 'Aqueles Caras', 'Comédia', 2);
insert into VIDEOS values ('Quem é o comediante?', 50, 'Aqueles Caras', 'Comédia', 2);
insert into VIDEOS values ('Como programar em C', 100, 'joao', 'Tecnologia', 3);
insert into VIDEOS values ('Como programar em Java', 50, 'joao', 'Tecnologia', 4);

-- LIVE: (Nome,duracao,espectadores,username,contribuicoes) --

insert into LIVE values ('TRANSMISSÃO FINALIZADA: GLOBE SOCCER AWARDS 2024 | EDIÇÃO DUBAI', '5:46:03', 48741, 'CazéTv', NULL);
insert into LIVE values ('AO VIVO JOGANDO OUTER WILDS | LUAN GAMEPLAY', '12:06:04', 7, 'LUAN GAMEPLAY', NULL);

-- PLAYLIST_NAME: (Nome,descricao) --
INSERT INTO PLAYLIST_NAME VALUES ('Todos os Videos', 'Playlist com todos os vídeos da base de dados');

-- PLAYLISTS: (Nome,video) --
INSERT INTO PLAYLISTS (Nome, videos)
SELECT 'Todos os Videos', Nome FROM VIDEOS;

-- CATEGORIAS: (Nome,descricao) --

insert into CATEGORIAS values ('Esportes', 'Videos relacionados a esportes');
insert into CATEGORIAS values ('Comédia', 'Videos engraçados');
insert into CATEGORIAS values ('Tecnologia', 'Videos relacionados a tecnologia');
insert into CATEGORIAS values ('Música', 'Videos relacionados a música');
insert into CATEGORIAS values ('Jogos', 'Videos relacionados a jogos');
insert into CATEGORIAS values ('Notícias', 'Videos relacionados a notícias');

-- CONTRIBUICOES: (Id,username,live,valor) --

insert into CONTRIBUICOES values (1, 'joao', 'TRANSMISSÃO FINALIZADA: GLOBE SOCCER AWARDS 2024 | EDIÇÃO DUBAI', 10.00);
insert into CONTRIBUICOES values (2, 'joao', 'TRANSMISSÃO FINALIZADA: GLOBE SOCCER AWARDS 2024 | EDIÇÃO DUBAI', 5.00);
insert into CONTRIBUICOES values (3, 'joao', 'TRANSMISSÃO FINALIZADA: GLOBE SOCCER AWARDS 2024 | EDIÇÃO DUBAI', 9.99);
insert into CONTRIBUICOES values (4, 'BruninZor', 'TRANSMISSÃO FINALIZADA: GLOBE SOCCER AWARDS 2024 | EDIÇÃO DUBAI', 100);
insert into CONTRIBUICOES values (5, 'BruninZor', 'TRANSMISSÃO FINALIZADA: GLOBE SOCCER AWARDS 2024 | EDIÇÃO DUBAI', 50);
insert into CONTRIBUICOES values (6, 'BruninZor', 'TRANSMISSÃO FINALIZADA: GLOBE SOCCER AWARDS 2024 | EDIÇÃO DUBAI', 50);
insert into CONTRIBUICOES values (7, 'BruninZor', 'TRANSMISSÃO FINALIZADA: GLOBE SOCCER AWARDS 2024 | EDIÇÃO DUBAI', 500);
insert into CONTRIBUICOES values (8, 'Aqueles Caras', 'TRANSMISSÃO FINALIZADA: GLOBE SOCCER AWARDS 2024 | EDIÇÃO DUBAI', 50);

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

CREATE TABLE IF NOT EXISTS TEMP_VIDEO
(
    nome varchar(50) NOT NULL PRIMARY KEY,
    likes int,
    canal varchar(20) NOT NULL,
    categoria varchar(50),
    propagandas INT,
    FOREIGN KEY (canal) REFERENCES CANAIS(nome),
    FOREIGN KEY (categoria) REFERENCES CATEGORIAS(Nome),
    FOREIGN KEY (propagandas) REFERENCES PROPAGANDAS(Id)
);

CREATE TRIGGER after_video_insert
AFTER INSERT ON VIDEOS
FOR EACH ROW
BEGIN
    INSERT INTO TEMP_VIDEO (Nome, likes, canal, categoria, propagandas)
    VALUES (NEW.Nome, NEW.likes, NEW.canal, NEW.categoria, NEW.propagandas);
END;