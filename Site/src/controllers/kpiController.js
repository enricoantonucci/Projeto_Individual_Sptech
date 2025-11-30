var kpiModel = require("../models/kpiModel");

function buscarAproveitamento(req, res) {
    const idUsuario = req.params.idUsuario;
    kpiModel.buscarAproveitamento(idUsuario)
        .then(function (resultado) {
            if (resultado.length > 0) { res.status(200).json(resultado); } 
            else { res.status(204).send("Nenhum resultado de aproveitamento encontrado!"); }
        }).catch(function (erro) { res.status(500).json(erro.sqlMessage); });
}

function buscarMelhorPontuacao(req, res) {
    const idUsuario = req.params.idUsuario;
    kpiModel.buscarMelhorPontuacao(idUsuario)
        .then(function (resultado) {
            if (resultado.length > 0) { res.status(200).json(resultado); }
            else { res.status(204).send("Nenhuma pontuação máxima encontrada!"); }
        }).catch(function (erro) { res.status(500).json(erro.sqlMessage); });
}

function buscarHistoricoTentativas(req, res) {
    const idUsuario = req.params.idUsuario;
    kpiModel.buscarHistoricoTentativas(idUsuario)
        .then(function (resultado) {
            if (resultado.length > 0) { res.status(200).json(resultado); } 
            else { res.status(204).send("Nenhum histórico encontrado!"); }
        }).catch(function (erro) { res.status(500).json(erro.sqlMessage); });
}

module.exports = {
    buscarAproveitamento,
    buscarMelhorPontuacao,
    buscarHistoricoTentativas
};