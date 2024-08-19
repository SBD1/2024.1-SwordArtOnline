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
    } catch (err) {
        console.error('\nErro ao criar inventario:', err);
    } finally {
        if (client) client.release();
        return id_inventario;
    }
}

const openInventory = async (id_inventario) => {
    let client, inventario;
    const sql = 'SELECT id_inventario, qnt_max, COUNT(id_item) AS qnt_itens FROM inventario\n'
                + 'INNER JOIN inventario_item USING (id_inventario)\n'
                + 'WHERE id_inventario = $1\n'
                + 'GROUP BY id_inventario;';
    const values = [id_inventario];
    

    try {
        client = await connection();

        const response = await client.query(sql, values);
        inventario = response.rows[0];
    } catch (err) {
        console.error('\nErro ao abrir o inventario:', err);
    } finally {
        if (client) client.release();
        return inventario;
    }
}

module.exports = {
    insert,
    getLastInserted,
    openInventory
}