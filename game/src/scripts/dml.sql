-- Inserindo classes:
INSERT INTO classe (nome, descricao, atributo_melhorado, buff) VALUES
('Assassino', 'Especialista em eliminar inimigos com rapidez, focado em ataques furtivos e resistente a danos diretos.', 'Vida', 30),
('Mago', 'Mestre das artes arcanas, usa magia poderosa para atacar de longe e conjurar feitiços variados.', 'Magia', 15),
('Tanque', 'Defensor robusto que absorve dano e protege seus aliados com alta resistência e defesa.', 'Defesa', 20),
('Espadachim', 'Hábil com espadas, combina velocidade e força para desferir ataques poderosos em combate corpo a corpo.', 'Ataque', 15);

-- Inserindo itens:
-- Andar 1
INSERT INTO Item (id_item, nome, tipo, descricao, buff, efeito) VALUES
(1, 'Espada de Simples', 'Arma', 'Espada para iniciantes, causando 10 pontos de dano adicional.', 10, 'Ataque'), -- Andar 1
(2, 'Couro de Lobo', 'Consumivel', 'Couro obtido de lobos, útil para várias receitas.', 5, 'Defesa'); -- Andar 1

-- Andar 2
INSERT INTO Item (id_item, nome, tipo, descricao, buff, efeito) VALUES
(3, 'Amuleto das Ruínas', 'Consumivel', 'Amuleto perdido nas Ruínas do Norte.', 10, 'Magia'), -- Andar 2
(4, 'Escudo de Gelidus', 'Arma', 'Escudo poderoso que aumenta a defesa em 20 pontos.', 20, 'Defesa'); -- Andar 2

-- Andar 3
INSERT INTO Item (id_item, nome, tipo, descricao, buff, efeito) VALUES
(5, 'Minério Raro', 'Consumivel', 'Minério encontrado nas Cavernas dos Anões, utilizado em forjas.', 15, 'Ataque'), -- Andar 3
(6, 'Espada de Aço', 'Arma', 'Espada forte para o combate, aumentando o ataque em 25 pontos.', 25, 'Ataque'),
(7, 'Sword of Darkness', 'Arma', 'Espada lendária que causa 28 pontos de dano adicional. Referência à Sword of Darkness.', 28, 'Ataque'); -- Andar 3

-- Andar 4
INSERT INTO Item (id_item, nome, tipo, descricao, buff, efeito) VALUES
(8, 'Pétala Encantada', 'Consumivel', 'Pétala mágica encontrada na Floresta das Fadas.', 15, 'Magia'), -- Andar 4
(9, 'Escudo de Elfo', 'Arma', 'Escudo leve que aumenta a defesa em 25 pontos.', 25, 'Defesa'),
(10, 'Elven Sword', 'Arma', 'Espada ágil que aumenta o ataque em 29 pontos. Referência à Elven Sword.', 29, 'Magia'); -- Andar 4

-- Andar 5
INSERT INTO Item (id_item, nome, tipo, descricao, buff, efeito) VALUES
(11, 'Escama de Dragão', 'Consumivel', 'Escama resistente encontrada no Deserto das Ilusões.', 20, 'Defesa'), -- Andar 5
(12, 'Lança de Areia', 'Arma', 'Lança que causa 35 pontos de dano adicional.', 35, 'Ataque'),
(13, 'Dragon Slayer', 'Arma', 'Lança lendária que causa 40 pontos de dano adicional. Referência ao Dragon Slayer.', 40, 'Ataque'); -- Andar 5

-- Andar 6
INSERT INTO Item (id_item, nome, tipo, descricao, buff, efeito) VALUES
(14, 'Cristal Mágico', 'Consumivel', 'Cristal que aumenta a magia em 40 pontos.', 40, 'Magia'), -- Andar 6
(15, 'Espada de Cristal', 'Arma', 'Espada feita de cristal que causa 35 pontos de dano adicional.', 35, 'Ataque'),
(16, 'Holy Sword', 'Arma', 'Espada mágica que tem 50 pontos de efeitos de cura. Referência à Holy Sword.', 50, 'Cura'); -- Andar 6

-- Andar 7
INSERT INTO Item (id_item, nome, tipo, descricao, buff, efeito) VALUES
(17, 'Pedra de Lava', 'Consumivel', 'Pedra quente encontrada no Vulcão Infernal.', 30, 'Ataque'), -- Andar 7
(18, 'Espada Flamejante', 'Arma', 'Espada que causa 40 pontos de dano adicional e queimaduras.', 40, 'Ataque'),
(19, 'Inferno Blade', 'Arma', 'Espada de fogo que causa 55 pontos de dano adicional. Referência à Inferno Blade.', 55, 'Ataque'); -- Andar 7

-- Andar 8
INSERT INTO Item (id_item, nome, tipo, descricao, buff, efeito) VALUES
(20, 'Dente de Gigante', 'Consumivel', 'Dente grande encontrado nas Planícies dos Gigantes.', 50, 'Defesa'), -- Andar 8
(21, 'Clava Gigante', 'Arma', 'Clava pesada que aumenta o ataque em 50 pontos.', 50, 'Ataque'),
(22, 'Giants Sword', 'Arma', 'Espada colossal que causa 60 pontos de dano adicional. Referência à Giants Sword.', 60, 'Ataque'); -- Andar 8

-- Andar 9
INSERT INTO Item (id_item, nome, tipo, descricao, buff, efeito) VALUES
(23, 'Espada das Sombras', 'Arma', 'Espada que causa 45 pontos de dano adicional e reduz a visibilidade do inimigo.', 45, 'Ataque'), -- Andar 9
(24, 'Escudo das Sombras', 'Arma', 'Escudo que aumenta a defesa em 60 pontos e absorve parte do dano.', 60, 'Defesa'),
(25, 'Darkness Blade', 'Arma', 'Espada das Trevas que causa 70 pontos de dano adicional. Referência à Darkness Blade.', 70, 'Ataque'); -- Andar 9

-- Andar 10
INSERT INTO Item (id_item, nome, tipo, descricao, buff, efeito) VALUES
(26, 'Medalhão do Deus', 'Arma', 'Medalhão lendário que aumenta todos os atributos em 100 pontos.', 100, 'Ataque'),
(27, 'Excalibur', 'Arma', 'Espada lendária que causa 120 pontos de dano adicional. Referência à Excalibur, a arma mais poderosa.', 120, 'Ataque'); -- Andar 10

-- Inserindo inimigos:
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(1, 'Lobo', 20, 15, 2, 30), 
(2, 'Orc', 45, 35, 6, 40);  

INSERT INTO Mob (id_inimigo) VALUES (1);

INSERT INTO Boss (id_inimigo, passiva, buff) VALUES
(2, 'Defesa', 50);

-- Inimigos e Bosses do Andar 2
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(3, 'Gelidus', 60, 50, 4, 80),  -- O item_drop deve ser ajustado para 4 (Escudo de Gelidus)
(4, 'Arqueiro das Ruínas', 50, 45, 3, 60);  -- O item_drop deve ser ajustado para 4 (Escudo de Gelidus)

INSERT INTO Mob (id_inimigo) VALUES (4);

INSERT INTO Boss (id_inimigo, passiva, buff) VALUES
(3, 'Defesa', 50);

-- Inimigos e Bosses do Andar 3
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(5, 'Minotauro', 70, 60, 7, 100),  -- O item_drop deve ser ajustado para 7 (Sword of Darkness)
(6, 'Guerreiro Anão', 55, 50, 5, 80);  -- O item_drop deve ser ajustado para 7 (Sword of Darkness)

INSERT INTO Mob (id_inimigo) VALUES (6);

INSERT INTO Boss (id_inimigo, passiva, buff) VALUES
(5, 'Defesa', 50);

-- Inimigos e Bosses do Andar 4
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(7, 'Rainha das Fadas', 80, 70, 9, 120),  -- O item_drop deve ser ajustado para 10 (Elven Sword)
(8, 'Guardiã das Fadas', 65, 60, 8, 90);  -- O item_drop deve ser ajustado para 10 (Elven Sword)

INSERT INTO Mob (id_inimigo) VALUES (8);

INSERT INTO Boss (id_inimigo, passiva, buff) VALUES
(7, 'Defesa', 50);

-- Inimigos e Bosses do Andar 5
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(9, 'Dragão de Areia', 90, 80, 13, 150),  -- O item_drop deve ser ajustado para 13 (Dragon Slayer)
(10, 'Escorpião de Areia', 75, 70, 12, 110);  -- O item_drop deve ser ajustado para 13 (Dragon Slayer)

INSERT INTO Mob (id_inimigo) VALUES (10);

INSERT INTO Boss (id_inimigo, passiva, buff) VALUES
(9, 'Defesa', 50);

-- Inimigos e Bosses do Andar 6
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(11, 'Senhor das Torres', 100, 90, 16, 180),  -- O item_drop deve ser ajustado para 16 (Holy Sword)
(12, 'Guardião dos Cristais', 85, 80, 14, 140);  -- O item_drop deve ser ajustado para 16 (Holy Sword)

INSERT INTO Mob (id_inimigo) VALUES (12);

INSERT INTO Boss (id_inimigo, passiva, buff) VALUES
(11, 'Defesa', 50);

-- Inimigos e Bosses do Andar 7
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(13, 'Inferno', 110, 100, 19, 200),  -- O item_drop deve ser ajustado para 18 (Inferno Blade)
(14, 'Demônio de Lava', 95, 85, 17, 160);  -- O item_drop deve ser ajustado para 18 (Inferno Blade)

INSERT INTO Mob (id_inimigo) VALUES (14);

INSERT INTO Boss (id_inimigo, passiva, buff) VALUES
(13, 'Defesa', 50);

-- Inimigos e Bosses do Andar 8
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(15, 'Gigante Colossal', 120, 110, 21, 220),  -- O item_drop deve ser ajustado para 20 (Giant\'s Sword)
(16, 'Golem de Pedra', 105, 100, 20, 180);  -- O item_drop deve ser ajustado para 20 (Giant\'s Sword)

INSERT INTO Mob (id_inimigo) VALUES (16);

INSERT INTO Boss (id_inimigo, passiva, buff) VALUES
(15, 'Defesa', 50);

-- Inimigos e Bosses do Andar 9
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(17, 'Asuna', 130, 120, 25, 240),  -- O item_drop deve ser ajustado para 23 (Darkness Blade)
(18, 'Sombra Assassina', 115, 105, 23, 200);  -- O item_drop deve ser ajustado para 23 (Darkness Blade)

INSERT INTO Mob (id_inimigo) VALUES (18);

INSERT INTO Boss (id_inimigo, passiva, buff) VALUES
(17, 'Defesa', 50);

-- Inimigos e Bosses do Andar 10
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(19, 'Kirito', 150, 140, 26, 300),  -- O item_drop deve ser ajustado para 25 (Excalibur)
(20, 'Guardião Celestial', 135, 125, 24, 260);  -- O item_drop deve ser ajustado para 25 (Excalibur)

INSERT INTO Mob (id_inimigo) VALUES (20);

INSERT INTO Boss (id_inimigo, passiva, buff) VALUES
(19, 'Defesa', 50);

-- Inserir Localizações (andares)
INSERT INTO Localizacao (id_localizacao, andar, descricao, estacao, localizacao_anterior, localizacao_posterior) VALUES
(1, 1, 'O primeiro andar do jogo, onde você enfrentará os primeiros inimigos e boss.', 'Outono', NULL, 2),
(2, 2, 'O segundo andar, cheio de novos desafios e inimigos.', 'Inverno', 1, 3),
(3, 3, 'O terceiro andar, onde a dificuldade começa a aumentar.', 'Primavera', 2, 4),
(4, 4, 'O quarto andar, repleto de perigos e inimigos mais fortes.', 'Verao', 3, 5),
(5, 5, 'O quinto andar, apresentando novos desafios e boss poderoso.', 'Outono', 4, 6),
(6, 6, 'O sexto andar, onde os desafios se tornam ainda maiores.', 'Inverno', 5, 7),
(7, 7, 'O sétimo andar, cheio de inimigos e uma forte luta contra o boss.', 'Primavera', 6, 8),
(8, 8, 'O oitavo andar, oferecendo batalhas intensas e um boss desafiador.', 'Verao', 7, 9),
(9, 9, 'O nono andar, onde os inimigos são mais difíceis e o boss é um desafio considerável.', 'Outono', 8, 10),
(10, 10, 'O décimo andar, o último desafio antes do confronto final.', 'Inverno', 9, NULL);


-- Inserir Salas
INSERT INTO Sala (id_sala, nome, tipo, sala_anterior, sala_posterior, id_localizacao) VALUES
-- Andar 1
(1, 'Sala inicial com Eldor, o Protetor.', 'Comum', NULL, 2, 1),
(2, 'Sala com Lobos. Prepare-se para enfrentar eles.', 'Comum', 1, 3, 1),
(3, 'Sala com Orcs. Cuidado com seus ataques.', 'Comum', 2, 4, 1),
(4, 'Sala do Boss: Orc. Derrote-o para completar o andar.', 'Boss', 3, NULL, 1),

-- Andar 2
(5, 'Sala inicial com Lysander, o Místico. Receba sua missão aqui.', 'Comum', NULL, 6, 2),
(6, 'Sala com Gelidus. Enfrente-o com cuidado.', 'Comum', 5, 7, 2),
(7, 'Sala com Arqueiros das Ruínas. Eles são ágeis e perigosos.', 'Comum', 6, 8, 2),
(8, 'Sala do Boss: Gelidus. Derrote-o para completar o andar.', 'Boss', 7, NULL, 2),

-- Andar 3
(9, 'Sala inicial com Borin, o Ancião. Receba sua missão aqui.', 'Comum', NULL, 10, 3),
(10, 'Sala com Minotauros. Eles são fortes e resistentes.', 'Comum', 9, 11, 3),
(11, 'Sala com Guerreiros Anões. Eles são experientes em combate.', 'Comum', 10, 12, 3),
(12, 'Sala do Boss: Minotauro. Derrote-o para completar o andar.', 'Boss', 11, NULL, 3),

-- Andar 4
(13, 'Sala inicial com Elara, a Guardiã. Receba sua missão aqui.', 'Comum', NULL, 14, 4),
(14, 'Sala com Rainha das Fadas. Ela é poderosa e mágica.', 'Comum', 13, 15, 4),
(15, 'Sala com Guardiãs das Fadas. Elas protegem a Rainha.', 'Comum', 14, 16, 4),
(16, 'Sala do Boss: Rainha das Fadas. Derrote-a para completar o andar.', 'Boss', 15, NULL, 4),

-- Andar 5
(17, 'Sala inicial com Tariq, o Deserto. Receba sua missão aqui.', 'Comum', NULL, 18, 5),
(18, 'Sala com Dragão de Areia. Ele é temível e forte.', 'Comum', 17, 19, 5),
(19, 'Sala com Escorpiões de Areia. Eles são venenosos.', 'Comum', 18, 20, 5),
(20, 'Sala do Boss: Dragão de Areia. Derrote-o para completar o andar.', 'Boss', 19, NULL, 5),

-- Andar 6
(21, 'Sala inicial com Aelric, o Guardião. Receba sua missão aqui.', 'Comum', NULL, 22, 6),
(22, 'Sala com Senhor das Torres. Ele é robusto e poderoso.', 'Comum', 21, 23, 6),
(23, 'Sala com Guardiões dos Cristais. Eles protegem os cristais.', 'Comum', 22, 24, 6),
(24, 'Sala do Boss: Senhor das Torres. Derrote-o para completar o andar.', 'Boss', 23, NULL, 6),

-- Andar 7
(25, 'Sala inicial com Moros, o Alquimista. Receba sua missão aqui.', 'Comum', NULL, 26, 7),
(26, 'Sala com Inferno. Ele é perigoso e flamejante.', 'Comum', 25, 27, 7),
(27, 'Sala com Demônios de Lava. Eles são quentes e fortes.', 'Comum', 26, 28, 7),
(28, 'Sala do Boss: Inferno. Derrote-o para completar o andar.', 'Boss', 27, NULL, 7),

-- Andar 8
(29, 'Sala inicial com Brom, o Guerreiro. Receba sua missão aqui.', 'Comum', NULL, 30, 8),
(30, 'Sala com Gigante Colossal. Ele é enorme e resistente.', 'Comum', 29, 31, 8),
(31, 'Sala com Golem de Pedra. Ele é forte e durável.', 'Comum', 30, 32, 8),
(32, 'Sala do Boss: Gigante Colossal. Derrote-o para completar o andar.', 'Boss', 31, NULL, 8),

-- Andar 9
(33, 'Sala inicial com Morgana, a Feiticeira. Receba sua missão aqui.', 'Comum', NULL, 34, 9),
(34, 'Sala com Espectro das Sombras. Ele é etéreo e assustador.', 'Comum', 33, 35, 9),
(35, 'Sala com Sombras Assassinas. Elas são furtivas e rápidas.', 'Comum', 34, 36, 9),
(36, 'Sala do Boss: Espectro das Sombras. Derrote-o para completar o andar.', 'Boss', 35, NULL, 9),

-- Andar 10
(37, 'Sala inicial com Ares, o Guia. Receba sua missão aqui.', 'Comum', NULL, 38, 10),
(38, 'Sala com Deus dos Céus. Ele é um adversário poderoso.', 'Comum', 37, 39, 10),
(39, 'Sala com Guardião Celestial. Ele é imponente e forte.', 'Comum', 38, 40, 10),
(40, 'Sala do Boss: Deus dos Céus. Derrote-o para completar o andar.', 'Boss', 39, NULL, 10);

-- Inserindo missões
INSERT INTO Missao (id_missao, nome, descricao, recompensa_xp) VALUES
(1, 'Derrote Lobos', 'Derrote 3 Lobos e obtenha o Couro de Lobo.', 30),
(2, 'Derrote os Arqueiros das Ruínas', 'Derrote 2 Arqueiro das Ruínas e obtenha o Escudo de Gelidus.', 60),
(3, 'Derrote o Guerreiro Anão', 'Derrote 2 Guerreiros Anão e se prepare para o boss.', 80),
(4, 'Derrote a Rainha das Fadas', 'Derrote a Rainha das Fadas e salve o andar.', 90),
(5, 'Derrote o Escorpião de Areia', 'Derrote 3 Escorpião de Areia e tire o andar da infestação.', 110),
(6, 'Derrote o Guardião dos Cristais', 'Derrote 2 Guardião dos Cristais e loot a caverna.', 140),
(7, 'Derrote o Demônio de Lava', 'Derrote 2 Demônios de Lava e se prepare para o Inferno.', 160),
(8, 'Derrote o Golem de Pedra', 'Derrote 2 Golem de Pedra e se prepare para o Gigante.', 180),
(9, 'Derrote a Asuna', 'Derrote a Asuna e obtenha a Darkness Blade.', 200),
(10, 'Derrote o Kirito', 'VENÇA O DEUS DE SWORD ART ONLINE', 220);

-- Relacionando as missões com os inimigos
INSERT INTO Missao_Inimigo (id_missao, id_inimigo, quantidade) VALUES
(1, 1, 3),  -- Derrote 3 Lobo
(2, 4, 2),  -- Derrote 2 Arqueiro das Ruínas
(3, 6, 2),  -- Derrote 2 Guerreiro Anão
(4, 7, 1),  -- Derrote a Rainha das Fadas
(5, 10, 3), -- Derrote 3 Escorpião de Areia
(6, 12, 2), -- Derrote 2 Guardião dos Cristais
(7, 14, 2), -- Derrote 2 Demônio de Lava
(8, 16, 2), -- Derrote 2 Golem de Pedra
(9, 17, 1), -- Derrote a Asuna
(10, 19, 1);-- Derrote o Kirito

-- Inserindo NPC:
-- NPCs do Andar 1
INSERT INTO NPC (id_npc, profissao, nome, fala, item_drop, missao)
VALUES 
(1, 'Guardião da Aldeia', 'Kirito', 'Bem-vindo, aventureiro! Pegue esta espada para começar sua jornada.', 1, 1),
(2, 'Ferreiro', 'Heathcliff', 'Procure por materiais para forjar suas armas.', 2, NULL);

-- NPCs do Andar 2
INSERT INTO NPC (id_npc, profissao, nome, fala, item_drop, missao)
VALUES 
(3, 'Mago das Ruínas', 'Kibaou', 'Encontre os artefatos mágicos nas ruínas.', NULL, 2),
(4, 'Arqueiro das Ruínas', 'Sachi', 'Precisa de mais precisão? Pegue esta arma.', 4, NULL);

-- NPCs do Andar 3
INSERT INTO NPC (id_npc, profissao, nome, fala, item_drop, missao)
VALUES 
(5, 'Ancião Anão', 'Biscuit', 'Traga os minérios raros e eu farei uma arma poderosa.', NULL, 3),
(6, 'Ferreiro Anão', 'Gnome', 'Armas poderosas podem ser forjadas com estes materiais.', 6, NULL);

-- NPCs do Andar 4
INSERT INTO NPC (id_npc, profissao, nome, fala, item_drop, missao)
VALUES 
(7, 'Guardião das Fadas', 'Yui', 'Pegue estas pétalas e as use sabiamente.', NULL, 4),
(8, 'Herbalista', 'Argo', 'Precisa de poções? Tenho algumas para você.', 8, NULL);

-- NPCs do Andar 5
INSERT INTO NPC (id_npc, profissao, nome, fala, item_drop, missao)
VALUES 
(9, 'Desertor', 'Sinon', 'Traga escamas de dragão e obtenha uma recompensa.', NULL, 5),
(10, 'Explorador do Deserto', 'Kibaou', 'Recompensas esperam por aqueles que enfrentam os perigos.', 10, NULL);

-- NPCs do Andar 6
INSERT INTO NPC (id_npc, profissao, nome, fala, item_drop, missao)
VALUES 
(11, 'Guardião das Torres', 'Asuna', 'Cristais mágicos são poderosos; use-os bem.', NULL, 6),
(12, 'Mestre dos Cristais', 'Kibaou', 'Cristais mágicos são essenciais para a magia.', 12, NULL);

-- NPCs do Andar 7
INSERT INTO NPC (id_npc, profissao, nome, fala, item_drop, missao)
VALUES 
(13, 'Alquimista do Vulcão', 'Leafa', 'Traga pedras de lava para criar poções.', NULL, 7),
(14, 'Explorador Vulcânico', 'Sinon', 'Prepare-se para os desafios à frente.', 14, NULL);

-- NPCs do Andar 8
INSERT INTO NPC (id_npc, profissao, nome, fala, item_drop, missao)
VALUES 
(15, 'Guerreiro das Planícies', 'Kirito', 'Prepare-se para enfrentar os gigantes.', NULL, 8),
(16, 'Forjador dos Gigantes', 'Leafa', 'Forje armas poderosas com estes materiais.', 16, NULL);

-- NPCs do Andar 9
INSERT INTO NPC (id_npc, profissao, nome, fala, item_drop, missao)
VALUES 
(17, 'Feiticeira das Sombras', 'Morgiana', 'Itens de sombra poderosos para enfrentar os espectros.', NULL, 9),
(18, 'Artesã das Sombras', 'Argo', 'Armas e itens de sombra são essenciais para enfrentar os desafios.', 18, NULL);

-- NPCs do Andar 10
INSERT INTO NPC (id_npc, profissao, nome, fala, item_drop, missao)
VALUES 
(19, 'Guia dos Deuses', 'Asuna', 'Você conseguiu chegar até aqui. Pegue estas recompensas finais.', NULL, 10),
(20, 'Guardião Celestial', 'Kirito', 'Recompensas aguardam aqueles que conseguem vencer os desafios.', 20, NULL);