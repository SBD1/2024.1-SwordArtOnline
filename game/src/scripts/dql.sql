-- Lista todas as classes (Para a tela de criação de personagem)
SELECT * FROM classe;

-- Trás o id do último inventário que foi criado (Para a tela de criação de personagem)
SELECT MAX(id_inventario) AS last_id_inserted FROM inventario i;

-- Abrir o inventário
SELECT id_inventario, qnt_max, COUNT(id_item) AS qnt_itens FROM inventario
INNER JOIN inventario_item USING (id_inventario)
WHERE id_inventario = $1
GROUP BY id_inventario;

-- Listar os itens do inventário
SELECT * FROM inventario_item ii 
INNER JOIN item i USING (id_item)
WHERE id_inventario = $1;

-- Trás todas as informações do jogador
SELECT * FROM jogador WHERE nome = $1

-- Trás todas as informações do jogador e sua classe atual
SELECT id_jogador, xp, nivel, defesa, magia, ataque, vida, j.nome, inventario, item_atual, classe, sala_atual, c.nome as nome_classe 
FROM jogador AS j 
INNER JOIN classe AS c 
ON j.classe = c.id_classe;

-- Trás todas as informações da sala atual
SELECT * FROM sala INNER JOIN localizacao using (id_localizacao) WHERE id_sala = $1;

-- Trás todos os npc's presentes em uma sala
SELECT * FROM npc WHERE sala_atual = $1;

-- Trás todos os mob's presentes em uma sala
SELECT * FROM instancia_inimigo INNER JOIN inimigo USING (id_inimigo) INNER JOIN mob USING (id_inimigo) WHERE sala_atual = $1;

-- Trás todos os boss's presentes em uma sala
SELECT * FROM instancia_inimigo INNER JOIN inimigo USING (id_inimigo) INNER JOIN boss USING (id_inimigo) WHERE sala_atual = $1;

-- Mostra o item atual do jogador
SELECT j.item_atual, i.nome, i.descricao, i.tipo, i.buff, i.efeito FROM jogador j 
INNER JOIN item i 
ON j.item_atual = i.id_item
WHERE id_jogador = $1;