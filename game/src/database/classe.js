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

module.exports = {
    getAll
}