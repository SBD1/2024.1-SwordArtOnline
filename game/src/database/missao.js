const { connection } = require('../utils/connection');

// Essa função usa a view que lista as missoes de um jogador que estão em andamento
const getMissionsInProgress = async (idJogador) => {
    let client, missoes;
    const sql = `
        SELECT * FROM missao_andamento WHERE id_jogador = $1;
    `;
    const values = [idJogador];

    try {
        client = await connection();
        const response = await client.query(sql, values);
        missoes = response.rows;
    } catch (err) {
        console.error('\nErro ao inicializar o jogo:', err);
    } finally {
        if (client) client.release();
        return missoes;
    }
}

const getCompletedMission = async (idJogador, idInimigo) => {
    let client, missao;
    const sql = `
        SELECT * FROM missao_concluida 
        WHERE id_jogador = $1
        AND id_inimigo = $2;
    `;
    const values = [idJogador, idInimigo];

    try {
        client = await connection();
        const response = await client.query(sql, values);
        missao = response.rows[0];
    } catch (err) {
        console.error('\nErro ao inicializar o jogo:', err);
    } finally {
        if (client) client.release();
        return missao;
    }
}

const updateStatusMission = async (idJogador, idInstanciaInimigo) => {
    let client;
    // Chama a procedure que atualiza o status da missão
    const sql = `
        SELECT atualizarStatusMissao($1, $2);
    `;
    const values = [idJogador, idInstanciaInimigo];

    try {
        client = await connection();
        await client.query(sql, values);
    } catch (err) {
        console.error('\nErro ao inicializar o jogo:', err);
    } finally {
        if (client) client.release();
    }
}

module.exports = {
    getMissionsInProgress,
    getCompletedMission,
    updateStatusMission
};
