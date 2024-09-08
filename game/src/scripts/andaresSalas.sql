-- Inserir Localizações (andares)
INSERT INTO Localizacao (id_localizacao, andar, descricao, estacao, localizacao_anterior, localizacao_posterior) VALUES
(1, 1, 'O primeiro andar do jogo, onde você enfrentará os primeiros inimigos e boss.', 'tipo_andares', NULL, 2),
(2, 2, 'O segundo andar, cheio de novos desafios e inimigos.', 'tipo_andares', 1, 3),
(3, 3, 'O terceiro andar, onde a dificuldade começa a aumentar.', 'tipo_andares', 2, 4),
(4, 4, 'O quarto andar, repleto de perigos e inimigos mais fortes.', 'tipo_andares', 3, 5),
(5, 5, 'O quinto andar, apresentando novos desafios e boss poderoso.', 'tipo_andares', 4, 6),
(6, 6, 'O sexto andar, onde os desafios se tornam ainda maiores.', 'tipo_andares', 5, 7),
(7, 7, 'O sétimo andar, cheio de inimigos e uma forte luta contra o boss.', 'tipo_andares', 6, 8),
(8, 8, 'O oitavo andar, oferecendo batalhas intensas e um boss desafiador.', 'tipo_andares', 7, 9),
(9, 9, 'O nono andar, onde os inimigos são mais difíceis e o boss é um desafio considerável.', 'tipo_andares', 8, 10),
(10, 10, 'O décimo andar, o último desafio antes do confronto final.', 'tipo_andares', 9, NULL);


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


-- Inserir Instâncias de Sala
INSERT INTO Instancia_Sala (id_sala) VALUES
-- Andar 1
(1),
(2),
(3),
(4),
-- Andar 2
(5),
(6),
(7),
(8),
-- Andar 3
(9),
(10),
(11),
(12),
-- Andar 4
(13),
(14),
(15),
(16),
-- Andar 5
(17),
(18),
(19),
(20),
-- Andar 6
(21),
(22),
(23),
(24),
-- Andar 7
(25),
(26),
(27),
(28),
-- Andar 8
(29),
(30),
(31),
(32),
-- Andar 9
(33),
(34),
(35),
(36),
-- Andar 10
(37),
(38),
(39),
(40);


-- Associar NPCs com as salas
INSERT INTO npc_sala (id_npc, id_sala) VALUES
-- Andar 1
(1, 1),
(2, 2),
-- Andar 2
(3, 5),
(4, 6),
-- Andar 3
(5, 9),
(6, 10),
-- Andar 4
(7, 13),
(8, 14),
-- Andar 5
(9, 17),
(10, 18),
-- Andar 6
(11, 21),
(12, 22),
-- Andar 7
(13, 25),
(14, 26),
-- Andar 8
(15, 29),
(16, 30),
-- Andar 9
(17, 33),
(18, 34),
-- Andar 10
(19, 37),
(20, 38);


-- Associar inimigos com as salas
INSERT INTO mob_sala (id_inimigo, id_sala) VALUES
-- Andar 1
(1, 2),
(2, 3),
-- Andar 2
(3, 6),
(4, 7),
-- Andar 3
(5, 10),
(6, 11),
-- Andar 4
(7, 14),
(8, 15),
-- Andar 5
(9, 18),
(10, 19),
-- Andar 6
(11, 22),
(12, 23),
-- Andar 7
(13, 26),
(14, 27),
-- Andar 8
(15, 30),
(16, 31),
-- Andar 9
(17, 34),
(18, 35),
-- Andar 10
(19, 38),
(20, 39);
