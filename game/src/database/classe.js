const { connection } = require('../config/connection');

const getAll = async () => {
    let client, classe;
    const sql = `SELECT * FROM classe;`;

    try {
        client = await connection();

        const response = await client.query(sql);
        classe = response.rows;
    } catch (err) {
        console.error('\nErro ao buscar a classe:', err);
    } finally {
        if (client) client.release();
        return classe;
    }
}

const getById = async (id) => {
    let client, classe;
    const sql = 'SELECT * FROM classe WHERE id_classe = $1;';
    const values = [id];

    try {
        client = await connection();

        const response = await client.query(sql, values);
        classe = response.rows[0];
    } catch (err) {
        console.error('Erro ao buscar a classe:', err);
    } finally {
        if (client) client.release();
        return classe;
    }
}

module.exports = {
    getAll,
    getById
}