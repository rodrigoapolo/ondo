var graficosModel = require("../models/graficosModel");

function temperaturaAtual(req, res) {

    var idEstufa = req.params.estufaID;

    if (idEstufa == undefined) {
        res.status(400).send("Seu id da Estufa está undefined!");
    } 


    graficosModel.temperaturaAtual(idEstufa)
    .then(function (resultado) {
        if (resultado[0].temperatura_atual != null) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar a temperatua atual.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function quantidadeAlerta(req, res) {

    var idEstufa = req.params.estufaID;

    if (idEstufa == undefined) {
        res.status(400).send("Seu id da Estufa está undefined!");
    } 


    graficosModel.quantidadeAlerta(idEstufa)
    .then(function (resultado) {
        if (resultado[0].quantidade_alertas != 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar a quantidade de alerta.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function temperaturaMaxima(req, res) {

    var idEstufa = req.params.estufaID;

    if (idEstufa == undefined) {
        res.status(400).send("Seu id da Estufa está undefined!");
    } 


    graficosModel.temperaturaMaxima(idEstufa)
    .then(function (resultado) {
        if (resultado[0].temperatura_maxima != null) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar a temperatua maxima.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function temperaturaMinima(req, res) {

    var idEstufa = req.params.estufaID;

    if (idEstufa == undefined) {
        res.status(400).send("Seu id da Estufa está undefined!");
    } 


    graficosModel.temperaturaMinima(idEstufa)
    .then(function (resultado) {
        if (resultado[0].temperatura_minima != null) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar a temperatua minima.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function listaTemperaturaDia(req, res) {

    var idEstufa = req.params.estufaID;

    if (idEstufa == undefined) {
        res.status(400).send("Seu id da Estufa está undefined!");
    } 


    graficosModel.listaTemperaturaDia(idEstufa)
    .then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar a lista da temperatura do dia.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function alertaAbaixo(req, res) {

    var idEstufa = req.params.estufaID;

    if (idEstufa == undefined) {
        res.status(400).send("Seu id da Estufa está undefined!");
    } 


    graficosModel.alertaAbaixo(idEstufa)
    .then(function (resultado) {
        
        if (resultado.length > 0) {
            
            res.status(200).json(resultado);
                
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar a quantidade de alerta abaixo.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}


function alertaAcima(req, res) {

    var idEstufa = req.params.estufaID;

    if (idEstufa == undefined) {
        res.status(400).send("Seu id da Estufa está undefined!");
    } 


    graficosModel.alertaAcima(idEstufa)
    .then(function (resultado) {
        
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar a quantidade de alerta acima.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}


function listaMensagemAlerta(req, res) {

    var idEstufa = req.params.estufaID;

    if (idEstufa == undefined) {
        res.status(400).send("Seu id da Estufa está undefined!");
    } 


    graficosModel.listaMensagemAlerta(idEstufa)
    .then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar a lista de mensagem de alerta.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
    temperaturaAtual,
    quantidadeAlerta,
    temperaturaMaxima,
    temperaturaMinima,
    listaTemperaturaDia,
    alertaAbaixo,
    alertaAcima,
    listaMensagemAlerta
}