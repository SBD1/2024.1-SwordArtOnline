// Função para limpar o terminal
const clearTerminal = () => {
    process.stdout.write('\x1Bc');
};

// Função para efeito de digitação
const typeWriter = (text, delay = 50) => {
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
