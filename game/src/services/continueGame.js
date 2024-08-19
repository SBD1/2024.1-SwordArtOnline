const { clearTerminal, typeWriter } = require('../config/terminalUtils');
const jogadorDatabase = require('../database/jogador');
const { question } = require('../config/readlineConfig');
const { createPlayer } = require('./createPlayer');
const interactions = require('./interactions');

const continueGame = async () => {
    clearTerminal(500);

    setTimeout(async () => {
        await typeWriter('\n***Seleção de Personagem***\n');
        await getOldGames();
    }, 500);
}

const getOldGames = async () => {
    const jogadores = await jogadorDatabase.getAll();

    if (jogadores.length == 0) {
        await typeWriter('\tNão foi encontrado nenhum personagem ;-;\n');
        await typeWriter('\n\nAperte 1 para voltar pra tela anterior...\n');

        while (true) {
            const input = await question(' -> ');

            if (input == 1) {
                await typeWriter('\nVoltando pra tela de boas vindas..')
                welcomeToGame();
                break;
            } else {
                await typeWriter('\nOpção inválida. Por favor, digite um número válido...\n');
            }
        }
    } else {
        for (const [index, jogador] of jogadores.entries()) {
            await typeWriter(`\t${index + 1} - ** ${jogador.nome} -- ${jogador.nome_classe} **\n`, 20);
        }

        while (true) {
            const input = await question(' -> ');
            const selectedIndex = parseInt(input) - 1;

            if (selectedIndex >= 0 && selectedIndex < jogadores.length) {
                const selectedPlayer = jogadores[selectedIndex];
                await typeWriter(`\n--Jogador selecionado--`);
                await typeWriter(`  Nome: **${selectedPlayer.nome}**`);
                await typeWriter(`  Classe: **${selectedPlayer.nome_classe}**`);
                await typeWriter(`  Vida: **${selectedPlayer.vida}**`);
                await typeWriter(`  Magia: **${selectedPlayer.magia}**`);
                await typeWriter(`  Defesa: **${selectedPlayer.defesa}**`);
                await typeWriter(`  Ataque: **${selectedPlayer.ataque}**\n`);

                interactions.describeCurrentRoom(selectedPlayer);
                break;
            } else {
                await typeWriter('\nOpção inválida. Por favor, digite um número válido...\n');
            }
        }
    }
}

const askQuestion = async () => {
    const input = await question(' -> ');
    if (input === '1') {
        await typeWriter('Você escolheu começar um novo jogo.');
        await createPlayer();
    } else {
        await typeWriter('Opção inválida...');
        askQuestion();
    }
};

const welcomeToGame = async () => {
    clearTerminal();

    await typeWriter('\nBem vindo ao Sword Art Online!\n');
    await typeWriter('O que você deseja fazer?\n');
    await typeWriter('\t1 - Começar um novo jogo\n');

    askQuestion();
};

module.exports = {
    continueGame
}