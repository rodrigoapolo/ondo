var database = require("../database/config");

function estufasMonitoradas(idEstufa) {
  var instrucaoSql = `SELECT COUNT(idEstufa) qtdEstufas
                      FROM estufa
                      WHERE fkEmpresa = ${idEstufa};`;
                        
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function temperaturasAdequadas(idEmpresa) {
  var instrucaoSql = `SELECT COUNT(e.idEstufa) as qtdEstufas
                      FROM estufa e JOIN sensor s
                      ON e.idEstufa = s.fkEstufa
                      JOIN medicao m
                      ON s.idSensor = m.fkSensor
                      WHERE e.fkEmpresa = ${idEmpresa} AND m.temperatura > 8 AND m.temperatura < 21 AND m.dataHora >= NOW();`;
                        
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function temperaturasInadequadas(idEmpresa) {
  var instrucaoSql = `SELECT COUNT(e.idEstufa) as qtdEstufas
                      FROM estufa e JOIN sensor s
                      ON e.idEstufa = s.fkEstufa
                      JOIN medicao m
                      ON s.idSensor = m.fkSensor
                      WHERE e.fkEmpresa = ${idEmpresa} AND (m.temperatura > 21 OR m.temperatura < 8) AND m.dataHora >= NOW();`;
                        
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function listaEsfufasEmpresa(idEmpresa) {
  var instrucaoSql = `SELECT idEstufa 
                      FROM estufa
                      WHERE fkEmpresa = ${idEmpresa};`;
                        
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarEstufa(idEstufa) {
  var instrucaoSql = `SELECT e.idEstufa, e.nome, m.temperatura
                      FROM estufa e JOIN sensor s
                      ON e.idEstufa = s.fkEstufa
                      JOIN medicao m
                      ON s.idSensor = m.fkSensor
                      WHERE e.idEstufa = ${idEstufa}
                      ORDER BY m.dataHora DESC
                      LIMIT 1;`;
                        
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

module.exports = {
  estufasMonitoradas,
  temperaturasAdequadas,
  temperaturasInadequadas,
  listaEsfufasEmpresa,
  buscarEstufa
}
