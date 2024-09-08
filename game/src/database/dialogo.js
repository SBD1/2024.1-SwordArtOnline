const { connection } = require("../utils/connection");

const createDialogue = async (decisao, idJogador, idInstanciaNpc) => {
    let client;
    const sql = `
        INSERT INTO dialogo (decisao, id_jogador, id_instancia_npc) 
        VALUES ($1, $2, $3);
    `;
    const values = [decisao, idJogador, idInstanciaNpc];

    try {
        client = await connection();

        await client.query(sql, values);
    } catch (err) {
        console.error('\nErro ao criar diálogo:', err);
    } finally {
        if (client) client.release();
    }
}

module.exports = {
    createDialogue
}