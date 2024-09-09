-- Scripts DDL

-- ENUMS:
    CREATE TYPE tipo_sala AS ENUM ('Comum', 'Boss');
    CREATE TYPE status_missao AS ENUM ('Em andamento', 'Concluida');
    CREATE TYPE passiva_boss AS ENUM ('Vida', 'Defesa', 'Ataque');
    CREATE TYPE nome_classe AS ENUM ('Assassino', 'Mago', 'Tanque', 'Espadachim');
    CREATE TYPE atributo AS ENUM ('Vida', 'Defesa', 'Ataque', 'Magia');
    CREATE TYPE tipo_decisao AS ENUM ('Aceitar', 'Ignorar');
    CREATE TYPE tipo_estacao AS ENUM ('Outono', 'Inverno', 'Primavera', 'Verao');
    CREATE TYPE tipo_item AS ENUM ('Consumivel', 'Arma');
    CREATE TYPE tipo_efeito AS ENUM ('Ataque', 'Magia', 'Cura', 'Defesa');

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
    id_inventario_item SERIAL PRIMARY KEY,
    id_inventario INTEGER NOT NULL,
    id_item INTEGER NOT NULL,
    CONSTRAINT FK_Inventario_Item_Inventario FOREIGN KEY (id_inventario) REFERENCES Inventario (id_inventario),
    CONSTRAINT FK_Inventario_Item_Item FOREIGN KEY (id_item) REFERENCES Item (id_item)
);

CREATE TABLE Missao (
    id_missao SERIAL PRIMARY KEY,
    nome VARCHAR NOT NULL,
    descricao VARCHAR NOT NULL,
    recompensa_xp INTEGER NOT NULL
);

CREATE TABLE Inimigo (
    id_inimigo SERIAL PRIMARY KEY,
    nome VARCHAR NOT NULL,
    ataque INTEGER NOT NULL,
    defesa INTEGER NOT NULL,
    item_drop INTEGER NOT NULL,
    xp INTEGER NOT NULL,
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
    CONSTRAINT FK_Instancia_Inimigo_Instancia_Sala FOREIGN KEY (sala_atual) REFERENCES Instancia_Sala (id_instancia_sala),
    CONSTRAINT FK_Instancia_Inimigo_Inimigo FOREIGN KEY (id_inimigo) REFERENCES Inimigo (id_inimigo)
);

CREATE TABLE Missao_Inimigo (
    id_missao INTEGER NOT NULL,
    id_inimigo INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    PRIMARY KEY (id_missao, id_inimigo),
    CONSTRAINT FK_Missao_Inimigo_Missao FOREIGN KEY (id_missao) REFERENCES Missao (id_missao),
    CONSTRAINT FK_Missao_Inimigo_Inimigo FOREIGN KEY (id_inimigo) REFERENCES Inimigo (id_inimigo)
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
    status STATUS_MISSAO NOT NULL,
    PRIMARY KEY (id_jogador, id_missao),
    CONSTRAINT FK_Jogador_Missao_Jogador FOREIGN KEY (id_jogador) REFERENCES Jogador (id_jogador),
    CONSTRAINT FK_Jogador_Missao_Missao FOREIGN KEY (id_missao) REFERENCES Missao (id_missao)
);

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

-- View que mostra o inventario do jogador
CREATE OR REPLACE VIEW inventario_jogador AS
	SELECT 
		id_inventario, 
		qnt_max, 
		COUNT(CASE WHEN i.tipo = 'Arma' THEN 1 END) AS qnt_armas, 
		COUNT(CASE WHEN i.tipo = 'Consumivel' THEN 1 END) AS qnt_itens_consumiveis
	FROM inventario
	LEFT JOIN inventario_item USING (id_inventario)
	LEFT JOIN item i USING (id_item)
	GROUP BY id_inventario;

-- View que lista os itens do tipo arma do jogador
CREATE OR REPLACE VIEW armas_jogador AS
	SELECT * FROM inventario_item ii
	INNER JOIN item i USING (id_item)
    WHERE i.tipo = 'Arma';

-- View que lista os itens consumiveis do jogador
CREATE OR REPLACE VIEW itens_consumiveis_jogador AS
	SELECT * FROM inventario_item ii
	INNER JOIN item i USING (id_item)
    WHERE i.tipo = 'Consumivel';

-- View usada para mostrar o item atual do jogador
CREATE OR REPLACE VIEW item_atual AS
	SELECT 
		id_jogador,
		i.nome,
		i.descricao,
		i.buff,
		i.efeito
	FROM item i
	INNER JOIN jogador j 
	ON i.id_item = j.item_atual 
	WHERE i.tipo = 'Arma';

-- View responsável pelas informações dos jogadores
CREATE OR REPLACE VIEW informacao_jogadores AS
	SELECT 
		id_jogador, 
		xp, 
		nivel, 
		defesa, 
		magia, 
		ataque, 
		vida, 
		j.nome, 
		inventario, 
		item_atual, 
		classe, 
		sala_atual, 
		c.nome as nome_classe 
	FROM jogador AS j 
	INNER JOIN classe AS c 
	ON j.classe = c.id_classe;

-- View que lista todas as instâncias de boss vivas
CREATE OR REPLACE VIEW boss_vivo AS
	SELECT * FROM instancia_inimigo 
    INNER JOIN inimigo USING (id_inimigo) 
    INNER JOIN boss USING (id_inimigo)
    WHERE vida > 0;

-- View que lista todas as instâncias de mob vivas
CREATE OR REPLACE VIEW mob_vivo AS
		SELECT * FROM instancia_inimigo 
        INNER JOIN inimigo USING (id_inimigo) 
        INNER JOIN mob USING (id_inimigo)
        WHERE vida > 0;

-- View que lista os inimigos que devem estar com a vida zerada pra missao ser concluida
CREATE OR REPLACE VIEW instancia_inimigo_missao AS
	SELECT 
		m.id_missao,
		jm.id_jogador,
		i.id_inimigo,
		ii.vida,
		i.nome AS nome_inimigo
	FROM missao m 
	INNER JOIN jogador_missao jm
	USING (id_missao)
	INNER JOIN missao_inimigo mi 
	USING (id_missao)
	INNER JOIN instancia_inimigo ii 
	USING (id_inimigo)
	INNER JOIN inimigo i 
	USING (id_inimigo)
	WHERE jm.status = 'Em andamento' 
	AND ii.vida > 0;

-- View que lista as missões em andamento de um jogador
CREATE OR REPLACE VIEW missao_andamento AS
	SELECT 
		id_jogador,
		id_missao,
		id_inimigo,
		m.nome,
		descricao,
		recompensa_xp,
		status
	FROM missao m 
	INNER JOIN jogador_missao jm
	USING (id_missao)
	INNER JOIN missao_inimigo mi 
	USING (id_missao)
	INNER JOIN inimigo i 
	USING (id_inimigo)
	WHERE jm.status = 'Em andamento';

-- View que lista as missões em andamento de um jogador
CREATE OR REPLACE VIEW missao_concluida AS
	SELECT 
		id_jogador,
		id_missao,
		id_inimigo,
		m.nome,
		descricao,
		recompensa_xp,
		status
	FROM missao m 
	INNER JOIN jogador_missao jm
	USING (id_missao)
	INNER JOIN missao_inimigo mi 
	USING (id_missao)
	INNER JOIN inimigo i 
	USING (id_inimigo)
	WHERE jm.status = 'Concluida';

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
RETURNS INTEGER AS
$$
DECLARE 
    primeira_sala INTEGER;
    segunda_sala INTEGER;
    terceira_sala INTEGER;
    quarta_sala INTEGER;
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

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (4, terceira_sala, NULL) 
   	RETURNING id_instancia_sala INTO quarta_sala;

    -- Construindo os relacionamentos entre as instâncias de sala:
    UPDATE instancia_sala SET sala_posterior = segunda_sala
    WHERE id_instancia_sala = primeira_sala;
    
    UPDATE instancia_sala SET sala_posterior = terceira_sala
    WHERE id_instancia_sala = segunda_sala;

    UPDATE instancia_sala SET sala_posterior = quarta_sala
    WHERE id_instancia_sala = terceira_sala;

    -- Criando o Jogador
    INSERT INTO jogador (xp, nivel, defesa, magia, ataque, vida, nome, inventario, classe, sala_atual) 
    VALUES (xp_jogador, nivel_jogador, defesa_jogador, magia_jogador, ataque_jogador, vida_jogador, nome_jogador, inventario_jogador, classe_jogador, primeira_sala);

    -- Populando as salas do primeiro andar:
    -- Inserindo instâncias de mob e dragão
    INSERT INTO instancia_inimigo (vida, sala_atual, id_inimigo) values
    (60, segunda_sala, 1),
    (60, segunda_sala, 1),
    (60, terceira_sala, 1),
    (120, quarta_sala, 2);--BOSS ORC

    -- Inserindo instância de NPC
    INSERT INTO instancia_npc (sala_atual, id_npc, interagiu_jogador) values (primeira_sala, 1, FALSE);
    INSERT INTO instancia_npc (sala_atual, id_npc, interagiu_jogador) values (primeira_sala, 2, FALSE);
   
   	RETURN quarta_sala;
END;
$$ LANGUAGE plpgsql;
---------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION inicializarSalasSegundoAndar(quarta_sala INTEGER)
RETURNS INTEGER AS
$$
DECLARE 
    quinta_sala INTEGER;
    sexta_sala INTEGER;
    setima_sala INTEGER;
    oitava_sala INTEGER;
BEGIN    
    -- Inserindo as instâncias das salas do segundo andar
    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (5, quarta_sala, NULL) 
   	RETURNING id_instancia_sala INTO quinta_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (6, quinta_sala, NULL) 
   	RETURNING id_instancia_sala INTO sexta_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (7, sexta_sala, NULL) 
   	RETURNING id_instancia_sala INTO setima_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (8, setima_sala, NULL) 
   	RETURNING id_instancia_sala INTO oitava_sala;

    -- Construindo os relacionamentos entre as instâncias de sala:
    UPDATE instancia_sala SET sala_posterior = sexta_sala
    WHERE id_instancia_sala = quinta_sala;
    
    UPDATE instancia_sala SET sala_posterior = setima_sala
    WHERE id_instancia_sala = sexta_sala;

    UPDATE instancia_sala SET sala_posterior = oitava_sala
    WHERE id_instancia_sala = setima_sala;

    -- Populando as salas do primeiro andar:
    -- Inserindo instâncias de mob e dragão
    INSERT INTO instancia_inimigo (vida, sala_atual, id_inimigo) values
    (80, sexta_sala, 4),
    (80, setima_sala, 4),
    (80, setima_sala, 4),
    (150, oitava_sala, 3);--BOSS GELIDUS

    -- Inserindo instância de NPC
    INSERT INTO instancia_npc (sala_atual, id_npc, interagiu_jogador) values (sexta_sala, 3, FALSE);
    INSERT INTO instancia_npc (sala_atual, id_npc, interagiu_jogador) values (quinta_sala, 4, FALSE);
   
   RETURN oitava_sala;
END;
$$ LANGUAGE plpgsql;
----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION inicializarSalasTerceiroAndar(oitava_sala INTEGER)
RETURNS INTEGER AS
$$
DECLARE 
    nona_sala INTEGER;
    decima_sala INTEGER;
    decima_primeira_sala INTEGER;
    decima_segunda_sala INTEGER;
BEGIN    
    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (9, oitava_sala, NULL) 
    RETURNING id_instancia_sala INTO nona_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (10, nona_sala, NULL) 
    RETURNING id_instancia_sala INTO decima_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (11, decima_sala, NULL) 
    RETURNING id_instancia_sala INTO decima_primeira_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (12, decima_primeira_sala, NULL) 
    RETURNING id_instancia_sala INTO decima_segunda_sala;

    UPDATE instancia_sala SET sala_posterior = decima_sala
    WHERE id_instancia_sala = nona_sala;
    
    UPDATE instancia_sala SET sala_posterior = decima_primeira_sala
    WHERE id_instancia_sala = decima_sala;

    UPDATE instancia_sala SET sala_posterior = decima_segunda_sala
    WHERE id_instancia_sala = decima_primeira_sala;


    INSERT INTO instancia_inimigo (vida, sala_atual, id_inimigo) values
    (100, decima_sala, 6),
    (100, decima_sala, 6),
    (100, decima_primeira_sala, 6),
    (165, decima_segunda_sala, 5);--BOSS MINOTAURO

    -- Inserindo instância de NPC
    INSERT INTO instancia_npc (sala_atual, id_npc, interagiu_jogador) values (nona_sala, 5, FALSE);
    INSERT INTO instancia_npc (sala_atual, id_npc, interagiu_jogador) values (nona_sala, 6, FALSE);
   
   	RETURN decima_segunda_sala INTEGER;
END;
$$ LANGUAGE plpgsql;
----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION inicializarSalasQuartoAndar(decima_segunda_sala INTEGER)
RETURNS INTEGER AS
$$
DECLARE 
    decima_terceira_sala INTEGER;
    decima_quarta_sala INTEGER;
    decima_quinta_sala INTEGER;
    decima_sexta_sala INTEGER;
BEGIN    
    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (13, decima_segunda_sala, NULL) 
    RETURNING id_instancia_sala INTO decima_terceira_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (14, decima_terceira_sala, NULL) 
    RETURNING id_instancia_sala INTO decima_quarta_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (15, decima_quarta_sala, NULL) 
    RETURNING id_instancia_sala INTO decima_quinta_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (16, decima_quinta_sala, NULL) 
    RETURNING id_instancia_sala INTO decima_sexta_sala;

    UPDATE instancia_sala SET sala_posterior = decima_quarta_sala
    WHERE id_instancia_sala = decima_terceira_sala;
    
    UPDATE instancia_sala SET sala_posterior = decima_quinta_sala
    WHERE id_instancia_sala = decima_quarta_sala;

    UPDATE instancia_sala SET sala_posterior = decima_sexta_sala
    WHERE id_instancia_sala = decima_quinta_sala;


    INSERT INTO instancia_inimigo (vida, sala_atual, id_inimigo) values
    (120, decima_quarta_sala, 8),
    (120, decima_quinta_sala, 8),
    (180, decima_sexta_sala, 7);--BOSS RAINHA DAS FADAS

    -- Inserindo instância de NPC
    INSERT INTO instancia_npc (sala_atual, id_npc, interagiu_jogador) values (decima_terceira_sala, 7, FALSE);
    INSERT INTO instancia_npc (sala_atual, id_npc, interagiu_jogador) values (decima_terceira_sala, 8, FALSE);
   
   	RETURN decima_sexta_sala;
END;
$$ LANGUAGE plpgsql;
----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION inicializarSalasQuintoAndar(decima_sexta_sala INTEGER)
RETURNS INTEGER AS
$$
DECLARE 
    decima_setima_sala INTEGER;
    decima_oitava_sala INTEGER;
    decima_nona_sala INTEGER;
    vigesima_sala INTEGER;
BEGIN    
    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (17, decima_sexta_sala, NULL) 
    RETURNING id_instancia_sala INTO decima_setima_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (18, decima_setima_sala, NULL) 
    RETURNING id_instancia_sala INTO decima_oitava_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (19, decima_oitava_sala, NULL) 
    RETURNING id_instancia_sala INTO decima_nona_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (20, decima_nona_sala, NULL) 
    RETURNING id_instancia_sala INTO vigesima_sala;

    UPDATE instancia_sala SET sala_posterior = decima_oitava_sala
    WHERE id_instancia_sala = decima_setima_sala;
    
    UPDATE instancia_sala SET sala_posterior = decima_nona_sala
    WHERE id_instancia_sala = decima_oitava_sala;

    UPDATE instancia_sala SET sala_posterior = vigesima_sala
    WHERE id_instancia_sala = decima_nona_sala;


    INSERT INTO instancia_inimigo (vida, sala_atual, id_inimigo) values
    (140, decima_oitava_sala, 10),
    (140, decima_oitava_sala, 10),
    (140, decima_nona_sala, 10),
    (140, decima_nona_sala, 10),
    (190, vigesima_sala, 9);--BOSS DRAGÃO DE AREIA

    -- Inserindo instância de NPC
    INSERT INTO instancia_npc (sala_atual, id_npc, interagiu_jogador) values (decima_setima_sala, 9, FALSE);
    INSERT INTO instancia_npc (sala_atual, id_npc, interagiu_jogador) values (decima_nona_sala, 10, FALSE);
   
   	RETURN vigesima_sala;
END;
$$ LANGUAGE plpgsql;
----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION inicializarSalasSextoAndar(vigesima_sala INTEGER)
RETURNS INTEGER AS
$$
DECLARE 
    vigesima_primeira_sala INTEGER;
    vigesima_segunda_sala INTEGER;
    vigesima_terceira_sala INTEGER;
    vigesima_quarta_sala INTEGER;
BEGIN    
    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (21, vigesima_sala, NULL) 
    RETURNING id_instancia_sala INTO vigesima_primeira_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (22, vigesima_primeira_sala, NULL) 
    RETURNING id_instancia_sala INTO vigesima_segunda_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (23, vigesima_segunda_sala, NULL) 
    RETURNING id_instancia_sala INTO vigesima_terceira_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (24, vigesima_terceira_sala, NULL) 
    RETURNING id_instancia_sala INTO vigesima_quarta_sala;

    UPDATE instancia_sala SET sala_posterior = vigesima_segunda_sala
    WHERE id_instancia_sala = vigesima_primeira_sala;
    
    UPDATE instancia_sala SET sala_posterior = vigesima_terceira_sala
    WHERE id_instancia_sala = vigesima_segunda_sala;

    UPDATE instancia_sala SET sala_posterior = vigesima_quarta_sala
    WHERE id_instancia_sala = vigesima_terceira_sala;


    INSERT INTO instancia_inimigo (vida, sala_atual, id_inimigo) values
    (160, vigesima_segunda_sala, 12),
    (160, vigesima_terceira_sala, 12),
    (160, vigesima_terceira_sala, 12),
    (200, vigesima_quarta_sala, 11);--BOSS SENHOR DAS TORRES

    -- Inserindo instância de NPC
    INSERT INTO instancia_npc (sala_atual, id_npc, interagiu_jogador) values (vigesima_primeira_sala, 11, FALSE);
    INSERT INTO instancia_npc (sala_atual, id_npc, interagiu_jogador) values (vigesima_primeira_sala, 12, FALSE);
   
   	RETURN vigesima_quarta_sala;
END;
$$ LANGUAGE plpgsql;
----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION inicializarSalasSetimoAndar(vigesima_quarta_sala INTEGER)
RETURNS INTEGER AS
$$
DECLARE 
    vigesima_quinta_sala INTEGER;
    vigesima_sexta_sala INTEGER;
    vigesima_setima_sala INTEGER;
    vigesima_oitava_sala INTEGER;
BEGIN    
    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (25, vigesima_quarta_sala, NULL) 
    RETURNING id_instancia_sala INTO vigesima_quinta_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (26, vigesima_quinta_sala, NULL) 
    RETURNING id_instancia_sala INTO vigesima_sexta_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (27, vigesima_sexta_sala, NULL) 
    RETURNING id_instancia_sala INTO vigesima_setima_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (28, vigesima_setima_sala, NULL) 
    RETURNING id_instancia_sala INTO vigesima_oitava_sala;

    UPDATE instancia_sala SET sala_posterior = vigesima_sexta_sala
    WHERE id_instancia_sala = vigesima_quinta_sala;
    
    UPDATE instancia_sala SET sala_posterior = vigesima_setima_sala
    WHERE id_instancia_sala = vigesima_sexta_sala;

    UPDATE instancia_sala SET sala_posterior = vigesima_oitava_sala
    WHERE id_instancia_sala = vigesima_setima_sala;


    INSERT INTO instancia_inimigo (vida, sala_atual, id_inimigo) values
    (180, vigesima_sexta_sala, 14),
    (180, vigesima_sexta_sala, 14),
    (180, vigesima_setima_sala, 14),
    (180, vigesima_setima_sala, 14),
    (220, vigesima_oitava_sala, 13);--BOSS INFERNO

    -- Inserindo instância de NPC
    INSERT INTO instancia_npc (sala_atual, id_npc, interagiu_jogador) values (vigesima_quinta_sala, 13, FALSE);
    INSERT INTO instancia_npc (sala_atual, id_npc, interagiu_jogador) values (vigesima_setima_sala, 14, FALSE);
   
   	RETURN vigesima_oitava_sala;
END;
$$ LANGUAGE plpgsql;
----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION inicializarSalasOitavoAndar(vigesima_oitava_sala INTEGER)
RETURNS INTEGER AS
$$
DECLARE 
    vigesima_nona_sala INTEGER;
    trigessima_sala INTEGER;
    trigessima_primeira_sala INTEGER;
    trigessima_segunda_sala INTEGER;
BEGIN    
    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (29, vigesima_oitava_sala, NULL) 
    RETURNING id_instancia_sala INTO vigesima_nona_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (30, vigesima_nona_sala, NULL) 
    RETURNING id_instancia_sala INTO trigessima_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (31, trigessima_sala, NULL) 
    RETURNING id_instancia_sala INTO trigessima_primeira_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (32, trigessima_primeira_sala, NULL) 
    RETURNING id_instancia_sala INTO trigessima_segunda_sala;

    UPDATE instancia_sala SET sala_posterior = trigessima_sala
    WHERE id_instancia_sala = vigesima_nona_sala;
    
    UPDATE instancia_sala SET sala_posterior = trigessima_primeira_sala
    WHERE id_instancia_sala = trigessima_sala;

    UPDATE instancia_sala SET sala_posterior = trigessima_segunda_sala
    WHERE id_instancia_sala = trigessima_primeira_sala;


    INSERT INTO instancia_inimigo (vida, sala_atual, id_inimigo) values
    (200, trigessima_sala, 16),
    (200, trigessima_sala, 16),
    (200, trigessima_primeira_sala, 16),
    (200, trigessima_primeira_sala, 16),
    (230, trigessima_segunda_sala, 15);--BOSS Gigante Colossal

    -- Inserindo instância de NPC
    INSERT INTO instancia_npc (sala_atual, id_npc, interagiu_jogador) values (vigesima_nona_sala, 15, FALSE);
    INSERT INTO instancia_npc (sala_atual, id_npc, interagiu_jogador) values (trigessima_sala, 16, FALSE);
   
   	RETURN trigessima_segunda_sala;
END;
$$ LANGUAGE plpgsql;
----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION inicializarSalasNonoAndar(trigessima_segunda_sala INTEGER)
RETURNS INTEGER AS
$$
DECLARE 
    trigessima_terceira_sala INTEGER;
    trigessima_quarta_sala INTEGER;
    trigessima_quinta_sala INTEGER;
    trigessima_sexta_sala INTEGER;
BEGIN    
    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (33, trigessima_segunda_sala, NULL) 
    RETURNING id_instancia_sala INTO trigessima_terceira_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (34, trigessima_terceira_sala, NULL) 
    RETURNING id_instancia_sala INTO trigessima_quarta_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (35, trigessima_quarta_sala, NULL) 
    RETURNING id_instancia_sala INTO trigessima_quinta_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (36, trigessima_quinta_sala, NULL) 
    RETURNING id_instancia_sala INTO trigessima_sexta_sala;

    UPDATE instancia_sala SET sala_posterior = trigessima_quarta_sala
    WHERE id_instancia_sala = trigessima_terceira_sala;
    
    UPDATE instancia_sala SET sala_posterior = trigessima_quinta_sala
    WHERE id_instancia_sala = trigessima_quarta_sala;

    UPDATE instancia_sala SET sala_posterior = trigessima_sexta_sala
    WHERE id_instancia_sala = trigessima_quinta_sala;


    INSERT INTO instancia_inimigo (vida, sala_atual, id_inimigo) values
    (220, trigessima_quarta_sala, 18),
    (220, trigessima_quinta_sala, 18),
    (280, trigessima_sexta_sala, 17);--BOSS ASUNA

    -- Inserindo instância de NPC
    INSERT INTO instancia_npc (sala_atual, id_npc, interagiu_jogador) values (trigessima_terceira_sala, 17, FALSE);
    INSERT INTO instancia_npc (sala_atual, id_npc, interagiu_jogador) values (trigessima_quinta_sala, 18, FALSE);
   
   	RETURN trigessima_sexta_sala;
END;
$$ LANGUAGE plpgsql;
----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION inicializarSalasDecimoAndar(trigessima_sexta_sala INTEGER)
RETURNS VOID AS
$$
DECLARE 
    trigessima_setima_sala INTEGER;
    trigessima_oitava_sala INTEGER;
    trigessima_nona_sala INTEGER;
    quadragesima_sala INTEGER;
BEGIN    
    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (37, trigessima_sexta_sala, NULL) 
    RETURNING id_instancia_sala INTO trigessima_setima_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (38, trigessima_setima_sala, NULL) 
    RETURNING id_instancia_sala INTO trigessima_oitava_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (39, trigessima_oitava_sala, NULL) 
    RETURNING id_instancia_sala INTO trigessima_nona_sala;

    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (40, trigessima_nona_sala, NULL) 
    RETURNING id_instancia_sala INTO quadragesima_sala;

    UPDATE instancia_sala SET sala_posterior = trigessima_oitava_sala
    WHERE id_instancia_sala = trigessima_setima_sala;
    
    UPDATE instancia_sala SET sala_posterior = trigessima_nona_sala
    WHERE id_instancia_sala = trigessima_oitava_sala;

    UPDATE instancia_sala SET sala_posterior = quadragesima_sala
    WHERE id_instancia_sala = trigessima_nona_sala;


    INSERT INTO instancia_inimigo (vida, sala_atual, id_inimigo) values
    (250, trigessima_oitava_sala, 20),
    (250, trigessima_nona_sala, 20),
    (300, quadragesima_sala, 19);--BOSS kirito

    -- Inserindo instância de NPC
    INSERT INTO instancia_npc (sala_atual, id_npc, interagiu_jogador) values (trigessima_setima_sala, 19, FALSE);
    INSERT INTO instancia_npc (sala_atual, id_npc, interagiu_jogador) values (trigessima_nona_sala, 20, FALSE);
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
DECLARE
	ultima_sala_primeiro_andar INTEGER;
	ultima_sala_segundo_andar INTEGER;
	ultima_sala_terceiro_andar INTEGER;
	ultima_sala_quarto_andar INTEGER;
	ultima_sala_quinto_andar INTEGER;
	ultima_sala_sexto_andar INTEGER;
	ultima_sala_setimo_andar INTEGER;
	ultima_sala_oitavo_andar INTEGER;
	ultima_sala_nono_andar INTEGER;
BEGIN
   	-- Instancia todas as salas de todos os andares
   	SELECT inicializarSalasPrimeiroAndar(xp_jogador, nivel_jogador, defesa_jogador, magia_jogador, ataque_jogador, vida_jogador, nome_jogador, inventario_jogador, classe_jogador) INTO ultima_sala_primeiro_andar;
    SELECT inicializarSalasSegundoAndar(ultima_sala_primeiro_andar) INTO ultima_sala_segundo_andar;
    SELECT inicializarSalasTerceiroAndar(ultima_sala_segundo_andar) INTO ultima_sala_terceiro_andar;
    SELECT inicializarSalasQuartoAndar(ultima_sala_terceiro_andar) INTO ultima_sala_quarto_andar;
    SELECT inicializarSalasQuintoAndar(ultima_sala_quarto_andar) INTO ultima_sala_quinto_andar;
    SELECT inicializarSalasSextoAndar(ultima_sala_quinto_andar) INTO ultima_sala_sexto_andar;
    SELECT inicializarSalasSetimoAndar(ultima_sala_sexto_andar) INTO ultima_sala_setimo_andar;
    SELECT inicializarSalasOitavoAndar(ultima_sala_setimo_andar) INTO ultima_sala_oitavo_andar;
    SELECT inicializarSalasNonoAndar(ultima_sala_oitavo_andar) INTO ultima_sala_nono_andar;
    PERFORM inicializarSalasDecimoAndar(ultima_sala_nono_andar);
END;
$$
LANGUAGE plpgsql;

-- Procedure responsável por fazer o jogador subir de andar
CREATE OR REPLACE FUNCTION subirAndar(jogador_atual INTEGER, sala_atual INTEGER) 
RETURNS INTEGER AS 
$$
DECLARE 
	sala_nova INTEGER;
BEGIN 
	-- Pega a sala do próximo andar
	SELECT id_instancia_sala INTO sala_nova
	FROM instancia_sala
	WHERE sala_anterior = sala_atual;

	-- Atualiza a sala do jogador
	UPDATE jogador SET sala_atual = sala_nova
	WHERE id_jogador = jogador_atual;

	RETURN sala_nova;
END;
$$
LANGUAGE plpgsql;

-- Procedure responsável por verificar se uma missão foi concluída ou não e atualiza-la
CREATE OR REPLACE FUNCTION atualizarStatusMissao(id_jogador_atual INTEGER, instancia_atual INTEGER)
RETURNS VOID AS 
$$ 
DECLARE 
	inimigo_missao INTEGER;
	xp_dropado INTEGER;
	missao_jogador INTEGER;
BEGIN 
	-- Pegando o id do inimigo envolvido na missao
	SELECT id_inimigo INTO inimigo_missao
	FROM instancia_inimigo 
	WHERE id_instancia = instancia_atual;
		
	-- Verifica se ainda existe alguma instância viva desse inimigo na missão
    IF NOT EXISTS (
        SELECT * FROM instancia_inimigo_missao 
		WHERE id_jogador = id_jogador_atual 
		AND id_inimigo = inimigo_missao
    ) THEN
        -- Pegando o id da missão que foi concluída
        SELECT id_missao INTO missao_jogador
        FROM missao_andamento
        WHERE id_jogador = id_jogador_atual
        AND id_inimigo = inimigo_missao;

        IF (missao_jogador IS NULL) THEN
            RETURN;
        END IF;

        -- Atualizando o status da missão do jogador
        UPDATE jogador_missao
        SET status = 'Concluida'
        WHERE id_jogador = id_jogador_atual
        AND id_missao = missao_jogador;

        -- Pegando a recompensa da missão
        SELECT recompensa_xp INTO xp_dropado
        FROM missao
        WHERE id_missao = missao_jogador;

        -- Atribuindo a recompensa da missão para o jogador
        UPDATE jogador
        SET xp = xp + xp_dropado
        WHERE id_jogador = id_jogador_atual;
    END IF;
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
                INSERT INTO jogador_missao (id_jogador, id_missao, status) VALUES (NEW.id_jogador, id_missao, 'Em andamento');
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
EXECUTE PROCEDURE updateNpc();

-- Stored Procedure responsável pela logica de consumir item
CREATE OR REPLACE FUNCTION consumirItem()
RETURNS TRIGGER AS
$$
DECLARE
    id_jogador_consumiu INTEGER;
    tipo_item_consumido TIPO_ITEM;
    buff_item_consumido INTEGER;
    efeito_item_consumido TIPO_EFEITO;
BEGIN
    -- Seleciona o jogador que consumiu o item
    SELECT id_jogador INTO id_jogador_consumiu
    FROM jogador 
    WHERE inventario = OLD.id_inventario;

    -- Seleciona o tipo do item
    SELECT tipo INTO tipo_item_consumido
    FROM item 
    WHERE id_item = OLD.id_item;

    -- Se o item for uma arma, não faz nada
    IF (tipo_item_consumido = 'Arma') THEN 
        RETURN NULL;
    ELSE
        -- Seleciona o buff do item
        SELECT buff INTO buff_item_consumido
        FROM item 
        WHERE id_item = OLD.id_item;
        
        -- Seleciona o efeito do item
        SELECT efeito INTO efeito_item_consumido
        FROM item 
        WHERE id_item = OLD.id_item;

        -- Aplica o efeito do item ao jogador
        IF (efeito_item_consumido = 'Ataque') THEN
            -- Aumenta o ataque do jogador
            UPDATE jogador 
            SET ataque = ataque + buff_item_consumido 
            WHERE id_jogador = id_jogador_consumiu;
        
        ELSIF (efeito_item_consumido = 'Magia') THEN
            -- Aumenta a magia do jogador
            UPDATE jogador 
            SET magia = magia + buff_item_consumido 
            WHERE id_jogador = id_jogador_consumiu;
        
        ELSIF (efeito_item_consumido = 'Cura') THEN
            -- Aumenta a cura do jogador
            UPDATE jogador 
            SET cura = cura + buff_item_consumido 
            WHERE id_jogador = id_jogador_consumiu;
           
       	ELSIF (efeito_item_consumido = 'Defesa') THEN
	        -- Aumenta a defesa do jogador
	        UPDATE jogador 
	        SET defesa = defesa + buff_item_consumido 
	        WHERE id_jogador = id_jogador_consumiu;
	        
	        END IF;

        -- Retorna NULL, pois o item foi consumido com sucesso
        RETURN NULL;
    END IF;

END;
$$
LANGUAGE plpgsql;

-- Trigger responsável pela lógica de consumir item
CREATE TRIGGER consumirItem
AFTER DELETE 
ON inventario_item
FOR EACH ROW 
EXECUTE PROCEDURE consumirItem();

-- Stored procedure responsável por fazer as atualizações e inserções necessárias apos uma batalha
CREATE OR REPLACE FUNCTION resultadoBatalha()
RETURNS TRIGGER AS
$$
DECLARE 
	xp_ganho INTEGER;
	item_droppado INTEGER;
	inventario_jogador INTEGER;
BEGIN 
	IF (NEW.venceu = true) THEN
		-- Garantindo que a vida do inimigo (instancia) fique em 0 quendo ele morreu
		UPDATE instancia_inimigo SET vida = 0 WHERE id_instancia = NEW.id_instancia;
	
		-- Pegando o xp dropado pelo inimigo
		SELECT xp INTO xp_ganho
		FROM inimigo i 
		LEFT JOIN instancia_inimigo ii USING (id_inimigo)
		WHERE ii.id_instancia = NEW.id_instancia;
	
		-- Atribuindo o xp ganho para o jogador
		UPDATE jogador SET xp = (xp + xp_ganho)
		WHERE id_jogador = NEW.id_jogador;
		
		-- Pegando o item dropado pelo inimigo
		SELECT item_drop INTO item_droppado
		FROM inimigo i 
		LEFT JOIN instancia_inimigo ii USING (id_inimigo)
		WHERE ii.id_instancia = NEW.id_instancia;
	
		-- Pegando o inventário do jogador
		SELECT inventario INTO inventario_jogador
		FROM jogador j WHERE id_jogador = NEW.id_jogador;
	
		-- Adicionando esse item dropado ao inventario do jogador
		INSERT INTO inventario_item (id_inventario, id_item)
		VALUES (inventario_jogador, item_droppado);
		
		RETURN NEW;
	END IF;

	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

-- Trigger responsável por fazer as atualizações e inserções necessárias apos uma batalha
CREATE TRIGGER resultadoBatalha
AFTER INSERT 
ON batalha
FOR EACH ROW
EXECUTE PROCEDURE resultadoBatalha();



