const usuarioModel = require("../models/usuarioModel");
const empresaModel = require("../models/empresaModel");
const aquarioModel = require("../models/aquarioModel");

function autenticar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else {
        usuarioModel.autenticar(email, senha)
            .then(
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String
                    
                    if (resultadoAutenticar.length == 1) {
                        // aquarioModel.buscarAquariosPorEmpresa(resultadoAutenticar[0].empresaId)
                        empresaModel.listar(resultadoAutenticar[0].idUsuario)
                        .then((resultadoEmpresas) => {
                            console.log(`Resultados empresa: ${JSON.stringify(resultadoEmpresas)}`); // transforma JSON em String

                            if (resultadoEmpresas.length > 0) {
                                    res.json({
                                        idEmpresa: resultadoEmpresas[0].idEmpresa,
                                        idUsuario: resultadoAutenticar[0].idUsuario,
                                        cnpj: resultadoEmpresas[0].cnpj,
                                        razão_social : resultadoEmpresas[0].razão_social,
                                        nome_fantasia: resultadoEmpresas[0].nome_fantasia,
                                        responsavel: resultadoAutenticar[0].nome,
                                        email: resultadoAutenticar[0].email,
                                        cep: resultadoEmpresas[0].cep,
                                        bairro: resultadoEmpresas[0].bairro,
                                        logradouro: resultadoEmpresas[0].logradouro,
                                        cidade: resultadoEmpresas[0].cidade,
                                        estado: resultadoEmpresas[0].estado,
                                        // aquarios: resultadoAquarios
                                    });
                                } else {
                                    res.status(204).json({ aquarios: [] });
                                }
                            })
                    } else if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Email e/ou senha inválido(s)");
                    } else {
                        res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

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
            empresaModel.cadastrar(cnpj, razaoSocial, nomeFantasia, cep, bairro, logradouro, numero, cidade, estado, idUsuario)
                .then((resultadoEmpresa) => {
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

module.exports = {
    cadastrar,
    autenticar
};