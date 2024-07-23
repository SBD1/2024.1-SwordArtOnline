# DD - Dicionário de Dados

> Um dicionário de dados é um documento de texto ou planilha que centraliza informações sobre o conjunto de dados (dataset) sob análise dos cientistas de dados.
> Segundo a IBM, um dicionário de dados:
> “é um repositório centralizado com informações sobre os dados, tais como: significado, relacionamentos, origem, uso e formatos”

## Entidade: Jogador

#### Descrição: A entidade Jogador descreve todas as informações sobre o jogador.

#### Observação: Essa tabela possui chave estrangeira da entidade `Localização` e da entidade `Classe`.

|   Nome Variável   |     Tipo     |         Descrição          | Permite valores nulos? | É chave? | Outras Restrições |
| :---------------: | :----------: | :------------------------: | :--------------------: | :------: | ----------------- |
|   id-jogador      |     int      |  Identificador do jogador  |          não           |    PK    |                   |
|     nome          | varchar[50]  |       Nome do jogador      |          não           |          |                   |
|     nivel         |     int      |     Descrição do jogador   |          não           |          |                   |
|  experiencia      |     int      |   Experiencia do jogador   |          não           |          |                   |
|     vida          |     int      |     Vida do jogador        |          não           |          |                   |
|     mana          |     int      |     Mana do jogador        |          não           |          |                   |
| equipamento_atual | varchar[100] |    Equipamento do jogador  |          não           |          |                   |
|  id_localizacao   |     int      |     localização atual      |          não           |    FK    |                   |
|    id_classe      |     int      |     classe do jogador      |          não           |    FK    |                   |


## Entidade: Missao

#### Descrição: A entidade Missao descreve todas as informações sobre uma missão realizada por um jogador.

#### Observação: Essa tabela possui chave estrangeira da entidade `Jogador`.

|   Nome Variável   |     Tipo     |         Descrição             | Permite valores nulos? | É chave? | Outras Restrições |
| :---------------: | :----------: | :---------------------------: | :--------------------: | :------: | ----------------- |
|   id-missao       |     int      | Identificador da missão       |          não           |    PK    |                   |
|     nome          | varchar[50]  |       Nome da missão          |          não           |          |                   |
|   descricao       | varchar[150] |     Descrição da missão       |          não           |          |                   |
|   recompensa      | varchar[150] |   Recompensa da missão        |          não           |          |                   |
|  nivel_requerido  |     int      | Nível requerido para a missão |          não           |          |                   |
|     status        |   boolean    |     Status: Sucesso/Falha     |          não           |          |                   |
|   id_jogador      |     int      |  Jogador que realiza a missão |          não           |    FK    |                   |


## Entidade: Classe

#### Descrição: A entidade Classe descreve todas as informações sobre a classe de um jogador.

#### Observação: Essa tabela não possui chaves estrangeiras.

|    Nome Variável    |     Tipo     |         Descrição              | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------------: | :----------: | :----------------------------: | :--------------------: | :------: | ----------------- |
|     id-classe       |     int      | Identificador da classe        |          não           |    PK    |                   |
|       nome          | varchar[50]  |       Nome da classe           |          não           |          |                   |
|     descricao       | varchar[150] |     Descrição da classe        |          não           |          |                   |
| habilidade_especial | varchar[150] | Habilidade especial da classe  |          não           |          |                   |
| atributo_melhorado  |     int      | Artibuto melhorado pela classe |          não           |          |                   |


## Entidade: Localizacao

#### Descrição: A entidade Localizacao descreve em qual andar/local um jogador está.

#### Observação: Essa tabela não possui chaves estrangeiras.

|    Nome Variável    |     Tipo     |         Descrição              | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------------: | :----------: | :----------------------------: | :--------------------: | :------: | ----------------- |
|   id-localizacao    |     int      |  Identificador da localização  |          não           |    PK    |                   |
|       nome          | varchar[50]  |       Nome da localização      |          não           |          |                   |
|     descricao       | varchar[150] |  Descrição da localização      |          não           |          |                   |
|       tipo          | varchar[150] |      Tipo de localização       |          não           |          |                   |
|      andar          |     int      |         Andar do local         |          não           |          |                   |


## Entidade: Inventario

#### Descrição: A entidade Inventario descreve um inventário e sua capacidade de armazenamento de itens.

#### Observação: Essa tabela não possui chaves estrangeiras.

|    Nome Variável    |     Tipo     |         Descrição                                          | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------------: | :----------: | :--------------------------------------------------------: | :--------------------: | :------: | ----------------- |
|   id-inventario     |     int      |  Identificador do inventário                               |          não           |    PK    |                   |
|       quantidade    |     int      | Quantidade de itens que é possível armazenar no inventário |          não           |          |                   |


## Entidade: Item

#### Descrição: A entidade Item descreve um item disponível no jogo.

#### Observação: Essa tabela não possui chaves estrangeiras.

|    Nome Variável    |     Tipo     |         Descrição                                          | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------------: | :----------: | :--------------------------------------------------------: | :--------------------: | :------: | ----------------- |
|   id-item           |     int      |  Identificador do inventário                               |          não           |    PK    |                   |
|       nome          | varchar[50]  | Quantidade de itens que é possível armazenar no inventário |          não           |          |                   |
|   tipo              | varchar[50]  |  Identificador do inventário                               |          não           |    PK    |                   |
|       descricao     | varchar[150] | Quantidade de itens que é possível armazenar no inventário |          não           |          |                   |
|   efeito            | varchar[150] |  Identificador do inventário                               |          não           |    PK    |                   |
|       raridade      | varchar[50]  | Quantidade de itens que é possível armazenar no inventário |          não           |          |                   |


## Entidade: Inventario_Item

#### Descrição: A entidade Inventario_Item existe para que seja possível realizar a relação de cardinalidade n:n entre a tabela de `Inventario` e a de `Item`.

#### Observação: Essa tabela possui chave estrangeira da entidade `Inventario` e da entidade `Item`.

|    Nome Variável    |     Tipo     |         Descrição                                          | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------------: | :----------: | :--------------------------------------------------------: | :--------------------: | :------: | ----------------- |
|   id-inventario     |     int      |  Identificador do inventário                               |          não           |    FK    |                   |
|       id-item       |     int      |  Identificador do item                                     |          não           |    FK    |                   |


## Entidade: Chefe

#### Descrição: A entidade Chefe descreve um boss que pode ser enfrentado por um jogador.

#### Observação: Essa tabela possui chave estrangeira da entidade `Localizacao` e da entidade `Inventario`.

|    Nome Variável    |     Tipo     |         Descrição              | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------------: | :----------: | :----------------------------: | :--------------------: | :------: | ----------------- |
|   id-chefe          |     int      |  Identificador do chefe        |          não           |    PK    |                   |
|       nome          | varchar[50]  |       Nome do chefe            |          não           |          |                   |
|     descricao       | varchar[150] |  Descrição do chefe            |          não           |          |                   |
|       ataque        |     int      |      poder de ataque           |          não           |          |                   |
|      defesa         |     int      |         defesa                 |          não           |          |                   |
|      vida           |     int      |         vida do chefe          |          não           |          |                   |
|      mana           |     int      |         mana do chefe          |          não           |          |                   |
|  id_localizacao     |     int      |   Localização do chefe         |          não           |    FK    |                   |
|  id_inventario      |     int      |         Inventário do chefe    |          não           |    FK    |                   |


## Entidade: Inimigo

#### Descrição: A entidade Inimigo descreve um mob que pode ser enfrentado por um jogador.

#### Observação: Essa tabela possui chave estrangeira da entidade `Localizacao` e da entidade `Inventario`.

|    Nome Variável    |     Tipo     |         Descrição              | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------------: | :----------: | :----------------------------: | :--------------------: | :------: | ----------------- |
|   id-inimigo        |     int      |  Identificador do inimigo      |          não           |    PK    |                   |
|       nome          | varchar[50]  |       Nome do inimigo          |          não           |          |                   |
|     descricao       | varchar[150] |  Descrição do inimigo          |          não           |          |                   |
|       ataque        |     int      |      Poder de ataque           |          não           |          |                   |
|      defesa         |     int      |         Defesa                 |          não           |          |                   |
|      vida           |     int      |         Vida do inimigo        |          não           |          |                   |
|      mana           |     int      |         Mana do inimigo        |          não           |          |                   |
|  id_localizacao     |     int      |   Localização do inimigo       |          não           |    FK    |                   |
|  id_inventario      |     int      |         Inventário do inimigo  |          não           |    FK    |                   |


## Entidade: NPC

#### Descrição: A entidade NPC descreve um personagem que pode interagir com um jogador.

#### Observação: Essa tabela possui chave estrangeira da entidade `Localizacao` e da entidade `Inventario`.

|    Nome Variável    |     Tipo     |         Descrição              | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------------: | :----------: | :----------------------------: | :--------------------: | :------: | ----------------- |
|   id-npc            |     int      |  Identificador do npc          |          não           |    PK    |                   |
|       nome          | varchar[50]  |       Nome do npc              |          não           |          |                   |
|     descricao       | varchar[150] |  Descrição do npc              |          não           |          |                   |
|       profissao     | varchar[150] |      Profissão do npc          |          não           |          |                   |
|  id_localizacao     |     int      |   Localização do npc           |          não           |    FK    |                   |
|  id_inventario      |     int      |         Inventário do npc      |          não           |    FK    |                   |


## Histórico de versão

| Versão |    Data    | Descrição                                      | Autor                                               | Revisão                                                      |
| :----: | :--------: | ---------------------------------------------- | --------------------------------------------------- | ------------------------------------------------------------ |
| `1.0`  | 22/07/2024 | Criação do documento e adicionando conteúdo    | [Henrique Torres](https://github.com/henriqtorresl) | [Douglas Marinho](https://github.com/M4RINH0)                |
