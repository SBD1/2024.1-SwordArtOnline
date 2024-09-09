const { clearTerminal } = require('../utils/terminalUtils');
const jogadorDatabase = require('../database/jogador');
const { question } = require('../utils/readlineConfig');
const { createPlayer } = require('./createPlayer');
const interactions = require('./interactions');
const { greenBoldText, magentaBoldText, redBoldText, yellowBoldText, blueBoldText } = require('../utils/colors');

const continueGame = async () => {
    clearTerminal();

    setTimeout(async () => {
        console.log('\n');
        console.log(greenBoldText, '**Seleção de Personagem**\n');
        await getOldGames();
    }, 1);
}

const getOldGames = async () => {
    const jogadores = await jogadorDatabase.getAll();

    if (jogadores.length == 0) {
        console.log(redBoldText, '\tNão foi encontrado nenhum personagem ;-;');
        console.log(yellowBoldText, '\nAperte 1 para voltar pra tela anterior...\n');

        while (true) {
            const input = await question(' -> ');

            if (input == 1) {
                console.log(blueBoldText, '\nVoltando pra tela de boas vindas..')
                welcomeToGame();
                break;
            } else {
                console.log(redBoldText, '\nOpção inválida. Por favor, digite um número válido...\n');
            }
        }
    } else {
        const options = [];

        for (const jogador of jogadores) {
            options.push({
                Nome: jogador.nome,
                Classe: jogador.nome_classe
            });
        }

        console.table(options);
        console.log('\n');

        while (true) {
            const input = await question(' -> ');
            const selectedIndex = parseInt(input);

            if (selectedIndex >= 0 && selectedIndex < jogadores.length) {
                const selectedPlayer = jogadores[selectedIndex];

                clearTerminal();

                setTimeout(() => {
                    console.log('\n');
                    console.log(greenBoldText, `**Jogador selecionado**\n`);
                    console.table([
                        {
                            Nome: selectedPlayer.nome,
                            Classe: selectedPlayer.nome_classe,
                            Vida: selectedPlayer.vida,
                            Magia: selectedPlayer.magia,
                            Defesa: selectedPlayer.defesa,
                            Ataque: selectedPlayer.ataque,
                        }
                    ]);
                }, 1)

                
                setTimeout(async () => {
                    await interactions.describeCurrentRoom(selectedPlayer);
                }, 2000);

                break;
            } else {
                console.log(redBoldText, '\nOpção inválida. Por favor, digite um número válido...\n');
            }
        }
    }
}

const askQuestion = async () => {
    const input = await question(' -> ');
    if (input === '0') {
        console.log(blueBoldText, '\nVocê escolheu começar um novo jogo.\n');
        await createPlayer();
    } else {
        console.log(redBoldText, '\nOpção inválida...\n');
        askQuestion();
    }
};

const welcomeToGame = async () => {
    clearTerminal();

    setTimeout(() => {
        console.log(greenBoldText, 'Bem vindo ao Sword Art Online!\n');
        console.log(magentaBoldText, 'O que você deseja fazer?\n');
        console.table([
            {
                Opções: 'Começar um novo jogo'
            }
        ]);

        console.log('\n');

        askQuestion();
    }, 1)
};

module.exports = {
    continueGame
}