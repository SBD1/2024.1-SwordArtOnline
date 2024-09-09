const { connection } = require("../utils/connection")

const updateLifeEnemy = async (vida, idInstanciaInimigo) => {
    let client;
    const sql = `UPDATE instancia_inimigo SET vida = $1 WHERE id_instancia = $2;`; 
    const values = [vida, idInstanciaInimigo];

    try {
        client = await connection();

        await client.query(sql,values);
    } catch (err) {
        console.error('\nErro ao atualizar vida do inimigo:', err);
    } finally {
        if (client) client.release();
    }
}

module.exports = {
    updateLifeEnemy
}