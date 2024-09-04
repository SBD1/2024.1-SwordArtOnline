const path = require('path');
const { executeSQLFile } = require('./config/executeFile');
const { rl } = require('./config/readlineConfig');

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