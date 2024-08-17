require('dotenv').config();
const { Pool } = require('pg');

const connection = async () => {
    if (global.connection)
        return global.connection.connect();
 
    const pool = new Pool({
        connectionString: process.env.CONNECTION_STRING
    });
 
    const client = await pool.connect();
    console.log('Conexão com o banco realizada com sucesso!');
 
    client.release();
 
    global.connection = pool;
    return pool.connect();
}

module.exports = {
    connection
}