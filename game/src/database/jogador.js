const { connection } = require('../utils/connection');

// Esse metodo chama a procedure responsável pela criação de todas as localizações, salas, instancias de npc e inimigo e o jogador
const createNewGame = async (xp, nivel, defesa, magia, ataque, vida, nome, inventario, classe) => {
    let client;
    const sql = `
        SELECT inicializarJogo($1, $2, $3, $4, $5, $6, $7, $8, $9);
    `;
    const values = [xp, nivel, defesa, magia, ataque, vida, nome, inventario, classe];

    try {
        client = await connection();
        await client.query(sql, values);
    } catch (err) {
        console.error('\nErro ao inicializar o jogo:', err);
    } finally {
        if (client) client.release();
    }
}

const insert = async (xp, nivel, defesa, magia, ataque, vida, nome, inventario, classe, sala_atual) => {
    let client;
    const sql = `
        INSERT INTO jogador (xp, nivel, defesa, magia, ataque, vida, nome, inventario, classe, sala_atual) 
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10);
    `;
    const values = [xp, nivel, defesa, magia, ataque, vida, nome, inventario, classe, sala_atual];

    try {
        client = await connection();
        await client.query(sql, values);
    } catch (err) {
        console.error('\nErro ao criar jogador:', err);
    } finally {
        if (client) client.release();
    }
}

const getByNome = async (nome) => {
    let client, jogador;
    const sql = `SELECT * FROM jogador WHERE nome = $1`;
    const values = [nome];

    try {
        client = await connection();
        const response = await client.query(sql, values);
        jogador = response.rows[0];
    } catch (err) {
        console.error('\nErro ao buscar jogador:', err);
    } finally {
        if (client) client.release();
        return jogador;
    }
}

const getAll = async () => {
    let client, jogadores;
    const sql = 'SELECT * FROM informacao_jogadores';

    try {
        client = await connection();
        const response = await client.query(sql);
        jogadores = response.rows;
    } catch (err) {
        console.error('\nErro ao buscar jogadores:', err);
    } finally {
        if (client) client.release();
        return jogadores;
    }
}

const getOne = async (idJogador) => {
    let client, jogador;
    const sql = 'SELECT * FROM informacao_jogadores WHERE id_jogador = $1';
    const values = [idJogador];

    try {
        client = await connection();
        const response = await client.query(sql, values);
        jogador = response.rows[0];
    } catch (err) {
        console.error('\nErro ao buscar jogador:', err);
    } finally {
        if (client) client.release();
        return jogador;
    }
}

const updateCurrentWeapon = async (idItem, idJogador) => {
    let client;
    const sql = 'UPDATE jogador SET item_atual = $1 WHERE id_jogador = $2;';
    const values = [idItem, idJogador]

    try {
        client = await connection();
        await client.query(sql, values);
    } catch (err) {
        console.error('\nErro ao atualizar arma atual do jogador:', err);
    } finally {
        if (client) client.release();
    }
}

const getCurrentItem = async (idJogador) => {
    let client, currentItem;
    const sql = 'SELECT * FROM item_atual WHERE id_jogador = $1;';
    const values = [idJogador]

    try {
        client = await connection();
        const response = await client.query(sql, values);
        currentItem = response.rows[0];
    } catch (err) {
        console.error('\nErro ao atualizar arma atual do jogador:', err);
    } finally {
        if (client) client.release();
        return currentItem;
    }
}

const goToAnotherRoom = async (idAnotherRoom, idJogador) => {
    let client;
    const sql = 'UPDATE jogador SET sala_atual = $1 WHERE id_jogador = $2';
    const values = [idAnotherRoom, idJogador]

    try {
        client = await connection();
        await client.query(sql, values);
    } catch (err) {
        console.error('\nErro ao atualizar arma atual do jogador:', err);
    } finally {
        if (client) client.release();
    }
}

const tookDamage = async (vida, idJogador) => {
    let client;
    const sql = 'UPDATE jogador SET vida = $1 WHERE id_jogador = $2';
    const values = [vida, idJogador]

    try {
        client = await connection();
        await client.query(sql, values);
    } catch (err) {
        console.error('\nErro ao atualizar vida do jogador:', err);
    } finally {
        if (client) client.release();
    }
}

const ressurgePlayer = async (jogador) => {
    let client;
    let life = 50;

    if (jogador.nome_classe == 'Assassino') {
        life = life + 30;
    }

    const sql = 'UPDATE jogador SET vida = $1, xp = 0 WHERE id_jogador = $2';
    const values = [life, jogador.id_jogador]

    try {
        client = await connection();
        await client.query(sql, values);
    } catch (err) {
        console.error('\nErro ao atualizar vida do jogador:', err);
    } finally {
        if (client) client.release();
    }
}

const goUp = async (jogador) => {
    let client, novoAndar;
    const sql = 'SELECT subirAndar($1, $2) AS novo_andar;';
    const values = [jogador.id_jogador, jogador.sala_atual]

    try {
        client = await connection();
        const response = await client.query(sql, values);
        novoAndar = response.rows[0].novo_andar;
    } catch (err) {
        console.error('\nErro ao subir de andar:', err);
    } finally {
        if (client) client.release();
        return novoAndar;
    }
}

module.exports = {
    createNewGame,
    insert,
    getByNome,
    getAll,
    updateCurrentWeapon,
    getCurrentItem,
    getOne,
    goToAnotherRoom,
    tookDamage,
    ressurgePlayer,
    goUp
};
