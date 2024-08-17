const { question, rl } = require('../config/readlineConfig');

const selectClasse = async () => {
    const input = await question('Classe:\t');
    if (input === '1') {
        console.log('Você escolheu a classe Assassino.');
        return 'Assassino';
    } else if (input === '2') {
        console.log('Você escolheu a classe Mago.');
        return 'Mago';
    } else if (input === '3') {
        console.log('Você escolheu a classe Tanque.');
        return 'Tanque';
    } else if (input === '4') {
        console.log('Você escolheu a classe Espadachin.');
        return 'Espadachin';
    } else {
        console.log('Opção inválida. Digite um número entre 1 e 4...');
        return await selectClasse();  // Chama a função novamente para tentar uma nova entrada
    }
};

const createPlayer = async () => {
    const xp = 0;
    const nivel = 1;
    const defesa = 50;
    const magia = 50;
    const ataque = 50;
    const vida = 100;

    console.log('\n\t--- Criação de Personagem ---\n');
    const nome = await question('Nome:\t');

    console.log('Escolha uma classe:\n');
    console.log('1 - Assassino\n');
    console.log('2 - Mago\n');
    console.log('3 - Tanque\n');
    console.log('4 - Espadachin\n');
    
    const classe = await selectClasse();

    console.log(`\nPersonagem criado! Nome: ${nome}, Classe: ${classe}`);

    rl.close(); // Fecha o readline apenas após todo o processo estar completo
};

module.exports = {
    createPlayer
};
