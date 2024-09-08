const { connection } = require('../utils/connection');

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

const getInventory = async (idInventario) => {
    let client, inventario;
    const sql = `
        SELECT * FROM inventario_jogador WHERE id_inventario = $1;
    `;
    const values = [idInventario];
    

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

const getWeapons = async (id_inventario) => {
    let client, itens;
    const sql = `
        SELECT * FROM armas_jogador WHERE id_inventario = $1;
    `;
    const values = [id_inventario];
    
    try {
        client = await connection();

        const response = await client.query(sql, values);
        itens = response.rows;
    } catch (err) {
        console.error('\nErro ao listar as armas do inventário:', err);
    } finally {
        if (client) client.release();
        return itens;
    }
}

const getConsumableItens = async (id_inventario) => {
    let client, itens;
    const sql = `
        SELECT * FROM itens_consumiveis_jogador WHERE id_inventario = $1;
    `;
    const values = [id_inventario];
    
    try {
        client = await connection();

        const response = await client.query(sql, values);
        itens = response.rows;
    } catch (err) {
        console.error('\nErro ao listar os itens consumíveis do inventário:', err);
    } finally {
        if (client) client.release();
        return itens;
    }
}


module.exports = {
    insert,
    getLastInserted,
    getInventory,
    getWeapons
}