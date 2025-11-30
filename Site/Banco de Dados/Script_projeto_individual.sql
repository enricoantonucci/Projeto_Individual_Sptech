USE projeto_individual;

CREATE TABLE quiz (
    id_quiz INT PRIMARY KEY,
    nome_quiz VARCHAR(45)
);

CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    email VARCHAR(45),
    senha VARCHAR(45)
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
        fk_idQuiz
    ),
    FOREIGN KEY (fk_idUsuario) REFERENCES usuario (id_usuario),
    FOREIGN KEY (fk_idQuestoes) REFERENCES questoes (id_questoes),
    FOREIGN KEY (fk_idQuiz) REFERENCES quiz (id_quiz)
);

CREATE TABLE tentativa_quiz (
    id_tentativa INT PRIMARY KEY AUTO_INCREMENT,
    fk_usuario INT,
    pontuacao INT,
    erros INT,
    dt_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (fk_usuario) REFERENCES usuario (id_usuario)
);

SELECT * FROM tentativa_quiz;

SELECT * FROM questoes;