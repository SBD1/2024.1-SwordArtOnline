# 2024.1-SwordArtOnline

<div align="center"> <img src="docs/images/banner-SAO.jpg" height="230" width="auto"/> </div>

<div align="center">Repositório para desenvolvimento de um MUD inspirado em Sword Art Online da disciplina de SBD1 - 2024.1</div>

## Alunos

| Nome                                                               | Matrícula |
| :----------------------------------------------------------------- | :-------: |
| [Douglas Marinho Martins](https://github.com/M4RINH0)              | 221037465 |
| [Henrique Torres Landin](https://github.com/henriqtorresl)         | 202016524 |

## Jogo

Após o acesso a um novo aparelho de realidade virtual, ao entrar no jogo Sword Art Online um mundo com diversos ambientes presentes em um tipo de edificio flutuante com 100 andares, todos os jogadores ficam presos nesse mundo cheio de inimigos e criaturas perigosas. Eles são informados que, caso morram no jogo, perderão suas vidas no mundo real. Para se salvar e voltar à realidade, você precisa derrotar todos os chefes dos 100 andares. Será que você tem o que é preciso?

### Como o jogo funciona?

Sword Art Online (SAO) é uma light novel famosa que teve uma adaptação em anime de grande sucesso, conquistando fãs ao redor do mundo. Nesse MUD, o jogador deve se equipar bem, coletar recursos e derrotar o chefe ("boss") presente em cada andar.

Você pode escolher entre classes como Espadachins, usando espadas; Assassinos, com adagas e lanças para eliminar seus alvos; ou Magos, utilizando cajados para lançar magias de ataque ou suporte.

Cada classe tem especialidades que auxiliam em batalha, melhorando atributos específicos. Escolha seus equipamentos com sabedoria de acordo com sua classe.

Explore os andares até encontrar a sala do chefe. Quando estiver pronto, enfrente-o para testar sua capacidade e força.

Os jogadores podem melhorar seus equipamentos ou trocá-los por itens mais raros. Melhor equipamento significa mais força e maior facilidade em derrotar os chefes de cada andar.

Em cada andar, você pode realizar várias missões que oferecem recompensas, como novos equipamentos ou dinheiro para negociar com NPCs.

Prepare-se para uma aventura intensa e emocionante, onde cada decisão pode significar a diferença entre a vida e a morte. Está pronto para o desafio? Entre no mundo de Sword Art Online e lute para sobreviver!

**No vídeo abaixo é possível ver o trailer do anime em que se baseia o jogo:**

<div align="center">
<a href="https://www.youtube.com/watch?v=UZ_O3qhOjHc"><img src="https://i.ytimg.com/vi/6ohYYtxfDCg/hq720.jpg" width="50%"></a>
</div>



## Apresentações

Todas as Apresentações estão no YouTube nos links a seguir:

| Módulo | Link da gravação                                                                                    | Data       |
| ------ | --------------------------------------------------------------------------------------------------- | ---------- |
| 1      | [Apresentação Módulo 1](https://youtu.be/DtC8UW9KK5I)                                               | 22/07/2024 |
| 2      | [Apresentação Módulo 2](https://youtu.be/hE4lcQh91ak)                                               | 19/08/2024 |
| 3      | [Apresentação Módulo Final](https://youtu.be/FlJ2Sy_Tt_o)                                           | 09/09/2024 |


## Entregas

- Módulo 1

  - [Diagrama Entidade-Relacionamento](./docs/Entrega-01/DER_SAO.md)
  - [Dicionário de Dados](./docs/Entrega-01/DD_SAO.md)
  - [Modelo Entidade-Relacionamento](./docs/Entrega-01/MER_SAO.md)
  - [Modelo Relacional](./docs/Entrega-01/MREL_SAO.md)

- Módulo 2

  - [Normalização](./docs/Entrega-01/) Documentos da entrega 1 normalizados e com comparação de versões
  - [DDL](./docs/Entrega-02/ddl.sql)
  - [DML](./docs/Entrega-02/dml.sql)
  - [DQL](./docs/Entrega-02/dql.sql)

- Módulo 3

  - [Jogo](./game)
  - [Tables ,Stored Procedures, Triggers e Views](./game/src/scripts/ddl.sql)
  - [Inserts](./game/src/scripts/dml.sql)


## Como Rodar

  1. **Crie o arquivo `.env`:**
    - Baseie-se no modelo fornecido em `./game/.env.example` para criar o arquivo `.env` na mesma pasta.

  2. **Rodar Banco PostgreSQL(Recomendado uso de Docker):**
    - Certifique-se de que o Docker está em execução.
    - Execute o script Docker também indicado em `./game/.env.example` para configurar os containers necessários.

  3. **Acesse o diretório do projeto:**
    - Abra o terminal e navegue até `./game`.

  4. **Inicialize o jogo:**
    - Execute o comando `npm run initialize-game` para configurar o ambiente de jogo.

  5. **Inicie o jogo:**
    - Use o comando `npm start` para iniciar o jogo.


### Histórico de versões

| Versão |    Data    | Descrição                                      | Autor                                               | Revisão                                                      |
| :----: | :--------: | ---------------------------------------------- | --------------------------------------------------- | ------------------------------------------------------------ |
| `1.0`  | 21/07/2024 | Criação do README e enredo | [Douglas Marinho](https://github.com/M4RINH0)  | [Henrique Torres](https://github.com/henriqtorresl)          |
| `2.0`  | 19/08/2024 | Atualização de links para módulo 2 | [Douglas Marinho](https://github.com/M4RINH0)  | [Henrique Torres](https://github.com/henriqtorresl)          |
| `3.0`  | 09/09/2024 | Atualização de links para módulo 3 e como rodar| [Douglas Marinho](https://github.com/M4RINH0)  | [Henrique Torres](https://github.com/henriqtorresl)          |
