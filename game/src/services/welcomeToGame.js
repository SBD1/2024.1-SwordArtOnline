const { createPlayer } = require('./createPlayer');
const { question } = require('../config/readlineConfig');
const { clearTerminal, typeWriter } = require('../config/terminalUtils');
const { continueGame } = require('./continueGame');

const askQuestion = async () => {
    const input = await question(' -> ');
    if (input === '1') {
        await typeWriter('Você escolheu começar um novo jogo.');
        await createPlayer();
    } else if (input === '2') {
        await typeWriter('Você escolheu continuar com um jogo antigo.');
        await continueGame();
    } else {
        await typeWriter('Opção inválida. Escolha uma opção entre 1 e 2...');
        askQuestion();
    }
};

const welcomeToGame = async () => {
    clearTerminal();

    await typeWriter('\nBem vindo ao Sword Art Online!\n');
    await typeWriter('O que você deseja fazer?\n');
    await typeWriter('\t1 - Começar um novo jogo\n');
    await typeWriter('\t2 - Continuar com um jogo antigo\n');

    askQuestion();
};

module.exports = {
    welcomeToGame
};