var database = require("../database/config");

function temperaturaAtual(idEstufa) {
  var instrucaoSql = `SELECT m.temperatura AS temperatura_atual
                      FROM medicao AS m JOIN sensor AS s 
                      ON m.fkSensor = s.idSensor
                      JOIN estufa AS e ON s.fkEstufa = e.idEstufa
                      WHERE e.idEstufa = ${idEstufa}
                      ORDER BY m.dataHora DESC
                      LIMIT 1;`;
                        

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function quantidadeAlerta(idEstufa) {
  var instrucaoSql = `SELECT COUNT(a.idAlerta) AS quantidade_alertas
                      FROM alerta a
                      JOIN sensor s ON a.fkSensor = s.idSensor
                      JOIN estufa e ON s.fkEstufa = e.idEstufa
                      WHERE e.idEstufa = ${idEstufa} AND a.dataHora >= NOW() - INTERVAL 7 DAY;`;
                        

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function temperaturaMaxima(idEstufa) {
  var instrucaoSql = `SELECT MAX(m.temperatura) AS temperatura_maxima
                      FROM medicao AS m JOIN sensor AS s 
                      ON m.fkSensor = s.idSensor
                      JOIN estufa AS e ON s.fkEstufa = e.idEstufa
                      WHERE e.idEstufa = ${idEstufa} AND dataHora >= NOW() - INTERVAL 1 DAY;`;
                        

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function temperaturaMinima(idEstufa) {
  var instrucaoSql = `SELECT MIN(m.temperatura) AS temperatura_minima
                      FROM medicao AS m
                      JOIN sensor AS s ON m.fkSensor = s.idSensor
                      JOIN estufa AS e ON s.fkEstufa = e.idEstufa
                      WHERE e.idEstufa = ${idEstufa} AND dataHora >= NOW() - INTERVAL 1 DAY;`;
                        

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function listaTemperaturaDia(idEstufa) {
  var instrucaoSql = `SELECT m.temperatura, TIME(m.dataHora) AS hora
                      FROM medicao m JOIN sensor s
                      ON m.fkSensor = s.idSensor
                      JOIN estufa e
                      ON s.fkEstufa = e.idEstufa
                      WHERE e.idEstufa = ${idEstufa} AND dataHora >= NOW() - INTERVAL 1 DAY
                      ORDER BY m.dataHora DESC
                      LIMIT 10;`;
                        

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function alertaAbaixo(idEstufa){
  var instrucaoSql = `SELECT COUNT(a.idAlerta) AS quantidade_alertas
                      FROM alerta a
                      JOIN sensor s ON a.fkSensor = s.idSensor
                      JOIN estufa e ON s.fkEstufa = e.idEstufa
                      WHERE temperatura < 8.0 AND e.idEstufa = ${idEstufa} AND a.dataHora >= NOW() - INTERVAL 7 DAY;`;


  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);;
}

function alertaAcima(idEstufa){
  var instrucaoSql = `SELECT COUNT(a.idAlerta) AS quantidade_alertas
                      FROM alerta a
                      JOIN sensor s ON a.fkSensor = s.idSensor
                      JOIN estufa e ON s.fkEstufa = e.idEstufa
                      WHERE temperatura > 17 AND e.idEstufa = ${idEstufa} AND a.dataHora >= NOW() - INTERVAL 7 DAY;`;


  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);;
}

function totalAlerta(idEstufa){
  var instrucaoSql = `select count(idMedicao) as total
                      FROM medicao m JOIN sensor s
                      ON m.fkSensor = s.idSensor
                      JOIN estufa e
                      ON s.fkEstufa = e.idEstufa
                      WHERE e.idEstufa = ${idEstufa} AND m.dataHora >= NOW() - INTERVAL 7 DAY;`;
    

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function listaMensagemAlerta(idEstufa){
  var instrucaoSql = `SELECT s.localidade, date(a.dataHora) as 'data', time(dataHora) as hora, a.mensagem 
                      FROM alerta a JOIN sensor s
                      ON a.fksensor = s.idSensor
                      JOIN estufa e
                      ON s.fkEstufa = e.idEstufa
                      WHERE e.idEstufa = ${idEstufa} AND a.dataHora >= NOW() - INTERVAL 7 DAY
                      ORDER BY a.dataHora DESC;`;
    

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  temperaturaAtual,
  quantidadeAlerta,
  temperaturaMaxima,
  temperaturaMinima,
  listaTemperaturaDia,
  alertaAbaixo,
  totalAlerta,
  alertaAcima,
  listaMensagemAlerta
}
