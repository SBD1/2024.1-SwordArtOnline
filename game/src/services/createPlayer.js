const { question } = require('../config/readlineConfig');
const { clearTerminal, typeWriter } = require('../config/terminalUtils');
const classeDatabase = require('../database/classe');
const inventarioDatabase = require('../database/inventario');
const jogadorDatabase = require('../database/jogador');
const interactions = require('./interactions');

const selectClasse = async () => {
    clearTerminal();
    const classes = await classeDatabase.getAll();

    await typeWriter('**Escolha uma classe** \n');
    for (const [index, classe] of classes.entries()) {
        await typeWriter(` ${index + 1} - **${classe.nome}**\n`);
        await typeWriter(`   Descrição: ${classe.descricao}\n`, 20);
        await typeWriter(`   Aumenta **${classe.buff} pontos** de ${classe.atributo_melhorado}\n\n`);
    }

    while (true) {
        const input = await question('Digite o número da classe desejada: ');
        const selectedIndex = parseInt(input) - 1;

        if (selectedIndex >= 0 && selectedIndex < classes.length) {
            const selectedClasse = classes[selectedIndex];
            await typeWriter(`\nVocê escolheu a classe **${selectedClasse.nome}**`);
            return selectedClasse;
        } else {
            await typeWriter('\nOpção inválida. Por favor, digite um número válido...\n');
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
    clearTerminal(500);

    const xp = 0;
    const nivel = 1;
    let defesa = 50;
    let magia = 50;
    let ataque = 50;
    let vida = 100;
    const sala_atual = 1;

    setTimeout( async () => {
        await typeWriter('\n***Criação de Personagem***\n');
        const nome = await question('Digite o nome do seu personagem: ');

        const classe = await selectClasse();
        const atributosBuffados = applyClassBuff(classe, defesa, magia, ataque, vida);

        await inventarioDatabase.insert(50);
        const id_inventario = await inventarioDatabase.getLastInserted();

        await jogadorDatabase.insert(
            xp,
            nivel,
            atributosBuffados.defesa,
            atributosBuffados.magia,
            atributosBuffados.ataque,
            atributosBuffados.vida,
            nome,
            id_inventario,
            classe.id_classe,
            sala_atual
        );

        await typeWriter(`\n**Personagem Criado!**`);
        await typeWriter(`  Nome: **${nome}**`);
        await typeWriter(`  Classe: **${classe.nome}**`);
        await typeWriter(`  Vida: **${atributosBuffados.vida}**`);
        await typeWriter(`  Magia: **${atributosBuffados.magia}**`);
        await typeWriter(`  Defesa: **${atributosBuffados.defesa}**`);
        await typeWriter(`  Ataque: **${atributosBuffados.ataque}**\n`);

        const jogador = await jogadorDatabase.getByNome(nome);
        await interactions.describeCurrentRoom(jogador);
    }, 500);
};

module.exports = {
    createPlayer
};
