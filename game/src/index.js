const { clearTerminal } = require('./utils/terminalUtils');
const { welcomeToGame } = require('./services/welcomeToGame');

clearTerminal();

// Espera um milisegundo apos limpar o terminal para inicializar o jogo
setTimeout(() => {
    welcomeToGame();
}, 1);
