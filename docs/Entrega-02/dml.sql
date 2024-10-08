-- --------------------------------------------------------------------------------------
-- Data Criacao ...........: 18/08/2024                                                --
-- Autor(es) ..............: Douglas Marinho e Henrique Torres                         --
-- Versao ..............: 1.0                                                          --
-- Banco de Dados .........: PostgreSQL                                                --
-- Descricao .........: Inserções de Modelo de cada tabela para o Banco de Dados.      --
-- --------------------------------------------------------------------------------------

INSERT INTO classe (nome, descricao, atributo_melhorado, buff) VALUES
('Assassino', 'Especialista em eliminar inimigos com rapidez, focado em ataques furtivos e resistente a danos diretos.', 'Vida', 50),
('Mago', 'Mestre das artes arcanas, usa magia poderosa para atacar de longe e conjurar feitiços variados.', 'Magia', 70),
('Tanque', 'Defensor robusto que absorve dano e protege seus aliados com alta resistência e defesa.', 'Defesa', 80),
('Espadachim', 'Hábil com espadas, combina velocidade e força para desferir ataques poderosos em combate corpo a corpo.', 'Ataque', 60);


-- Inserindo localizações:
INSERT INTO localizacao (id_localizacao, andar, descricao, estacao, localizacao_anterior, localizacao_posterior) VALUES
(1, 1, 'Entrada da cidade dos inícios com uma arquitetura medieval europeia, um ponto de partida comum para aventuras.', 'Primavera', NULL, NULL);

INSERT INTO localizacao (id_localizacao, andar, descricao, estacao, localizacao_anterior, localizacao_posterior) VALUES
(2, 2, 'Um Vale de Montanhas com paisagens rochosas e uma série de cavernas e desfiladeiros', 'Primavera', 1, NULL);

INSERT INTO localizacao (id_localizacao, andar, descricao, estacao, localizacao_anterior, localizacao_posterior) VALUES
(3, 3, 'Uma Floresta de Névoa o terceiro andar é caracterizado por uma floresta densa e misteriosa, coberta por uma névoa constante', 'Outono', 2, NULL);


-- Construindo os relacionamentos entre as localizações:
UPDATE localizacao SET localizacao_posterior = 2
WHERE id_localizacao = 1;

UPDATE localizacao SET localizacao_posterior = 3
WHERE id_localizacao = 2;


-- Inserindo as salas
INSERT INTO sala (id_sala, nome, tipo, sala_anterior, sala_posterior, id_localizacao) VALUES
(1, 'Hall de Entrada', 'Comum', NULL, NULL, 1);

INSERT INTO sala (id_sala, nome, tipo, sala_anterior, sala_posterior, id_localizacao) VALUES
(2, 'Planicies', 'Comum', 1, NULL, 1);

INSERT INTO sala (id_sala, nome, tipo, sala_anterior, sala_posterior, id_localizacao) VALUES
(3, 'Sala do Guardião', 'Boss', NULL, NULL, 1);


-- Construindo os relacionamentos entre as salas:
UPDATE sala SET sala_posterior = 2
WHERE id_sala = 1;

UPDATE sala SET sala_anterior = 1, sala_posterior = 3
WHERE id_sala = 2;

UPDATE sala SET sala_anterior = 2
WHERE id_sala = 3;


-- Inserindo itens iniciais do jogo
INSERT INTO item (id_item, nome, tipo, descricao, buff, efeito) VALUES
(1, 'Espada de simples', 'Arma', 'Espada para iniciantes, causando 30 pontos de dano adicional.', 30, 'Ataque'),
(2, 'Machado de Guerra', 'Arma', 'Machado pesado bom para tankers que aumenta o ataque em 50 pontos.', 50, 'Ataque'),
(3, 'Arco Longo', 'Arma', 'Arco que permite ataques de longo alcance e aumenta a precisão em 25 pontos.', 25, 'Ataque'),
(4, 'Adaga de Aço', 'Arma', 'Adaga com lâmina afiada que causa 35 pontos de dano adicional.', 35, 'Ataque'), -- item dropado pelo goblin
(5, 'Cajado de Orc', 'Arma', 'Cajado simples que aumenta a magia em 60 pontos.', 60, 'Magia'); -- item dropado pelo dragão


-- Inserindo inimigos iniciais:
-- Mob:
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop) VALUES
(1, 'Orc', 45, 35, 4);
INSERT INTO Mob (id_inimigo) VALUES
(1);
-- Boss:
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop) VALUES
(2, 'Illfang the Kobold Lord', 100, 80, 5); 
INSERT INTO Boss (passiva, id_inimigo, buff) VALUES
('Defesa', 2, 150);

-- Inserindo instancias de mob e dragao
INSERT INTO instancia_inimigo (vida, sala_atual, id_inimigo) values
(60, 1, 1),
(60, 2, 2),
(60, 2, 2),
(150, 3, 2);

-- Inserindo NPC
INSERT INTO NPC (profissao, nome, fala, sala_atual, item_drop)
VALUES (1, 'Guardião da Aldeia', 'Bem-vindo, aventureiro! Pegue esta arma para começar sua jornada.', 1, 1);

-- Inserindo inventário
INSERT INTO inventario (qnt_max) VALUES 
(10),
(15),
(20);

-- Inserindo Jogador
INSERT INTO jogador (xp, nivel, defesa, magia, ataque, vida, nome, inventario, classe, sala_atual) 
VALUES 
(100, 1, 20, 10, 15, 100, 'Kirito', 1, 'Espadachim', 1),
(200, 2, 25, 15, 20, 120, 'Asuna', 2, 'Mago', 2),
(50, 1, 30, 5, 10, 150, 'Klein', 3, 'Tanque', 1);


-- Criando um diálogo
INSERT INTO dialogo (decisao, id_npc, id_jogador) VALUES 
('Aceitar Missão', 1, 1),
('Comprar Item', 1, 2),
('Recusar Ajuda', 1, 3);


-- Começando uma batalha
INSERT INTO batalha (venceu, id_instancia, id_jogador) VALUES 
(true, 1, 1),
(false, 2, 2),
(true, 3, 3);


-- Adicionando um item ao inventário do jogador
INSERT INTO inventario_item (id_inventario, id_item) VALUES 
(1, 1),
(2, 3),
(3, 5);

-- Inserindo missao
INSERT INTO missao (nome, descricao, recompensa_xp, status) VALUES 
('Derrote o Guardião', 'Derrote o boss do 1º andar para liberar o próximo nível.', 100, 'Pendente'),
('Salve o Aldeão', 'Ajude o aldeão perdido na floresta do 3º andar.', 50, 'Concluída'),
('Colete Ervas Medicinais', 'Colete 10 ervas na floresta do 2º andar.', 30, 'Pendente');


-- Jogador pegou uma missao
INSERT INTO jogador_missao (id_jogador, id_missao) VALUES 
(1, 1),
(2, 2),
(3, 3);
