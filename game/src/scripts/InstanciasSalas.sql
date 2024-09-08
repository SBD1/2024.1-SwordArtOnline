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
END;
$$ LANGUAGE plpgsql;
---------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION inicializarSalasSegundoAndar()
RETURNS VOID AS
$$
DECLARE 
    quinta_sala INTEGER;
    sexta_sala INTEGER;
    setima_sala INTEGER;
    oitava_sala INTEGER;
BEGIN    
    -- Inserindo as instâncias das salas do segundo andar
    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (5, NULL, NULL) 
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
END;
$$ LANGUAGE plpgsql;
----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION inicializarSalasTerceiroAndar()
RETURNS VOID AS
$$
DECLARE 
    nona_sala INTEGER;
    decima_sala INTEGER;
    decima_primeira_sala INTEGER;
    decima_segunda_sala INTEGER;
BEGIN    
    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (9, NULL, NULL) 
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
END;
$$ LANGUAGE plpgsql;
----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION inicializarSalasQuartoAndar()
RETURNS VOID AS
$$
DECLARE 
    decima_terceira_sala INTEGER;
    decima_quarta_sala INTEGER;
    decima_quinta_sala INTEGER;
    decima_sexta_sala INTEGER;
BEGIN    
    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (13, NULL, NULL) 
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
END;
$$ LANGUAGE plpgsql;
----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION inicializarSalasQuintoAndar()
RETURNS VOID AS
$$
DECLARE 
    decima_setima_sala INTEGER;
    decima_oitava_sala INTEGER;
    decima_nona_sala INTEGER;
    vigesima_sala INTEGER;
BEGIN    
    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (17, NULL, NULL) 
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
END;
$$ LANGUAGE plpgsql;
----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION inicializarSalasSextoAndar()
RETURNS VOID AS
$$
DECLARE 
    vigesima_primeira_sala INTEGER;
    vigesima_segunda_sala INTEGER;
    vigesima_terceira_sala INTEGER;
    vigesima_quarta_sala INTEGER;
BEGIN    
    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (21, NULL, NULL) 
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
END;
$$ LANGUAGE plpgsql;
----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION inicializarSalasSetimoAndar()
RETURNS VOID AS
$$
DECLARE 
    vigesima_quinta_sala INTEGER;
    vigesima_sexta_sala INTEGER;
    vigesima_setima_sala INTEGER;
    vigesima_oitava_sala INTEGER;
BEGIN    
    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (25, NULL, NULL) 
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
END;
$$ LANGUAGE plpgsql;
----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION inicializarSalasOitavoAndar()
RETURNS VOID AS
$$
DECLARE 
    vigesima_nona_sala INTEGER;
    trigessima_sala INTEGER;
    trigessima_primeira_sala INTEGER;
    trigessima_segunda_sala INTEGER;
BEGIN    
    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (29, NULL, NULL) 
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
END;
$$ LANGUAGE plpgsql;
----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION inicializarSalasNonoAndar()
RETURNS VOID AS
$$
DECLARE 
    trigessima_terceira_sala INTEGER;
    trigessima_quarta_sala INTEGER;
    trigessima_quinta_sala INTEGER;
    trigessima_sexta_sala INTEGER;
BEGIN    
    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (33, NULL, NULL) 
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
END;
$$ LANGUAGE plpgsql;
----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION inicializarSalasDecimoAndar()
RETURNS VOID AS
$$
DECLARE 
    trigessima_setima_sala INTEGER;
    trigessima_oitava_sala INTEGER;
    trigessima_nona_sala INTEGER;
    quadragesima_sala INTEGER;
BEGIN    
    INSERT INTO instancia_sala (id_sala, sala_anterior, sala_posterior) 
    VALUES (37, NULL, NULL) 
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



