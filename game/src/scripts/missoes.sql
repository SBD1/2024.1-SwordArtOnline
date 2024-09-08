-- Exemplo de inserção de missões
INSERT INTO Missao (id_missao, nome, descricao, recompensa_xp, status) VALUES
(1, 'Derrote Lobos', 'Derrote 3 Lobos e obtenha o Couro de Lobo.', 30, 'Pendente'),
(2, 'Derrote os Arqueiros das Ruínas', 'Derrote 2 Arqueiro das Ruínas e obtenha o Escudo de Gelidus.', 60, 'Pendente'),
(3, 'Derrote o Guerreiro Anão', 'Derrote 2 Guerreiros Anão e se prepare para o boss.', 80, 'Pendente'),
(4, 'Derrote a Rainha das Fadas', 'Derrote a Rainha das Fadas e salve o andar.', 90, 'Pendente'),
(5, 'Derrote o Escorpião de Areia', 'Derrote 3 Escorpião de Areia e tire o andar da infestação.', 110, 'Pendente'),
(6, 'Derrote o Guardião dos Cristais', 'Derrote 2 Guardião dos Cristais e loot a caverna.', 140, 'Pendente'),
(7, 'Derrote o Demônio de Lava', 'Derrote 2 Demônios de Lava e se prepare para o Inferno.', 160, 'Pendente'),
(8, 'Derrote o Golem de Pedra', 'Derrote 2 Golem de Pedra e se prepare para o Gigante.', 180, 'Pendente'),
(9, 'Derrote a Asuna', 'Derrote a Asuna e obtenha a Darkness Blade.', 200, 'Pendente'),
(10, 'Derrote o Kirito', 'VENÇA O DEUS DE SWORD ART ONLINE', 220, 'Pendente');

-- Exemplo de inserção de missões com inimigos
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

