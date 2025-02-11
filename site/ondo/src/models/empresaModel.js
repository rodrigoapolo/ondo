var database = require("../database/config");

function buscarPorId(id) {
  var instrucaoSql = `SELECT * FROM empresa WHERE id = '${id}'`;

  return database.executar(instrucaoSql);
}

function listar(idUsuario) {
  var instrucaoSql = `select * from empresa where fkUsuario = ${idUsuario};`;

  return database.executar(instrucaoSql);
}
function listarAll() {
  console.log('buscando Empresas')
  var instrucaoSql = `select razaoSocial, idEmpresa from empresa;
  `;

  return database.executar(instrucaoSql);
}

function buscarPorCnpj(cnpj) {
  var instrucaoSql = `SELECT * FROM empresa WHERE cnpj = '${cnpj}'`;

  return database.executar(instrucaoSql);
}

function cadastrar(cnpj, razaoSocial, nomeFantasia, cep, bairro, logradouro, numero, cidade, estado, fkUsuario) {
  var instrucaoSql = `INSERT INTO empresa (cnpj, razaoSocial, nomeFantasia, cep, bairro, logradouro, numero, cidade, estado, fkUsuario) VALUES ('${cnpj}', '${razaoSocial}', '${nomeFantasia}', '${cep}', '${bairro}', '${logradouro}', '${numero}', '${cidade}', '${estado}', '${fkUsuario}')`;

  return database.executar(instrucaoSql);
}

module.exports = { buscarPorCnpj, buscarPorId, cadastrar, listar, listarAll };