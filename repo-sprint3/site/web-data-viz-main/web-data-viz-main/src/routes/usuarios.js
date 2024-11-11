const express = require("express");
const router = express.Router();
const usuarioController = require("../controllers/usuarioController");

// Rota para cadastrar um novo usuário
router.post("/cadastrar", usuarioController.cadastrar);




// Rota para autenticar um usuário
router.post("/autenticar", function (req, res) {
    usuarioController.autenticar(req, res);
});

module.exports = router;



