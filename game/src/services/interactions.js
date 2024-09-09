const { question } = require('../utils/readlineConfig');
const { clearTerminal } = require('../utils/terminalUtils');
const salaDatabase = require('../database/sala');
const inventarioDatabase = require('../database/inventario');
const enumDatabase = require('../database/enum');
const npcDatabase = require('../database/npc');
const dialogoDatabase = require('../database/dialogo');
const jogadorDatabase = require('../database/jogador');
const inimigoDatabase = require('../database/inimigo');
const batalhaDatabase = require('../database/batalha');
const missaoDatabase = require('../database/missao');
const { blueBoldText, cyanBoldText, yellowBoldText, redBoldText, magentaBoldText, greenBoldText } = require('../utils/colors');

// Exibe opções para o jogador e trata a escolha
const getOptions = async (jogador, sala) => {
    console.log(cyanBoldText, '\nSuas opções são:');
    console.log('\n');

    // Adicionar a lógica para ver missões
    const options = [
        { Opções: 'Olhar ao redor' },
        { Opções: 'Abrir inventário' },
        { Opções: 'Ver suas estatísticas' }
    ];

    console.table(options);
    console.log('\n');

    let keepRunning = true;

    while (keepRunning) {
        const option = parseInt(await question('-> '), 10);

        switch (option) {
            case 0:
                await detailRoom(jogador, sala); // Chama a função para detalhar a sala

                keepRunning = false;    // Encerra o loop
                break;
            case 1:
                await openInventory(jogador); // Chama a função para abrir inventário

                keepRunning = false;
                break;

            case 2:
                await yourInformations(jogador); // Chama a função para ver suas estatisticas

                keepRunning = false;
                break;
            case 3:
                clearTerminal();
                setTimeout(async () => {
                    await detailCurrentItem(jogador);
                }, 1);

                keepRunning = false;
                break;
            default:
                console.log(redBoldText, '\nOpção inválida. Por favor, digite um número válido...\n');
                break;
        }
    }
};

// Olhar ao redor da sala
const detailRoom = async (jogador, sala) => {
    clearTerminal();

    setTimeout(() => {
        console.log(blueBoldText, '\n\tVocê dá uma olhada ao redor da sala...\n');
    }, 1);

    clearTerminal(1000);

    setTimeout(async () => {
        const npcs = await salaDatabase.getNpcsInRoom(jogador.sala_atual);
        const mobs = await salaDatabase.getMobsInRoom(jogador.sala_atual);
        let boss = [];

        if (sala.andar === 10 && sala.sala_posterior == null) {
            console.log(greenBoldText, `\nParabéns, você conseguiu chegar até a última sala do jogo!\n`);
        }

        if (sala.tipo === 'Boss') {
            boss = await salaDatabase.getBossInRoom(jogador.sala_atual);
        }

        // Vendo os NPCs da sala
        if (npcs.length > 0) {
            console.log(yellowBoldText, `\nHá ${npcs.length} pessoa${npcs.length === 1 ? '' : 's'} aqui:\n`);
            for (const npc of npcs) {
                console.table([
                    {
                        Nome: npc.nome,
                        Profissão: npc.profissao
                    }
                ]);
            }
        } else {
            console.log(yellowBoldText, `\nNão tem nenhuma pessoa na sala...\n`);
        }

        // Vendo os mobs da sala
        if (mobs.length > 0) {
            console.log(redBoldText, `\n${mobs.length === 1 ? 'Um mob está vagando pela sala:' : `${mobs.length} mobs estão vagando pela sala:`}\n`);
            for (const mob of mobs) {
                console.table([
                    {
                        Nome: mob.nome,
                        Vida: mob.vida,
                        Ataque: mob.ataque,
                        Defesa: mob.defesa
                    }
                ]);
            }
        } else {
            console.log(yellowBoldText, `\nA sala parece estar livre de mobs.\n`);
        }

        // Vendo o boss da sala
        if (boss.length > 0) {
            console.log(redBoldText, `\nUm Boss imponente está presente aqui!\n`);
            for (const b of boss) {
                console.table([
                    {
                        Nome: b.nome,
                        Vida: b.vida,
                        Ataque: b.ataque,
                        Defesa: b.defesa,
                        Passiva: `Tem um buff de ${b.buff} em ${b.passiva}`
                    }
                ]);
            }
        }

        // Caso a sala esteja vazia
        if (npcs.length === 0 && mobs.length === 0 && boss.length === 0) {
            console.log(magentaBoldText, `\nA sala está vazia e silenciosa. Nada de interessante por aqui.\n`);
        }

        console.log(cyanBoldText, `\nO que você fará a seguir?\n`);

        let options = [];
        let optionNumber = 0;
        const optionsTable = [];

        // Adiciona a opção de detalhar a sala novamente
        options.push({ number: optionNumber++, text: 'Detalhar a sala atual novamente' });
        optionsTable.push({ Opções: 'Detalhar a sala atual novamente' });

        // Adiciona as opções de interação com NPCs, se houver algum
        if (npcs.length > 0) {
            options.push({ number: optionNumber++, text: 'Conversar com uma pessoa' });
            optionsTable.push({ Opções: 'Conversar com uma pessoa' });
        }

        // Adiciona as opções de combate com mobs, se houver algum
        if (mobs.length > 0) {
            options.push({ number: optionNumber++, text: 'Batalhar com um mob' });
            optionsTable.push({ Opções: 'Batalhar com um mob' });
        }

        // Adiciona a opção de enfrentar o Boss, se houver um
        if (boss.length > 0) {
            options.push({ number: optionNumber++, text: 'Batalhar com o Boss' });
            optionsTable.push({ Opções: 'Batalhar com o Boss' });
        }

        // Adiciona a opção de voltar para a sala anterior, se possível
        if (sala.sala_anterior !== null) {
            options.push({ number: optionNumber++, text: 'Ir para a sala anterior' });
            optionsTable.push({ Opções: 'Ir para a sala anterior' });
        }

        // Adiciona a opção de avançar para a próxima sala, se não houver mobs ou Boss na sala atual
        if (mobs.length === 0 && boss.length === 0 && sala.sala_posterior !== null) {
            options.push({ number: optionNumber++, text: 'Ir para a próxima sala' });
            optionsTable.push({ Opções: 'Ir para a próxima sala' });
        }

        if (mobs.length === 0 && boss.length === 0 && sala.sala_posterior == null) {
            options.push({ number: optionNumber++, text: 'Subir para o próximo andar' });
            optionsTable.push({ Opções: 'Subir para o próximo andar' });
        }

        console.table(optionsTable);

        // Tratando a escolha do jogador
        let keepRunning = true;
        while (keepRunning) {
            const choice = parseInt(await question('\n-> '), 10);

            const selectedOption = options.find(option => option.number === choice);

            if (selectedOption) {
                switch (selectedOption.text) {
                    case 'Conversar com uma pessoa':
                        talkWithNpc(npcs, jogador);

                        keepRunning = false;
                        break;

                    case 'Batalhar com um mob':
                        battleWithMob(mobs, jogador);

                        keepRunning = false;
                        break;

                    case 'Batalhar com o Boss':
                        battleWithBoss(boss, jogador);

                        keepRunning = false;
                        break;

                    case 'Ir para a sala anterior':
                        clearTerminal();
                        setTimeout(async () => {
                            await jogadorDatabase.goToAnotherRoom(sala.sala_anterior, jogador.id_jogador);
                            console.log(blueBoldText, '\n\tCaminhando até a sala anterior...\n');
                        }, 1);
                        clearTerminal(1000);
                        setTimeout(() => {
                            jogador.sala_atual = sala.sala_anterior;
                            describeCurrentRoom(jogador);
                        }, 1000);

                        keepRunning = false;
                        break;

                    case 'Ir para a próxima sala':
                        clearTerminal();
                        setTimeout(async () => {
                            await jogadorDatabase.goToAnotherRoom(sala.sala_posterior, jogador.id_jogador);
                            console.log(blueBoldText, '\n\tCaminhando até a próxima sala...\n');
                        }, 1);
                        clearTerminal(1000);
                        setTimeout(() => {
                            jogador.sala_atual = sala.sala_posterior;
                            describeCurrentRoom(jogador);
                        }, 1000);

                        keepRunning = false;
                        break;

                    case 'Subir para o próximo andar':
                        clearTerminal();
                        setTimeout(async () => {
                            const andarAtual = await jogadorDatabase.goUp(jogador);
                            console.log(blueBoldText, '\n\tSubindo para o próximo andar...\n');

                            clearTerminal(1000);
                            setTimeout(() => {
                                jogador.sala_atual = andarAtual;
                                describeCurrentRoom(jogador);
                            }, 1000);
                        }, 1);

                        keepRunning = false;
                        break;

                    case 'Detalhar a sala atual novamente':
                        await describeCurrentRoom(jogador);

                        keepRunning = false;
                        break;

                    default:
                        console.log('\nOpção inválida. Por favor, escolha uma opção válida.');
                        break;
                }
                break;
            } else {
                console.log('\nOpção inválida. Por favor, escolha uma opção válida.');
            }
        }
    }, 1000);
};

// Carregar a sala
const describeCurrentRoom = async (jogador) => {
    clearTerminal();

    setTimeout(() => {
        console.log(greenBoldText, '\n\tCarregando informações sobre a sala...')
    }, 1);

    clearTerminal(1000);

    setTimeout(async () => {
        const sala = await salaDatabase.getSalaInformations(jogador.sala_atual);

        console.log('\n');
        console.log(
            greenBoldText,
            `Sala: ${sala.nome}`
        );
        console.log(
            magentaBoldText,
            `Tipo de sala: ${sala.tipo}`
        );
        console.log(
            magentaBoldText,
            `Localização: ${sala.andar}° andar | Estação: ${sala.estacao}`
        );
        console.log(
            magentaBoldText,
            `Descrição da sala: ${sala.descricao}`
        );

        await getOptions(jogador, sala);
    }, 1000);
}

// Abre o inventário
const openInventory = async (jogador) => {
    clearTerminal();

    setTimeout(() => {
        console.log(greenBoldText, '\n\tAbrindo o inventário...')
    }, 1);

    clearTerminal(1000);

    setTimeout(async () => {
        const inventario = await inventarioDatabase.getInventory(jogador.inventario);

        console.log('\n');
        console.log(greenBoldText, '**Inventário**\n');
        console.table([
            {
                Quantidade_Máxima: inventario.qnt_max,
                Quantidade_de_Armas: Number(inventario.qnt_armas),
                Quantidade_de_Itens_Consumiveis: Number(inventario.qnt_itens_consumiveis),
            }
        ]);

        // Inventário Options:
        console.log(cyanBoldText, `\nO que deseja fazer?\n`);

        let options = [];
        let optionNumber = 0;
        const optionsTable = [];

        options.push({ number: optionNumber++, text: 'Fechar inventário' });
        optionsTable.push({ Opções: 'Fechar inventário' });

        if (Number(inventario.qnt_armas) > 0) {
            options.push({ number: optionNumber++, text: 'Listar armas' });
            optionsTable.push({ Opções: 'Listar armas' });
        }

        if (Number(inventario.qnt_itens_consumiveis) > 0) {
            options.push({ number: optionNumber++, text: 'Listar itens consumíveis' });
            optionsTable.push({ Opções: 'Listar itens consumíveis' });
        }

        console.table(optionsTable);

        // Tratando a escolha do jogador
        let keepRunning = true;
        while (keepRunning) {
            const choice = parseInt(await question('\n-> '), 10);

            const selectedOption = options.find(option => option.number === choice);

            if (selectedOption) {
                switch (selectedOption.text) {
                    case 'Fechar inventário':
                        clearTerminal();
                        setTimeout(() => {
                            describeCurrentRoom(jogador);
                        }, 1);

                        keepRunning = false;
                        break;
                    case 'Listar armas':
                        clearTerminal();
                        setTimeout(async () => {
                            await detailWeapons(jogador);
                        }, 1);

                        keepRunning = false;
                        break;
                    case 'Listar itens consumíveis':
                        clearTerminal();
                        setTimeout(async () => {
                            await detailConsumableItens(jogador);
                        }, 1);

                        keepRunning = false;
                        break;
                    default:
                        console.log(redBoldText, '\nOpção inválida. Por favor, escolha uma opção válida.');
                        continue;
                }
            } else {
                console.log(redBoldText, '\nOpção inválida. Por favor, escolha uma opção válida.');
            }
        }

    }, 1000);
};

// Informações sobre o jogador
const yourInformations = async (jogador) => {
    clearTerminal();

    setTimeout(() => {
        console.log(greenBoldText, `\n\tCarregando informações de ${jogador.nome}...`)
    }, 1);

    clearTerminal(1000);

    setTimeout(async () => {
        const currentPlayer = await jogadorDatabase.getOne(jogador.id_jogador);
        const missoes = await missaoDatabase.getMissionsInProgress(jogador.id_jogador);

        console.log('\n');
        console.log(greenBoldText, '**Suas Estatísticas**');
        console.table([
            {
                Nome: currentPlayer.nome,
                Classe: currentPlayer.nome_classe,
                Vida: currentPlayer.vida,
                Magia: currentPlayer.magia,
                Defesa: currentPlayer.defesa,
                Ataque: currentPlayer.ataque,
                Nivel: currentPlayer.nivel,
                XP: currentPlayer.xp
            }
        ]);

        if (missoes.length > 0) {
            console.log(greenBoldText, '\n**Missões em Andamento**');
            const missoesOptions = [];

            for (missao of missoes) {
                missoesOptions.push({
                    Nome: missao.nome,
                    Descrição: missao.descricao,
                    Recompensa: `${missao.recompensa_xp} pontos de XP`,
                    Status: missao.status
                });
            }

            console.table(missoesOptions);
        }

        if (jogador.item_atual) {
            detailCurrentItem(jogador);
        }

        setTimeout(async () => {
            console.log(yellowBoldText, '\nDigite 1 para fechar suas estatísticas!');

            let keepRunning = true;
            while (keepRunning) {
                const choice = parseInt(await question('\n-> '), 10);

                if (choice != 1) {
                    console.log(redBoldText, '\nOpção inválida...');
                } else {
                    keepRunning = false;

                    // Fecho o inventário
                    setTimeout(() => {
                        describeCurrentRoom(jogador);
                    }, 1500)
                }
            }
        }, 500);

    }, 1000);
}

// Ver as armas do inventario
const detailWeapons = async (jogador) => {
    const itens = await inventarioDatabase.getWeapons(jogador.inventario);
    const itensOptions = [];

    console.log('\n');
    console.log(greenBoldText, '**Armas do seu Inventário**\n');

    for (item of itens) {
        itensOptions.push({
            Nome: item.nome,
            Descrição: item.descricao,
            Buff: `Buff de ${item.buff} pontos em ${item.efeito}`
        });
    }

    console.table(itensOptions);

    console.log(cyanBoldText, '\nSuas opções são:');

    let options = [];
    let optionNumber = 0;
    const optionsTable = [];

    options.push({ number: optionNumber++, text: 'Fechar inventário' });
    optionsTable.push({ Opções: 'Fechar inventário' });

    options.push({ number: optionNumber++, text: 'Escolher uma arma' });
    optionsTable.push({ Opções: 'Escolher uma arma' });

    console.table(optionsTable);

    // Tratando a escolha do jogador
    let keepRunning = true;
    while (keepRunning) {
        const choice = parseInt(await question('\n-> '), 10);

        const selectedOption = options.find(option => option.number === choice);

        if (selectedOption) {
            switch (selectedOption.text) {
                case 'Fechar inventário':
                    clearTerminal();
                    setTimeout(() => {
                        describeCurrentRoom(jogador);
                    }, 1);

                    keepRunning = false;
                    break;
                case 'Escolher uma arma':
                    console.log(blueBoldText, '\nInforme a arma que quer usar: \n')

                    let keepRunning2 = true;
                    while (keepRunning2) {
                        const option = parseInt(await question('-> '), 10);

                        if (option >= 0 && option < itens.length) {
                            keepRunning2 = false
                            const currentItem = itens[option];

                            console.log(greenBoldText, `\nAgora você está usando: ${currentItem.nome}\n`);

                            // atualizo o item atual
                            await jogadorDatabase.updateCurrentWeapon(currentItem.id_item, jogador.id_jogador);
                            jogador.item_atual = currentItem.id_item;

                            // Fecho o inventário
                            setTimeout(() => {
                                describeCurrentRoom(jogador);
                            }, 3000)
                        } else {
                            console.log(redBoldText, '\nOpção inválida. Por favor, escolha uma opção válida.');
                        }
                    }

                    keepRunning = false;
                    break;
                default:
                    console.log(redBoldText, '\nOpção inválida. Por favor, escolha uma opção válida.');
                    continue;
            }
        } else {
            console.log(redBoldText, '\nOpção inválida. Por favor, escolha uma opção válida.');
        }
    }
}

// Ver arma atual
const detailCurrentItem = async (jogador) => {
    const currentItem = await jogadorDatabase.getCurrentItem(jogador.id_jogador);

    console.log(greenBoldText, '\n**Item Atual**');
    console.table([
        {
            Nome: currentItem.nome,
            Descrição: currentItem.descricao,
            Buff: `Buff de ${currentItem.buff} pontos em ${currentItem.efeito}`
        }
    ]);
}

// Ver os itens consumíveis do inventário
const detailConsumableItens = async (jogador) => {
    const itens = await inventarioDatabase.getConsumableItens(jogador.inventario);
    const itensOptions = [];
    console.log('\n');
    console.log(greenBoldText, '**Itens consumíveis do seu Inventário**\n');

    for (item of itens) {
        itensOptions.push({
            Nome: item.nome,
            Descrição: item.descricao,
            Buff: `Buff de ${item.buff} pontos em ${item.efeito}`
        });
    }

    console.table(itensOptions);

    console.log(cyanBoldText, '\nSuas opções são:');

    let options = [];
    let optionNumber = 0;
    const optionsTable = [];

    options.push({ number: optionNumber++, text: 'Fechar inventário' });
    optionsTable.push({ Opções: 'Fechar inventário' });

    options.push({ number: optionNumber++, text: 'Consumir um item' });
    optionsTable.push({ Opções: 'Consumir um item' });

    console.table(optionsTable);

    // Tratando a escolha do jogador
    let keepRunning = true;
    while (keepRunning) {
        const choice = parseInt(await question('\n-> '), 10);

        const selectedOption = options.find(option => option.number === choice);

        if (selectedOption) {
            switch (selectedOption.text) {
                case 'Fechar inventário':
                    clearTerminal();
                    setTimeout(() => {
                        describeCurrentRoom(jogador);
                    }, 1);

                    keepRunning = false;
                    break;
                case 'Consumir um item':
                    console.log(blueBoldText, '\nInforme o item que quer consumir: \n')

                    let keepRunning2 = true;
                    while (keepRunning2) {
                        const option = parseInt(await question('-> '), 10);

                        if (option >= 0 && option < itens.length) {
                            keepRunning2 = false
                            const currentItem = itens[option];

                            console.log(greenBoldText, `\nVocê consumiu: ${currentItem.nome}\n`);

                            // consumir o item
                            await inventarioDatabase.consumeItem(currentItem.id_inventario_item);

                            // Fecho o inventário
                            setTimeout(() => {
                                describeCurrentRoom(jogador);
                            }, 3000)
                        } else {
                            console.log(redBoldText, '\nOpção inválida. Por favor, escolha uma opção válida.\n');
                        }
                    }

                    keepRunning = false;
                    break;
                default:
                    console.log(redBoldText, '\nOpção inválida. Por favor, escolha uma opção válida.');
                    continue;
            }
        } else {
            console.log(redBoldText, '\nOpção inválida. Por favor, escolha uma opção válida.');
        }
    }
}

// Conversar com um NPC
const talkWithNpc = async (npcs, jogador) => {
    console.log(cyanBoldText, `\nEscolha com quem quer conversar:\n`);

    const options = [];
    for (let i = 0; i < npcs.length; i++) {
        options.push({
            Nome: npcs[i].nome,
            Profissão: npcs[i].profissao
        });
    }

    console.table(options);

    let keepRunning = true;
    while (keepRunning) {
        const npcChoice = parseInt(await question('\n-> '), 10);

        if (npcChoice >= 0 && npcChoice < npcs.length) {
            const currentNpc = npcs[npcChoice];

            if (currentNpc.interagiu_jogador == true) {
                console.log(yellowBoldText, `\nVocê já interagiu com ${currentNpc.nome}.\n`);

                if (npcs.length == 1) {
                    keepRunning = false;
                    setTimeout(() => {
                        describeCurrentRoom(jogador);
                    }, 1000);
                }
            } else {
                keepRunning = false;
                clearTerminal();

                setTimeout(() => {
                    console.log(blueBoldText, `\n\tCaminhando até ${currentNpc.nome}...\n`);
                }, 1);

                clearTerminal(1000);

                setTimeout(async () => {
                    console.log(yellowBoldText, `\nOlá ${jogador.nome}!`);
                    console.log(yellowBoldText, currentNpc.fala);

                    console.log(cyanBoldText, `\nSuas opções são:\n`);

                    // opção do usuário...
                    const typeDecision = await enumDatabase.getTypeDecision();
                    const options = [];
                    for (const d of typeDecision) {
                        options.push({
                            Decisão: d.decisao
                        });
                    }
                    console.table(options);

                    let keepRunning2 = true;
                    while (keepRunning2) {
                        const decision = parseInt(await question('\n-> '), 10);

                        if (decision >= 0 && decision < typeDecision.length) {
                            keepRunning2 = false;
                            const currentDecision = typeDecision[decision].decisao;

                            console.log(yellowBoldText, `\nVocê decidiu ${currentDecision}!`);

                            // Crio o diálogo
                            dialogoDatabase.createDialogue(currentDecision, jogador.id_jogador, currentNpc.id_instancia_npc);

                            if (currentDecision === 'Aceitar') {
                                clearTerminal();

                                // Mostrar a missão e o item imediatamente sem delay
                                const mission = await npcDatabase.getMission(currentNpc.id_instancia_npc);
                                if (mission) {
                                    console.log(greenBoldText, `\n${currentNpc.nome} te passou uma nova missão!\n`);

                                    console.table([
                                        {
                                            Nome: mission.nome,
                                            Descrição: mission.descricao,
                                            Recompensa: `${mission.recompensa_xp} pontos de XP`
                                        }
                                    ]);

                                    console.log('\n');
                                }

                                const item = await npcDatabase.getDropItem(currentNpc.id_instancia_npc);
                                if (item) {
                                    console.log(greenBoldText, `\n${currentNpc.nome} te dropou um novo item!\n`);

                                    console.table([
                                        {
                                            Nome: item.nome,
                                            Descrição: item.descricao,
                                            Tipo: item.tipo,
                                            Buff: `Tem um buff de ${item.buff} em ${item.efeito}`
                                        }
                                    ]);

                                    console.log('\n');
                                }

                                // Mostrar mensagem "Digite 1 para fechar" aqui, sem delay
                                console.log(yellowBoldText, 'Digite 1 para fechar!');

                                let keepRunning3 = true;
                                while (keepRunning3) {
                                    const choice = parseInt(await question('\n-> '), 10);

                                    if (choice !== 1) {
                                        console.log(redBoldText, '\nOpção inválida...');
                                    } else {
                                        keepRunning3 = false;

                                        // Fecho a tela
                                        describeCurrentRoom(jogador);
                                    }
                                }
                            } else {
                                // Retorno pra sala...
                                describeCurrentRoom(jogador);
                            }
                        } else {
                            console.log(redBoldText, '\nOpção inválida. Por favor, escolha uma decisão válida.');
                        }
                    }
                }, 1000);
            }
        } else {
            console.log(redBoldText, '\nOpção inválida. Por favor, escolha um NPC válido.');
        }
    }
};

// Batalhar com um inimigo
const battleWithMob = async (mobs, jogador) => {
    console.log(redBoldText, `\nEscolha com que inimigo quer batalhar:\n`);

    const options = [];
    for (let i = 0; i < mobs.length; i++) {
        options.push({
            Nome: mobs[i].nome,
            Ataque: mobs[i].ataque,
            Defesa: mobs[i].defesa,
            Vida: mobs[i].vida
        });
    }

    console.table(options);

    let keepRunning = true;
    while (keepRunning) {
        const enemyChoice = parseInt(await question('\n-> '), 10);

        if (enemyChoice >= 0 && enemyChoice < mobs.length) {
            const currentEnemy = mobs[enemyChoice];

            keepRunning = false;
            await battle(jogador, currentEnemy);
        } else {
            console.log(redBoldText, '\nOpção inválida. Por favor, escolha um inimigo válido.');
        }
    }
}

// Batalhar com um boss
const battleWithBoss = async (boss, jogador) => {
    console.log(redBoldText, `\nEscolha o Boss que quer batalhar:\n`);

    const options = [];
    for (let i = 0; i < boss.length; i++) {
        options.push({
            Nome: boss[i].nome,
            Ataque: boss[i].ataque,
            Defesa: boss[i].defesa,
            Vida: boss[i].vida,
            Buff: `${boss[i].buff} pontos a mais de ${boss[i].passiva}`
        });
    }

    console.table(options);

    let keepRunning = true;
    while (keepRunning) {
        const enemyChoice = parseInt(await question('\n-> '), 10);

        if (enemyChoice >= 0 && enemyChoice < boss.length) {
            const currentEnemy = boss[enemyChoice];

            keepRunning = false;
            await battle(jogador, currentEnemy);
        } else {
            console.log(redBoldText, '\nOpção inválida. Por favor, escolha um boss válido.');
        }
    }
}

const battle = async (jogador, inimigo) => {
    const currentItem = await jogadorDatabase.getCurrentItem(jogador.id_jogador);

    clearTerminal();

    setTimeout(() => {
        console.log(redBoldText, `\n\tVocê corre para atacar o ${inimigo.nome}...`);
    }, 1);

    clearTerminal(2000);

    setTimeout(async () => {
        console.log('\n');
        console.log(redBoldText, `**Batalha iniciada contra ${inimigo.nome}!**\n`);

        // Definir dano mínimo
        const danoMinimo = 1;

        // Atributos do jogador
        let { ataque: ataqueJogador, defesa: defesaJogador, magia: magiaJogador, vida: vidaJogador } = jogador;

        if (currentItem) {
            switch (currentItem.efeito) {
                case 'Ataque':
                    ataqueJogador += currentItem.buff;
                    break;

                case 'Magia':
                    magiaJogador += currentItem.buff;
                    break;

                case 'Defesa':
                    defesaJogador += currentItem.buff;
                    break;
            }
        }

        // Atributos do inimigo
        let { ataque: ataqueInimigo, defesa: defesaInimigo, vida: vidaInimigo } = inimigo;

        if (inimigo.passiva) {
            switch (inimigo.passiva) {
                case 'Ataque':
                    ataqueInimigo += inimigo.buff;
                    break;

                case 'Defesa':
                    defesaInimigo += inimigo.buff;
                    break;

                case 'Vida':
                    vidaInimigo += inimigo.buff;
                    break;
            }
        }

        // Iniciar o loop de batalha
        while (vidaJogador > 0 && vidaInimigo > 0) {
            console.log(cyanBoldText, `\nSua Vida: ${vidaJogador} | Vida do Inimigo: ${vidaInimigo}`);

            // Jogador realiza uma ação
            let keepRunning = true;
            while (keepRunning) {
                console.log('\nEscolha sua ação:');
                console.table([
                    { Opções: 'Ataque Físico' },
                    { Opções: 'Ataque Mágico' }
                ]);

                let acaoJogador = parseInt(await question('\n-> '), 10);

                switch (acaoJogador) {
                    case 0:
                        console.log(blueBoldText, '\nVocê escolheu Ataque Físico!');

                        console.log(magentaBoldText, 'Atacando o inimigo...');

                        // Calcular dano do ataque físico
                        let danoBase = ataqueJogador - defesaInimigo;
                        let danoJogador = danoBase < danoMinimo ? danoMinimo : danoBase;

                        // Atualizar vida do inimigo
                        vidaInimigo = vidaInimigo - danoJogador;
                        await inimigoDatabase.updateLifeEnemy(vidaInimigo, inimigo.id_instancia);

                        console.log(greenBoldText, `\nVocê causou ${danoJogador} de dano físico! Vida restante do inimigo: ${vidaInimigo}`);

                        keepRunning = false;
                        break;

                    case 1:
                        console.log(magentaBoldText, '\nVocê escolheu Ataque Mágico!');

                        console.log(magentaBoldText, '\n\tAtacando o inimigo...');
                        // Calcular dano da magia
                        let danoMagico = (magiaJogador < danoMinimo) ? danoMinimo : magiaJogador;

                        // Atualizar vida do inimigo
                        vidaInimigo = vidaInimigo - danoMagico;
                        await inimigoDatabase.updateLifeEnemy(vidaInimigo, inimigo.id_instancia);

                        console.log(greenBoldText, `\nVocê causou ${danoMagico} de dano mágico! Vida restante do inimigo: ${vidaInimigo}\n`);

                        keepRunning = false;
                        break;

                    default:
                        console.log(redBoldText, '\nAção inválida. Por favor, escolha 0 para Ataque Físico ou 1 para Ataque Mágico.\n');
                }
            }

            // Verificar se o inimigo foi derrotado
            if (vidaInimigo <= 0) {
                console.log(cyanBoldText, `Parabens você derrotou ${inimigo.nome}!`);
                await batalhaDatabase.createBatalha(true, inimigo.id_instancia, jogador.id_jogador);
                await missaoDatabase.updateStatusMission(jogador.id_jogador, inimigo.id_instancia); // Atualiza o status da missão, caso ela tenha sido finalizada
                const newItem = await inventarioDatabase.getItemById(inimigo.item_drop);

                console.log(cyanBoldText, '**Recompensas**')
                console.table([
                    {
                        Item: newItem.nome,
                        XP: `Ganhou mais ${inimigo.xp} de XP`
                    }
                ]);

                const completedMission = await missaoDatabase.getCompletedMission(jogador.id_jogador, inimigo.id_inimigo);

                if (completedMission) {
                    console.log(cyanBoldText, '\n**Parabéns você completou uma missão**')
                    console.log(cyanBoldText, '**Informações**')
                    console.table([
                        {
                            Nome: completedMission.nome,
                            Descrição: completedMission.descricao,
                            Recompensa_XP: `Ganhou mais ${completedMission.recompensa_xp} de XP`
                        }
                    ]);
                }

                // Mostrar mensagem "Digite 1 para fechar" aqui, sem delay
                console.log(yellowBoldText, 'Digite 1 para fechar!');

                let keepRunning3 = true;
                while (keepRunning3) {
                    const choice = parseInt(await question('\n-> '), 10);

                    if (choice !== 1) {
                        console.log(redBoldText, '\nOpção inválida...');
                    } else {
                        keepRunning3 = false;

                        // Fecho a tela
                        describeCurrentRoom(jogador);
                    }
                }

                return;
            }

            // Inimigo realiza uma ação
            console.log(redBoldText, `\n${inimigo.nome} está atacando...`);
            // Calcular dano do inimigo
            let danoBaseInimigo = ataqueInimigo - defesaJogador;
            let danoInimigo = danoBaseInimigo < danoMinimo ? danoMinimo : danoBaseInimigo;

            // Atualizar vida do jogador
            vidaJogador -= danoInimigo;
            await jogadorDatabase.tookDamage(vidaJogador, jogador.id_jogador);
            console.log(redBoldText, `O inimigo causou ${danoInimigo} de dano! Sua vida restante: ${vidaJogador}`);

            // Verificar se o jogador foi derrotado
            if (vidaJogador <= 0) {
                console.log(redBoldText, 'Você foi derrotado!');
                await batalhaDatabase.createBatalha(false, jogador.id_jogador, inimigo.id_instancia); // Supondo que essas propriedades existem

                clearTerminal(1000);
                setTimeout(async () => {
                    await jogadorDatabase.ressurgePlayer(jogador);
                    console.log(greenBoldText, '\n\tRenascendo no seu último checkpoint...');
                }, 1001);

                setTimeout(() => {
                    describeCurrentRoom(jogador);
                }, 3000);

                return;
            }
        }
    }, 2000)
};

module.exports = {
    getOptions,
    describeCurrentRoom
};
