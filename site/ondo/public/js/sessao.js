// sessão
function validarSessao() {
    var email = sessionStorage.EMAIL_USUARIO;
    var responsavel = sessionStorage.NOME_RESPONSAVEL;

    var b_usuario = document.getElementById("b_usuario");

    if (email != null && responsavel != null) {
        b_usuario.innerHTML = responsavel;
    } else {
        window.location = "../login.html";
    }
}

function limparSessao() {
    sessionStorage.clear();
    window.location = "../login.html";
}

// carregamento (loading)
function aguardar() {
    var divAguardar = document.getElementById("div_aguardar");
    divAguardar.style.display = "flex";
}

function finalizarAguardar(texto) {
    var divAguardar = document.getElementById("div_aguardar");
    divAguardar.style.display = "none";

    var divErrosLogin = document.getElementById("cardErro");
    if (texto) {
        divErrosLogin.style.display = "flex";
        divErrosLogin.innerHTML = texto;
    }
}

