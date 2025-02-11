const express = require("express");
const router = express.Router();
const graficosController = require("../controllers/graficosController");

router.get("/quantidade-alerta/:estufaID",function (req, res) {
    graficosController.quantidadeAlerta(req, res);
});

router.get("/temperatura-maxima/:estufaID",function (req, res) {
    graficosController.temperaturaMaxima(req, res);
});

router.get("/temperatura-minima/:estufaID",function (req, res) {
    graficosController.temperaturaMinima(req, res);
});


router.get("/lista-temperatura-dia/:estufaID",function (req, res) {
    graficosController.listaTemperaturaDia(req, res);
});

router.get("/alerta-abaixo/:estufaID",function (req, res) {
    graficosController.alertaAbaixo(req, res);
});

router.get("/alerta-acima/:estufaID",function (req, res) {
    graficosController.alertaAcima(req, res);
});

router.get("/lista-mensagem-alerta/:estufaID",function (req, res) {
    graficosController.listaMensagemAlerta(req, res);
});

router.get("/lista-temperatura-sensor-dia/:sensorID",function (req, res) {
    graficosController.listaTemperaturaSensorDia(req, res);
});

router.get("/lista-temperatura-sensor/:estufaID",function (req, res) {
    graficosController.listaTemperaturaSensor(req, res);
});

module.exports = router;



