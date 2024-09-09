const { connection } = require("../utils/connection")

const createBatalha = async (venceu, idInstanciaInimigo, idJogador) => {
    let client;
    const sql = `
        INSERT INTO batalha (venceu, id_instancia, id_jogador)
        VALUES ($1, $2, $3);
    `; 
    const values = [venceu, idInstanciaInimigo, idJogador];

    try {
        client = await connection();
        await client.query(sql,values);
    } catch (err) {
        console.error('\nErro ao criar registro da batalha:', err);
    } finally {
        if (client) client.release();
    }
}

module.exports = {
    createBatalha
}