-- Criação dos andares
INSERT INTO andar (id_andar, nome, descricao) VALUES
(1, 'Andar 1', 'O primeiro andar do jogo, onde você enfrentará os primeiros inimigos e boss.'),
(2, 'Andar 2', 'O segundo andar, cheio de novos desafios e inimigos.'),
(3, 'Andar 3', 'O terceiro andar, onde a dificuldade começa a aumentar.'),
(4, 'Andar 4', 'O quarto andar, repleto de perigos e inimigos mais fortes.'),
(5, 'Andar 5', 'O quinto andar, apresentando novos desafios e boss poderoso.'),
(6, 'Andar 6', 'O sexto andar, onde os desafios se tornam ainda maiores.'),
(7, 'Andar 7', 'O sétimo andar, cheio de inimigos e uma forte luta contra o boss.'),
(8, 'Andar 8', 'O oitavo andar, oferecendo batalhas intensas e um boss desafiador.'),
(9, 'Andar 9', 'O nono andar, onde os inimigos são mais difíceis e o boss é um desafio considerável.'),
(10, 'Andar 10', 'O décimo andar, o último desafio antes do confronto final.');

-- Criação das salas
-- Andar 1
INSERT INTO sala (id_sala, andar, descricao) VALUES
(1, 1, 'Sala inicial com Eldor, o Protetor. Receba sua missão aqui.'),
(2, 1, 'Sala com Lobos. Prepare-se para enfrentar eles.'),
(3, 1, 'Sala com Orcs. Cuidado com seus ataques.'),
(4, 1, 'Sala do Boss: Orc. Derrote-o para completar o andar.');

-- Andar 2
INSERT INTO sala (id_sala, andar, descricao) VALUES
(5, 2, 'Sala inicial com Lysander, o Místico. Receba sua missão aqui.'),
(6, 2, 'Sala com Gelidus. Enfrente-o com cuidado.'),
(7, 2, 'Sala com Arqueiros das Ruínas. Eles são ágeis e perigosos.'),
(8, 2, 'Sala do Boss: Gelidus. Derrote-o para completar o andar.');

-- Andar 3
INSERT INTO sala (id_sala, andar, descricao) VALUES
(9, 3, 'Sala inicial com Borin, o Ancião. Receba sua missão aqui.'),
(10, 3, 'Sala com Minotauros. Eles são fortes e resistentes.'),
(11, 3, 'Sala com Guerreiros Anões. Eles são experientes em combate.'),
(12, 3, 'Sala do Boss: Minotauro. Derrote-o para completar o andar.');

-- Andar 4
INSERT INTO sala (id_sala, andar, descricao) VALUES
(13, 4, 'Sala inicial com Elara, a Guardiã. Receba sua missão aqui.'),
(14, 4, 'Sala com Rainha das Fadas. Ela é poderosa e mágica.'),
(15, 4, 'Sala com Guardiãs das Fadas. Elas protegem a Rainha.'),
(16, 4, 'Sala do Boss: Rainha das Fadas. Derrote-a para completar o andar.');

-- Andar 5
INSERT INTO sala (id_sala, andar, descricao) VALUES
(17, 5, 'Sala inicial com Tariq, o Deserto. Receba sua missão aqui.'),
(18, 5, 'Sala com Dragão de Areia. Ele é temível e forte.'),
(19, 5, 'Sala com Escorpiões de Areia. Eles são venenosos.'),
(20, 5, 'Sala do Boss: Dragão de Areia. Derrote-o para completar o andar.');

-- Andar 6
INSERT INTO sala (id_sala, andar, descricao) VALUES
(21, 6, 'Sala inicial com Aelric, o Guardião. Receba sua missão aqui.'),
(22, 6, 'Sala com Senhor das Torres. Ele é robusto e poderoso.'),
(23, 6, 'Sala com Guardiões dos Cristais. Eles protegem os cristais.'),
(24, 6, 'Sala do Boss: Senhor das Torres. Derrote-o para completar o andar.');

-- Andar 7
INSERT INTO sala (id_sala, andar, descricao) VALUES
(25, 7, 'Sala inicial com Moros, o Alquimista. Receba sua missão aqui.'),
(26, 7, 'Sala com Inferno. Ele é perigoso e flamejante.'),
(27, 7, 'Sala com Demônios de Lava. Eles são quentes e fortes.'),
(28, 7, 'Sala do Boss: Inferno. Derrote-o para completar o andar.');

-- Andar 8
INSERT INTO sala (id_sala, andar, descricao) VALUES
(29, 8, 'Sala inicial com Brom, o Guerreiro. Receba sua missão aqui.'),
(30, 8, 'Sala com Gigante Colossal. Ele é enorme e resistente.'),
(31, 8, 'Sala com Golem de Pedra. Ele é forte e durável.'),
(32, 8, 'Sala do Boss: Gigante Colossal. Derrote-o para completar o andar.');

-- Andar 9
INSERT INTO sala (id_sala, andar, descricao) VALUES
(33, 9, 'Sala inicial com Morgana, a Feiticeira. Receba sua missão aqui.'),
(34, 9, 'Sala com Espectro das Sombras. Ele é etéreo e assustador.'),
(35, 9, 'Sala com Sombras Assassinas. Elas são furtivas e rápidas.'),
(36, 9, 'Sala do Boss: Espectro das Sombras. Derrote-o para completar o andar.');

-- Andar 10
INSERT INTO sala (id_sala, andar, descricao) VALUES
(37, 10, 'Sala inicial com Ares, o Guia. Receba sua missão aqui.'),
(38, 10, 'Sala com Deus dos Céus. Ele é um adversário poderoso.'),
(39, 10, 'Sala com Guardião Celestial. Ele é imponente e forte.'),
(40, 10, 'Sala do Boss: Deus dos Céus. Derrote-o para completar o andar.');

-- Associar NPCs com as salas
-- Andar 1
INSERT INTO npc_sala (id_npc, id_sala) VALUES
(1, 1),
(2, 1);

-- Andar 2
INSERT INTO npc_sala (id_npc, id_sala) VALUES
(3, 5),
(4, 5);

-- Andar 3
INSERT INTO npc_sala (id_npc, id_sala) VALUES
(5, 9),
(6, 9);

-- Andar 4
INSERT INTO npc_sala (id_npc, id_sala) VALUES
(7, 13),
(8, 13);

-- Andar 5
INSERT INTO npc_sala (id_npc, id_sala) VALUES
(9, 17),
(10, 17);

-- Andar 6
INSERT INTO npc_sala (id_npc, id_sala) VALUES
(11, 21),
(12, 21);

-- Andar 7
INSERT INTO npc_sala (id_npc, id_sala) VALUES
(13, 25),
(14, 25);

-- Andar 8
INSERT INTO npc_sala (id_npc, id_sala) VALUES
(15, 29),
(16, 29);

-- Andar 9
INSERT INTO npc_sala (id_npc, id_sala) VALUES
(17, 33),
(18, 33);

-- Andar 10
INSERT INTO npc_sala (id_npc, id_sala) VALUES
(19, 37),
(20, 37);

-- Associar inimigos com as salas
-- Andar 1
INSERT INTO mob_sala (id_inimigo, id_sala) VALUES
(1, 2),
(2, 3);

-- Andar 2
INSERT INTO mob_sala (id_inimigo, id_sala) VALUES
(3, 6),
(4, 7);

-- Andar 3
INSERT INTO mob_sala (id_inimigo, id_sala) VALUES
(5, 10),
(6, 11);

-- Andar 4
INSERT INTO mob_sala (id_inimigo, id_sala) VALUES
(7, 14),
(8, 15);

-- Andar 5
INSERT INTO mob_sala (id_inimigo, id_sala) VALUES
(9, 18),
(10, 19);

-- Andar 6
INSERT INTO mob_sala (id_inimigo, id_sala) VALUES
(11, 22),
(12, 23);

-- Andar 7
INSERT INTO mob_sala (id_inimigo, id_sala) VALUES
(13, 26),
(14, 27);

-- Andar 8
INSERT INTO mob_sala (id_inimigo, id_sala) VALUES
(15, 30),
(16, 31);

-- Andar 9
INSERT INTO mob_sala (id_inimigo, id_sala) VALUES
(17, 34),
(18, 35);

-- Andar 10
INSERT INTO mob_sala (id_inimigo, id_sala) VALUES
(19, 38),
(20, 39);
