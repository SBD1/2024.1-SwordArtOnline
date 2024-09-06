-- Inimigos e Bosses do Andar 1
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(1, 'Lobo', 20, 15, 6, 30),
(2, 'Orc', 45, 35, 7, 40);
INSERT INTO Mob (id_inimigo) VALUES (1);
INSERT INTO Boss (id_inimigo, passiva, buff) VALUES (2, 'Aumenta a defesa em 50 pontos.', 50);

-- Inimigos e Bosses do Andar 2
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(3, 'Gelidus', 60, 50, 8, 80),
(4, 'Arqueiro das Ruínas', 50, 45, 9, 60);
INSERT INTO Mob (id_inimigo) VALUES (4);
INSERT INTO Boss (id_inimigo, passiva, buff) VALUES (3, 'Aumenta a defesa em 50 pontos.', 50);

-- Inimigos e Bosses do Andar 3
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(5, 'Minotauro', 70, 60, 10, 100),
(6, 'Guerreiro Anão', 55, 50, 11, 80);
INSERT INTO Mob (id_inimigo) VALUES (6);
INSERT INTO Boss (id_inimigo, passiva, buff) VALUES (5, 'Aumenta a defesa em 50 pontos.', 50);

-- Inimigos e Bosses do Andar 4
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(7, 'Rainha das Fadas', 80, 70, 12, 120),
(8, 'Guardiã das Fadas', 65, 60, 13, 90);
INSERT INTO Mob (id_inimigo) VALUES (8);
INSERT INTO Boss (id_inimigo, passiva, buff) VALUES (7, 'Aumenta a defesa em 50 pontos.', 50);

-- Inimigos e Bosses do Andar 5
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(9, 'Dragão de Areia', 90, 80, 14, 150),
(10, 'Escorpião de Areia', 75, 70, 15, 110);
INSERT INTO Mob (id_inimigo) VALUES (10);
INSERT INTO Boss (id_inimigo, passiva, buff) VALUES (9, 'Aumenta a defesa em 50 pontos.', 50);

-- Inimigos e Bosses do Andar 6
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(11, 'Senhor das Torres', 100, 90, 16, 180),
(12, 'Guardião dos Cristais', 85, 80, 17, 140);
INSERT INTO Mob (id_inimigo) VALUES (12);
INSERT INTO Boss (id_inimigo, passiva, buff) VALUES (11, 'Aumenta a defesa em 50 pontos.', 50);

-- Inimigos e Bosses do Andar 7
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(13, 'Inferno', 110, 100, 18, 200),
(14, 'Demônio de Lava', 95, 85, 19, 160);
INSERT INTO Mob (id_inimigo) VALUES (14);
INSERT INTO Boss (id_inimigo, passiva, buff) VALUES (13, 'Aumenta a defesa em 50 pontos.', 50);

-- Inimigos e Bosses do Andar 8
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(15, 'Gigante Colossal', 120, 110, 20, 220),
(16, 'Golem de Pedra', 105, 100, 21, 180);
INSERT INTO Mob (id_inimigo) VALUES (16);
INSERT INTO Boss (id_inimigo, passiva, buff) VALUES (15, 'Aumenta a defesa em 50 pontos.', 50);

-- Inimigos e Bosses do Andar 9
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(17, 'Asuna', 130, 120, 22, 240),
(18, 'Sombra Assassina', 115, 105, 23, 200);
INSERT INTO Mob (id_inimigo) VALUES (18);
INSERT INTO Boss (id_inimigo, passiva, buff) VALUES (17, 'Aumenta a defesa em 50 pontos.', 50);

-- Inimigos e Bosses do Andar 10
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(19, 'Kirito', 150, 140, 24, 300),
(20, 'Guardião Celestial', 135, 125, 25, 260);
INSERT INTO Mob (id_inimigo) VALUES (20);
INSERT INTO Boss (id_inimigo, passiva, buff) VALUES (19, 'Aumenta a defesa em 50 pontos.', 50);
