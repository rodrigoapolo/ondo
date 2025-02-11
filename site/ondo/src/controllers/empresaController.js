var empresaModel = require("../models/empresaModel");

function buscarPorCnpj(req, res) {
  var cnpj = req.query.cnpj;

  empresaModel.buscarPorCnpj(cnpj).then((resultado) => {
    res.status(200).json(resultado);
  });
}

function listar(req, res) {
  empresaModel.listar().then((resultado) => {
    res.status(200).json(resultado);
  });
}
function listarAll(req, res) {
  empresaModel.listarAll()
  .then((resultado) => {
    console.log("Resultado do listar todos: " + resultado)
    res.status(200).json(resultado);
  });
}

function buscarPorId(req, res) {
  var id = req.params.id;

  empresaModel.buscarPorId(id).then((resultado) => {
    res.status(200).json(resultado);
  });
}

function cadastrar(req, res) {
  var cnpj = req.body.cnpj;
  var razaoSocial = req.body.razaoSocial;
  var nomeFantasia = req.body.nomeFantasia;
  var cep = req.body.cep;
  var bairro = req.body.bairro;
  var logradouro = req.body.logradouro;
  var numero = req.body.numero; 
  var cidade = req.body.cidade; 
  var estado = req.body.estado; 
  var fkUsuario


  empresaModel.buscarPorCnpj(cnpj).then((resultado) => {
    if (resultado.length > 0) {
      res
        .status(401)
        .json({ mensagem: `a empresa com o cnpj ${cnpj} já existe` });
    } else {
      empresaModel.cadastrar(cnpj,razaoSocial,nomeFantasia,cep,bairro, logradouro, numero, cidade, estado, fkUsuario).then((resultado) => {
        res.status(201).json(resultado);
      });
    }
  });
}

module.exports = {
  buscarPorCnpj,
  buscarPorId,
  cadastrar,
  listar,
  listarAll
};