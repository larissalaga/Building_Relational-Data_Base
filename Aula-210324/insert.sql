create database FIAP; -- cria um banco de dados

use fiap; -- selecionando o banco

-- outra forma é CREATE TABLE fiap.aluno

create table aluno(
	ra int primary key,
    nm_aluno varchar(100),
    dt_nascimento date,
    st_aluno char(1) check(st_aluno in("A","I"))
);

drop table aluno;

-- não procedural (para todas as colunas)
insert into aluno values(3,"Cleuza","2000-01-08","A");

-- procedural (informo as colunas que quero mudar)
insert into aluno(ra,nm_aluno) values (2,"Leonardo");

-- consulta simples
select * from aluno;

-- não procedural (vai atualizar todas as linhas da coluna NOME ALUNO)
update aluno set nm_aluno="João";

-- procedural (informo que é para mudar o NOME ALUNO somente desse RA)
update aluno set nm_aluno="João Lima" where ra=1;

-- CENÁRIOS DE ERRO COM INSERT
-- 1- COLUNAS A MENOS (ERROR CODE 1136
insert into aluno values(1,"Sara","2000-01-08");

-- 2- CHAVE PRIMÁRIA DUPLICADA (ERROR CODE 1062)
insert into aluno values(3,"Cleuza","2000-01-08","A");

-- 3- CONSTRAIND CHECK NÃO ATENDE O VALOR PADRÁO (ERROR CODE 4025)
INSERT INTO ALUNO VALUE(3,"Cleuza","2000-01-08","5");

-- 4- TIPO DE DADO INCORRETO PARA A COLUNA (ERROR CODE 1054 E 1366)
INSERT INTO ALUNO VALUE(3,Cleuza,"2000-01-08","A");
INSERT INTO ALUNO VALUE("A3","Cleuza","2000-01-08","A");


-- auto increment: é um contador automático de numerais em inteiro
CREATE TABLE  CONTATO(
	id_contato int primary key auto_increment,
	DDD int not null,
    nr_telefonr int not null,
    ra int REFERENCES ALUNO(ra)
);

INSERT INTO CONTATO VALUES (null, 11, 952486852, 1);

SELECT * FROM CONTATO;

-- CENÁRIOS INCORRETOS
-- Coluna com valor vazio (ERROR CODE 1048) - em razão do NOT NULL
INSERT INTO CONTATO VALUES (null, null, 952486852, 1);

-- VAI DAR PQ O RA NÃO ESTA COMO PRIMARY KEY
INSERT INTO CONTATO VALUES (null, 11, 952486852, 5);