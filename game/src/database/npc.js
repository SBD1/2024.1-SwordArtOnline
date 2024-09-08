const { connection } = require("../utils/connection");

// Usa a view que detalha a missão de uma instância de npc
const getMission = async (idInstanciaNpc) => {
    let client, mission;
    const sql = `
        SELECT * FROM missao_instancia_npc WHERE id_instancia_npc = $1;
    `;
    const values = [idInstanciaNpc];

    try {
        client = await connection();

        const response = await client.query(sql, values);
        mission = response.rows[0];
    } catch (err) {
        console.error('\nErro ao buscar missão:', err);
    } finally {
        if (client) client.release();
        return mission;
    }
}

// Usa a view que detalha o item dropado por uma instância de npc
const getDropItem = async (idInstanciaNpc) => {
    let client, item;
    const sql = `
        SELECT * FROM item_instancia_npc WHERE id_instancia_npc = $1;
    `;
    const values = [idInstanciaNpc];

    try {
        client = await connection();

        const response = await client.query(sql, values);
        item = response.rows[0];
    } catch (err) {
        console.error('\nErro ao buscar item:', err);
    } finally {
        if (client) client.release();
        return item;
    }
}

module.exports = {
    getMission,
    getDropItem
}