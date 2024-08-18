const { connection } = require('../config/connection');

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
        console.error('\nErro ao criar jogador:', err);
    } finally {
        if (client) client.release();
        return jogador;
    }
}

module.exports = {
    insert,
    getByNome
};
