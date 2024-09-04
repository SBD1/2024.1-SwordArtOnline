const fs = require('fs');
const { connection } = require('./connection');

const executeSQLFile = async (filePath) => {
  let client;

  try {
    client = await connection();
    const sql = fs.readFileSync(filePath, 'utf8');
    await client.query(sql);    
  } catch (err) {
    console.error('Erro ao executar o arquivo SQL:', err);
  } finally {
    if (client) client.release();
  }
}

module.exports = {
  executeSQLFile
}
