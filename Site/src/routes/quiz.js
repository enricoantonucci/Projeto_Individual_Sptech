var express = require("express");
var router = express.Router();

// Importando o Controller que criamos (verifique se o arquivo existe na pasta controllers)
var quizController = require("../controllers/quizController");

// Definindo a rota POST "/registrar"
// Como no app.js vamos definir o prefixo "/quiz", a URL completa será "/quiz/registrar"
router.post("/registrar", function (req, res) {
    // Chama a função 'registrar' do Controller
    quizController.registrar(req, res);
});

module.exports = router;