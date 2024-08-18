const { connection } = require('../config/connection');

const insert = async (qnt_max) => {
    let client;
    const sql = `INSERT INTO inventario (qnt_max) VALUES ($1);`;
    const values = [qnt_max];

    try {
        client = await connection();

        await client.query(sql, values);
    } catch (err) {
        console.error('Erro ao criar inventario:', err);
    } finally {
        if (client) client.release();
    }
}

// Trás o último inventário que foi inserido no banco..
const getLastInserted = async () => {
    let client, inventario;
    const sql = `SELECT * FROM inventario ORDER BY id_inventario DESC LIMIT 1;`;

    try {
        client = await connection();

        const response = await client.query(sql);
        inventario = response.rows[0];
    } catch (err) {
        console.error('\nErro ao criar inventario:', err);
    } finally {
        if (client) client.release();
        return inventario;
    }
}

module.exports = {
    insert,
    getLastInserted
}