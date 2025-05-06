USE escola;

-- EX01 - Crie a tabela aluno
CREATE TABLE aluno(
matricula INTEGER PRIMARY KEY, 
nomealuno VARCHAR(30) NOT NULL,
sexo CHAR(1), 
dtnascimento DATE
);

-- EX02 – Crie  a tabela departamento
CREATE TABLE departamento(
coddepto INTEGER PRIMARY KEY,
nomedepto VARCHAR(30)
);

-- EX03 – Crie a tabela curso
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

-- EX05 – Crie a tabela func, rigorosamente com o modelo ao lado (atenção para a FK)
CREATE TABLE func(
codfunc INTEGER PRIMARY KEY,
nomefunc VARCHAR(20),
city VARCHAR(20),
cbo INTEGER,
uf CHAR(2),
coddepto INTEGER,
FOREIGN KEY (coddepto) REFERENCES departamento(coddepto)
);

-- EX06 – Altere o nome do campo city para cidade
ALTER TABLE funcionario RENAME COLUMN city TO cidade;

-- EX07 – Crie a coluna sexo com o tipo char(1)
ALTER TABLE func ADD COLUMN sexo CHAR(1);

-- EX08 – Altere o tipo da coluna nomefunc para varchar(30)
ALTER TABLE func MODIFY COLUMN nomefunc VARCHAR(30);

-- EX09 – Apague a coluna CBO
ALTER TABLE func DROP COLUMN cbo;

-- EX10 – Defina a coluna UF como valor default ‘RJ’
ALTER TABLE func ALTER COLUMN uf SET DEFAULT 'RJ';

-- EX11 – Renomeie a tabela func para funcionario
ALTER TABLE func RENAME TO funcionario;

-- EX12 – Defina a coluna nomefunc para not null
ALTER TABLE funcionario MODIFY COLUMN nomefunc VARCHAR(30) NOT NULL;

-- EX13 – Transforme a coluna codfunc para incremental (em Postgres usar Sequence)
ALTER TABLE funcionario MODIFY COLUMN codfunc INTEGER AUTO_INCREMENT;

-- EX14 – Crie uma tabela chamada telefone, como no modelo abaixo; Crie a chave estrangeira codfunc na tabela telefone, apontando para a tabela funcionário (atenção para a FK). No MySQL o campo de auto numeração é  o auto_increment, no Postgres serial
CREATE TABLE telefone(
codtel SERIAL PRIMARY KEY,
ddd INTEGER,
numero VARCHAR(13),
codfunc INTEGER,
CONSTRAINT FK_FUNC FOREIGN KEY (codfunc) REFERENCES funcionario (codfunc)
);

-- EX15 – Tente apagar a tabela funcionário (apenas para ver a mensagem de erro, não usar CASCADE)
DROP TABLE funcionario;

-- EX16 – Apague a tabela telefone;
DROP TABLE telefone;

-- EX17 – Insira o aluno abaixo no tabela aluno
INSERT INTO aluno (matricula, nomealuno, sexo, dtnascimento)
VALUES (1, 'Ana', 'F', '1979-01-23');

-- EX18 – Insira os demais alunos na tabela aluno
INSERT INTO aluno (matricula, nomealuno, sexo, dtnascimento) 
VALUES 
('2', 'André', 'M', '1980-11-20'),
('3', 'Andreia', 'F', '1985-05-09'),
('4', 'Bruna', 'F', '1980-11-20'),
('5', 'Bruno', 'M', '1982-01-12');

SELECT nomealuno 
	FROM aluno
WHERE sexo = 'F'

-- EX19 – Cadastre os departamentos abaixo na tabela departamento
INSERT INTO departamento (coddepto, nomedepto)
VALUES 
('1','TI'),
('2', "ADM");

-- EX20 – Cadastre os cursos a seguir na tabela curso
INSERT INTO curso (codcurso, nomecurso, ch, preco, coddepto) 
VALUES 
('1', 'Python', '40', '1200', '1'),
('2', 'Power BI', '20', '900', '1'),
('3', 'Pentaho', '40', '1200', '1'),
('4', 'Recursos Humanos', '60', '2000', '2'),
('5', 'Marketing', '80', '2500', '1');

-- EX21 – Matricule os alunos nos cursos, conforme a lista a seguir
INSERT INTO matricula (matricula, codcurso, dtmatricula)
VALUES
(1,1,'2019-04-01'),
(2,1,'2019-04-01'),
(4,1,'2019-04-01'),
(4,2,'2019-04-02'),
(5,2,'2019-04-02'),
(1,2,'2019-04-02'),
(1,3,'2019-04-03'),
(5,3,'2019-04-03'),
(3,3,'2019-04-03'),
(2,3,'2019-04-03'),
(4,3,'2019-04-03'),
(5,4,'2019-04-04'),
(3,4,'2019-04-04'),
(5,5,'2019-04-06'),
(3,5,'2019-04-06'),
(2,5,'2019-04-06');

CREATE VIEW vw_matriculas AS
SELECT aluno.nomealuno, curso.nomecurso, matricula.dtmatricula
FROM aluno, matricula, curso
WHERE aluno.matricula = matricula.matricula
AND matricula.codcurso = curso.codcurso;

SELECT * FROM vw_matriculas;

-- EX22 – Cadastre os funcionários tal como a lista abaixo
INSERT INTO funcionario (codfunc, nomefunc, cidade, uf, coddepto, sexo)
VALUES 
(1, 'Paulo', 'Duque de Caxias', 'RJ', 1, 'M'),
(2, 'Paula', 'Rio de Janeiro', 'RJ', 2, 'F'),
(3, 'José', 'Rio de Janeiro', 'RJ', 1, 'M');

-- TESTANDO O DEFAULT SEM A UF
INSERT INTO funcionario (codfunc, nomefunc, cidade, uf, coddepto, sexo) VALUES
(4, 'AMANDA', ' Rio de Janeiro', 'RJ', 2, 'F');

SELECT * FROM funcionario;
