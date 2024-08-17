INSERT INTO classe (nome, descricao, atributo_melhorado, buff) VALUES
('Assassino', 'Especialista em eliminar inimigos com rapidez e precisão, focado em ataques furtivos e dano crítico.', 'Vida', 50),
('Mago', 'Mestre das artes arcanas, usa magia poderosa para atacar de longe e conjurar feitiços variados.', 'Magia', 70),
('Tanque', 'Defensor robusto que absorve dano e protege seus aliados com alta resistência e defesa.', 'Defesa', 80),
('Espadachin', 'Hábil com espadas, combina velocidade e força para desferir ataques poderosos em combate corpo a corpo.', 'Ataque', 60);


-- Inserindo localizações:
INSERT INTO localizacao (id_localizacao, andar, descricao, estacao, localizacao_anterior, localizacao_posterior) VALUES
(1, 1, 'Entrada da cidade, um ponto de partida comum para aventuras.', 'Primavera', NULL, NULL);

INSERT INTO localizacao (id_localizacao, andar, descricao, estacao, localizacao_anterior, localizacao_posterior) VALUES
(2, 2, 'Área comercial movimentada com várias lojas e tavernas.', 'Primavera', 1, NULL);

INSERT INTO localizacao (id_localizacao, andar, descricao, estacao, localizacao_anterior, localizacao_posterior) VALUES
(3, 3, 'Área do mercado com barracas de comida e vendedores variados.', 'Verao', 2, NULL);


-- Construindo os relacionamentos entre as localizações:
update localizacao set localizacao_posterior = 2
where id_localizacao = 1;

update localizacao set localizacao_posterior = 3
where id_localizacao = 2;


-- Inserindo as salas
INSERT INTO sala (id_sala, nome, tipo, sala_anterior, sala_posterior, id_localizacao) VALUES
(1, 'Hall de Entrada', 'Comum', NULL, NULL, 1);

INSERT INTO sala (id_sala, nome, tipo, sala_anterior, sala_posterior, id_localizacao) VALUES
(2, 'Salão Principal', 'Comum', 1, NULL, 1);

INSERT INTO sala (id_sala, nome, tipo, sala_anterior, sala_posterior, id_localizacao) VALUES
(3, 'Sala de Reuniões', 'Boss', NULL, NULL, 1);


-- Construindo os relacionamentos entre as salas:
where id_sala = 1;

update sala set sala_anterior = 1, sala_posterior = 3
where id_sala = 2;

update sala set sala_anterior = 2
where id_sala = 3;


-- Inserindo itens iniciais do jogo
INSERT INTO item (id_item, nome, tipo, descricao, buff, efeito) VALUES
(1, 'Espada de Fogo', 'Arma', 'Espada com encantamento de fogo, causando 40 pontos de dano adicional.', 40, 'Ataque'),
(2, 'Machado de Guerra', 'Arma', 'Machado pesado que aumenta o ataque em 50 pontos.', 50, 'Ataque'),
(3, 'Arco Longo', 'Arma', 'Arco que permite ataques de longo alcance e aumenta a precisão em 25 pontos.', 25, 'Ataque'),
(4, 'Adaga Envenenada', 'Arma', 'Adaga com veneno que causa 20 pontos de dano adicional ao longo do tempo.', 20, 'Ataque'), -- item dropado pelo goblin
(5, 'Escama do Dragão', 'Arma', 'Escama resistente que aumenta a defesa em 60 pontos.', 60, 'Magia'); -- item dropado pelo dragão


-- Inserindo inimigos iniciais:
-- Mob:
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop) VALUES
(1, 'Orc', 45, 35, 4);
INSERT INTO Mob (id_inimigo) VALUES
(1);
-- Boss:
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop) VALUES
(2, 'Dragão', 100, 80, 5); 
INSERT INTO Boss (passiva, id_inimigo, buff) VALUES
('Defesa', 2, 150);

-- Inserindo instancias de mob e dragao
insert into instancia_inimigo (vida, sala_atual, id_inimigo) values
(60, 1, 1),
(60, 2, 2),
(60, 2, 2),
(150, 3, 2);