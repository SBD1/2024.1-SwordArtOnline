const { question } = require('../utils/readlineConfig');
const { typeWriter, clearTerminal } = require('../utils/terminalUtils');
const salaDatabase = require('../database/sala');
const inventarioDatabase = require('../database/inventario');
const inventarioItemDatabase = require('../database/inventarioItem');
const { blueBoldText } = require('../utils/colors');

// Exibe opções para o jogador e trata a escolha
const getOptions = async (jogador, sala) => {
    const greenBoldText = '\x1b[32;1m%s\x1b[0m';  // Código ANSI para texto verde e em negrito

    console.log(greenBoldText, '**Opções** \n');
    console.log('\t1 - Olhar ao redor \n');
    console.log('\t2 - Abrir inventário \n');
    console.log('Escolha uma opção.. ');

    while (true) {
        const option = parseInt(await question('\n-> '), 10);

        switch (option) {
            case 1:
                await detailRoom(jogador, sala); // Chama a função para detalhar a sala
                break;
            case 2:
                await openInventory(jogador); // Chama a função para abrir inventário
                break;
            default:
                console.log('\nOpção inválida. Por favor, digite um número válido...');
                break;
        }
    }
}

// Detalha a sala
const detailRoom = async (jogador, sala) => {
    clearTerminal();
    const npcs = await salaDatabase.getNpcsInRoom(jogador.sala_atual);
    const mobs = await salaDatabase.getMobsInRoom(jogador.sala_atual);
    let boss = [];

    if (sala.tipo === 'Boss') {
        boss = await salaDatabase.getBossInRoom(jogador.sala_atual);
    }

    console.log('\nVocê dá uma olhada ao redor da sala...\n');

    // Vendo os NPCs da sala
    if (npcs.length > 0) {
        console.log(`\nHá ${npcs.length} NPC${npcs.length === 1 ? '' : 's'} aqui:\n`);
        for (const npc of npcs) {
            console.log(`- ${npc.nome}\n`);
        }
    } else {
        console.log(`\nNão há NPCs na sala.\n`);
    }

    // Vendo os mobs da sala
    if (mobs.length > 0) {
        console.log(`\n${mobs.length === 1 ? 'Um mob está vagando pela sala:' : '${mobs.length} mobs estão vagando pela sala:'}\n`);
        for (const mob of mobs) {
            console.log(`- ${mob.nome}\n`);
        }
    } else {
        console.log(`\nA sala parece estar livre de mobs.\n`);
    }

    // Vendo o boss da sala
    if (boss.length > 0) {
        console.log(`\nUm Boss imponente está presente aqui!\n`);
        for (const b of boss) {
            console.log(`- ${b.nome}\n`);
        }
    }

    // Caso a sala esteja vazia
    if (npcs.length === 0 && mobs.length === 0 && boss.length === 0) {
        console.log(`\nA sala está vazia e silenciosa. Nada de interessante por aqui.\n`);
    }

    console.log(`\nO que você fará a seguir?\n`);

    let options = [];
    let optionNumber = 1; // Começa a numeração em 1

    // Adiciona a opção de detalhar a sala novamente
    options.push({ number: optionNumber++, text: 'Detalhar a sala atual novamente' });

    // Adiciona as opções de interação com NPCs, se houver algum
    if (npcs.length > 0) {
        options.push({ number: optionNumber++, text: 'Conversar com um NPC' });
    }

    // Adiciona as opções de combate com mobs, se houver algum
    if (mobs.length > 0) {
        options.push({ number: optionNumber++, text: 'Batalhar com um mob' });
    }

    // Adiciona a opção de enfrentar o Boss, se houver um
    if (boss.length > 0) {
        options.push({ number: optionNumber++, text: 'Batalhar com o Boss' });
    }

    // Adiciona a opção de voltar para a sala anterior, se possível
    if (sala.sala_anterior !== null) {
        options.push({ number: optionNumber++, text: 'Ir para a sala anterior' });
    }

    // Adiciona a opção de avançar para a próxima sala, se não houver mobs ou Boss na sala atual
    if (mobs.length === 0 && boss.length === 0 && sala.sala_posterior !== null) {
        options.push({ number: optionNumber++, text: 'Ir para a próxima sala' });
    }

    // Exibe as opções numeradas
    for (const option of options) {
        console.log(`\n${option.number} - ${option.text}\n`);
    }

    // Tratando a escolha do jogador
    while (true) {
        const choice = parseInt(await question('\n-> '), 10);

        const selectedOption = options.find(option => option.number === choice);

        if (selectedOption) {
            switch (selectedOption.text) {
                case 'Conversar com um NPC':
                    talkWithNpc(npcs);
                    break;

                case 'Batalhar com um mob':
                    battleWithMob(mobs);
                    break;

                case 'Batalhar com o Boss':
                    battleWithBoss(boss);
                    break;

                case 'Ir para a sala anterior':
                    console.log('\nVocê decide voltar para a sala anterior.\n');
                    // Implemente a lógica para ir para a sala anterior
                    break;

                case 'Ir para a próxima sala':
                    console.log('\nVocê avança para a próxima sala.\n');
                    // Implemente a lógica para ir para a próxima sala
                    break;

                case 'Detalhar a sala atual novamente':
                    await describeCurrentRoom(jogador);
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
};

const describeCurrentRoom = async (jogador) => {
    clearTerminal();
    const sala = await salaDatabase.getSalaInformations(jogador.sala_atual);

    console.log(blueBoldText, `\nVocê está na sala: ${sala.nome} (Tipo: ${sala.tipo})`);
    console.log(blueBoldText, `Localização:`);
    console.log(blueBoldText, `  Andar: ${sala.andar}`);
    console.log(blueBoldText, `  Descrição: ${sala.descricao}`);

    console.log('\nDigite 1 para ver suas opções:');
    while (true) {
        const option = parseInt(await question('\n-> '), 10);

        if (option === 1) {
            await getOptions(jogador, sala);
        } else {
            console.log('\nOpção inválida. Por favor, digite um número válido...');
        }
    }
}

// Abre o inventário
const openInventory = async (jogador) => {
    const inventario = await inventarioDatabase.openInventory(jogador.id_inventario);

    if (inventario) {
        // Lógica de abrir o inventário e mostrar as coisas
        console.table([
            { item: "Domain-Driven Design: Atacando as Complexidades no Coração do Software", nome: "Martin Fowler" }, 
            { item: "Arquitetura Limpa: O guia do artesão para estrutura e design de software", nome: "Robert C. Martin" },
            { item: "Por que os generalistas vencem em um mundo de especialistas", nome: "David Epstein" }
        ]);
    } else {
        console.log('\n\tSeu inventário está vazio... ;-;\n');
    }
};

// Ver arma atual
const detailCurrentItem = async () => {
    // detalhar 
}

// Conversar com um NPC
const talkWithNpc = async (npcs) => {
    console.log(`\nEscolha um NPC para conversar:\n`);
    for (let i = 0; i < npcs.length; i++) {
        console.log(`${i + 1} - ${npcs[i].nome}\n`);
    }
    const npcChoice = parseInt(await question('\n-> '), 10);
    if (npcChoice > 0 && npcChoice <= npcs.length) {
        const currentNpc = npcs[npcChoice - 1];

        console.log(`\nVocê caminha até o ${currentNpc.nome}.\n`);
        console.log(`\t"${currentNpc.nome}"\n`);


    } else {
        console.log('\nOpção inválida. Por favor, escolha um NPC válido.');
    }
}

// Batalhar com um inimigo
const battleWithMob = async (mobs) => {
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
const battleWithBoss = async (boss) => {
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
