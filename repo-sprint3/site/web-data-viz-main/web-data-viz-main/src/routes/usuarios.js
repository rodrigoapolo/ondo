const express = require("express");
const router = express.Router();
const usuarioController = require("../controllers/usuarioController");

// Rota para cadastrar um novo usuário
router.post("/cadastrar",function (req, res) {
    usuarioController.cadastrar(req, res);
});




// Rota para autenticar um usuário
router.post("/autenticar", function (req, res) {
    usuarioController.autenticar(req, res);
});

module.exports = router;



