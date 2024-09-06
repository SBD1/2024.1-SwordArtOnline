// Função para limpar o terminal
const clearTerminal = (timeout = 0) => {            // O timeout é em milisegundos..
    setTimeout(() => {
        process.stdout.write('\x1Bc');
    }, timeout);
};

module.exports = {
    clearTerminal
};
