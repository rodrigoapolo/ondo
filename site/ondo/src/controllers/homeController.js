var homeModel = require("../models/homeModel");

function estufasMonitoradas(req, res) {

    var idEmpresa = req.params.empresaID;

    if (idEmpresa == undefined) {
        res.status(400).send("Seu id da Estufa está undefined!");
    } 


    homeModel.estufasMonitoradas(idEmpresa)
    .then(function (resultado) {
        if (resultado[0].qtdEstufas != 0) {
            res.status(200).json(resultado[0]);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as estufas monitoradas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function estufasPorEmpresa(req, res) {

    var idEmpresa = req.params.idEmpresa;

    if (idEmpresa == undefined) {
        res.status(400).send("Seu id da empresa está undefined!");
    } 


    homeModel.estufasPorEmpresa(idEmpresa)
    .then(function (resultado) {
        if (resultado[0].qtdEstufas != 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as estufas monitoradas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function temperaturasAdequadas(req, res) {

    var idEmpresa = req.params.empresaID;

    if (idEmpresa == undefined) {
        res.status(400).send("Seu id da Estufa está undefined!");
    } 


    homeModel.temperaturasAdequadas(idEmpresa)
    .then(function (resultado) {
        if (resultado[0].qtdEstufas != 0) {
            res.status(200).json(resultado[0]);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar a temperaturas Adequadas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function temperaturasInadequadas(req, res) {

    var idEmpresa = req.params.empresaID;

    if (idEmpresa == undefined) {
        res.status(400).send("Seu id da Estufa está undefined!");
    } 


    homeModel.temperaturasInadequadas(idEmpresa)
    .then(function (resultado) {
        if (resultado[0].qtdEstufas != 0) {
            res.status(200).json(resultado[0]);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar a temperaturas Inadequadas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function quantidadeAlertaEstufa(req, res) {

    var idEmpresa = req.params.empresaID;

    if (idEmpresa == undefined) {
        res.status(400).send("Seu id da Estufa está undefined!");
    } 


    homeModel.quantidadeAlertaEstufa(idEmpresa)
    .then(function (resultado) {
        if (resultado[0].quantidade_alertas != 0) {
            res.status(200).json(resultado[0]);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar a quantidade de alerta.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function listaEsfufas(req, res) {
    
    var idEmpresa = req.params.empresaID;
    
    if (idEmpresa == undefined) {
        res.status(400).send("Seu id da Estufa está undefined!");
    } 
    
    
    homeModel.listaEsfufasEmpresa(idEmpresa)
    .then(function (resultado) {
        if (resultado.length > 0) {
            var promessas = resultado.map(estufaEmpresa => {
                return homeModel.buscarEstufa(estufaEmpresa.idEstufa);
            });
            
            Promise.all(promessas)
            .then(listaEsfufasMonitoradas => {
                var estufasmonitoradas = []
                listaEsfufasMonitoradas.forEach(esf =>{
                    estufasmonitoradas.push(esf[0])
                })
                res.status(200).json(estufasmonitoradas);
            })
            .catch(function (erro) {
                console.error("Houve um erro ao buscar as estufas.", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            });
        } else {
            res.status(204).send("Nenhum resultado encontrado!");
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar a estufas da empresa.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function inserirEstufa(req, res) {

    var idEmpresa = req.params.empresaID;
    var nomeEstufa = req.body.nomeServer;
    var tamanho = req.body.tamanhoServer;
    var espaco = req.body.espacoServer;

    if (idEmpresa == undefined) {
        res.status(400).send("Seu id da Estufa está undefined!");
    } 


    homeModel.inserirEstufa(idEmpresa,nomeEstufa,tamanho,espaco)
    .then(
        function (resultado) {
            res.json(resultado);
        }
    ).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar a quantidade de alerta.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}
function inserirSensor(req, res) {
    var idEstufa = req.body.idEstufaServer;
    var local = req.body.localServer;
    var tipoSensor = req.body.tipoSensorServer;

    if (idEstufa == undefined) {
        res.status(400).send("Seu id da Estufa está undefined!");
    } 

    homeModel.inserirSensor(idEstufa,local,tipoSensor)
    .then(
        function (resultado) {
            res.json(resultado);
        }
    ).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar a quantidade de alerta.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}
module.exports = {
    estufasMonitoradas,
    temperaturasAdequadas,
    temperaturasInadequadas,
    listaEsfufas,
    quantidadeAlertaEstufa,
    inserirEstufa,
    estufasPorEmpresa,
    inserirSensor
}