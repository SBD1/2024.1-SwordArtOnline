# DD - Dicionário de Dados

> Um dicionário de dados é um documento de texto ou planilha que centraliza informações sobre o conjunto de dados (dataset) sob análise dos cientistas de dados.
> Segundo a IBM, um dicionário de dados:
> “é um repositório centralizado com informações sobre os dados, tais como: significado, relacionamentos, origem, uso e formatos”

## Entidades e Atributos

### Entidade: `Localizacao`

| Nome Variável         | Tipo         | Descrição                                                                 | Permite valores nulos? | É chave? | Outras Restrições                                            |
|-----------------------|--------------|---------------------------------------------------------------------------|------------------------|----------|--------------------------------------------------------------|
| `id_localizacao`      | SERIAL       | Identificador único para cada localização.                                | não                    | PK       |                                                              |
| `andar`               | INTEGER      | Número do andar onde a localização se encontra.                           | não                    |          |                                                              |
| `descricao`           | VARCHAR      | Breve descrição da localização.                                           | não                    |          |                                                              |
| `estacao`             | tipo_estacao | Estação do ano predominante na localização.                               | não                    |          |                                                              |
| `localizacao_anterior`| INTEGER      | Referência à localização anterior no jogo.                                | sim                    | FK       | FK para `Localizacao(id_localizacao)`                         |
| `localizacao_posterior`| INTEGER     | Referência à localização posterior no jogo.                               | sim                    | FK       | FK para `Localizacao(id_localizacao)`                         |

**Observação**: Esta entidade organiza as diferentes localizações do jogo, permitindo a criação de um mapa ou labirinto.

### Entidade: `Sala`

| Nome Variável      | Tipo         | Descrição                                                                 | Permite valores nulos? | É chave? | Outras Restrições                                            |
|--------------------|--------------|---------------------------------------------------------------------------|------------------------|----------|--------------------------------------------------------------|
| `id_sala`          | SERIAL       | Identificador único para cada sala.                                       | não                    | PK       |                                                              |
| `nome`             | VARCHAR      | Nome da sala.                                                             | não                    |          |                                                              |
| `tipo`             | tipo_sala    | Tipo da sala, indicando se é uma sala comum ou de chefão (Boss).          | não                    |          |                                                              |
| `sala_anterior`    | INTEGER      | Referência à sala anterior.                                               | sim                    | FK       | FK para `Sala(id_sala)`                                       |
| `sala_posterior`   | INTEGER      | Referência à sala posterior.                                              | sim                    | FK       | FK para `Sala(id_sala)`                                       |
| `id_localizacao`   | INTEGER      | Referência à localização onde a sala está situada.                        | não                    | FK       | FK para `Localizacao(id_localizacao)`                         |

**Observação**: A entidade Sala está vinculada a uma Localização e permite a criação de desafios e progressão dentro de cada andar ou área.

### Entidade: `Item`

| Nome Variável      | Tipo         | Descrição                                                                 | Permite valores nulos? | É chave? | Outras Restrições                                            |
|--------------------|--------------|---------------------------------------------------------------------------|------------------------|----------|--------------------------------------------------------------|
| `id_item`          | SERIAL       | Identificador único para cada item.                                       | não                    | PK       |                                                              |
| `nome`             | VARCHAR      | Nome do item.                                                             | não                    |          |                                                              |
| `tipo`             | tipo_item    | Tipo de item, categorizando como consumível ou arma.                      | não                    |          |                                                              |
| `descricao`        | VARCHAR      | Descrição detalhada do item.                                              | não                    |          |                                                              |
| `buff`             | INTEGER      | Valor de aumento de atributo fornecido pelo item.                         | não                    |          |                                                              |
| `efeito`           | tipo_efeito  | Efeito causado pelo item ao ser utilizado.                                | não                    |          |                                                              |

**Observação**: A entidade Item é essencial para definir os recursos que os jogadores podem usar ou equipar ao longo do jogo.

### Entidade: `Inventario`

| Nome Variável      | Tipo         | Descrição                                                                 | Permite valores nulos? | É chave? | Outras Restrições                                            |
|--------------------|--------------|---------------------------------------------------------------------------|------------------------|----------|--------------------------------------------------------------|
| `id_inventario`    | SERIAL       | Identificador único para cada inventário.                                 | não                    | PK       |                                                              |
| `qnt_max`          | INTEGER      | Quantidade máxima de itens que o inventário pode armazenar.               | não                    |          |                                                              |

**Observação**: O inventário é usado para gerenciar os itens coletados pelos jogadores, com uma restrição de quantidade máxima.

### Entidade: `Inventario_Item`

| Nome Variável      | Tipo         | Descrição                                                                 | Permite valores nulos? | É chave? | Outras Restrições                                            |
|--------------------|--------------|---------------------------------------------------------------------------|------------------------|----------|--------------------------------------------------------------|
| `id_inventario`    | INTEGER      | Referência ao inventário.                                                 | não                    | FK, PK   | FK para `Inventario(id_inventario)`                           |
| `id_item`          | INTEGER      | Referência ao item contido no inventário.                                 | não                    | FK, PK   | FK para `Item(id_item)`                                       |

**Observação**: Relaciona inventários a itens, permitindo que múltiplos itens sejam atribuídos a um único inventário.

### Entidade: `Inimigo`

| Nome Variável      | Tipo         | Descrição                                                                 | Permite valores nulos? | É chave? | Outras Restrições                                            |
|--------------------|--------------|---------------------------------------------------------------------------|------------------------|----------|--------------------------------------------------------------|
| `id_inimigo`       | SERIAL       | Identificador único para cada inimigo.                                    | não                    | PK       |                                                              |
| `nome`             | VARCHAR      | Nome do inimigo.                                                          | não                    |          |                                                              |
| `ataque`           | INTEGER      | Valor de ataque do inimigo.                                               | não                    |          |                                                              |
| `defesa`           | INTEGER      | Valor de defesa do inimigo.                                               | não                    |          |                                                              |
| `item_drop`        | INTEGER      | Referência ao item que o inimigo deixa cair ao ser derrotado.             | não                    | FK       | FK para `Item(id_item)`                                       |

**Observação**: A entidade Inimigo define os oponentes que os jogadores encontram no jogo, incluindo os itens que podem ser obtidos ao derrotá-los.

### Entidade: `Boss`

| Nome Variável      | Tipo         | Descrição                                                                 | Permite valores nulos? | É chave? | Outras Restrições                                            |
|--------------------|--------------|---------------------------------------------------------------------------|------------------------|----------|--------------------------------------------------------------|
| `id_boss`          | SERIAL       | Identificador único para cada chefe.                                      | não                    | PK       |                                                              |
| `passiva`          | passiva_boss | Habilidade passiva associada ao chefe.                                    | não                    |          |                                                              |
| `id_inimigo`       | INTEGER      | Referência ao inimigo básico que forma a base para o chefe.               | não                    | FK       | FK para `Inimigo(id_inimigo)`                                 |
| `buff`             | INTEGER      | Valor de buff adicional dado ao chefe.                                    | não                    |          |                                                              |

**Observação**: A entidade Boss é uma especialização de Inimigo, com habilidades e atributos adicionais que tornam o combate mais desafiador.

### Entidade: `Mob`

| Nome Variável      | Tipo         | Descrição                                                                 | Permite valores nulos? | É chave? | Outras Restrições                                            |
|--------------------|--------------|---------------------------------------------------------------------------|------------------------|----------|--------------------------------------------------------------|
| `id_mob`           | SERIAL       | Identificador único para cada mob (monstro básico).                       | não                    | PK       |                                                              |
| `id_inimigo`       |

 INTEGER      | Referência ao inimigo básico que forma a base para o mob.                 | não                    | FK       | FK para `Inimigo(id_inimigo)`                                 |

**Observação**: Mob representa inimigos comuns e mais fáceis, encontrados em grande quantidade no jogo.

### Entidade: `Instancia_Inimigo`

| Nome Variável      | Tipo         | Descrição                                                                 | Permite valores nulos? | É chave? | Outras Restrições                                            |
|--------------------|--------------|---------------------------------------------------------------------------|------------------------|----------|--------------------------------------------------------------|
| `id_instancia`     | SERIAL       | Identificador único para cada instância de um inimigo em uma sala.        | não                    | PK       |                                                              |
| `id_inimigo`       | INTEGER      | Referência ao inimigo instanciado.                                        | não                    | FK       | FK para `Inimigo(id_inimigo)`                                 |
| `id_sala`          | INTEGER      | Referência à sala onde o inimigo está localizado.                         | não                    | FK       | FK para `Sala(id_sala)`                                       |

**Observação**: Cada instância representa uma ocorrência única de um inimigo em uma sala específica.

### Entidade: `NPC`

| Nome Variável      | Tipo         | Descrição                                                                 | Permite valores nulos? | É chave? | Outras Restrições                                            |
|--------------------|--------------|---------------------------------------------------------------------------|------------------------|----------|--------------------------------------------------------------|
| `id_npc`           | SERIAL       | Identificador único para cada NPC (Personagem Não Jogável).               | não                    | PK       |                                                              |
| `nome`             | VARCHAR      | Nome do NPC.                                                              | não                    |          |                                                              |
| `funcao`           | VARCHAR      | Função desempenhada pelo NPC (vendedor, guia, etc.).                      | não                    |          |                                                              |
| `id_sala`          | INTEGER      | Referência à sala onde o NPC está localizado.                             | não                    | FK       | FK para `Sala(id_sala)`                                       |

**Observação**: NPCs são personagens que interagem com jogadores, oferecendo missões, itens, ou informações.

### Entidade: `Missao`

| Nome Variável      | Tipo         | Descrição                                                                 | Permite valores nulos? | É chave? | Outras Restrições                                            |
|--------------------|--------------|---------------------------------------------------------------------------|------------------------|----------|--------------------------------------------------------------|
| `id_missao`        | SERIAL       | Identificador único para cada missão.                                     | não                    | PK       |                                                              |
| `nome`             | VARCHAR      | Nome da missão.                                                           | não                    |          |                                                              |
| `descricao`        | VARCHAR      | Descrição detalhada da missão.                                            | não                    |          |                                                              |
| `recompensa_xp`    | INTEGER      | Pontos de experiência (XP) dados como recompensa ao completar a missão.   | não                    |          |                                                              |
| `status`           | status_missao| Status atual da missão (em andamento, concluída).                         | não                    |          |                                                              |

**Observação**: Missões são desafios ou tarefas que os jogadores podem completar para ganhar recompensas.

### Entidade: `Classe`

| Nome Variável      | Tipo         | Descrição                                                                 | Permite valores nulos? | É chave? | Outras Restrições                                            |
|--------------------|--------------|---------------------------------------------------------------------------|------------------------|----------|--------------------------------------------------------------|
| `id_classe`        | SERIAL       | Identificador único para cada classe de personagem.                       | não                    | PK       |                                                              |
| `nome`             | nome_classe  | Nome da classe (Assassino, Mago, etc.).                                   | não                    |          |                                                              |
| `descricao`        | VARCHAR      | Descrição da classe e suas especializações.                               | não                    |          |                                                              |
| `atributo_melhorado`| atributo    | Atributo principal melhorado pela classe (ataque, magia, etc.).           | não                    |          |                                                              |
| `buff`             | INTEGER      | Buff ou melhoria adicional concedida pela classe.                         | não                    |          |                                                              |

**Observação**: Define as classes disponíveis para os jogadores, cada uma com atributos e habilidades únicas.

### Entidade: `Jogador`

| Nome Variável      | Tipo         | Descrição                                                                 | Permite valores nulos? | É chave? | Outras Restrições                                            |
|--------------------|--------------|---------------------------------------------------------------------------|------------------------|----------|--------------------------------------------------------------|
| `id_jogador`       | SERIAL       | Identificador único para cada jogador.                                    | não                    | PK       |                                                              |
| `xp`               | INTEGER      | Pontos de experiência acumulados pelo jogador.                            | não                    |          |                                                              |
| `nivel`            | INTEGER      | Nível atual do jogador.                                                   | não                    |          |                                                              |
| `defesa`           | INTEGER      | Valor de defesa do jogador.                                               | não                    |          |                                                              |
| `magia`            | INTEGER      | Valor de magia do jogador.                                                | não                    |          |                                                              |
| `ataque`           | INTEGER      | Valor de ataque do jogador.                                               | não                    |          |                                                              |
| `vida`             | INTEGER      | Pontos de vida do jogador.                                                | não                    |          |                                                              |
| `nome`             | VARCHAR      | Nome do jogador.                                                          | não                    |          |                                                              |
| `inventario`       | INTEGER      | Referência ao inventário do jogador.                                      | não                    | FK       | FK para `Inventario(id_inventario)`                           |
| `item_atual`       | INTEGER      | Referência ao item atualmente equipado pelo jogador.                      | não                    | FK       | FK para `Item(id_item)`                                       |
| `classe`           | INTEGER      | Referência à classe do jogador.                                           | não                    | FK       | FK para `Classe(id_classe)`                                   |
| `sala_atual`       | INTEGER      | Referência à sala onde o jogador está atualmente.                         | não                    | FK       | FK para `Sala(id_sala)`                                       |

**Observação**: Esta entidade armazena as principais informações sobre os jogadores, incluindo seus atributos, classe e progresso.

### Entidade: `Batalha`

| Nome Variável      | Tipo         | Descrição                                                                 | Permite valores nulos? | É chave? | Outras Restrições                                            |
|--------------------|--------------|---------------------------------------------------------------------------|------------------------|----------|--------------------------------------------------------------|
| `id_batalha`       | SERIAL       | Identificador único para cada batalha.                                    | não                    | PK       |                                                              |
| `venceu`           | BOOLEAN      | Indicador se o jogador venceu a batalha.                                  | não                    |          |                                                              |
| `id_instancia`     | INTEGER      | Referência à instância do inimigo combatido.                              | não                    | FK       | FK para `Instancia_Inimigo(id_instancia)`                     |
| `id_jogador`       | INTEGER      | Referência ao jogador envolvido na batalha.                               | não                    | FK       | FK para `Jogador(id_jogador)`                                 |

**Observação**: Registra os detalhes das batalhas entre jogadores e inimigos, incluindo o resultado e as instâncias envolvidas.

### Entidade: `Dialogo`

| Nome Variável      | Tipo         | Descrição                                                                 | Permite valores nulos? | É chave? | Outras Restrições                                            |
|--------------------|--------------|---------------------------------------------------------------------------|------------------------|----------|--------------------------------------------------------------|
| `id_dialogo`       | SERIAL       | Identificador único para cada diálogo.                                    | não                    | PK       |                                                              |
| `decisao`          | tipo_decisao | Decisão tomada pelo jogador durante o diálogo.                            | não                    |          |                                                              |
| `id_npc`           | INTEGER      | Referência ao NPC com quem o jogador interagiu.                           | não                    | FK       | FK para `NPC(id_npc)`                                         |
| `id_jogador`       | INTEGER      | Referência ao jogador participante do diálogo.                            | não                    | FK       | FK para `Jogador(id_jogador)`                                 |

**Observação**: Registra as interações e decisões tomadas em diálogos entre jogadores e NPCs.

### Entidade: `Jogador_Missao`

| Nome Variável      | Tipo         | Descrição                                                                 | Permite valores nulos? | É chave? | Outras Restrições                                            |
|--------------------|--------------|---------------------------------------------------------------------------|------------------------|----------|--------------------------------------------------------------|
| `id_jogador`       | INTEGER      | Referência ao jogador.                                                    | não                    | FK, PK   | FK para `Jogador(id_jogador)`                                 |
| `id_missao`        | INTEGER      | Referência à missão atribuída ao jogador.                                 | não                    | FK, PK   | FK para `Missao(id_missao)`                                   |

**Observação**: Relaciona jogadores às missões que eles aceitam e completam durante o jogo.


## Histórico de versão

| Versão |    Data    | Descrição                                      | Autor                                               | Revisão                                                      |
| :----: | :--------: | ---------------------------------------------- | --------------------------------------------------- | ------------------------------------------------------------ |
| `1.0`  | 22/07/2024 | Criação do documento e adicionando conteúdo    | [Henrique Torres](https://github.com/henriqtorresl) | [Douglas Marinho](https://github.com/M4RINH0)                |
| `2.0`  | 17/08/2024 | Atualizando dicionario baseado na versão 2.0 do DER e MREL    | [Douglas Marinho](https://github.com/M4RINH0) | [Henrique Torres](https://github.com/henriqtorresl)                |