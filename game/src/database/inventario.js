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
    let client, id_inventario;
    const sql = `SELECT MAX(id_inventario) AS last_id_inserted FROM inventario i;`; // Retorna o id do último inventario inserido...

    try {
        client = await connection();

        const response = await client.query(sql);
        id_inventario = response.rows[0].last_id_inserted;
        console.log(id_inventario)
    } catch (err) {
        console.error('\nErro ao criar inventario:', err);
    } finally {
        if (client) client.release();
        return id_inventario;
    }
}

module.exports = {
    insert,
    getLastInserted
}