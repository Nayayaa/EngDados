# EngDados
Exercicíos de MySQL em Engenharia de Dados.

CREATE schema aula;
use aula;

-- EX01 – Crie o database escola e, com base no modelo ao lado, crie a tabela aluno.
CREATE TABLE aluno(
matricula INTEGER PRIMARY KEY, 
nomealuno VARCHAR(30) NOT NULL,
sexo CHAR(1), 
dtnascimento DATE
);

-- EX02 – Crie  a tabela departamento; 
CREATE TABLE departamento(
coddepto INTEGER PRIMARY KEY,
nomedepto VARCHAR(30)
);

-- EX03 – Crie a tabela Curso
CREATE TABLE curso(
codcurso INTEGER PRIMARY KEY,
nomecurso VARCHAR(30) NOT NULL,
ch INTEGER,
preco REAL,
coddepto INTEGER,
FOREIGN KEY(coddepto) REFERENCES departamento(coddepto) 
);

-- EX04 – Crie a tabela matrícula
CREATE TABLE matricula(
matricula INTEGER,
codcurso INTEGER, 
dtmatricula DATE,
PRIMARY KEY (matricula, codcurso),
FOREIGN KEY (matricula) REFERENCES aluno (matricula),
FOREIGN KEY (codcurso) REFERENCES curso (codcurso)
);
