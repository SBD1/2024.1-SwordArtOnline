# MER - Modelo Entidade Relacionamento

O Modelo Entidade Relacionamento de um banco de dados é um modelo conceitual que descreve as entidades de um domínio de negócios, com seus atributos e seus relacionamentos.

> Entidades: os objetos da realidade a ser modelada.<br>
> Relacionamentos: as associações entre as entidades.<br>
> Atributos: características específicas de uma entidade.<br>

Aqui está o Modelo Entidade-Relacionamento atualizado com as entidades que estavam faltando:

## 1. Entidades

- **Classe**
- **Boss**
- **Inimigo**
- **Inventário**
- **Item**
- **Jogador**
- **Localização**
- **Missão**
- **NPC**
- **Sala**
- **Mob**
- **Instancia_Inimigo**
- **Instancia_Sala**
- **Batalha**
- **Dialogo**
- **Jogador_Missao**
- **Instancia_NPC** 
- **Instancia_Item** 
- **Instancia_Sala** 

## 2. Atributos

- **Classe**: <ins>id_classe</ins>, nome, descricao, atributo_melhorado, buff
- **Boss**: <ins>id_boss</ins>, passiva, id_inimigo, buff
- **Inimigo**: <ins>id_inimigo</ins>, nome, ataque, defesa, item_drop, xp
- **Inventário**: <ins>id_inventario</ins>, qnt_max
- **Item**: <ins>id_item</ins>, nome, tipo, descricao, buff, efeito
- **Jogador**: <ins>id_jogador</ins>, xp, nivel, defesa, magia, ataque, vida, nome, inventario, item_atual, classe, sala_atual
- **Localização**: <ins>id_localizacao</ins>, andar, descricao, estacao, localizacao_anterior, localizacao_posterior
- **Missão**: <ins>id_missao</ins>, nome, descricao, recompensa_xp, status
- **NPC**: <ins>id_npc</ins>, profissao, nome, fala, item_drop, missao
- **Sala**: <ins>id_sala</ins>, nome, tipo, sala_anterior, sala_posterior, id_localizacao
- **Mob**: <ins>id_mob</ins>, id_inimigo
- **Instancia_Inimigo**: <ins>id_instancia</ins>, vida, sala_atual, id_inimigo
- **Instancia_Sala**: <ins>id_instancia_sala</ins>, id_sala, sala_anterior, sala_posterior
- **Batalha**: <ins>id_batalha</ins>, venceu, id_instancia, id_jogador
- **Dialogo**: <ins>id_dialogo</ins>, decisao, id_instancia_npc, id_jogador
- **Jogador_Missao**: <ins>id_jogador</ins>, id_missao, status
- **Instancia_NPC**: <ins>id_instancia_npc</ins>, sala_atual, id_npc, interagiu_jogador
- **Instancia_Item**: <ins>id_instancia_item</ins>, id_item, quantidade, sala_atual (Nova entidade para refletir a existência de itens nas salas)

## 3. Relacionamentos

**Jogador _pertence_ à Classe**

- O jogador pertence a apenas uma classe (1,1)
- A classe pode conter nenhum ou vários jogadores (0,N)

**Jogador _realiza_ Missão**

- O jogador realiza nenhuma ou várias missões (0,N)
- A missão é realizada por apenas um jogador (1,1)

**Jogador _possui_ Inventário**

- O jogador possui um único inventário (1,1)
- O inventário pertence a apenas um jogador (1,1)

**Jogador _se encontra em_ Localização**

- O jogador se encontra em uma única localização (1,1)
- A localização pode conter nenhum ou vários jogadores (0,N)

**Jogador _enfrenta_ Boss**

- O jogador pode enfrentar nenhum ou vários bosses (0,N)
- O boss é enfrentado por apenas um jogador (1,1)

**Jogador _enfrenta_ Inimigo**

- O jogador pode enfrentar nenhum ou vários inimigos (0,N)
- O inimigo é enfrentado por apenas um jogador (1,1)

**Inventário _contém_ Item**

- O inventário pode conter nenhum ou vários itens (0,N)
- O item pode estar em nenhum ou vários inventários (0,N)

**Boss _se encontra em_ Localização**

- O boss se encontra em uma única localização (1,1)
- A localização pode conter nenhum ou vários bosses (0,N)

**Inimigo _se encontra em_ Localização**

- O inimigo se encontra em uma única localização (1,1)
- A localização pode conter nenhum ou vários inimigos (0,N)

**NPC _se encontra em_ Localização**

- O NPC se encontra em uma única localização (1,1)
- A localização pode conter nenhum ou vários NPCs (0,N)

**NPC _possui_ Inventário**

- O NPC possui um único inventário (1,1)
- O inventário pertence a apenas um NPC (1,1)

**Sala _pertence a_ Localização**

- A sala pertence a uma única localização (1,1)
- A localização pode conter nenhuma ou várias salas (0,N)

**Mob _é um_ Inimigo**

- O mob é um tipo de inimigo (1,1)
- O inimigo pode ter nenhum ou vários mobs (0,N)

**Instancia_Inimigo _está em_ Sala**

- A instância de inimigo está em uma única sala (1,1)
- A sala pode conter nenhuma ou várias instâncias de inimigos (0,N)

**Batalha _envolve_ Jogador**

- A batalha envolve um único jogador (1,1)
- O jogador pode estar em nenhuma ou várias batalhas (0,N)

**Dialogo _é entre_ Jogador e NPC**

- O diálogo é entre um único jogador e um único NPC (1,1)
- O jogador e o NPC podem estar em nenhum ou vários diálogos (0,N)

**Jogador_Missao _relaciona_ Jogador e Missão**

- O jogador pode ter várias missões (0,N)
- A missão pode ser atribuída a vários jogadores (0,N)

**Instancia_Item _está em_ Sala**

- O item está em uma única sala (1,1)
- A sala pode conter nenhum ou vários itens (0,N)

## Histórico de versão

| Versão |    Data    | Descrição                                      | Autor                                               | Revisão                                                      |
| :----: | :--------: | ---------------------------------------------- | --------------------------------------------------- | ------------------------------------------------------------ |
| `1.0`  | 22/07/2024 | Criação do documento MER                       | [Douglas Marinho](https://github.com/M4RINH0)       | [Henrique Torres](https://github.com/henriqtorresl)          |
| `2.0`  | 17/08/2024 | Atualizando documento com base no DD 2.0 e ajustes | [Douglas Marinho](https://github.com/M4RINH0)       | [Henrique Torres](https://github.com/henriqtorresl)          |
| `3.0`  | 09/09/2024 | Atualizando documento com versão final do game | [Douglas Marinho](https://github.com/M4RINH0)       | [Henrique Torres](https://github.com/henriqtorresl)          |
