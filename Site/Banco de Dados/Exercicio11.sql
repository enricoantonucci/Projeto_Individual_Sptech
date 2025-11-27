
USE Exercicio11;

CREATE TABLE Departamento (
    idDepto INT PRIMARY KEY,
    nomeDepto VARCHAR(50) NOT NULL,
    fkGerente INT,
    dataInicioGer DATE
);

CREATE TABLE Funcionario (
    idFunc INT PRIMARY KEY,
    nomeFunc VARCHAR(30) NOT NULL,
    salario DECIMAL(10, 2),
    sexo CHAR(1),
    fkSupervisor INT,
    dataNasc DATE,
    fkDepto INT,
    CONSTRAINT fkFuncDepto FOREIGN KEY (fkDepto) REFERENCES Departamento(idDepto)
);

CREATE TABLE Projeto (
    idProj INT PRIMARY KEY,
    nomeProj VARCHAR(50) NOT NULL,
    localProj VARCHAR(50),
    fkDepto INT,
    CONSTRAINT fkProjDepto FOREIGN KEY (fkDepto) REFERENCES Departamento(idDepto)
);

CREATE TABLE FuncProj (
    fkFunc INT,
    fkProj INT,
    horas DECIMAL(3, 1),
    PRIMARY KEY (fkFunc, fkProj),
    CONSTRAINT fkFuncProjFunc FOREIGN KEY (fkFunc) REFERENCES Funcionario(idFunc),
    CONSTRAINT fkFuncProjProj FOREIGN KEY (fkProj) REFERENCES Projeto(idProj)
);


INSERT INTO Departamento VALUES
(105, 'Pesquisa', 2, '2008-05-22'),
(104, 'Administração', 7, '2015-01-01'),
(101, 'Matriz', 8, '2001-06-19');

INSERT INTO Funcionario VALUES
(1, 'Joao Silva', 3500, 'm', 2, '1985-01-09', 105),
(2, 'Fernando Wong', 4500, 'm', 8, '1975-12-08', 105),
(3, 'Alice Sousa', 2500, 'f', 7, '1988-01-19', 104),
(4, 'Janice Morais', 4300, 'f', 8, '1970-06-20', 104),
(5, 'Ronaldo Lima', 3800, 'm', 1, '1982-09-15', 105),
(6, 'Joice Leite', 2500, 'f', 1, '1992-07-31', 105),
(7, 'Antonio Pereira', 2500, 'm', 4, '1989-03-29', 104),
(8, 'Juliano Brito', 5500, 'm', NULL, '1957-11-10', 101);

INSERT INTO Projeto VALUES
(1, 'Produto X', 'Santo André', 105),
(2, 'Produto Y', 'Itu', 105),
(3, 'Produto Z', 'São Paulo', 105),
(10, 'Informatização', 'Mauá', 104),
(20, 'Reorganização', 'São Paulo', 101),
(30, 'Benefícios', 'Mauá', 104);

INSERT INTO FuncProj VALUES
(1, 1, 32.5), (1, 2, 7.5),
(5, 3, 40.0),
(6, 1, 20.0), (6, 2, 20.0),
(2, 2, 10.0), (2, 3, 10.0), (2, 10, 10.0), (2, 20, 10.0),
(3, 30, 30.0), (3, 10, 10.0),
(7, 10, 35.0), (7, 30, 5.0),
(4, 30, 20.0), (4, 20, 15.0),
(8, 20, NULL);

ALTER TABLE Departamento
ADD CONSTRAINT fkDeptoGerente
FOREIGN KEY (fkGerente) REFERENCES Funcionario(idFunc);

ALTER TABLE Funcionario
ADD CONSTRAINT fkFuncSupervisor
FOREIGN KEY (fkSupervisor) REFERENCES Funcionario(idFunc);

SELECT '--- Tabela Departamento ---' AS Tabela;
SELECT * FROM Departamento;
SELECT '--- Tabela Funcionario ---' AS Tabela;
SELECT * FROM Funcionario;
SELECT '--- Tabela Projeto ---' AS Tabela;
SELECT * FROM Projeto;
SELECT '--- Tabela FuncProj ---' AS Tabela;
SELECT * FROM FuncProj;


SELECT '--- Resultados dos Comandos de Manipulação ---';


INSERT INTO Funcionario VALUES (9, 'Cecília Ribeiro', 2800, 'f', 4, '1980-04-05', 104);
SELECT 'Funcionário 9 inserido: Cecília Ribeiro';

DELETE FROM FuncProj WHERE fkFunc = 3 AND fkProj = 10;
SELECT 'Tupla (3, 10) excluída de FuncProj';


SELECT 'DELETE de idFunc=4 falhou por FK (é supervisor e gerente)';

SELECT 'DELETE de idFunc=2 falhou por FK (é supervisor, gerente e está em FuncProj)';

UPDATE Funcionario SET salario = 2800 WHERE idFunc = 3;
SELECT 'Salário do funcionário 3 alterado para 2800';

UPDATE Funcionario SET fkDepto = 101 WHERE idFunc = 3;
SELECT 'fkDepto do funcionário 3 alterado para 101';


SELECT 'UPDATE de fkDepto=107 falhou por FK (Departamento não existe)';

UPDATE Funcionario SET fkDepto = 104 WHERE idFunc = 3;

SELECT '--- Relatórios e Consultas SQL ---';

SELECT nomeFunc, dataNasc, salario FROM Funcionario WHERE nomeFunc = 'Joao Silva';

SELECT salario FROM Funcionario;

SELECT DISTINCT salario FROM Funcionario;

SELECT * FROM Funcionario ORDER BY nomeFunc;

SELECT * FROM Funcionario ORDER BY salario DESC;

SELECT * FROM Funcionario WHERE salario BETWEEN 2000 AND 4000;

SELECT nomeFunc, salario FROM Funcionario WHERE nomeFunc LIKE 'J%';

SELECT nomeFunc, salario FROM Funcionario WHERE nomeFunc LIKE '%a';

SELECT nomeFunc FROM Funcionario WHERE nomeFunc LIKE '__n%';

SELECT nomeFunc, dataNasc FROM Funcionario WHERE nomeFunc LIKE '%S____';

SELECT f.*
FROM Funcionario f
JOIN Departamento d ON f.fkDepto = d.idDepto
WHERE d.nomeDepto = 'Pesquisa';

SELECT f.*
FROM Funcionario f
JOIN Departamento d ON f.fkDepto = d.idDepto
WHERE d.nomeDepto = 'Pesquisa' AND f.salario > 3500;

SELECT f.*
FROM Funcionario f
JOIN Departamento d ON f.fkDepto = d.idDepto
WHERE d.nomeDepto = 'Pesquisa' AND f.nomeFunc LIKE 'J%';

SELECT
    f.idFunc AS idFuncionario,
    f.nomeFunc AS NomeFuncionario,
    s.idFunc AS idSupervisor,
    s.nomeFunc AS NomeSupervisor
FROM
    Funcionario f
LEFT JOIN
    Funcionario s ON f.fkSupervisor = s.idFunc;

SELECT
    p.idProj,
    d.idDepto AS DeptoControlador,
    g.nomeFunc AS NomeGerente,
    g.dataNasc AS DataNascGerente
FROM
    Projeto p
JOIN
    Departamento d ON p.fkDepto = d.idDepto
JOIN
    Funcionario g ON d.fkGerente = g.idFunc
WHERE
    p.localProj = 'São Paulo';

SELECT
    f.idFunc,
    f.nomeFunc AS NomeFuncionario,
    p.idProj,
    p.nomeProj AS NomeProjeto,
    fp.horas AS HorasTrabalhadas
FROM
    Funcionario f
JOIN
    FuncProj fp ON f.idFunc = fp.fkFunc
JOIN
    Projeto p ON fp.fkProj = p.idProj;


SELECT nomeFunc FROM Funcionario WHERE dataNasc < '1980-01-01';


SELECT COUNT(DISTINCT salario) AS QuantidadeSalariosDiferentes FROM Funcionario;


SELECT COUNT(DISTINCT localProj) AS QuantidadeLocaisDiferentes FROM Projeto;


SELECT
    AVG(salario) AS SalarioMedioEmpresa,
    SUM(salario) AS SomaSalarios
FROM Funcionario;

SELECT
    MIN(salario) AS MenorSalario,
    MAX(salario) AS MaiorSalario
FROM Funcionario;

SELECT
    fkDepto,
    AVG(salario) AS SalarioMedio,
    SUM(salario) AS SomaSalario
FROM Funcionario
GROUP BY fkDepto;

SELECT
    fkDepto,
    MIN(salario) AS MenorSalario,
    MAX(salario) AS MaiorSalario
FROM Funcionario
GROUP BY fkDepto;

INSERT INTO Funcionario (idFunc, nomeFunc, salario, sexo, fkSupervisor, dataNasc, fkDepto) VALUES
(10, 'José da Silva', 1800, 'm', 3, '2000-10-12', NULL),
(11, 'Benedito Almeida', 1200, 'm', 5, '2001-09-01', NULL);
SELECT 'Funcionários 10 e 11 inseridos';

INSERT INTO Departamento VALUES
(110, 'RH', 3, '2018-11-10');
SELECT 'Departamento 110 (RH) inserido';