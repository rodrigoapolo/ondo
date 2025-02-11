var database = require("../database/config");

function buscarAquariosPorEmpresa(idEmpresa) {
  var instrucaoSql = `SELECT * FROM estufa WHERE fkEmpresa = ${idEmpresa}`;
  

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(empresaId, descricao) {
  
  var instrucaoSql = `INSERT INTO (descricao, fkEmpresa) estufa VALUES (${descricao}, ${empresaId})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarAquariosPorEmpresa,
  cadastrar
}
