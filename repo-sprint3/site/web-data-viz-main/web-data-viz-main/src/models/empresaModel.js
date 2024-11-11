var database = require("../database/config");

function buscarPorId(id) {
  var instrucaoSql = `SELECT * FROM empresa WHERE id = '${id}'`;

  return database.executar(instrucaoSql);
}

function listar() {
  var instrucaoSql = `SELECT id, razao_social, cnpj, codigo_ativacao FROM empresa`;

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

module.exports = { buscarPorCnpj, buscarPorId, cadastrar, listar };