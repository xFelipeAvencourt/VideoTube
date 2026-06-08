import sqlite3
import os

# Ler e executar o script de instâncias para configurar o banco de dados
with open('instancias.sql', 'r') as file:
    sql_script = file.read()

conn = sqlite3.connect('consultas.db')
cursor = conn.cursor()
cursor.executescript(sql_script)
conn.commit()

while True:
    cursor.close()
    print("Qual consulta deseja fazer? \n1)Inscritos por categorias\n", end='')
    print("2)Canais a serem monetizandos\n3)Videos em destaque \n", end='')
    print("4)Canais com likes\n5)Users sem donate\n", end='')
    print("6)Categorias que tem propaganda\n7)Canais patrocinados por certa marca\n", end='')
    print("8)Total de produtos anunciados em uma playlist\n", end='')
    print("9)Inserir nova tupla na tabela VIDEOS")
    print("10)Visualizar tabela\n0)Sair")
    opcao = int(input("Digite a opção desejada: "))
    os.system('cls' if os.name == 'nt' else 'clear')
    cursor = conn.cursor()
    match opcao:
        case 1:
            cursor.execute('''
                SELECT cat.Nome AS Categoria, SUM(c.NumerodeInscritos) AS Total_de_Inscritos
                FROM (
                SELECT DISTINCT c.Nome, c.NumerodeInscritos, v.categoria
                FROM CANAIS c
                JOIN VIDEOS v ON c.Nome = v.canal
                ) c
                JOIN CATEGORIAS cat ON c.categoria = cat.Nome
                GROUP BY cat.Nome
                HAVING SUM(c.NumerodeInscritos) > 22000;''')
            results = cursor.fetchall()
            print("\nCategoria\t| Total de Inscritos")
            for row in results:
                print(f"{row[0]}\t\t| {row[1]}")
        case 2:
            cursor.execute('''
            SELECT c.Nome AS Canal, c.NumerodeInscritos
            FROM CANAIS c
            JOIN VIDEOS v ON c.Nome = v.canal
            WHERE c.NumerodeInscritos > 1000 AND (
                SELECT COUNT(*)
                FROM VIDEOS v2
                WHERE v2.canal = c.Nome
            ) > 2
            GROUP BY c.Nome, c.NumerodeInscritos;''')
            results = cursor.fetchall()
            print("\nCanal\t\t\t| Numero de Inscritos")
            for row in results:
                print(f"{row[0]}\t\t\t| {row[1]}")
        case 3:
            cursor.execute('''
            SELECT v.Nome, v.likes, avg_likes.media_likes
            FROM VIDEOS v
            JOIN CATEGORIAS cat ON v.categoria = cat.Nome
            JOIN (
                SELECT v2.categoria, AVG(v2.likes) AS media_likes
                FROM VIDEOS v2
                GROUP BY v2.categoria
            ) avg_likes ON v.categoria = avg_likes.categoria
            WHERE v.likes > avg_likes.media_likes;''')
            results = cursor.fetchall()
            print("\nNome\t\t\t| Likes\t| Media de Likes")
            for row in results:
                print(f"{row[0]}\t\t\t| {row[1]}\t| {row[2]}")
        case 4:
            cursor.execute('''
            SELECT DISTINCT c.Nome AS Canal, cat.Nome AS Categoria, c.NumerodeInscritos
            FROM CANAIS c
            JOIN VIDEOS v ON c.Nome = v.canal
            JOIN CATEGORIAS cat ON v.categoria = cat.Nome
            WHERE v.likes > (
                SELECT AVG(likes)
                FROM VIDEOS);''')
            results = cursor.fetchall()
            print("\nCanal\t\t| Categoria\t| Numero de Inscritos")
            for row in results:
                print(f"{row[0]}\t\t| {row[1]}\t| {row[2]}")
        case 5:
            cursor.execute('''
            SELECT u.Username
            FROM CONTA u
            WHERE NOT EXISTS (
                SELECT 1
                FROM CONTRIBUICOES c
                WHERE c.username = u.Username);''')
            results = cursor.fetchall()
            print("\nUsername:")
            for row in results:
                print(row[0])
        case 6:
            cursor.execute('''
            SELECT DISTINCT cat.Nome AS categoria
            FROM CATEGORIAS cat
            JOIN VIDEOS v ON v.categoria = cat.Nome
            JOIN PROPAGANDAS p ON v.propagandas = p.Id;''')
            results = cursor.fetchall()
            print("\nCategoria:")
            for row in results:
                print(row[0])
        case 7:
            print("Qual marca gostaria de pesquisar?")
            marca = input("Digite o nome da marca: ")
            print("Qual categoria gostaria de pesquisar?")
            categoria = input("Digite a categoria: ")
            cursor = conn.cursor()
            cursor.execute('''
            SELECT DISTINCT pvc.canal
            FROM PlaylistVideosComCanal pvc
            JOIN PATROCINIOS pat ON pvc.canal = pat.canal
            WHERE pat.nome = ? AND pvc.categoria = ?;''', (marca,categoria))
            results = cursor.fetchall()
            print("\nCanal:")
            for row in results:
                print(row[0])
        case 8:
            cursor.execute('''
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
                pvc.Playlist, pvc.categoria;''')
            results = cursor.fetchall()
            print("\nPlaylist\t| Categoria\t| Total de Produtos")
            for row in results:
                print(f"{row[0]}\t| {row[1]}\t| {row[2]}")
        case 9:
            nome_video = input("Digite o nome do vídeo: ")
            nome_canal = input("Digite o nome do canal: ")
            cursor.execute('SELECT Nome FROM CANAIS WHERE Nome = ?', (nome_canal,))
            canal_existe = cursor.fetchone()
            if canal_existe:
                cursor.execute('''
                INSERT INTO TempVideoData (Nome, Likes, Canal)
                VALUES (?, ?, ?);''', (nome_video, 0 , nome_canal))
                conn.commit()
                print("Nova tupla inserida na tabela VIDEOS.")

            else:
                print("Esse canal não está na lista disponível.")
        case 10:
            tabela = input("Digite o nome da tabela que deseja visualizar: ")
            cursor = conn.cursor()
            cursor.execute(f'SELECT * FROM {tabela}')
            results = cursor.fetchall()
            for row in results:
                print(row)
        case 0:
            print("Encerrando o processamento.")
            break
        case _:
            print("Consulta invalida!")