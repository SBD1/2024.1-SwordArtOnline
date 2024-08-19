const { connection } = require('../config/connection');

const getItensInInventory = async (id_inventario) => {
    let client, itens;
    const sql = 'SELECT * FROM inventario_item ii\n' 
                + 'INNER JOIN item i USING (id_item)\n'
                + 'WHERE id_inventario = $1;';
    const values = [id_inventario];
    
    try {
        client = await connection();

        const response = await client.query(sql, values);
        itens = response.rows[0];
    } catch (err) {
        console.error('\nErro ao listar os itens do inventário:', err);
    } finally {
        if (client) client.release();
        return itens;
    }
}

module.exports = {
    getItensInInventory
}