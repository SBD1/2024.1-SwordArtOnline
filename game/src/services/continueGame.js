const { clearTerminal } = require('../utils/terminalUtils');
const jogadorDatabase = require('../database/jogador');
const { question } = require('../utils/readlineConfig');
const { createPlayer } = require('./createPlayer');
const interactions = require('./interactions');
const { greenBoldText } = require('../utils/colors');

const continueGame = async () => {
    clearTerminal();

    setTimeout(async () => {
        console.log(greenBoldText, '\n***Seleção de Personagem***\n');
        await getOldGames();
    }, 1);
}

const getOldGames = async () => {
    const jogadores = await jogadorDatabase.getAll();

    if (jogadores.length == 0) {
        console.log('\tNão foi encontrado nenhum personagem ;-;\n');
        console.log('\n\nAperte 1 para voltar pra tela anterior...\n');

        while (true) {
            const input = await question(' -> ');

            if (input == 1) {
                console.log('\nVoltando pra tela de boas vindas..')
                welcomeToGame();
                break;
            } else {
                console.log('\nOpção inválida. Por favor, digite um número válido...\n');
            }
        }
    } else {
        for (const [index, jogador] of jogadores.entries()) {
            console.log(`\t${index + 1} - ** ${jogador.nome} -- ${jogador.nome_classe} **\n`);
        }

        while (true) {
            const input = await question(' -> ');
            const selectedIndex = parseInt(input) - 1;

            if (selectedIndex >= 0 && selectedIndex < jogadores.length) {
                const selectedPlayer = jogadores[selectedIndex];
                console.log(`\n--Jogador selecionado--`);
                console.log(`  Nome: **${selectedPlayer.nome}**`);
                console.log(`  Classe: **${selectedPlayer.nome_classe}**`);
                console.log(`  Vida: **${selectedPlayer.vida}**`);
                console.log(`  Magia: **${selectedPlayer.magia}**`);
                console.log(`  Defesa: **${selectedPlayer.defesa}**`);
                console.log(`  Ataque: **${selectedPlayer.ataque}**\n`);
                console.log(`\n`);

                await interactions.describeCurrentRoom(selectedPlayer);
                break;
            } else {
                console.log('\nOpção inválida. Por favor, digite um número válido...\n');
            }
        }
    }
}

const askQuestion = async () => {
    const input = await question(' -> ');
    if (input === '1') {
        console.log('Você escolheu começar um novo jogo.');
        await createPlayer();
    } else {
        console.log('Opção inválida...');
        askQuestion();
    }
};

const welcomeToGame = async () => {
    clearTerminal();

    setTimeout(() => {
        console.log(greenBoldText, 'Bem vindo ao Sword Art Online!\n');
        console.log('O que você deseja fazer?\n');
        console.log('\t1 - Começar um novo jogo\n');

        askQuestion();
    }, 1)
};

module.exports = {
    continueGame
}