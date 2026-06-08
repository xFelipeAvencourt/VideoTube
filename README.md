YouTube Analytics Database Project

**Dupla - Felipe Avencourt & Luiz Henryque Ramus Correa**

Descrição do Projeto:

Este projeto consiste em um sistema de banco de dados para gerenciamento e análise de dados do YouTube, desenvolvido como parte de um trabalho acadêmico. O sistema permite realizar diversas consultas analíticas sobre canais, vídeos, categorias, patrocínios e métricas de engajamento.

🗂️ Estrutura do Projeto:


├── integracao.py          # Interface principal do usuário (versão completa)
├── Integracao copy.py     # Versão inicial do sistema
├── instancias.sql         # Script de criação do banco de dados e inserção de dados
├── consultas.sql          # Definição das consultas analíticas
├── gatilho.sql            # Trigger para cópia de dados de vídeos
└── consultas.db           # Banco de dados SQLite (gerado automaticamente)

Modelo do Banco de Dados

Principais Tabelas
Tabela	Descrição
CONTA	Contas de usuários
CANAIS	Canais do YouTube
VIDEOS	Vídeos publicados
CATEGORIAS	Categorias de vídeos
PROPAGANDAS	Propagandas veiculadas
PATROCINIOS	Patrocínios de canais
ANUNCIANTES	Empresas anunciantes
LIVE	Transmissões ao vivo
CONTRIBUICOES	Doações/contribuições em lives
PLAYLISTS	Playlists de vídeos
Visões (Views)

    PlaylistVideosComCanal: Visão que combina playlists com informações dos vídeos e canais

Funcionalidades

O sistema oferece 10 consultas analíticas:
Opção	Consulta	Descrição
1	Inscritos por categorias	Total de inscritos por categoria (filtro > 22.000)
2	Canais a serem monetizados	Canais com >1.000 inscritos e >2 vídeos
3	Vídeos em destaque	Vídeos com mais likes que a média da categoria
4	Canais com likes	Canais com vídeos acima da média geral de likes
5	Users sem donate	Usuários que nunca contribuíram em lives
6	Categorias com propaganda	Categorias que possuem vídeos com propaganda
7	Canais patrocinados	Busca por marca e categoria específica
8	Total de produtos anunciados	Soma dos preços em playlist específica
9	Inserir nova tupla	Adicionar novo vídeo à tabela VIDEOS
10	Visualizar tabela	Exibir conteúdo de qualquer tabela

🚀 Como Executar
Pré-requisitos

    Python 3.x instalado

    Biblioteca SQLite3 (já inclusa no Python)

Passos

    Clone ou baixe os arquivos do projeto

    Execute o programa principal:
    bash

    python integracao.py

    O programa irá:

        Criar automaticamente o banco de dados consultas.db

        Executar o script instancias.sql para criar tabelas e inserir dados

        Apresentar o menu interativo

Exemplo de Uso

Qual consulta deseja fazer? 
1)Inscritos por categorias
2)Canais a serem monetizandos
3)Videos em destaque 
4)Canais com likes
5)Users sem donate
6)Categorias que tem propaganda
7)Canais patrocinados por certa marca
8)Total de produtos anunciados em uma playlist
9)Inserir nova tupla na tabela VIDEOS
10)Visualizar tabela
0)Sair

Digite a opção desejada: 1

Categoria       | Total de Inscritos
Comédia         | 38840
Jogos           | 500397
Música          | 50061

Funcionalidade de Trigger

O sistema inclui um trigger (after_video_insert) que automaticamente:

    Cria uma tabela TEMP_VIDEO para armazenamento secundário

    Toda vez que um vídeo é inserido na tabela VIDEOS, uma cópia é salva em TEMP_VIDEO

Dados de Exemplo

O banco já vem populado com dados de exemplo incluindo:

    Canais: Aqueles Caras, CazéTv, Podpah, BruninZor, LUAN GAMEPLAY

    Categorias: Esportes, Comédia, Tecnologia, Música, Jogos

    Anunciantes: Coca-Cola, Nike, Adidas, Ifood

    Vídeos: Conteúdos variados com diferentes métricas de likes

⚠️ Observações Importantes

    O banco de dados é recriado a cada execução do script principal

    Para manter dados persistentes, remova a execução automática do instancias.sql

    A opção 7 (Canais patrocinados) solicita entrada do usuário para marca e categoria

    A opção 8 está com valores fixos ("Todos os Videos" e "Esportes")
