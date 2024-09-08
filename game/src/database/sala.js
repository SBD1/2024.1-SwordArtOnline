const { connection } = require('../utils/connection');

// Usa a view "sala_atual"
const getSalaInformations = async (id_sala) => {
    let client, sala;
    const sql = 'SELECT * FROM sala_atual WHERE id_instancia_sala = $1;';
    const values = [id_sala];

    try {
        client = await connection();

        const response = await client.query(sql, values);
        sala = response.rows[0];
    } catch (err) {
        console.error('Erro ao buscar a sala:', err);
    } finally {
        if (client) client.release();
        return sala;
    }
}

const getNpcsInRoom = async (id_sala) => {
    let client, npcs;
    const sql = 'SELECT * FROM instancia_npc INNER JOIN npc USING (id_npc) WHERE sala_atual = $1;';
    const values = [id_sala];

    try {
        client = await connection();

        const response = await client.query(sql, values);
        npcs = response.rows;
    } catch (err) {
        console.error('Erro ao buscar a sala:', err);
    } finally {
        if (client) client.release();
        return npcs;
    }
}

const getMobsInRoom = async (id_sala) => {
    let client, mobs;
    const sql = 'SELECT * FROM instancia_inimigo INNER JOIN inimigo USING (id_inimigo) INNER JOIN mob USING (id_inimigo) WHERE sala_atual = $1;';
    const values = [id_sala];

    try {
        client = await connection();

        const response = await client.query(sql, values);
        mobs = response.rows;
    } catch (err) {
        console.error('Erro ao buscar a sala:', err);
    } finally {
        if (client) client.release();
        return mobs;
    }
}

const getBossInRoom = async (id_sala) => {
    let client, boss;
    const sql = 'SELECT * FROM instancia_inimigo INNER JOIN inimigo USING (id_inimigo) INNER JOIN boss USING (id_inimigo) WHERE sala_atual = $1;';
    const values = [id_sala];

    try {
        client = await connection();

        const response = await client.query(sql, values);
        boss = response.rows;
    } catch (err) {
        console.error('Erro ao buscar a sala:', err);
    } finally {
        if (client) client.release();
        return boss;
    }
}

module.exports = {
    getSalaInformations,
    getNpcsInRoom,
    getMobsInRoom,
    getBossInRoom
}