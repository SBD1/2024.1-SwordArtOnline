-- Inserindo classes:
INSERT INTO classe (nome, descricao, atributo_melhorado, buff) VALUES
('Assassino', 'Especialista em eliminar inimigos com rapidez, focado em ataques furtivos e resistente a danos diretos.', 'Vida', 50),
('Mago', 'Mestre das artes arcanas, usa magia poderosa para atacar de longe e conjurar feitiços variados.', 'Magia', 70),
('Tanque', 'Defensor robusto que absorve dano e protege seus aliados com alta resistência e defesa.', 'Defesa', 80),
('Espadachim', 'Hábil com espadas, combina velocidade e força para desferir ataques poderosos em combate corpo a corpo.', 'Ataque', 60);

-- Inserindo itens iniciais do jogo:
INSERT INTO item (id_item, nome, tipo, descricao, buff, efeito) VALUES
(1, 'Espada de simples', 'Arma', 'Espada para iniciantes, causando 30 pontos de dano adicional.', 30, 'Ataque'),
(2, 'Machado de Guerra', 'Arma', 'Machado pesado bom para tankers que aumenta o ataque em 50 pontos.', 50, 'Ataque'),
(3, 'Arco Longo', 'Arma', 'Arco que permite ataques de longo alcance e aumenta a precisão em 25 pontos.', 25, 'Ataque'),
(4, 'Adaga de Aço', 'Arma', 'Adaga com lâmina afiada que causa 35 pontos de dano adicional.', 35, 'Ataque'),
(5, 'Cajado de Orc', 'Arma', 'Cajado simples que aumenta a magia em 60 pontos.', 60, 'Magia');

-- Inserindo inimigos:
-- Mob:
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(1, 'Orc', 45, 35, 4, 40);
INSERT INTO Mob (id_inimigo) VALUES
(1);

-- Boss:
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(2, 'Illfang the Kobold Lord', 100, 80, 5, 100); 
INSERT INTO Boss (id_inimigo, passiva, buff) VALUES
(2, 'Defesa', 150);

-- Inserindo NPC:
INSERT INTO NPC (id_npc, profissao, nome, fala, item_drop, missao)
VALUES (1, 'Guardião da Aldeia', 'Eldor, o Protetor', 'Bem-vindo, aventureiro! Pegue esta arma para começar sua jornada.', 1, NULL);

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