var express = require("express");
var router = express.Router();

var kpiController = require("../controllers/kpiController");

router.get("/aproveitamento/:idUsuario", function (req, res) {
    kpiController.buscarAproveitamento(req, res);
});

router.get("/melhor-pontuacao/:idUsuario", function (req, res) {
    kpiController.buscarMelhorPontuacao(req, res);
});

router.get("/historico/:idUsuario", function (req, res) {
    kpiController.buscarHistoricoTentativas(req, res);
});

module.exports = router;