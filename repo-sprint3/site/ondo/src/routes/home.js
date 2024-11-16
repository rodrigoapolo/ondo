const express = require("express");
const router = express.Router();
const homeController = require("../controllers/homeController");

router.get("/estufas-monitoradas/:empresaID",function (req, res) {
    homeController.estufasMonitoradas(req, res);
});

router.get("/temperaturas-adequadas/:empresaID",function (req, res) {
    homeController.temperaturasAdequadas(req, res);
});

router.get("/temperaturas-inadequadas/:empresaID",function (req, res) {
    homeController.temperaturasInadequadas(req, res);
});

router.get("/lista-estufas/:empresaID",function (req, res) {
    homeController.listaEsfufas(req, res);
});


module.exports = router;



