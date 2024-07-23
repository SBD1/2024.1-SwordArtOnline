## Histórico de versões


| Versão |    Data    | Descrição                                      | Autor                                               | Revisão                                                      |
| :----: | :--------: | ---------------------------------------------- | --------------------------------------------------- | ------------------------------------------------------------ |
| `1.0`  | 22/07/2024 | Criação do documento MER             | [Douglas Marinho](https://github.com/M4RINH0)   | [Henrique Torres](https://github.com/henriqtorresl)          |



# MER - Modelo Entidade Relacionamento

O Modelo Entidade Relacionamento de um bancos de dados é um modelo conceitual que descreve as entidades de um domínio de negócios, com seus atributos e seus relacionamentos.

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

## 2. Atributos

- **Classe**: <ins>id_classe</ins>, nome, descricao, habilidade_especial, atributo_melhorado;
- **Chefe**: <ins>id_chefe</ins>, nome, descricao, ataque, vida, mana, defesa, id_localizacao, id_inventario;
- **Inimigo**: <ins>id_inimigo</ins>, nome, descricao, ataque, vida, mana, defesa, id_localizacao, id_inventario;
- **Inventário**: <ins>id_inventario</ins>, quantidade;
- **Item**: <ins>id_item</ins>, nome, tipo, descricao, efeito, raridade;
- **Jogador**: <ins>id_jogador</ins>, nome, nivel, experiencia, vida, mana, equipamento_atual, id_localizacao, id_classe;
- **Localização**: <ins>id_localizacao</ins>, nome, descricao, tipo, andar;
- **Missão**: <ins>id_missao</ins>, nome, descricao, recompensa, nivel_requerido, status, id_jogador;
- **NPC**: <ins>id_npc</ins>, nome, profissao, descricao, id_localizacao, id_inventario;

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
