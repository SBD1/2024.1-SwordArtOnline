const { question, rl } = require('../config/readlineConfig');
const classeDatabase = require('../database/classe');

const selectClasse = async () => {
    const classes = await classeDatabase.getAll();

    if (classes.length !== 0) {
        console.log('Escolha uma classe:\n');

        classes.forEach((classe, index) => {
            console.log(`${index + 1} - ${classe.nome}\n`);
        });

        const input = await question('Classe:\t');
        const selectedIndex = parseInt(input) - 1;

        if (selectedIndex >= 0 && selectedIndex < classes.length) {
            const selectedClasse = classes[selectedIndex];
            console.log(`Você escolheu a classe ${selectedClasse.nome}.`);
            return selectedClasse.nome;
        } else {
            console.log('Opção inválida. Digite um número válido...');
            return await selectClasse();  // Chama a função novamente para tentar uma nova entrada
        }
    } else {
        console.log('Não foi possível listar as classes...');
        rl.close(); // Fecha o readline
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

    const classe = await selectClasse();

    console.log(`\nPersonagem criado! Nome: ${nome}, Classe: ${classe}`);

    // rl.close(); 
};

module.exports = {
    createPlayer
};
