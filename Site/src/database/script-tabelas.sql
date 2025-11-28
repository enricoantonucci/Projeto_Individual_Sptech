-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/*
comandos para mysql server
*/

CREATE DATABASE projeto_individual;

USE projeto_individual;

CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    email VARCHAR(45),
    senha VARCHAR(45)
);

CREATE TABLE quiz (
    id_quiz INT PRIMARY KEY,
    nome_quiz VARCHAR(45)
);

CREATE TABLE questoes (
    id_questoes INT AUTO_INCREMENT,
    resposta_certa INT,
    resposta_errada INT,
    fk_idUsuario INT,
    fk_idQuestoes INT,
    fk_idQuiz INT,
    PRIMARY KEY (
id_questoes,
    fk_idUsuario,
        fk_idQuiz),

    FOREIGN KEY (fk_idUsuario) REFERENCES usuario (id_usuario),
    FOREIGN KEY (fk_idQuestoes) REFERENCES questoes (id_questoes),
    FOREIGN KEY (fk_idQuiz) REFERENCES quiz (id_quiz)
);