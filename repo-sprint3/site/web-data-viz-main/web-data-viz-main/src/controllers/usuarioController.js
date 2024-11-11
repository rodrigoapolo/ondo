const usuarioModel = require("../models/usuarioModel");
const empresaModel = require("../models/empresaModel");

function cadastrar(req, res) {
    const nome = req.body.responsavelServer;
    const email = req.body.emailServer;
    const senha = req.body.senhaServer;
    
    // Verificar se os campos obrigatórios foram preenchidos
    if (!nome || !email || !senha) {
        return res.status(400).send("Campos obrigatórios não preenchidos!");
    }

    // Primeiro, tenta cadastrar o usuário
    usuarioModel.cadastrar(nome, email, senha)
        .then((resultadoUsuario) => {
            console.log("Usuário cadastrado com sucesso:", resultadoUsuario);

            // Após cadastrar o usuário, cria a empresa, passando o idUsuario
            const fkUsuario = resultadoUsuario.insertId;
            const cnpj = req.body.cnpjServer;
            const razaoSocial = req.body.razaoSocialServer;
            const nomeFantasia = req.body.nomeFantasiaServer;
            const cep = req.body.cepServer;
            const bairro = req.body.bairroServer;
            const logradouro = req.body.logradouroServer;
            const numero = req.body.numeroServer;
            const cidade = req.body.cidadeServer;
            const uf = req.body.ufServer;

            // Verifica se todos os dados da empresa foram enviados
            if (!cnpj || !razaoSocial || !nomeFantasia || !cep || !bairro || !logradouro || !numero || !cidade || !uf) {
                return res.status(400).send("Campos obrigatórios da empresa não preenchidos!");
            }

            // Criando a empresa e associando com o usuário
            empresaModel.cadastrar(cnpj, razaoSocial, nomeFantasia, cep, bairro, logradouro, numero, cidade, uf, fkUsuario)
                .then((resultadoEmpresa) => {
                    console.log("Empresa cadastrada com sucesso:", resultadoEmpresa);
                    res.status(201).json({
                        idUsuario: resultadoUsuario.insertId,
                        idEmpresa: resultadoEmpresa.insertId,
                        mensagem: "Usuário e Empresa cadastrados com sucesso!"
                    });
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
