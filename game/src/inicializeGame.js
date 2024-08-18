require('dotenv').config();
const fs = require('fs');
const path = require('path');
const { connection } = require('./config/connection');
const { rl } = require('./config/readlineConfig');

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

(async () => {
  const sqlDdlFilePath = path.join(__dirname, './scripts/ddl.sql');
  await executeSQLFile(sqlDdlFilePath);
  console.log('Script DDL executado com sucesso...\n');

  const sqlDmlFilePath = path.join(__dirname, './scripts/dml.sql');
  await executeSQLFile(sqlDmlFilePath);
  console.log('Script DML executado com sucesso...\n');

  console.log('Jogo pronto pra ser inicializado!');
  rl.close();
})();
