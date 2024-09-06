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
