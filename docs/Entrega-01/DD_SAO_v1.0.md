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


## Entidade: Missão


#### Descrição: A entidade Missão descreve todas as informações sobre uma missão realizada por um jogador.


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


## Entidade: Localização


#### Descrição: A entidade Localização descreve em qual andar/local um jogador está.


#### Observação: Essa tabela não possui chaves estrangeiras.


|    Nome Variável    |     Tipo     |         Descrição              | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------------: | :----------: | :----------------------------: | :--------------------: | :------: | ----------------- |
|   id-localizacao    |     int      |  Identificador da localização  |          não           |    PK    |                   |
|       nome          | varchar[50]  |       Nome da localização      |          não           |          |                   |
|     descricao       | varchar[150] |  Descrição da localização      |          não           |          |                   |
|       tipo          | varchar[150] |      Tipo de localização       |          não           |          |                   |
|      andar          |     int      |         Andar do local         |          não           |          |                   |


## Histórico de versão

| Versão |    Data    | Descrição                                      | Autor                                               | Revisão                                                      |
| :----: | :--------: | ---------------------------------------------- | --------------------------------------------------- | ------------------------------------------------------------ |
| `1.0`  | 22/07/2024 | Criação do documento e adicionando conteúdo    | [Henrique Torres](https://github.com/henriqtorresl) | [Douglas Marinho](https://github.com/M4RINH0)                |
