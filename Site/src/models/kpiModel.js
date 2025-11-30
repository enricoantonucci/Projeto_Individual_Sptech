var database = require("../database/config");

function buscarAproveitamento(idUsuario) {
    // Busca os totais somando as colunas da tabela nova
    var instrucaoSql = `
        SELECT 
            SUM(pontuacao) as total_certas, 
            SUM(erros) as total_erradas,
            COUNT(id_tentativa) as total_respostas
        FROM tentativa_quiz 
        WHERE fk_usuario = ${idUsuario};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMelhorPontuacao(idUsuario) {
    var instrucaoSql = `
        SELECT MAX(pontuacao) as maior_acerto 
        FROM tentativa_quiz 
        WHERE fk_usuario = ${idUsuario};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarHistoricoTentativas(idUsuario) {
    var instrucaoSql = `
        SELECT 
            DATE_FORMAT(dt_hora, '%d/%m %H:%i') as label_data, 
            pontuacao 
        FROM tentativa_quiz 
        WHERE fk_usuario = ${idUsuario} 
        ORDER BY id_tentativa DESC;`;
        
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarAproveitamento,
    buscarMelhorPontuacao,
    buscarHistoricoTentativas
};