Claro! Com base nos scripts DDL fornecidos, aqui está o Dicionário de Dados completo, incluindo todas as entidades e seus atributos atualizados:

---

# Dicionário de Dados

> Um dicionário de dados é um documento que centraliza informações sobre o conjunto de dados sob análise, descrevendo as entidades, atributos e suas características.

## Entidades e Atributos

### **Enumerações (ENUMs)**

Antes de descrever as entidades, aqui estão os tipos ENUM definidos:

- **`tipo_sala`**: 'Comum', 'Boss'
- **`status_missao`**: 'Em andamento', 'Concluida'
- **`passiva_boss`**: 'Vida', 'Defesa', 'Ataque'
- **`nome_classe`**: 'Assassino', 'Mago', 'Tanque', 'Espadachim'
- **`atributo`**: 'Vida', 'Defesa', 'Ataque', 'Magia'
- **`tipo_decisao`**: 'Aceitar', 'Ignorar'
- **`tipo_estacao`**: 'Outono', 'Inverno', 'Primavera', 'Verao'
- **`tipo_item`**: 'Consumivel', 'Arma'
- **`tipo_efeito`**: 'Ataque', 'Magia', 'Cura', 'Defesa'

---

### **Entidade: `Localizacao`**

| Nome Variável           | Tipo           | Descrição                                             | Permite Nulos? | Chave  | Restrições                                           |
|-------------------------|----------------|-------------------------------------------------------|----------------|--------|------------------------------------------------------|
| `id_localizacao`        | SERIAL         | Identificador único da localização                    | Não            | PK     |                                                      |
| `andar`                 | INTEGER        | Número do andar da localização                        | Não            |        | Valor mínimo 0                                       |
| `descricao`             | VARCHAR        | Descrição da localização                              | Não            |        |                                                      |
| `estacao`               | tipo_estacao   | Estação predominante na localização                   | Não            |        |                                                      |
| `localizacao_anterior`  | INTEGER        | Referência à localização anterior                     | Sim            | FK     | FK para `Localizacao(id_localizacao)`                |
| `localizacao_posterior` | INTEGER        | Referência à localização posterior                    | Sim            | FK     | FK para `Localizacao(id_localizacao)`                |

---

### **Entidade: `Sala`**

| Nome Variável    | Tipo         | Descrição                                           | Permite Nulos? | Chave  | Restrições                                           |
|------------------|--------------|-----------------------------------------------------|----------------|--------|------------------------------------------------------|
| `id_sala`        | SERIAL       | Identificador único da sala                         | Não            | PK     |                                                      |
| `nome`           | VARCHAR      | Nome da sala                                        | Não            |        |                                                      |
| `tipo`           | tipo_sala    | Tipo da sala ('Comum' ou 'Boss')                    | Não            |        |                                                      |
| `sala_anterior`  | INTEGER      | Referência à sala anterior                          | Sim            | FK     | FK para `Sala(id_sala)`                              |
| `sala_posterior` | INTEGER      | Referência à sala posterior                         | Sim            | FK     | FK para `Sala(id_sala)`                              |
| `id_localizacao` | INTEGER      | Referência à localização da sala                    | Não            | FK     | FK para `Localizacao(id_localizacao)`                |

---

### **Entidade: `Instancia_Sala`**

| Nome Variável       | Tipo    | Descrição                                               | Permite Nulos? | Chave  | Restrições                                           |
|---------------------|---------|---------------------------------------------------------|----------------|--------|------------------------------------------------------|
| `id_instancia_sala` | SERIAL  | Identificador único da instância de sala                | Não            | PK     |                                                      |
| `id_sala`           | INTEGER | Referência à sala base                                  | Não            | FK     | FK para `Sala(id_sala)`                              |
| `sala_anterior`     | INTEGER | Referência à instância de sala anterior                 | Sim            | FK     | FK para `Instancia_Sala(id_instancia_sala)`          |
| `sala_posterior`    | INTEGER | Referência à instância de sala posterior                | Sim            | FK     | FK para `Instancia_Sala(id_instancia_sala)`          |

---

### **Entidade: `Item`**

| Nome Variável | Tipo         | Descrição                                           | Permite Nulos? | Chave  | Restrições                                           |
|---------------|--------------|-----------------------------------------------------|----------------|--------|------------------------------------------------------|
| `id_item`     | SERIAL       | Identificador único do item                         | Não            | PK     |                                                      |
| `nome`        | VARCHAR      | Nome do item                                        | Não            |        |                                                      |
| `tipo`        | tipo_item    | Tipo do item ('Consumivel' ou 'Arma')               | Não            |        |                                                      |
| `descricao`   | VARCHAR      | Descrição do item                                   | Não            |        |                                                      |
| `buff`        | INTEGER      | Valor de buff proporcionado pelo item               | Não            |        | Valor mínimo 0                                       |
| `efeito`      | tipo_efeito  | Efeito do item ('Ataque', 'Magia', 'Cura', 'Defesa')| Não            |        |                                                      |

---

### **Entidade: `Inventario`**

| Nome Variável  | Tipo    | Descrição                                         | Permite Nulos? | Chave  | Restrições                         |
|----------------|---------|---------------------------------------------------|----------------|--------|------------------------------------|
| `id_inventario`| SERIAL  | Identificador único do inventário                 | Não            | PK     |                                    |
| `qnt_max`      | INTEGER | Quantidade máxima de itens no inventário          | Não            |        | Valor mínimo 1                     |

---

### **Entidade: `Inventario_Item`**

| Nome Variável        | Tipo    | Descrição                                         | Permite Nulos? | Chave  | Restrições                                         |
|----------------------|---------|---------------------------------------------------|----------------|--------|----------------------------------------------------|
| `id_inventario_item` | SERIAL  | Identificador único da relação inventário-item    | Não            | PK     |                                                    |
| `id_inventario`      | INTEGER | Referência ao inventário                          | Não            | FK     | FK para `Inventario(id_inventario)`                |
| `id_item`            | INTEGER | Referência ao item                                | Não            | FK     | FK para `Item(id_item)`                            |

---

### **Entidade: `Missao`**

| Nome Variável   | Tipo    | Descrição                                         | Permite Nulos? | Chave  | Restrições                         |
|-----------------|---------|---------------------------------------------------|----------------|--------|------------------------------------|
| `id_missao`     | SERIAL  | Identificador único da missão                     | Não            | PK     |                                    |
| `nome`          | VARCHAR | Nome da missão                                    | Não            |        |                                    |
| `descricao`     | VARCHAR | Descrição detalhada da missão                     | Não            |        |                                    |
| `recompensa_xp` | INTEGER | Recompensa em XP por concluir a missão            | Não            |        | Valor mínimo 0                     |

---

### **Entidade: `Inimigo`**

| Nome Variável | Tipo    | Descrição                                         | Permite Nulos? | Chave  | Restrições                                         |
|---------------|---------|---------------------------------------------------|----------------|--------|----------------------------------------------------|
| `id_inimigo`  | SERIAL  | Identificador único do inimigo                    | Não            | PK     |                                                    |
| `nome`        | VARCHAR | Nome do inimigo                                   | Não            |        |                                                    |
| `ataque`      | INTEGER | Valor de ataque do inimigo                        | Não            |        | Valor mínimo 0                                     |
| `defesa`      | INTEGER | Valor de defesa do inimigo                        | Não            |        | Valor mínimo 0                                     |
| `item_drop`   | INTEGER | Referência ao item que o inimigo pode dropar      | Não            | FK     | FK para `Item(id_item)`                            |
| `xp`          | INTEGER | XP concedido ao derrotar o inimigo                | Não            |        | Valor mínimo 0                                     |

---

### **Entidade: `Boss`**

| Nome Variável | Tipo         | Descrição                                         | Permite Nulos? | Chave  | Restrições                                         |
|---------------|--------------|---------------------------------------------------|----------------|--------|----------------------------------------------------|
| `id_boss`     | SERIAL       | Identificador único do boss                       | Não            | PK     |                                                    |
| `passiva`     | passiva_boss | Habilidade passiva do boss                        | Não            |        |                                                    |
| `id_inimigo`  | INTEGER      | Referência ao inimigo base do boss                | Não            | FK     | FK para `Inimigo(id_inimigo)`                      |
| `buff`        | INTEGER      | Valor de buff adicional do boss                   | Não            |        | Valor mínimo 0                                     |

---

### **Entidade: `Mob`**

| Nome Variável | Tipo    | Descrição                                         | Permite Nulos? | Chave  | Restrições                                         |
|---------------|---------|---------------------------------------------------|----------------|--------|----------------------------------------------------|
| `id_mob`      | SERIAL  | Identificador único do mob                        | Não            | PK     |                                                    |
| `id_inimigo`  | INTEGER | Referência ao inimigo base do mob                 | Não            | FK     | FK para `Inimigo(id_inimigo)`                      |

---

### **Entidade: `Instancia_Inimigo`**

| Nome Variável  | Tipo    | Descrição                                         | Permite Nulos? | Chave  | Restrições                                            |
|----------------|---------|---------------------------------------------------|----------------|--------|-------------------------------------------------------|
| `id_instancia` | SERIAL  | Identificador único da instância do inimigo       | Não            | PK     |                                                       |
| `vida`         | INTEGER | Vida atual da instância do inimigo                | Não            |        | Valor mínimo 0                                        |
| `sala_atual`   | INTEGER | Referência à instância de sala onde o inimigo está| Não            | FK     | FK para `Instancia_Sala(id_instancia_sala)`           |
| `id_inimigo`   | INTEGER | Referência ao inimigo base                        | Não            | FK     | FK para `Inimigo(id_inimigo)`                         |

---

### **Entidade: `Missao_Inimigo`**

| Nome Variável | Tipo    | Descrição                                         | Permite Nulos? | Chave   | Restrições                                         |
|---------------|---------|---------------------------------------------------|----------------|---------|----------------------------------------------------|
| `id_missao`   | INTEGER | Referência à missão                               | Não            | PK, FK  | FK para `Missao(id_missao)`                        |
| `id_inimigo`  | INTEGER | Referência ao inimigo                             | Não            | PK, FK  | FK para `Inimigo(id_inimigo)`                      |
| `quantidade`  | INTEGER | Quantidade do inimigo necessária para a missão    | Não            |         | Valor mínimo 1                                     |

---

### **Entidade: `NPC`**

| Nome Variável | Tipo    | Descrição                                         | Permite Nulos? | Chave  | Restrições                                         |
|---------------|---------|---------------------------------------------------|----------------|--------|----------------------------------------------------|
| `id_npc`      | SERIAL  | Identificador único do NPC                        | Não            | PK     |                                                    |
| `profissao`   | VARCHAR | Profissão do NPC                                  | Não            |        |                                                    |
| `nome`        | VARCHAR | Nome do NPC                                       | Não            |        |                                                    |
| `fala`        | VARCHAR | Fala padrão do NPC                                | Não            |        |                                                    |
| `item_drop`   | INTEGER | Referência ao item que o NPC pode fornecer        | Sim            | FK     | FK para `Item(id_item)`                            |
| `missao`      | INTEGER | Referência à missão oferecida pelo NPC            | Sim            | FK     | FK para `Missao(id_missao)`                        |

---

### **Entidade: `Instancia_NPC`**

| Nome Variável       | Tipo     | Descrição                                         | Permite Nulos? | Chave  | Restrições                                         |
|---------------------|----------|---------------------------------------------------|----------------|--------|----------------------------------------------------|
| `id_instancia_npc`  | SERIAL   | Identificador único da instância do NPC           | Não            | PK     |                                                    |
| `sala_atual`        | INTEGER  | Referência à instância de sala onde o NPC está    | Não            | FK     | FK para `Instancia_Sala(id_instancia_sala)`        |
| `id_npc`            | INTEGER  | Referência ao NPC base                            | Não            | FK     | FK para `NPC(id_npc)`                              |
| `interagiu_jogador` | BOOLEAN  | Indica se o jogador já interagiu com o NPC        | Não            |        | Valor padrão: FALSE                                |

---

### **Entidade: `Classe`**

| Nome Variável       | Tipo          | Descrição                                         | Permite Nulos? | Chave  | Restrições                                         |
|---------------------|---------------|---------------------------------------------------|----------------|--------|----------------------------------------------------|
| `id_classe`         | SERIAL        | Identificador único da classe                     | Não            | PK     |                                                    |
| `nome`              | nome_classe   | Nome da classe ('Assassino', 'Mago', etc.)        | Não            |        |                                                    |
| `descricao`         | VARCHAR       | Descrição da classe                               | Não            |        |                                                    |
| `atributo_melhorado`| atributo      | Atributo aprimorado pela classe                   | Não            |        |                                                    |
| `buff`              | INTEGER       | Valor de buff concedido pela classe               | Não            |        | Valor mínimo 0                                     |

---

### **Entidade: `Jogador`**

| Nome Variável   | Tipo          | Descrição                                         | Permite Nulos? | Chave  | Restrições                                         |
|-----------------|---------------|---------------------------------------------------|----------------|--------|----------------------------------------------------|
| `id_jogador`    | SERIAL        | Identificador único do jogador                    | Não            | PK     |                                                    |
| `xp`            | INTEGER       | Pontos de experiência do jogador                  | Não            |        | Valor mínimo 0                                     |
| `nivel`         | INTEGER       | Nível atual do jogador                            | Não            |        | Valor mínimo 1                                     |
| `defesa`        | INTEGER       | Valor de defesa do jogador                        | Não            |        | Valor mínimo 0                                     |
| `magia`         | INTEGER       | Valor de magia do jogador                         | Não            |        | Valor mínimo 0                                     |
| `ataque`        | INTEGER       | Valor de ataque do jogador                        | Não            |        | Valor mínimo 0                                     |
| `vida`          | INTEGER       | Vida atual do jogador                             | Não            |        | Valor mínimo 1                                     |
| `nome`          | VARCHAR       | Nome do jogador                                   | Não            |        |                                                    |
| `inventario`    | INTEGER       | Referência ao inventário do jogador               | Não            | FK     | FK para `Inventario(id_inventario)`                |
| `item_atual`    | INTEGER       | Referência ao item atualmente equipado            | Sim            | FK     | FK para `Item(id_item)`                            |
| `classe`        | INTEGER       | Referência à classe do jogador                    | Não            | FK     | FK para `Classe(id_classe)`                        |
| `sala_atual`    | INTEGER       | Referência à instância de sala atual              | Sim            | FK     | FK para `Instancia_Sala(id_instancia_sala)`        |

---

### **Entidade: `Batalha`**

| Nome Variável  | Tipo     | Descrição                                         | Permite Nulos? | Chave  | Restrições                                         |
|----------------|----------|---------------------------------------------------|----------------|--------|----------------------------------------------------|
| `id_batalha`   | SERIAL   | Identificador único da batalha                    | Não            | PK     |                                                    |
| `venceu`       | BOOLEAN  | Indica se o jogador venceu a batalha              | Não            |        |                                                    |
| `id_instancia` | INTEGER  | Referência à instância do inimigo                 | Não            | FK     | FK para `Instancia_Inimigo(id_instancia)`          |
| `id_jogador`   | INTEGER  | Referência ao jogador                             | Não            | FK     | FK para `Jogador(id_jogador)`                      |

---

Claro! Aqui está a tabela `Dialogo` e a tabela `Jogador_Missao` no formato desejado:

### **Entidade: `Dialogo`**

| Nome Variável        | Tipo          | Descrição                                         | Permite Nulos? | Chave  | Restrições                                         |
|----------------------|---------------|---------------------------------------------------|----------------|--------|----------------------------------------------------|
| `id_dialogo`         | SERIAL        | Identificador único do diálogo                    | Não            | PK     |                                                    |
| `decisao`            | tipo_decisao  | Verificador da decisão do diálogo                 | Não            |        |                                                    |
| `id_instancia_npc`   | INTEGER       | Código do NPC no diálogo                          | Não            | FK     |FK para `Instancia NPC` |
| `id_jogador`         | INTEGER       | Código do jogador no diálogo                      | Não            | FK     |FK para `Jogador(id_jogador)` |

### **Entidade: `Jogador_Missao`**

| Nome Variável        | Tipo          | Descrição                                         | Permite Nulos? | Chave  | Restrições                                         |
|----------------------|---------------|---------------------------------------------------|----------------|--------|----------------------------------------------------|
| `id_jogador`         | INTEGER       | Código do jogador na missão                       | Não            | PK     | FK para `Jogador(id_jogador)` |
| `id_missao`          | INTEGER       | Código da missão                                  | Não            | PK     | FK para `Missao` |
| `status`             | STATUS_MISSAO | Status da missão para o jogador                   | Não            |        |                                                    |


---

## Histórico de versão

| Versão |    Data    | Descrição                                      | Autor                                               | Revisão                                                      |
| :----: | :--------: | ---------------------------------------------- | --------------------------------------------------- | ------------------------------------------------------------ |
| 1.0  | 22/07/2024 | Criação do documento e adicionando conteúdo    | [Henrique Torres](https://github.com/henriqtorresl) | [Douglas Marinho](https://github.com/M4RINH0)                |
| 2.0  | 17/08/2024 | Atualizando dicionario baseado na versão 2.0 do DER e MREL    | [Douglas Marinho](https://github.com/M4RINH0) | [Henrique Torres](https://github.com/henriqtorresl)                |
| 3.0  | 09/09/2024 | Versão Final DD   | [Douglas Marinho](https://github.com/M4RINH0) | [Henrique Torres](https://github.com/henriqtorresl)                |