-- Scripts DDL

-- ENUMS:
    CREATE TYPE tipo_sala AS ENUM ('Comum', 'Boss');
    CREATE TYPE status_missao AS ENUM ('Em andamento', 'Concluido');
    CREATE TYPE passiva_boss AS ENUM ('Vida', 'Defesa', 'Ataque');
    CREATE TYPE nome_classe AS ENUM ('Assassino', 'Mago', 'Tanque', 'Espadachim');
    CREATE TYPE atributo AS ENUM ('Vida', 'Defesa', 'Ataque', 'Magia');
    CREATE TYPE tipo_decisao AS ENUM ('Aceitar', 'Ignorar');
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

CREATE TABLE Instancia_Sala (
    id_instancia_sala SERIAL PRIMARY KEY,
    id_sala INTEGER NOT NULL,
    sala_anterior INTEGER,
    sala_posterior INTEGER,
    CONSTRAINT FK_Instancia_Sala_Sala FOREIGN KEY (id_sala) REFERENCES Sala (id_sala),
    CONSTRAINT FK_Sala_Anterior FOREIGN KEY (sala_anterior) REFERENCES Instancia_Sala (id_instancia_sala),
    CONSTRAINT FK_Sala_Posterior FOREIGN KEY (sala_posterior) REFERENCES Instancia_Sala (id_instancia_sala)
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

CREATE TABLE Missao (
    id_missao SERIAL PRIMARY KEY,
    nome VARCHAR NOT NULL,
    descricao VARCHAR NOT NULL,
    recompensa_xp INTEGER NOT NULL,
    status status_missao NOT NULL
);

CREATE TABLE Inimigo (
    id_inimigo SERIAL PRIMARY KEY,
    nome VARCHAR NOT NULL,
    ataque INTEGER NOT NULL,
    defesa INTEGER NOT NULL,
    item_drop INTEGER NOT NULL,
    xp INTEGER NOT NULL,
    id_missao INTEGER,
    CONSTRAINT FK_Inimigo_Drop FOREIGN KEY (item_drop) REFERENCES Item (id_item),
    CONSTRAINT FK_Inimigo_Missao FOREIGN KEY (id_missao) REFERENCES Missao (id_missao)
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
    CONSTRAINT FK_Instancia_Inimigo_Instancia_Sala FOREIGN KEY (sala_atual) REFERENCES Instancia_Sala (id_instancia_sala),
    CONSTRAINT FK_Instancia_Inimigo_Inimigo FOREIGN KEY (id_inimigo) REFERENCES Inimigo (id_inimigo)
);

CREATE TABLE NPC (
    id_npc SERIAL PRIMARY KEY,
    profissao VARCHAR NOT NULL,
    nome VARCHAR NOT NULL,
    fala VARCHAR NOT NULL,
    item_drop INTEGER,
    missao INTEGER,
    CONSTRAINT FK_NPC_Drop FOREIGN KEY (item_drop) REFERENCES Item (id_item),
    CONSTRAINT FK_NPC_Missao FOREIGN KEY (missao) REFERENCES Missao (id_missao)
);

CREATE TABLE Instancia_NPC (
    id_instancia_npc SERIAL PRIMARY KEY,
    sala_atual INTEGER NOT NULL,
    id_npc INTEGER NOT NULL,
    interagiu_jogador BOOLEAN NOT NULL,
    CONSTRAINT FK_Instancia_NPC_Instancia_Sala FOREIGN KEY (sala_atual) REFERENCES Instancia_Sala (id_instancia_sala),
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
    sala_atual INTEGER,
    CONSTRAINT FK_Jogador_Inventario FOREIGN KEY (inventario) REFERENCES Inventario (id_inventario),
    CONSTRAINT FK_Jogador_Item FOREIGN KEY (item_atual) REFERENCES Item (id_item),
    CONSTRAINT FK_Jogador_Classe FOREIGN KEY (classe) REFERENCES Classe (id_classe),
    CONSTRAINT FK_Jogador_Instancia_Sala FOREIGN KEY (sala_atual) REFERENCES Instancia_Sala (id_instancia_sala)
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
    id_instancia_npc INTEGER NOT NULL,
    id_jogador INTEGER NOT NULL,
    CONSTRAINT FK_Dialogo_Instancia_NPC FOREIGN KEY (id_instancia_npc) REFERENCES Instancia_NPC (id_instancia_npc),
    CONSTRAINT FK_Dialogo_Jogador FOREIGN KEY (id_jogador) REFERENCES Jogador (id_jogador)
);

CREATE TABLE Jogador_Missao (
    id_jogador INTEGER NOT NULL,
    id_missao INTEGER NOT NULL,
    PRIMARY KEY (id_jogador, id_missao),
    CONSTRAINT FK_Jogador_Missao_Jogador FOREIGN KEY (id_jogador) REFERENCES Jogador (id_jogador),
    CONSTRAINT FK_Jogador_Missao_Missao FOREIGN KEY (id_missao) REFERENCES Missao (id_missao)
);

-----------------------------------------------------------------------------------------
-- Procedures:

-- Procedure que instancia salas do primeiro andar e cria o jogador
CREATE OR REPLACE FUNCTION inicializarSalasPrimeiroAndar(
    xp_jogador INTEGER, 
    nivel_jogador INTEGER, 
    defesa_jogador INTEGER, 
    magia_jogador INTEGER, 
    ataque_jogador INTEGER, 
    vida_jogador INTEGER, 
    nome_jogador VARCHAR, 
    inventario_jogador INTEGER, 
    classe_jogador INTEGER)
RETURNS VOID AS
$$
DECLARE 
    primeira_sala INTEGER;
    segunda_sala INTEGER;
    terceira_sala INTEGER;
BEGIN    
    -- Inserindo as instâncias das salas do primeiro andar
    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (1, NULL, NULL) 
   	RETURNING id_instancia_sala INTO primeira_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (2, primeira_sala, NULL) 
   	RETURNING id_instancia_sala INTO segunda_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (3, segunda_sala, NULL) 
   	RETURNING id_instancia_sala INTO terceira_sala;

    -- Construindo os relacionamentos entre as instâncias de sala:
    UPDATE instancia_sala SET sala_posterior = segunda_sala
    WHERE id_instancia_sala = primeira_sala;
    
    UPDATE instancia_sala SET sala_posterior = terceira_sala
    WHERE id_instancia_sala = segunda_sala;

    -- Criando o Jogador
    INSERT INTO jogador (xp, nivel, defesa, magia, ataque, vida, nome, inventario, classe, sala_atual) 
    VALUES (xp_jogador, nivel_jogador, defesa_jogador, magia_jogador, ataque_jogador, vida_jogador, nome_jogador, inventario_jogador, classe_jogador, primeira_sala);

    -- Populando as salas do primeiro andar:
    -- Inserindo instâncias de mob e dragão
    INSERT INTO instancia_inimigo (vida, sala_atual, id_inimigo) values
    (60, primeira_sala, 1),
    (60, segunda_sala, 1),
    (60, segunda_sala, 1),
    (150, terceira_sala, 2);

    -- Inserindo instância de NPC
    INSERT INTO instancia_npc (sala_atual, id_npc, interagiu_jogador) values (primeira_sala, 1, FALSE);
    
END;
$$ LANGUAGE plpgsql;

-- Procedure de criação do mapa (Cria todas as instâncias de sala e popula elas)
CREATE OR REPLACE FUNCTION inicializarJogo(
	xp_jogador INTEGER, 
	nivel_jogador INTEGER, 
	defesa_jogador INTEGER, 
	magia_jogador INTEGER, 
	ataque_jogador INTEGER, 
	vida_jogador INTEGER, 
	nome_jogador VARCHAR, 
	inventario_jogador INTEGER, 
	classe_jogador INTEGER)
RETURNS VOID AS
$$
BEGIN
   	-- Salas do primeiro andar e criação do jogador:
   	PERFORM inicializarSalasPrimeiroAndar(xp_jogador, nivel_jogador, defesa_jogador, magia_jogador, ataque_jogador, vida_jogador, nome_jogador, inventario_jogador, classe_jogador);
END;
$$
LANGUAGE plpgsql;

-----------------------------------------------------------------------------------------
-- Triggers e stored procedures:

-- Stored Procedure responsável por fazer as devidas manipulações após a criação de um dialogo
CREATE OR REPLACE FUNCTION updateNpc()
RETURNS TRIGGER AS
$$
DECLARE
    interacao BOOLEAN;
    id_missao INTEGER;
    id_item_npc INTEGER;
    id_inventario_jogador INTEGER;
BEGIN 
    -- Vendo se o jogador já interagiu com o npc ou não
    SELECT interagiu_jogador INTO interacao 
    FROM instancia_npc 
    INNER JOIN npc USING (id_npc) 
    WHERE id_instancia_npc = NEW.id_instancia_npc;

    -- Pegando o inventário do jogador
    SELECT inventario INTO id_inventario_jogador 
    FROM jogador 
    WHERE id_jogador = NEW.id_jogador;
    
    -- Pegando a missão do NPC
    SELECT missao INTO id_missao 
    FROM instancia_npc 
    INNER JOIN npc USING (id_npc) 
    WHERE id_instancia_npc = NEW.id_instancia_npc;

    -- Pegando o item do NPC
    SELECT item_drop INTO id_item_npc 
    FROM instancia_npc 
    INNER JOIN npc USING (id_npc) 
    WHERE id_instancia_npc = NEW.id_instancia_npc;
       
   	-- Se a decisão for aceitar
    IF (NEW.decisao = 'Aceitar') THEN 
    	-- Se não tiver interação
        IF (NOT interacao) THEN
            -- Atualizando a tabela de instancia_npc, "Ele já dropou o item" e/ou "ele já dropou a missão"
            UPDATE instancia_npc SET interagiu_jogador = true 
            WHERE id_instancia_npc = NEW.id_instancia_npc;
        
            -- Atribuindo a missão ao jogador
            IF (id_missao IS NOT NULL) THEN
                INSERT INTO jogador_missao (id_jogador, id_missao) VALUES (NEW.id_jogador, id_missao);
            END IF;
        
            -- Atribuindo o item ao jogador
            IF (id_item_npc IS NOT NULL) THEN
                INSERT INTO inventario_item (id_inventario, id_item) VALUES (id_inventario_jogador, id_item_npc);
            END IF;
        END IF;
    END IF;

    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

-- Trigger responsável por fazer as devidas manipulações após a criação de um dialogo
CREATE TRIGGER updateNpc AFTER
INSERT
    ON dialogo FOR EACH ROW
EXECUTE PROCEDURE updateNpc ();

-----------------------------------------------------------------------------------------
-- Views:

-- View responsável por descrever as informações da sala atual do jogador
CREATE OR REPLACE VIEW sala_atual AS
	SELECT 
		i.id_instancia_sala,
		i.id_sala,
		l.id_localizacao,
		i.sala_anterior,
		i.sala_posterior,
		l.andar,
		l.descricao,
		l.estacao,
		s.nome,
		s.tipo
	FROM instancia_sala AS i 
	INNER JOIN sala AS s USING (id_sala) 
	INNER JOIN localizacao AS l using (id_localizacao);

-- View que mostra a missao de uma instancia de npc
CREATE OR REPLACE VIEW missao_instancia_npc AS
	SELECT i.id_instancia_npc, m.nome, m.descricao, m.recompensa_xp FROM missao m 
	INNER JOIN npc n ON m.id_missao = n.missao
	INNER JOIN instancia_npc i ON n.id_npc = i.id_npc;

-- View que mostra o item dropado por uma instancia de npc
CREATE OR REPLACE VIEW item_instancia_npc AS
	SELECT ins.id_instancia_npc, i.nome, i.descricao, i.tipo, i.buff, i.efeito FROM item i
	INNER JOIN npc n ON i.id_item = n.item_drop
	INNER JOIN instancia_npc ins ON n.id_npc = ins.id_npc;

-- View que lista os itens do jogador
CREATE OR REPLACE VIEW itens_jogador AS
	SELECT * FROM inventario_item ii
	INNER JOIN item i USING (id_item);

-- View que mostra o inventario do jogador
CREATE OR REPLACE VIEW inventario_jogador AS
		SELECT id_inventario, qnt_max, COUNT(id_item) AS qnt_itens FROM inventario
        INNER JOIN inventario_item USING (id_inventario)
        GROUP BY id_inventario;