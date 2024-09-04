-- Scripts DDL

-- ENUMS:
CREATE TYPE tipo_sala AS ENUM ('Comum', 'Boss');
CREATE TYPE status_missao AS ENUM ('Em andamento', 'Concluido');
CREATE TYPE passiva_boss AS ENUM ('Vida', 'Defesa', 'Ataque');
CREATE TYPE nome_classe AS ENUM ('Assassino', 'Mago', 'Tanque', 'Espadachim');
CREATE TYPE atributo AS ENUM ('Vida', 'Defesa', 'Ataque', 'Magia');
CREATE TYPE tipo_decisao AS ENUM ('Aceitar', 'Recusar', 'Ignorar');
CREATE TYPE tipo_estacao AS ENUM ('Outono', 'Inverno', 'Primavera', 'Verao');
CREATE TYPE tipo_item AS ENUM ('Consumivel', 'Arma');
CREATE TYPE tipo_efeito AS ENUM ('Ataque', 'Magia', 'Cura');

-- Tabelas:
CREATE TABLE Localizacao (
    id_localizacao SERIAL PRIMARY KEY,
    andar INTEGER NOT NULL,
    descricao VARCHAR NOT NULL,
    estacao tipo_estacao NOT NULL,
    localizacao_anterior INTEGER,
    localizacao_posterior INTEGER,
    CONSTRAINT FK_Localizacao_Anterior FOREIGN KEY (localizacao_anterior) REFERENCES Localizacao (id_localizacao),
    CONSTRAINT FK_Localizacao_Posterior FOREIGN KEY (localizacao_posterior) REFERENCES Localizacao (id_localizacao)
);

CREATE TABLE Sala (
    id_sala SERIAL PRIMARY KEY,
    nome VARCHAR NOT NULL,
    tipo tipo_sala NOT NULL,
    sala_anterior INTEGER,
    sala_posterior INTEGER,
    id_localizacao INTEGER NOT NULL,
    CONSTRAINT FK_Sala_Anterior FOREIGN KEY (sala_anterior) REFERENCES Sala (id_sala),
    CONSTRAINT FK_Sala_Posterior FOREIGN KEY (sala_posterior) REFERENCES Sala (id_sala),
    CONSTRAINT FK_Sala_Localizacao FOREIGN KEY (id_localizacao) REFERENCES Localizacao (id_localizacao)
);

CREATE TABLE Item (
    id_item SERIAL PRIMARY KEY,
    nome VARCHAR NOT NULL,
    tipo tipo_item NOT NULL,
    descricao VARCHAR NOT NULL,
    buff INTEGER NOT NULL,
    efeito tipo_efeito NOT NULL
);

CREATE TABLE Inventario (
    id_inventario SERIAL PRIMARY KEY,
    qnt_max INTEGER NOT NULL
);

CREATE TABLE Inventario_Item (
    id_inventario INTEGER NOT NULL,
    id_item INTEGER NOT NULL,
    PRIMARY KEY (id_inventario, id_item),
    CONSTRAINT FK_Inventario_Item_Inventario FOREIGN KEY (id_inventario) REFERENCES Inventario (id_inventario),
    CONSTRAINT FK_Inventario_Item_Item FOREIGN KEY (id_item) REFERENCES Item (id_item)
);

CREATE TABLE Inimigo (
    id_inimigo SERIAL PRIMARY KEY,
    nome VARCHAR NOT NULL,
    ataque INTEGER NOT NULL,
    defesa INTEGER NOT NULL,
    item_drop INTEGER NOT NULL,
    CONSTRAINT FK_Inimigo_Drop FOREIGN KEY (item_drop) REFERENCES Item (id_item)
);

CREATE TABLE Boss (
    id_boss SERIAL PRIMARY KEY,
    passiva passiva_boss NOT NULL,
    id_inimigo INTEGER NOT NULL,
    buff INTEGER NOT NULL,
    CONSTRAINT FK_Boss_Inimigo FOREIGN KEY (id_inimigo) REFERENCES Inimigo (id_inimigo)
);

CREATE TABLE Mob (
    id_mob SERIAL PRIMARY KEY,
    id_inimigo INTEGER NOT NULL,
    CONSTRAINT FK_Mob_Inimigo FOREIGN KEY (id_inimigo) REFERENCES Inimigo (id_inimigo)
);

CREATE TABLE Instancia_Inimigo (
    id_instancia SERIAL PRIMARY KEY,
    vida INTEGER NOT NULL,
    sala_atual INTEGER NOT NULL,
    id_inimigo INTEGER NOT NULL,
    CONSTRAINT FK_Instancia_Inimigo_Sala FOREIGN KEY (sala_atual) REFERENCES Sala (id_sala),
    CONSTRAINT FK_Instancia_Inimigo_Inimigo FOREIGN KEY (id_inimigo) REFERENCES Inimigo (id_inimigo)
);

CREATE TABLE Missao (
    id_missao SERIAL PRIMARY KEY,
    nome VARCHAR NOT NULL,
    descricao VARCHAR NOT NULL,
    recompensa_xp INTEGER NOT NULL,
    status status_missao NOT NULL
);

CREATE TABLE NPC (
    id_npc SERIAL PRIMARY KEY,
    profissao INTEGER NOT NULL,
    nome VARCHAR NOT NULL,
    fala VARCHAR NOT NULL,
    item_drop INTEGER NOT NULL,
    missao INTEGER,
    CONSTRAINT FK_NPC_Drop FOREIGN KEY (item_drop) REFERENCES Item (id_item),
    CONSTRAINT FK_NPC_Missao FOREIGN KEY (missao) REFERENCES Missao (id_missao)
);

CREATE TABLE Instancia_NPC (
    id_instancia_npc SERIAL PRIMARY KEY,
    sala_atual INTEGER NOT NULL,
    id_npc INTEGER NOT NULL,
    CONSTRAINT FK_NPC_Sala FOREIGN KEY (sala_atual) REFERENCES Sala (id_sala),
    CONSTRAINT FK_Instancia_NPC_NPC FOREIGN KEY (id_npc) REFERENCES NPC (id_npc)
);

CREATE TABLE Classe (
    id_classe SERIAL PRIMARY KEY,
    nome nome_classe NOT NULL,
    descricao VARCHAR NOT NULL,
    atributo_melhorado atributo NOT NULL,
    buff INTEGER NOT NULL
);

CREATE TABLE Jogador (
    id_jogador SERIAL PRIMARY KEY,
    xp INTEGER NOT NULL,
    nivel INTEGER NOT NULL,
    defesa INTEGER NOT NULL,
    magia INTEGER NOT NULL,
    ataque INTEGER NOT NULL,
    vida INTEGER NOT NULL,
    nome VARCHAR NOT NULL,
    inventario INTEGER NOT NULL,
    item_atual INTEGER,
    classe INTEGER NOT NULL,
    sala_atual INTEGER NOT NULL,
    CONSTRAINT FK_Jogador_Inventario FOREIGN KEY (inventario) REFERENCES Inventario (id_inventario),
    CONSTRAINT FK_Jogador_Item FOREIGN KEY (item_atual) REFERENCES Item (id_item),
    CONSTRAINT FK_Jogador_Classe FOREIGN KEY (classe) REFERENCES Classe (id_classe),
    CONSTRAINT FK_Jogador_Sala FOREIGN KEY (sala_atual) REFERENCES Sala (id_sala)
);

CREATE TABLE Batalha (
    id_batalha SERIAL PRIMARY KEY,
    venceu BOOLEAN NOT NULL,
    id_instancia INTEGER NOT NULL,
    id_jogador INTEGER NOT NULL,
    CONSTRAINT FK_Batalha_Instancia FOREIGN KEY (id_instancia) REFERENCES Instancia_Inimigo (id_instancia),
    CONSTRAINT FK_Batalha_Jogador FOREIGN KEY (id_jogador) REFERENCES Jogador (id_jogador)
);

CREATE TABLE Dialogo (
    id_dialogo SERIAL PRIMARY KEY,
    decisao tipo_decisao NOT NULL,
    id_npc INTEGER NOT NULL,
    id_jogador INTEGER NOT NULL,
    CONSTRAINT FK_Dialogo_NPC FOREIGN KEY (id_npc) REFERENCES NPC (id_npc),
    CONSTRAINT FK_Dialogo_Jogador FOREIGN KEY (id_jogador) REFERENCES Jogador (id_jogador)
);

CREATE TABLE Jogador_Missao (
    id_jogador INTEGER NOT NULL,
    id_missao INTEGER NOT NULL,
    PRIMARY KEY (id_jogador, id_missao),
    CONSTRAINT FK_Jogador_Missao_Jogador FOREIGN KEY (id_jogador) REFERENCES Jogador (id_jogador),
    CONSTRAINT FK_Jogador_Missao_Missao FOREIGN KEY (id_missao) REFERENCES Missao (id_missao)
);
