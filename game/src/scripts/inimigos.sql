-- Inimigos e Bosses do Andar 1
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(1, 'Lobo', 20, 15, 2, 30), 
(2, 'Orc', 45, 35, 6, 40);  

INSERT INTO Mob (id_inimigo) VALUES (1);

INSERT INTO Boss (id_inimigo, passiva, buff) VALUES
(2, 'Aumenta a defesa em 50 pontos.', 50);

-- Inimigos e Bosses do Andar 2
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(3, 'Gelidus', 60, 50, 4, 80),  -- O item_drop deve ser ajustado para 4 (Escudo de Gelidus)
(4, 'Arqueiro das Ruínas', 50, 45, 3, 60);  -- O item_drop deve ser ajustado para 4 (Escudo de Gelidus)

INSERT INTO Mob (id_inimigo) VALUES (4);

INSERT INTO Boss (id_inimigo, passiva, buff) VALUES
(3, 'Aumenta a defesa em 50 pontos.', 50);

-- Inimigos e Bosses do Andar 3
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(5, 'Minotauro', 70, 60, 7, 100),  -- O item_drop deve ser ajustado para 7 (Sword of Darkness)
(6, 'Guerreiro Anão', 55, 50, 5, 80);  -- O item_drop deve ser ajustado para 7 (Sword of Darkness)

INSERT INTO Mob (id_inimigo) VALUES (6);

INSERT INTO Boss (id_inimigo, passiva, buff) VALUES
(5, 'Aumenta a defesa em 50 pontos.', 50);

-- Inimigos e Bosses do Andar 4
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(7, 'Rainha das Fadas', 80, 70, 9, 120),  -- O item_drop deve ser ajustado para 10 (Elven Sword)
(8, 'Guardiã das Fadas', 65, 60, 8, 90);  -- O item_drop deve ser ajustado para 10 (Elven Sword)

INSERT INTO Mob (id_inimigo) VALUES (8);

INSERT INTO Boss (id_inimigo, passiva, buff) VALUES
(7, 'Aumenta a defesa em 50 pontos.', 50);

-- Inimigos e Bosses do Andar 5
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(9, 'Dragão de Areia', 90, 80, 13, 150),  -- O item_drop deve ser ajustado para 13 (Dragon Slayer)
(10, 'Escorpião de Areia', 75, 70, 12, 110);  -- O item_drop deve ser ajustado para 13 (Dragon Slayer)

INSERT INTO Mob (id_inimigo) VALUES (10);

INSERT INTO Boss (id_inimigo, passiva, buff) VALUES
(9, 'Aumenta a defesa em 50 pontos.', 50);

-- Inimigos e Bosses do Andar 6
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(11, 'Senhor das Torres', 100, 90, 16, 180),  -- O item_drop deve ser ajustado para 16 (Holy Sword)
(12, 'Guardião dos Cristais', 85, 80, 14, 140);  -- O item_drop deve ser ajustado para 16 (Holy Sword)

INSERT INTO Mob (id_inimigo) VALUES (12);

INSERT INTO Boss (id_inimigo, passiva, buff) VALUES
(11, 'Aumenta a defesa em 50 pontos.', 50);

-- Inimigos e Bosses do Andar 7
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(13, 'Inferno', 110, 100, 19, 200),  -- O item_drop deve ser ajustado para 18 (Inferno Blade)
(14, 'Demônio de Lava', 95, 85, 17, 160);  -- O item_drop deve ser ajustado para 18 (Inferno Blade)

INSERT INTO Mob (id_inimigo) VALUES (14);

INSERT INTO Boss (id_inimigo, passiva, buff) VALUES
(13, 'Aumenta a defesa em 50 pontos.', 50);

-- Inimigos e Bosses do Andar 8
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(15, 'Gigante Colossal', 120, 110, 21, 220),  -- O item_drop deve ser ajustado para 20 (Giant\'s Sword)
(16, 'Golem de Pedra', 105, 100, 20, 180);  -- O item_drop deve ser ajustado para 20 (Giant\'s Sword)

INSERT INTO Mob (id_inimigo) VALUES (16);

INSERT INTO Boss (id_inimigo, passiva, buff) VALUES
(15, 'Aumenta a defesa em 50 pontos.', 50);

-- Inimigos e Bosses do Andar 9
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(17, 'Asuna', 130, 120, 25, 240),  -- O item_drop deve ser ajustado para 23 (Darkness Blade)
(18, 'Sombra Assassina', 115, 105, 23, 200);  -- O item_drop deve ser ajustado para 23 (Darkness Blade)

INSERT INTO Mob (id_inimigo) VALUES (18);

INSERT INTO Boss (id_inimigo, passiva, buff) VALUES
(17, 'Aumenta a defesa em 50 pontos.', 50);

-- Inimigos e Bosses do Andar 10
INSERT INTO Inimigo (id_inimigo, nome, ataque, defesa, item_drop, xp) VALUES
(19, 'Kirito', 150, 140, 26, 300),  -- O item_drop deve ser ajustado para 25 (Excalibur)
(20, 'Guardião Celestial', 135, 125, 24, 260);  -- O item_drop deve ser ajustado para 25 (Excalibur)

INSERT INTO Mob (id_inimigo) VALUES (20);

INSERT INTO Boss (id_inimigo, passiva, buff) VALUES
(19, 'Aumenta a defesa em 50 pontos.', 50);
