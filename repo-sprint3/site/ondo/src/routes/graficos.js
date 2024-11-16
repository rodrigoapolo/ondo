const express = require("express");
const router = express.Router();
const graficosController = require("../controllers/graficosController");

router.get("/temperatura-atual/:estufaID",function (req, res) {
    graficosController.temperaturaAtual(req, res);
});

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

module.exports = router;



