const { createPlayer } = require('./createPlayer');
const { question } = require('../utils/readlineConfig');
const { continueGame } = require('./continueGame');
const { greenBoldText } = require('../utils/colors');

const askQuestion = async () => {
    const input = await question(' -> ');
    if (input === '1') {
        console.log('Você escolheu começar um novo jogo.');
        await createPlayer();
    } else if (input === '2') {
        console.log('Você escolheu continuar com um jogo antigo.');
        await continueGame();
    } else {
        console.log('Opção inválida. Escolha uma opção entre 1 e 2...');
        askQuestion();
    }
};

const welcomeToGame = () => {
    console.log(greenBoldText, 'Bem vindo ao Sword Art Online!\n');

    console.log('O que você deseja fazer?\n');
    console.log('\t1 - Começar um novo jogo\n');
    console.log('\t2 - Continuar com um jogo antigo\n');

    askQuestion();
};

module.exports = {
    welcomeToGame
};