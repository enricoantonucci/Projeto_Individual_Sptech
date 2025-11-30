var database = require("../database/config");

function registrarTentativa(idUsuario, pontuacao, erros) {


    var instrucaoSql = `
        INSERT INTO tentativa_quiz (fk_usuario, pontuacao, erros) VALUES (${idUsuario}, ${pontuacao}, ${erros});
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    registrarTentativa
};