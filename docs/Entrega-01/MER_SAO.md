# MER - Modelo Entidade Relacionamento

O Modelo Entidade Relacionamento de um banco de dados é um modelo conceitual que descreve as entidades de um domínio de negócios, com seus atributos e seus relacionamentos.

> Entidades: os objetos da realidade a ser modelada.<br>
> Relacionamentos: as associações entre as entidades.<br>
> Atributos: características específicas de uma entidade.<br>

## 1. Entidades

- **Classe**
- **Chefe**
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
- **Batalha**
- **Dialogo**
- **Jogador_Missao**

## 2. Atributos

- **Classe**: <ins>id_classe</ins>, nome, descricao, habilidade_especial, atributo_melhorado;
- **Chefe**: <ins>id_chefe</ins>, nome, descricao, ataque, vida, mana, defesa, id_localizacao, id_inventario;
- **Inimigo**: <ins>id_inimigo</ins>, nome, descricao, ataque, vida, mana, defesa, id_localizacao, id_inventario;
- **Inventário**: <ins>id_inventario</ins>, quantidade, qnt_max;
- **Item**: <ins>id_item</ins>, nome, tipo, descricao, efeito, raridade;
- **Jogador**: <ins>id_jogador</ins>, nome, nivel, experiencia, vida, mana, equipamento_atual, id_localizacao, id_classe;
- **Localização**: <ins>id_localizacao</ins>, nome, descricao, tipo, andar, estacao, localizacao_anterior, localizacao_posterior;
- **Missão**: <ins>id_missao</ins>, nome, descricao, recompensa_xp, nivel_requerido, status, id_jogador;
- **NPC**: <ins>id_npc</ins>, nome, profissao, descricao, id_localizacao, id_inventario;
- **Sala**: <ins>id_sala</ins>, nome, tipo, sala_anterior, sala_posterior, id_localizacao;
- **Mob**: <ins>id_mob</ins>, id_inimigo;
- **Instancia_Inimigo**: <ins>id_instancia</ins>, id_inimigo, id_sala;
- **Batalha**: <ins>id_batalha</ins>, venceu, id_instancia, id_jogador;
- **Dialogo**: <ins>id_dialogo</ins>, decisao, id_npc, id_jogador;
- **Jogador_Missao**: <ins>id_jogador</ins>, id_missao;

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

**Jogador _enfrenta_ Chefe**

- O jogador pode enfrentar nenhum ou vários chefes (0,N)
- O chefe é enfrentado por apenas um jogador (1,1)

**Jogador _enfrenta_ Inimigo**

- O jogador pode enfrentar nenhum ou vários inimigos (0,N)
- O inimigo é enfrentado por apenas um jogador (1,1)

**Inventário _contém_ Item**

- O inventário pode conter nenhum ou vários itens (0,N)
- O item pode estar em nenhum ou vários inventários (0,N)

**Chefe _se encontra em_ Localização**

- O chefe se encontra em uma única localização (1,1)
- A localização pode conter nenhum ou vários chefes (0,N)

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

## Histórico de versão

| Versão |    Data    | Descrição                                      | Autor                                               | Revisão                                                      |
| :----: | :--------: | ---------------------------------------------- | --------------------------------------------------- | ------------------------------------------------------------ |
| `1.0`  | 22/07/2024 | Criação do documento MER                       | [Douglas Marinho](https://github.com/M4RINH0)       | [Henrique Torres](https://github.com/henriqtorresl)          |
| `2.0`  | 17/08/2024 | Atualizando documento com base no DD 2.0 e ajustes | [Douglas Marinho](https://github.com/M4RINH0)       | [Henrique Torres](https://github.com/henriqtorresl)          |
