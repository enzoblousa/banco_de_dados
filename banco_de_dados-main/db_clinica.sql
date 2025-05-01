create database clinica;
use clinica;

CREATE TABLE Ambulatorios (
			nroa		    integer,
			andar		    numeric(3) NOT NULL,
			capacidade      smallint,    
			PRIMARY KEY(nroa) 	
);

CREATE TABLE Medicos (
	codm		      integer,
	nome		      varchar(40) NOT NULL,
	idade            smallint    NOT NULL,
	especialidade    char(20), 
	CPF              numeric(11) UNIQUE, 
	cidade           varchar(30),  
	nroa             integer,
   PRIMARY KEY(codm)	
);

ALTER TABLE Medicos ADD FOREIGN KEY (nroa) 
REFERENCES ambulatorios(nroa);

CREATE TABLE Pacientes (
	codp INTEGER,
    nome varchar(40) not null,
    idade smallint,
    cidade char(30),
    cpf numeric(11) unique,
    doenca varchar(40) not null,
    PRIMARY KEY(codp)
);

CREATE TABLE Funcionarios (
	codf INTEGER, 
    nome varchar(40) NOT NULL, 
    idade smallint, 
    CPF numeric(11) UNIQUE, 
    cidade varchar(30), 
    salario numeric(10), 
    cargo varchar(20),
    PRIMARY KEY(codf)
);

CREATE TABLE Consultas (
	codm INTEGER, 
    codp INTEGER, 
    data date, 
    hora time
);

ALTER TABLE Consultas ADD FOREIGN KEY (codm) 
REFERENCES medicos(codm);

ALTER TABLE Consultas ADD FOREIGN KEY (codp) 
REFERENCES pacientes(codp);

-- INSERTS DE AMBULATÓRIO --
INSERT INTO ambulatorios (nroa, andar, capacidade)
VALUES (1,1,30);

INSERT INTO ambulatorios (nroa, andar, capacidade)
VALUES(2,1,50);

INSERT INTO ambulatorios (nroa, andar, capacidade)
VALUES(3,2,40);

INSERT INTO ambulatorios (nroa, andar, capacidade)
VALUES (4,2,25);

INSERT INTO ambulatorios (nroa, andar, capacidade)
VALUES (5,2,55);

-- INSERT DE MÉDICOS -- 
           
INSERT INTO Medicos 
    (codm, nome, idade, especialidade, 
     CPF, cidade,nroa)
    VALUES (1,
'Joao',
40,
'ortopedia',
10000100000,
'Florianopolis',
1);

INSERT INTO Medicos 
    (codm, nome, idade, especialidade, 
     CPF, cidade,nroa)
    VALUES (2,
'Maria',
42,
'traumatologia',
10000110000,
'Blumenau',
2);

INSERT INTO Medicos 
    (codm, nome, idade, especialidade, 
     CPF, cidade,nroa)
    VALUES (3,
'Pedro',
51,
'pediatria',
11000100000,
'São José',
2);

INSERT INTO Medicos 
    (codm, nome, idade, especialidade, 
     CPF, cidade,nroa)
    VALUES (4,
'Carlos',
28,
'ortopedia',
11000110000,
'Joinville',
5);

INSERT INTO Medicos 
    (codm, nome, idade, especialidade, 
     CPF, cidade,nroa)
    VALUES (5,
'Marcia',
33,
'neurologia',
11000111000,
'Biguacu',
3);

INSERT INTO Pacientes (codp, nome, idade, cidade, cpf, doenca) VALUES
(4, 'Ana Rodrigues', 28, 'Belo Horizonte', '45678901234', 'Gripe'),
(5, 'Fernando Oliveira', 55, 'Porto Alegre', '56789012345', 'Artrite'),
(6, 'Juliana Santos', 33, 'Recife', '67890123456', 'Rinite'),
(7, 'Ricardo Silva', 40, 'Brasília', '78901234567', 'Enxaqueca'),
(8, 'Camila Souza', 22, 'Manaus', '89012345678', 'Sinusite'),
(9, 'Paulo Costa', 48, 'Fortaleza', '90123456789', 'Colesterol'),
(10, 'Mariana Lima', 37, 'Curitiba', '01234567890', 'Hipotireoidismo'),
(11, 'Gustavo Pereira', 29, 'Belém', '12345678901', 'Asma'),
(12, 'Luciana Almeida', 41, 'Salvador', '23456789012', 'Diabetes'),
(13, 'Daniel Mendes', 50, 'São Paulo', '34567890123', 'Hipertensão');

-- Inserir dados na tabela Funcionarios
INSERT INTO Funcionarios (codf, nome, idade, cpf, cidade, salario, cargo) VALUES
(1, 'Aline Santos', 30, '23456789012', 'Belo Horizonte', 5500.00, 'Médico'),
(2, 'Roberto Oliveira', 42, '34567890123', 'Porto Alegre', 4300.00, 'Enfermeiro'),
(3, 'Tatiane Lima', 27, '45678901234', 'Recife', 3200.00, 'Recepcionista'),
(4, 'Renato Costa', 35, '56789012345', 'Brasília', 5000.00, 'Médico'),
(5, 'Patrícia Silva', 31, '67890123456', 'Manaus', 3800.00, 'Enfermeiro'),
(6, 'Thiago Sousa', 26, '78901234567', 'Fortaleza', 3000.00, 'Recepcionista'),
(7, 'Bianca Pereira', 37, '89012345678', 'Curitiba', 4500.00, 'Médico'),
(8, 'Felipe Santos', 29, '90123456789', 'Belém', 3700.00, 'Enfermeiro'),
(9, 'Juliana Costa', 33, '01234567890', 'Salvador', 3200.00, 'Recepcionista'),
(10, 'Lucas Oliveira', 39, '12345678901', 'São Paulo', 4800.00, 'Médico');

-- Inserir dados na tabela Consultas
INSERT INTO Consultas (codm, codp, data, hora) VALUES
(4, 4, '2024-03-24', '09:30:00'),
(5, 5, '2024-03-25', '15:00:00'),
(5, 6, '2024-03-26', '10:45:00'),
(4, 7, '2024-03-27', '11:30:00'),
(3, 8, '2024-03-28', '13:20:00'),
(4, 9, '2024-03-29', '14:10:00'),
(2, 10, '2024-03-30', '16:30:00');

-- ITEM 1 (Buscar o nome e o CPF dos médicos com menos de 40 anos ou com especialidade diferente de traumatologia)
SELECT nome, cpf, idade, especialidade
FROM Medicos
WHERE idade < '40' OR especialidade != 'traumatologia';

-- ITEM 2 (Buscar todos os dados das consultas marcadas no período da tarde após o dia 19/06/2006)
SELECT *
FROM Consultas 
WHERE hora >= '12:00:00' and data > '2006-06-19';  

-- ITEM 3 (Buscar o nome e a idade dos pacientes que não residem em Florianópolis)
SELECT nome, idade, cidade 
FROM Pacientes 
WHERE cidade != 'Florianópolis';

-- ITEM 4 (Buscar a hora das consultas marcadas antes do dia 14/06/2024 e depois do dia 20/12/2024)
SELECT hora 
FROM Consultas 
WHERE data > '2024-12-20' and data < '2024-06-14';

-- ITEM 5 (Buscar o nome e a idade (em meses) dos pacientes) 
SELECT nome, idade * 12
FROM Pacientes;

-- ITEM 6 (Em quais cidades residem os funcionários?)
SELECT nome, cidade 
FROM Funcionarios;

-- ITEM 7 (Qual o menor e o maior salário dos funcionários da Florianópolis?)
SELECT MAX(salario), MIN(salario)
FROM Funcionarios;
WHERE cidade = 'Florianopolis';

-- ITEM 10(nao tem 8) (Qual o horário da última consulta marcada para o dia 13/06/2024?)
SELECT MAX(hora)
FROM Consultas
WHERE data = '2024-06-13';

-- ITEM 11 (Qual a média de idade dos médicos e o total de ambulatórios atendidos por eles?)
SELECT AVG(idade), COUNT(DISTINCT nroa)
FROM Medicos;

-- ITEM 12 (Buscar o código, o nome e o salário líquido dos funcionários. O salário líquido é obtido pela diferença entre o salário cadastrado menos 20% deste mesmo salário)
SELECT codf, nome, salario - salario * 0.20 as sario_liquido
FROM Funcionarios;

-- ITEM 13 (Buscar o nome dos funcionários que terminam com a letra “a”)
SELECT nome
FROM Funcionarios
WHERE nome like'%a';

-- ITEM 14 (Buscar o nome e CPF dos funcionários que não possuam a seqüência “00000” em seus CPFs)
SELECT nome, cpf 
FROM Funcionarios
WHERE cpf not like '%00000%';

-- ITEM 15 (Buscar o nome e a especialidade dos médicos cuja segunda e a última letra de seus nomes seja a letra “o”)
SELECT nome, especialidade 
FROM Medicos
WHERE nome like '_o%o';

-- ITEM 16 (Buscar os códigos e nomes dos pacientes com mais de 25 anos que estão com tendinite, fratura, gripe e sarampo )
SELECT codp, nome
FROM Pacientes
WHERE idade > '25' and doenca in ('tendinite','fratura','gripe','sarampo');

