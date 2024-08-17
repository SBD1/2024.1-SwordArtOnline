// Arquivo responsável pela criação dos Enum's e das tabelas..
require('dotenv').config();
const fs = require('fs');
const path = require('path');
const { connection } = require('../config/connection');

async function executeSQLFile(filePath) {
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

const sqlDdlFilePath = path.join(__dirname, '../scripts/ddl.sql');
executeSQLFile(sqlDdlFilePath);
console.log('Script DDL executado com sucesso...\n');

const sqlDmlFilePath = path.join(__dirname, '../scripts/dml.sql');
executeSQLFile(sqlDmlFilePath);
console.log('Script DML executado com sucesso...\n');

console.log('Jogo pronto pra ser inicializado!');