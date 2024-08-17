const { createPlayer } = require('./createPlayer');
const { question } = require('../config/readlineConfig');

const askQuestion = async () => {
    const input = await question(' -> ');
    if (input === '1') {
        console.log('Você escolheu começar um novo jogo.');
        await createPlayer();
    } else if (input === '2') {
        console.log('Você escolheu continuar com um jogo antigo.');
    } else {
        console.log('Opção inválida. Digite 1 ou 2...');
        askQuestion();
    }
};

const welcomeToGame = () => {
    console.log('\nBem vindo ao Sword Art Online!\n');
    console.log('Escolha um opção:\n');
    console.log('\t1 - Novo Jogo\n');
    console.log('\t2 - Continuar\n');

    askQuestion();
};

module.exports = {
    welcomeToGame
};
