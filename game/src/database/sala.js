const { connection } = require('../config/connection');

const getSalaInformations = async (id_sala) => {
    let client, sala;
    const sql = 'SELECT * FROM sala INNER JOIN localizacao using (id_localizacao) WHERE id_sala = ($1);';
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
    const sql = 'select * from npc where sala_atual = $1;';
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
    const sql = 'select * from instancia_inimigo inner join inimigo using (id_inimigo) inner join mob using (id_inimigo) where sala_atual = $1;';
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
    let client, npc;
    const sql = 'select * from instancia_inimigo inner join inimigo using (id_inimigo) inner join boss using (id_inimigo) where sala_atual = $1;';
    const values = [id_sala];

    try {
        client = await connection();

        const response = await client.query(sql, values);
        npc = response.rows;
    } catch (err) {
        console.error('Erro ao buscar a sala:', err);
    } finally {
        if (client) client.release();
        return npc;
    }
}

module.exports = {
    getSalaInformations,
    getNpcsInRoom,
    getMobsInRoom,
    getBossInRoom
}