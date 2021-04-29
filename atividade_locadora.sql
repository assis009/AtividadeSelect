CREATE DATABASE locadora
GO
USE locadora
 
CREATE TABLE filme (
id		INT			NOT NULL,
titulo	VARCHAR(40)	NOT NULL,
ano		INT			NULL		CHECK(ano <= 2021)
PRIMARY KEY(id)
)
GO
CREATE TABLE estrela (
id		INT			NOT NULL,
nome	VARCHAR(50)	NOT NULL
PRIMARY KEY(id)
)
GO
CREATE TABLE cliente (
num_cadastro		INT				NOT NULL,
nome				VARCHAR(70)		NOT NULL,
logradouro			VARCHAR(150)	NOT NULL,
num					INT				NOT NULL	CHECK(num > 0),
cep					CHAR(8)			NULL		CHECK(LEN(cep) = 8)
PRIMARY KEY(num_cadastro)
)
GO
CREATE TABLE dvd (
num					INT			NOT NULL,
data_fabricacao		DATE		NOT NULL CHECK(data_fabricacao <= GETDATE()),
filmeid				INT			NOT NULL,
PRIMARY KEY(num)
)
GO
CREATE TABLE filme_estrela (
filmeid				INT				NOT NULL,
estrelaid			INT				NOT NULL
PRIMARY KEY(filmeid, estrelaid)
FOREIGN KEY(filmeid) REFERENCES filme(id),
FOREIGN KEY(estrelaid) REFERENCES estrela(id)
)
GO
CREATE TABLE locacao (
dvdnum				INT				NOT NULL,
clientenum_cadastro	INT				NOT NULL,
data_locacao		DATE			NOT NULL	DEFAULT(GETDATE()),
data_devolucao		DATE			NOT NULL,
valor				DECIMAL(7,2)	NOT NULL	CHECK(valor > 0.00)
PRIMARY KEY(dvdnum, clientenum_cadastro)
FOREIGN KEY(dvdnum) REFERENCES dvd(num),
FOREIGN KEY(clientenum_cadastro) REFERENCES cliente(num_cadastro),
CONSTRAINT chk_dt CHECK(data_devolucao > data_locacao)
)
 
EXEC sp_help estrela
EXEC sp_help filme
 
ALTER TABLE estrela
ADD nome_real VARCHAR(50) NULL
 
ALTER TABLE filme
ALTER COLUMN titulo VARCHAR(80) NOT NULL
 
INSERT INTO filme VALUES
(1001,'Whiplash',2015),
(1002,'Birdman',2015),
(1003,'Interestelar',2014),
(1004,'A Culpa � das estrelas',2014),
(1005,'Alexandre e o Dia Terr�vel, Horr�vel, Espantoso e Horroroso',2014),
(1006,'Sing',2016)
 
INSERT INTO estrela VALUES
(9901,'Michael Keaton','Michael John Douglas'),
(9902,'Emma Stone','Emily Jean Stone'),
(9903,'Miles Teller',NULL),
(9904,'Steve Carell','Steven John Carell'),
(9905,'Jennifer Garner','Jennifer Anne Garner')
 
INSERT INTO filme_estrela VALUES 
(1002,9901),
(1002,9902),
(1001,9903),
(1005,9904),
(1005,9905)
 
INSERT INTO dvd VALUES 
(10001,'2020-12-02',1001),
(10002,'2019-10-18',1002),
(10003,'2020-04-03',1003),
(10004,'2020-12-02',1001),
(10005,'2019-10-18',1004),
(10006,'2020-04-03',1002),
(10007,'2020-12-02',1005),
(10008,'2019-10-18',1002),
(10009,'2020-04-03',1003)
 
INSERT INTO cliente VALUES
(5501,'Matilde Luz','Rua S�ria',150,'03086040'),
(5502,'Carlos Carreiro','Rua Bartolomeu Aires',1250,'04419110'),
(5503,'Daniel Ramalho','Rua Itajutiba',169,NULL),
(5504,'Roberta Bento','Rua Jayme Von Rosenburg',36,NULL),
(5505,'Rosa Cerqueira','Rua Arnaldo Sim�es Pinto',235,'02917110')
 
INSERT INTO locacao VALUES
(10001,5502,'2021-02-18','2021-02-21',3.50),
(10009,5502,'2021-02-18','2021-02-21',3.50),
(10002,5503,'2021-02-18','2021-02-19',3.50),
(10002,5505,'2021-02-20','2021-02-23',3.00),
(10004,5505,'2021-02-20','2021-02-23',3.00),
(10005,5505,'2021-02-20','2021-02-23',3.00),
(10001,5501,'2021-02-24','2021-02-26',3.50),
(10008,5501,'2021-02-24','2021-02-26',3.50)
 
UPDATE cliente
SET cep = '08411150'
WHERE num_cadastro = 5503
 
UPDATE cliente
SET cep = '02918190'
WHERE num_cadastro = 5504
 
UPDATE locacao
SET valor = 3.25
WHERE data_locacao = '2021-02-18' AND clientenum_cadastro = 5502
 
UPDATE locacao
SET valor = 3.10
WHERE data_locacao = '2021-02-24' AND clientenum_cadastro = 5501
 
UPDATE dvd
SET data_fabricacao = '2019-07-14'
WHERE num = 10005
 
UPDATE estrela
SET nome_real = 'Miles Alexander Teller'
WHERE nome = 'Miles Teller'
 
DELETE filme
WHERE titulo = 'Sing'
 
SELECT * FROM cliente
SELECT * FROM dvd
SELECT * FROM estrela
SELECT * FROM filme
SELECT * FROM filme_estrela
SELECT * FROM locacao

select titulo from filme
where ano = 2014

select id, ano from filme
where  titulo = 'Birdman'

select id, ano from filme
where titulo like '%plash%'

select id, nome, nome_real from estrela
where nome_real like'Steve%'

select filmeid, CONVERT(CHAR(10), GETDATE(), 103) data_fabricacao from dvd
where data_fabricacao > '01-01-2020'


select dvdnum, data_locacao, data_devolucao, valor from locacao
where clientenum_cadastro = '5505'

select logradouro, num, cep from cliente 
where nome like'Matilde%'

select nome_real from estrela
where nome = 'Michael Keaton'

select num_cadastro,nome, logradouro + ' - '+ convert (varchar(10),num) + ' - '+ cep as end_comp from cliente
where num_cadastro >= 5503