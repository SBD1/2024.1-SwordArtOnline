const { question } = require('../utils/readlineConfig');
const { clearTerminal } = require('../utils/terminalUtils');
const salaDatabase = require('../database/sala');
const inventarioDatabase = require('../database/inventario');
const enumDatabase = require('../database/enum');
const npcDatabase = require('../database/npc');
const dialogoDatabase = require('../database/dialogo');
const jogadorDatabase = require('../database/jogador');
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

    if (jogador.item_atual) {
        options.push({ Opções: 'Ver seu item atual' });
    }

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

        console.log(blueBoldText, `${sala.nome} (Tipo: ${sala.tipo})`);
        console.log(blueBoldText, `  Andar: ${sala.andar}`);
        console.log(blueBoldText, `  Descrição: ${sala.descricao}`);

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

        console.log(greenBoldText, '**Suas Estatísticas**\n');
        console.table([
            {
                Nome: currentPlayer.nome,
                Classe: currentPlayer.nome_classe,
                Vida: currentPlayer.vida,
                Magia: currentPlayer.magia,
                Defesa: currentPlayer.defesa,
                Ataque: currentPlayer.ataque,
            }
        ]);

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

    }, 1000);
}

// Ver as armas do inventario
const detailWeapons = async (jogador) => {
    const itens = await inventarioDatabase.getWeapons(jogador.inventario);
    const itensOptions = [];

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

    console.log(greenBoldText, '**Item Atual**\n');
    console.table([
        {
            Nome: currentItem.nome,
            Descrição: currentItem.descricao,
            Buff: `Buff de ${currentItem.buff} pontos em ${currentItem.efeito}`
        }
    ]);

    console.log(yellowBoldText, '\nDigite 1 para fechar o inventário!');

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
}

// Ver os itens consumíveis do inventário
const detailConsumableItens = async (jogador) => {
    const itens = await inventarioDatabase.getConsumableItens(jogador.inventario);
    console.log(itens);

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
                            await inventarioDatabase.consumeItem(jogador.inventario, currentItem.id_item);

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
                    console.log(blueBoldText, `\n\tCaminhando até ${currentNpc.nome}.\n`);
                }, 1);

                clearTerminal(1000);

                setTimeout(async () => {
                    console.log(yellowBoldText, `Olá ${jogador.nome}!`);
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
                                    console.log(greenBoldText, `${currentNpc.nome} te passou uma nova missão!\n`);

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
                                    console.log(greenBoldText, `${currentNpc.nome} te dropou um novo item!\n`);

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
    console.log(`\nEscolha um mob para batalhar:\n`);
    for (let i = 0; i < mobs.length; i++) {
        console.log(`${i + 1} - ${mobs[i].nome}\n`);
    }
    const mobChoice = parseInt(await question('\n-> '), 10);
    if (mobChoice > 0 && mobChoice <= mobs.length) {
        console.log(`\nVocê se prepara para batalhar com ${mobs[mobChoice - 1].nome}.\n`);
        // Implemente a lógica para batalhar com o mob
    } else {
        console.log('\nOpção inválida. Por favor, escolha um mob válido.');
    }
}

// Batalhar com um boss
const battleWithBoss = async (boss, jogador) => {
    console.log(`\nEscolha o Boss para batalhar:\n`);
    for (let i = 0; i < boss.length; i++) {
        console.log(`${i + 1} - ${boss[i].nome}\n`);
    }
    const bossChoice = parseInt(await question('\n-> '), 10);
    if (bossChoice > 0 && bossChoice <= boss.length) {
        console.log(`\nVocê enfrenta o Boss ${boss[bossChoice - 1].nome}!\n`);
        // Implemente a lógica para batalhar com o Boss
    } else {
        console.log('\nOpção inválida. Por favor, escolha um Boss válido.');
    }
}

module.exports = {
    getOptions,
    describeCurrentRoom
};
