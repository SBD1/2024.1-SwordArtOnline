const { question, rl } = require('../config/readlineConfig');
const { typeWriter, clearTerminal } = require('../config/terminalUtils');
const salaDatabase = require('../database/sala');

// Exibe opções para o jogador e trata a escolha
const getOptions = async (jogador, sala) => {
    await typeWriter('**Opções** \n');
    await typeWriter('\t1 - Olhar ao redor \n', 20);
    await typeWriter('\t2 - Abrir inventário \n', 20);
    await typeWriter('Escolha uma opção.. ');

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
                await typeWriter('\nOpção inválida. Por favor, digite um número válido...');
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

    await typeWriter('\nVocê dá uma olhada ao redor da sala...\n', 40);

    // Vendo os NPCs da sala
    if (npcs.length > 0) {
        await typeWriter(`\nHá ${npcs.length} NPC${npcs.length === 1 ? '' : 's'} aqui:\n`, 30);
        for (const npc of npcs) {
            await typeWriter(`- ${npc.nome}\n`, 20);
        }
    } else {
        await typeWriter(`\nNão há NPCs na sala.\n`, 30);
    }

    // Vendo os mobs da sala
    if (mobs.length > 0) {
        await typeWriter(`\n${mobs.length === 1 ? 'Um mob está vagando pela sala:' : '${mobs.length} mobs estão vagando pela sala:'}\n`, 30);
        for (const mob of mobs) {
            await typeWriter(`- ${mob.nome}\n`, 20);
        }
    } else {
        await typeWriter(`\nA sala parece estar livre de mobs.\n`, 30);
    }

    // Vendo o boss da sala
    if (boss.length > 0) {
        await typeWriter(`\nUm Boss imponente está presente aqui!\n`, 40);
        for (const b of boss) {
            await typeWriter(`- ${b.nome}\n`, 20);
        }
    }

    // Caso a sala esteja vazia
    if (npcs.length === 0 && mobs.length === 0 && boss.length === 0) {
        await typeWriter(`\nA sala está vazia e silenciosa. Nada de interessante por aqui.\n`, 30);
    }

    await typeWriter(`\nO que você fará a seguir?\n`, 40);

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
        await typeWriter(`\n${option.number} - ${option.text}\n`, 20);
    }

    // Tratando a escolha do jogador
    while (true) {
        const choice = parseInt(await question('\n-> '), 10);

        const selectedOption = options.find(option => option.number === choice);

        if (selectedOption) {
            switch (selectedOption.text) {
                case 'Conversar com um NPC':
                    await typeWriter(`\nEscolha um NPC para conversar:\n`, 30);
                    for (let i = 0; i < npcs.length; i++) {
                        await typeWriter(`${i + 1} - ${npcs[i].nome}\n`, 20);
                    }
                    const npcChoice = parseInt(await question('\n-> '), 10);
                    if (npcChoice > 0 && npcChoice <= npcs.length) {
                        await typeWriter(`\nVocê escolhe conversar com ${npcs[npcChoice - 1].nome}.\n`, 30);
                        // Implemente a lógica para conversar com o NPC
                    } else {
                        await typeWriter('\nOpção inválida. Por favor, escolha um NPC válido.', 30);
                    }
                    break;

                case 'Batalhar com um mob':
                    await typeWriter(`\nEscolha um mob para batalhar:\n`, 30);
                    for (let i = 0; i < mobs.length; i++) {
                        await typeWriter(`${i + 1} - ${mobs[i].nome}\n`, 20);
                    }
                    const mobChoice = parseInt(await question('\n-> '), 10);
                    if (mobChoice > 0 && mobChoice <= mobs.length) {
                        await typeWriter(`\nVocê se prepara para batalhar com ${mobs[mobChoice - 1].nome}.\n`, 30);
                        // Implemente a lógica para batalhar com o mob
                    } else {
                        await typeWriter('\nOpção inválida. Por favor, escolha um mob válido.', 30);
                    }
                    break;

                case 'Batalhar com o Boss':
                    await typeWriter(`\nEscolha o Boss para batalhar:\n`, 30);
                    for (let i = 0; i < boss.length; i++) {
                        await typeWriter(`${i + 1} - ${boss[i].nome}\n`, 20);
                    }
                    const bossChoice = parseInt(await question('\n-> '), 10);
                    if (bossChoice > 0 && bossChoice <= boss.length) {
                        await typeWriter(`\nVocê enfrenta o Boss ${boss[bossChoice - 1].nome}!\n`, 30);
                        // Implemente a lógica para batalhar com o Boss
                    } else {
                        await typeWriter('\nOpção inválida. Por favor, escolha um Boss válido.', 30);
                    }
                    break;

                case 'Ir para a sala anterior':
                    await typeWriter('\nVocê decide voltar para a sala anterior.\n', 30);
                    // Implemente a lógica para ir para a sala anterior
                    break;

                case 'Ir para a próxima sala':
                    await typeWriter('\nVocê avança para a próxima sala.\n', 30);
                    // Implemente a lógica para ir para a próxima sala
                    break;

                case 'Detalhar a sala atual novamente':
                    await describeCurrentRoom(jogador);
                    break;

                default:
                    await typeWriter('\nOpção inválida. Por favor, escolha uma opção válida.', 30);
                    break;
            }
            break;
        } else {
            await typeWriter('\nOpção inválida. Por favor, escolha uma opção válida.', 30);
        }
    }
};

const describeCurrentRoom = async (jogador) => {
    clearTerminal(500);
    const sala = await salaDatabase.getSalaInformations(jogador.sala_atual);

    setInterval( async () => {
        await typeWriter(
            `
            Você está na sala: ${sala.nome} (Tipo: ${sala.tipo})
            Localização:
                Andar: ${sala.andar}
                Descrição: ${sala.descricao}
                Estação: ${sala.estacao}
            `
            , 20);
        
            await typeWriter('\nDigite 1 para ver suas opções:');
            while (true) {
                const option =  parseInt(await question('\n-> '), 10);
        
                if (option === 1) {
                    await getOptions(jogador, sala);
                } else {
                    await typeWriter('\nOpção inválida. Por favor, digite um número válido...');
                }
            }
    }, 500);
}

// Abre o inventário
const openInventory = async (jogador) => {
    // Implemente a lógica para abrir o inventário aqui
    console.log('abrir o inventário')
};

// Ver arma atual
const detailCurrentItem = async () => {
    // detalhar 
}

module.exports = {
    getOptions,
    describeCurrentRoom
};
