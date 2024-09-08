const { question } = require('../utils/readlineConfig');
const { clearTerminal } = require('../utils/terminalUtils');
const salaDatabase = require('../database/sala');
const inventarioDatabase = require('../database/inventario');
const enumDatabase = require('../database/enum');
const npcDatabase = require('../database/npc');
const dialogoDatabase = require('../database/dialogo');
const { blueBoldText, cyanBoldText, yellowBoldText, redBoldText, magentaBoldText, greenBoldText } = require('../utils/colors');

// Exibe opções para o jogador e trata a escolha
const getOptions = async (jogador, sala) => {
    console.log(cyanBoldText, '\nSuas opções são:');
    console.log('\n');
    console.table([
        { Opções: 'Olhar ao redor' },
        { Opções: 'Abrir inventário' }
    ]);
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
            default:
                console.log('\nOpção inválida. Por favor, digite um número válido...');
                break;
        }
    }
};

// Detalha a sala
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
            console.log(yellowBoldText, `\nHá ${npcs.length} NPC${npcs.length === 1 ? '' : 's'} aqui:\n`);
            for (const npc of npcs) {
                console.table([
                    {
                        Nome: npc.nome,
                        Profissão: npc.profissao
                    }
                ]);
            }
        } else {
            console.log(yellowBoldText, `\nNão há NPCs na sala.\n`);
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
            options.push({ number: optionNumber++, text: 'Conversar com um NPC' });
            optionsTable.push({ Opções: 'Conversar com um NPC' });
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
                    case 'Conversar com um NPC':
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
                        console.log('\nVocê decide voltar para a sala anterior.\n');
                        // Implemente a lógica para ir para a sala anterior

                        keepRunning = false;
                        break;

                    case 'Ir para a próxima sala':
                        console.log('\nVocê avança para a próxima sala.\n');
                        // Implemente a lógica para ir para a próxima sala

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

const describeCurrentRoom = async (jogador) => {
    clearTerminal();

    setTimeout(() => {
        console.log(greenBoldText, '\n\tCarregando...')
    }, 1);

    clearTerminal(2000);

    setTimeout(async () => {
        const sala = await salaDatabase.getSalaInformations(jogador.sala_atual);

        console.log(blueBoldText, `${sala.nome} (Tipo: ${sala.tipo})`);
        console.log(blueBoldText, `  Andar: ${sala.andar}`);
        console.log(blueBoldText, `  Descrição: ${sala.descricao}`);

        await getOptions(jogador, sala);
    }, 2000);
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
                Quantidade_de_Itens: Number(inventario.qnt_itens)
            }
        ]);

        // Inventário Options:
        console.log(cyanBoldText, `\nO que deseja fazer?\n`);

        let options = [];
        let optionNumber = 0;
        const optionsTable = [];

        // Adiciona a opção de detalhar a sala novamente
        options.push({ number: optionNumber++, text: 'Fechar inventário' });
        optionsTable.push({ Opções: 'Fechar inventário' });

        if (Number(inventario.qnt_itens) > 0) {
            options.push({ number: optionNumber++, text: 'Listar itens' });
            optionsTable.push({ Opções: 'Listar itens' });

            options.push({ number: optionNumber++, text: 'Ver seu item atual' });
            optionsTable.push({ Opções: 'Ver seu item atual' });
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

                    case 'Listar itens':
                        clearTerminal();
                        setTimeout(() => {
                            // Listar itens...
                        }, 1);

                        keepRunning = false;
                        break;
                    case 'Ver seu item atual':
                        clearTerminal();
                        setTimeout(() => {
                            detailCurrentItem(jogador);
                        }, 1);

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

// Ver os itens do inventario
const detailItens = async (jogador) => {

} 

// Ver arma atual
const detailCurrentItem = async (jogador) => {
    // detalhar 
}

// Conversar com um NPC
const talkWithNpc = async (npcs, jogador) => {
    console.log(cyanBoldText, `\nEscolha um NPC para conversar:\n`);

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
                    for (d of typeDecision) {
                        options.push({
                            Decisão: d.decisao
                        })
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

                            if (currentDecision == 'Aceitar') {
                                clearTerminal();

                                setTimeout(async () => {
                                    // Mostro a nova missão passada pelo npc, se existir...
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

                                    // Mostro o item dropado pelo npc, se existir...
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
                                }, 1);

                                clearTerminal(10000);

                                // Retorno pra sala...
                                setTimeout(() => {
                                    describeCurrentRoom(jogador);
                                }, 10000);
                            } else {
                                // Retorno pra sala...
                                setTimeout(() => {
                                    describeCurrentRoom(jogador);
                                }, 500);
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
