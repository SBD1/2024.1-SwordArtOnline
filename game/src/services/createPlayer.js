const { question } = require('../utils/readlineConfig');
const { clearTerminal } = require('../utils/terminalUtils');
const classeDatabase = require('../database/classe');
const inventarioDatabase = require('../database/inventario');
const jogadorDatabase = require('../database/jogador');
const interactions = require('./interactions');
const { greenBoldText, cyanBoldText, redBoldText, blueBoldText } = require('../utils/colors');

const selectClasse = async () => {
    const classes = await classeDatabase.getAll();
    const classesLog = [];

    console.log(greenBoldText, '\n**Escolha uma classe** ');
    for (const classe of classes) {
        classesLog.push(
            {
                Nome: classe.nome,
                Descrição: classe.descricao,
                Buff: `Aumenta ${classe.buff} pontos de ${classe.atributo_melhorado}`
            }
        );
    }

    console.table(classesLog);

    while (true) {
        console.log(cyanBoldText, '\nInforme uma classe: \n');
        const input = await question(' -> ');
        const selectedIndex = parseInt(input);

        if (selectedIndex >= 0 && selectedIndex < classes.length) {
            const selectedClasse = classes[selectedIndex];

            return selectedClasse;
        } else {
            console.log(redBoldText, '\nOpção inválida. Por favor, digite um número válido...\n');
        }
    }
};


const applyClassBuff = (classe, defesa, magia, ataque, vida) => {
    switch (classe.atributo_melhorado) {
        case 'Vida':
            vida += classe.buff;
            break;
        case 'Magia':
            magia += classe.buff;
            break;
        case 'Defesa':
            defesa += classe.buff;
            break;
        case 'Ataque':
            ataque += classe.buff;
            break;
    }

    return { defesa, magia, ataque, vida };
};

const createPlayer = async () => {
    clearTerminal();

    const xp = 0;
    const nivel = 1;
    let defesa = 50;
    let magia = 50;
    let ataque = 50;
    let vida = 100;

    setTimeout(async () => {
        console.log('\n');
        console.log(greenBoldText, '**Criação de Personagem**\n');
        console.log(cyanBoldText, 'Digite o nome do seu personagem: \n');
        const nome = await question(' -> ');

        const classe = await selectClasse();
        const atributosBuffados = applyClassBuff(classe, defesa, magia, ataque, vida);

        await inventarioDatabase.insert(20);
        const id_inventario = await inventarioDatabase.getLastInserted();

        await jogadorDatabase.createNewGame(
            xp,
            nivel,
            atributosBuffados.defesa,
            atributosBuffados.magia,
            atributosBuffados.ataque,
            atributosBuffados.vida,
            nome,
            id_inventario,
            classe.id_classe
        );

        clearTerminal();

        setTimeout(() => {
            console.log('\n');
            console.log(greenBoldText, `**Personagem Criado!**\n`);
            console.table([
                {
                    Nome: nome,
                    Classe: classe.nome,
                    Vida: atributosBuffados.vida,
                    Magia: atributosBuffados.magia,
                    Defesa: atributosBuffados.defesa,
                    Ataque: atributosBuffados.ataque,
                }
            ]);
        }, 1);

        setTimeout(async () => {
            const jogador = await jogadorDatabase.getByNome(nome);
            await interactions.describeCurrentRoom(jogador);
        }, 2000);
        
    }, 1);
};

module.exports = {
    createPlayer
};
