const usuarioModel = require("../models/usuarioModel");
const empresaModel = require("../models/empresaModel");

function cadastrar(req, res) {
    const nome = req.body.responsavelServer;
    const email = req.body.emailServer;
    const senha = req.body.senhaServer;
    var cnpj = req.body.cnpjServer;
    var razaoSocial = req.body.razaoSocialServer;
    var nomeFantasia = req.body.nomeFantasiasServer;
    var cep = req.body.cepServer;
    var bairro = req.body.bairroServer;
    var logradouro = req.body.logradouroServer;
    var numero = req.body.numeroServer; 
    var cidade = req.body.cidadeServer; 
    var estado = req.body.estadoServer; 

    
    // Verificar se os campos obrigatórios foram preenchidos
    if (!nome || !email || !senha) {
        return res.status(400).send("Campos obrigatórios não preenchidos!");
    }

    // Primeiro, tenta cadastrar o usuário
    usuarioModel.cadastrar(nome, email, senha, )
        .then((resultadoUsuario) => {
            console.log("Usuário cadastrado com sucesso:", resultadoUsuario);
            
            var idUsuario = resultadoUsuario.insertId
    empresaModel.cadastrar(cnpj,razaoSocial,nomeFantasia,cep,bairro, logradouro, numero, cidade, estado, idUsuario)
            .then( (resultadoEmpresa) => {
                res.status(201).send(`Empresa e usuário cadastrado com sucesso`)

            })
            .catch((erroEmpresa) => {
                console.log("Erro ao cadastrar empresa:", erroEmpresa);
                res.status(500).json(erroEmpresa.sqlMessage);
            });
        })

        .catch((erroUsuario) => {
            console.log("Erro ao cadastrar usuário:", erroUsuario);
            res.status(500).json(erroUsuario.sqlMessage);
        });
}

module.exports = { cadastrar };
