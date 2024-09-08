const { connection } = require("../utils/connection");

// Pega os tipos possiveis do enum tipo_decisao
const getTypeDecision = async () => {
    let client, decisoes;
    const sql = `
        SELECT enumlabel AS decisao
        FROM pg_type t
        JOIN pg_enum e ON t.oid = e.enumtypid
        WHERE t.typname = 'tipo_decisao';
    `;

    try {
        client = await connection();

        const response = await client.query(sql);
        decisoes = response.rows;
    } catch (err) {
        console.error('\nErro ao buscar as decisões:', err);
    } finally {
        if (client) client.release();
        return decisoes;
    }
}

module.exports = {
    getTypeDecision
}