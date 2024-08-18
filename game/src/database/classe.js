const { connection } = require('../config/connection');

const findById = async (id) => {
    let client;
    const sql = `SELECT * FROM classe WHERE id_classe = ${id};`;

    try {
        client = await connection();

        await client.query(sql);
    } catch (err) {
        console.error('Erro ao buscar a classe:', err);
    } finally {
        if (client) client.release();
    }
}

module.exports = {
    findById
}