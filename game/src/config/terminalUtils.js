// Função para limpar o terminal
const clearTerminal = (timeout = 0) => {            // O timeout é em milisegundos..
    setTimeout(() => {
        process.stdout.write('\x1Bc');
    }, timeout);
};

// Função para efeito de digitação
const typeWriter = (text, delay = 40) => {
    return new Promise(resolve => {
        let index = 0;
        const interval = setInterval(() => {
            process.stdout.write(text[index]);
            index++;
            if (index === text.length) {
                clearInterval(interval);
                console.log();
                resolve();
            }
        }, delay);
    });
};

module.exports = {
    clearTerminal,
    typeWriter
};
