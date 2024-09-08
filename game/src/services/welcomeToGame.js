const { createPlayer } = require('./createPlayer');
const { question } = require('../utils/readlineConfig');
const { continueGame } = require('./continueGame');
const { greenBoldText, magentaBoldText, yellowBoldText, blueBoldText } = require('../utils/colors');

const askQuestion = async () => {
    const input = await question(' -> ');
    if (input === '0') {
        console.log(blueBoldText, '\nVocê escolheu começar um novo jogo.\n');
        await createPlayer();
    } else if (input === '1') {
        console.log(blueBoldText, '\nVocê escolheu continuar com um jogo antigo.\n');
        await continueGame();
    } else {
        console.log(yellowBoldText, '\nOpção inválida. Escolha uma opção entre 0 e 1...\n');
        askQuestion();
    }
};

const welcomeToGame = () => {
    console.log(greenBoldText, 'Bem vindo ao Sword Art Online!\n');

    console.log(magentaBoldText, 'O que você deseja fazer?\n');

    console.table([
        {
            Opções: 'Começar um novo jogo'
        },
        {
            Opções: 'Continuar com um jogo antigo'
        }
    ]);

    console.log('\n');

    askQuestion();
};

module.exports = {
    welcomeToGame
};