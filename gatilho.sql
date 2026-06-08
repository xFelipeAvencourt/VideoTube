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