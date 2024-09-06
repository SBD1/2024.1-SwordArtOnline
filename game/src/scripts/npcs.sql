-- NPCs do Andar 1
INSERT INTO NPC (id_npc, profissao, nome, fala, item_drop, missao)
VALUES 
(1, 'Guardião da Aldeia', 'Kirito', 'Bem-vindo, aventureiro! Pegue esta espada para começar sua jornada.', 1, 1),
(2, 'Ferreiro', 'Heathcliff', 'Procure por materiais para forjar suas armas.', 2, NULL);

-- NPCs do Andar 2
INSERT INTO NPC (id_npc, profissao, nome, fala, item_drop, missao)
VALUES 
(3, 'Mago das Ruínas', 'Kibaou', 'Encontre os artefatos mágicos nas ruínas.', 3, 2),
(4, 'Arqueiro das Ruínas', 'Sachi', 'Precisa de mais precisão? Pegue esta arma.', 4, NULL);

-- NPCs do Andar 3
INSERT INTO NPC (id_npc, profissao, nome, fala, item_drop, missao)
VALUES 
(5, 'Ancião Anão', 'Biscuit', 'Traga os minérios raros e eu farei uma arma poderosa.', 5, 3),
(6, 'Ferreiro Anão', 'Gnome', 'Armas poderosas podem ser forjadas com estes materiais.', 6, NULL);

-- NPCs do Andar 4
INSERT INTO NPC (id_npc, profissao, nome, fala, item_drop, missao)
VALUES 
(7, 'Guardião das Fadas', 'Yui', 'Pegue estas pétalas e as use sabiamente.', 7, 4),
(8, 'Herbalista', 'Argo', 'Precisa de poções? Tenho algumas para você.', 8, NULL);

-- NPCs do Andar 5
INSERT INTO NPC (id_npc, profissao, nome, fala, item_drop, missao)
VALUES 
(9, 'Desertor', 'Sinon', 'Traga escamas de dragão e obtenha uma recompensa.', 9, 5),
(10, 'Explorador do Deserto', 'Kibaou', 'Recompensas esperam por aqueles que enfrentam os perigos.', 10, NULL);

-- NPCs do Andar 6
INSERT INTO NPC (id_npc, profissao, nome, fala, item_drop, missao)
VALUES 
(11, 'Guardião das Torres', 'Asuna', 'Cristais mágicos são poderosos; use-os bem.', 11, 6),
(12, 'Mestre dos Cristais', 'Kibaou', 'Cristais mágicos são essenciais para a magia.', 12, NULL);

-- NPCs do Andar 7
INSERT INTO NPC (id_npc, profissao, nome, fala, item_drop, missao)
VALUES 
(13, 'Alquimista do Vulcão', 'Leafa', 'Traga pedras de lava para criar poções.', 13, 7),
(14, 'Explorador Vulcânico', 'Sinon', 'Prepare-se para os desafios à frente.', 14, NULL);

-- NPCs do Andar 8
INSERT INTO NPC (id_npc, profissao, nome, fala, item_drop, missao)
VALUES 
(15, 'Guerreiro das Planícies', 'Kirito', 'Prepare-se para enfrentar os gigantes.', 15, 8),
(16, 'Forjador dos Gigantes', 'Leafa', 'Forje armas poderosas com estes materiais.', 16, NULL);

-- NPCs do Andar 9
INSERT INTO NPC (id_npc, profissao, nome, fala, item_drop, missao)
VALUES 
(17, 'Feiticeira das Sombras', 'Morgiana', 'Itens de sombra poderosos para enfrentar os espectros.', 17, 9),
(18, 'Artesã das Sombras', 'Argo', 'Armas e itens de sombra são essenciais para enfrentar os desafios.', 18, NULL);

-- NPCs do Andar 10
INSERT INTO NPC (id_npc, profissao, nome, fala, item_drop, missao)
VALUES 
(19, 'Guia dos Deuses', 'Asuna', 'Você conseguiu chegar até aqui. Pegue estas recompensas finais.', 19, 10),
(20, 'Guardião Celestial', 'Kirito', 'Recompensas aguardam aqueles que conseguem vencer os desafios.', 20, NULL);

-- Instâncias de NPCs do Andar 1
INSERT INTO Instancia_NPC (instancia_sala, id_npc) VALUES
(1, 1), -- Sala inicial com Kirito
(2, 2); -- Sala com Heathcliff

-- Instâncias de NPCs do Andar 2
INSERT INTO Instancia_NPC (instancia_sala, id_npc) VALUES
(5, 3), -- Sala inicial com Kibaou
(6, 4); -- Sala com Sachi

-- Instâncias de NPCs do Andar 3
INSERT INTO Instancia_NPC (instancia_sala, id_npc) VALUES
(9, 5), -- Sala inicial com Biscuit
(10, 6); -- Sala com Gnome

-- Instâncias de NPCs do Andar 4
INSERT INTO Instancia_NPC (instancia_sala, id_npc) VALUES
(13, 7), -- Sala inicial com Yui
(14, 8); -- Sala com Argo

-- Instâncias de NPCs do Andar 5
INSERT INTO Instancia_NPC (instancia_sala, id_npc) VALUES
(17, 9), -- Sala inicial com Sinon
(18, 10); -- Sala com Kibaou

-- Instâncias de NPCs do Andar 6
INSERT INTO Instancia_NPC (instancia_sala, id_npc) VALUES
(21, 11), -- Sala inicial com Asuna
(22, 12); -- Sala com Kibaou

-- Instâncias de NPCs do Andar 7
INSERT INTO Instancia_NPC (instancia_sala, id_npc) VALUES
(25, 13), -- Sala inicial com Leafa
(26, 14); -- Sala com Sinon

-- Instâncias de NPCs do Andar 8
INSERT INTO Instancia_NPC (instancia_sala, id_npc) VALUES
(29, 15), -- Sala inicial com Kirito
(30, 16); -- Sala com Leafa

-- Instâncias de NPCs do Andar 9
INSERT INTO Instancia_NPC (instancia_sala, id_npc) VALUES
(33, 17), -- Sala inicial com Morgiana
(34, 18); -- Sala com Argo

-- Instâncias de NPCs do Andar 10
INSERT INTO Instancia_NPC (instancia_sala, id_npc) VALUES
(37, 19), -- Sala inicial com Asuna
(38, 20); -- Sala com Kirito
