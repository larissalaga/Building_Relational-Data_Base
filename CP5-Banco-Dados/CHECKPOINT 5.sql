
/*CHECKPOINT 05 
NOME: Larissa Araújo Gama RM:964996
NOME: Luna Faustino Lima RM:552473
*/

--Criação das tabelas (do arquivo disponibilizado pelo professor)

CREATE TABLE T_RHSTU_AUTENTICA(
    id_autentica NUMERIC ,
    login varchar(100),
    senha varchar(100),
    st_login char(1) check(st_login in ('i', 'a')),
    CONSTRAINT T_RHSTU_AUTENTICA_PK PRIMARY KEY (id_autentica)
);

CREATE TABLE T_RHSTU_TIPO_CONTATO (
    id_tipo_contato NUMERIC(5) ,
    nm_tipo_contato VARCHAR(80) NOT NULL,
    dt_inicio DATE NOT NULL,
    dt_fim DATE,
    CONSTRAINT T_RHSTU_TIPO_CONTATO_PK PRIMARY KEY (id_tipo_contato)
);

CREATE TABLE T_RHSTU_PACIENTE (
    id_paciente NUMERIC(9),
    nm_paciente VARCHAR(80) NOT NULL,
    nr_cpf NUMERIC(12) NOT NULL UNIQUE,
    nr_rg VARCHAR(15) UNIQUE,
    dt_nascimento DATE NOT NULL,
    fl_sexo CHAR(1) NOT NULL,
    ds_escolaridade VARCHAR(40) NOT NULL,
    ds_estado_civil VARCHAR(25) NOT NULL,
    tip_grupo_sanguineo VARCHAR(6) NOT NULL,
    nr_altura NUMERIC(3,2) NOT NULL,
    nr_peso NUMERIC(4,1) NOT NULL,
    id_autentica NUMERIC,
     CONSTRAINT T_RHSTU_PACIENTE_PK PRIMARY KEY (id_paciente), 
     CONSTRAINT T_RHSTU_PACIENTE_FK FOREIGN KEY (id_autentica)
         REFERENCES T_RHSTU_AUTENTICA(id_autentica)
);

CREATE TABLE T_RHSTU_FUNCIONARIO(
    id_funcionario NUMERIC,
    nm_funcionario varchar(255),
    fl_sexo char(1),
    ds_escolaridade varchar(40),
    dt_nascimento date,
    id_autentica NUMERIC NOT NULL, 
    CONSTRAINT T_RHSTU_FUNCIONARIO_FK FOREIGN KEY (id_autentica) 
            REFERENCES T_RHSTU_AUTENTICA(id_autentica),
    CONSTRAINT T_RHSTU_FUNCIONARIO_PK PRIMARY KEY (id_funcionario)
);

CREATE TABLE T_RHSTU_UNID_HOSPITALAR(
    id_unid_hospitalar NUMERIC(9),
    razao_social varchar(80) not null,
    nr_logradouro NUMERIC(7),
    ds_complemento_numero varchar(30),
    ds_ponto_referencia varchar(50),
    dt_cadastro date not null,
    st_unid_hospitalar varchar(10) check(st_unid_hospitalar in ('i', 'a')),
    CONSTRAINT T_RHSTU_UNID_HOSPITALAR_PK PRIMARY KEY (id_unid_hospitalar)
);

CREATE TABLE T_RHSTU_CONSULTA(
    id_consulta NUMERIC ,
    dt_hr_consulta date not null,
    tp_unidade varchar(255) not null,
    tp_modalidade varchar(255),
    id_paciente NUMERIC(9)  not null,
    id_unid_hospitalar NUMERIC(9)  not null,
    tel_central varchar(14),
    CONSTRAINT T_RHSTU_CONSULTA_PK PRIMARY KEY (id_consulta),
    CONSTRAINT T_RHSTU_CONSULTA_PACIENTE_FK FOREIGN KEY (id_paciente) 
        REFERENCES T_RHSTU_PACIENTE(id_paciente),
    CONSTRAINT T_RHSTU_CONSULTA_HOSPITLAR_FK FOREIGN KEY (id_unid_hospitalar) 
        REFERENCES T_RHSTU_UNID_HOSPITALAR(id_unid_hospitalar)
);

CREATE TABLE T_RHSTU_CONTATO_PACIENTE (
    id_contato NUMERIC(9),
    id_paciente NUMERIC(9),
    id_tipo_contato NUMERIC(5)  NOT NULL,
    nm_contato VARCHAR(40) NOT NULL,
    nr_ddi NUMERIC(3),
    nr_ddd NUMERIC(3),
    nr_telefone NUMERIC(10),
    CONSTRAINT T_RHSTU_CONTATO_PACIENTE_PK PRIMARY KEY(id_paciente, id_contato),
    CONSTRAINT T_RHSTU_CONTATO_PACIENTE_FK FOREIGN KEY (id_paciente) 
        REFERENCES T_RHSTU_PACIENTE(id_paciente),
    CONSTRAINT T_RHSTU_CONTATO_PACIENTE_TIPO_CONTATO_FK FOREIGN KEY (id_tipo_contato) 
        REFERENCES T_RHSTU_TIPO_CONTATO(id_tipo_contato) 
);

CREATE TABLE T_RHSTU_ENDERECO_PACIENTE (
    id_endereco NUMERIC(9),
    id_paciente NUMERIC(9) NOT NULL,
    nr_logradouro NUMERIC(7),
    ds_cidade VARCHAR(100),
    ds_complemento_numero VARCHAR(30),
    ds_ponto_referencia VARCHAR(50),
    dt_inicio DATE NOT NULL,
    dt_fim DATE,
    CONSTRAINT T_RHSTU_ENDERECO_PACIENTE_PK PRIMARY KEY( id_endereco),
    CONSTRAINT T_RHSTU_ENDERECO_PACIENTE_FK FOREIGN KEY (id_paciente)
        REFERENCES T_RHSTU_PACIENTE(id_paciente)
);

CREATE TABLE T_RHSTU_FORMA_PAGAMENTO(
    id_forma_pagamento numeric PRIMARY KEY,
    vl_total numeric not null,
    st_forma_pagamento char(1) not null check(st_forma_pagamento in('i', 'a')),
    id_consulta numeric  REFERENCES T_RHSTU_CONSULTA(id_consulta) not null
);

CREATE TABLE  T_RHSTU_FORMA_CONVENIO(
    id_forma_convenio numeric(9) primary key,
    nr_carteira numeric(10),
    nr_trasacao numeric(10),
    dt_trasacao date,
    dt_vencimento date,
    id_forma_pagamento numeric(9) references T_RHSTU_FORMA_PAGAMENTO(id_forma_pagamento) not null
);

CREATE TABLE T_RHSTU_FORMA_PIX(
    id_forma_pix numeric(9)  primary key,
    nr_transacao numeric(10),
    dt_transacao date,
    tp_chave varchar(60),
    id_forma_pagamento numeric(9) references T_RHSTU_FORMA_PAGAMENTO(id_forma_pagamento) not null
);

CREATE TABLE T_RHSTU_FOMRA_CARTAO(
    id_forma_cartao numeric(9)  primary key,
    nr_cartao numeric(36),
    nr_transacao numeric(10),
    dt_transacao date,
    tp_bandeira varchar(60),
    dt_vencimento date,
    id_forma_pagamento numeric(9) references T_RHSTU_FORMA_PAGAMENTO(id_forma_pagamento) not null
);

CREATE TABLE T_RHSTU_EMAIL_PACIENTE(
    id_email numeric(9) primary key,
    id_paciente numeric(9) not null,
    ds_email varchar(100) not null,
    tp_email varchar(20) not null,
    st_email char(1) not null check(st_email in ('i', 'a')),

    FOREIGN KEY (id_paciente) REFERENCES T_RHSTU_PACIENTE(id_paciente)
);

CREATE TABLE T_RHSTU_TELEFONE_PACIENTE(
    id_paciente numeric(9),
    id_telefone numeric(9),
    nr_ddi numeric(3) not null,
    nr_ddd numeric(3) not null,
    nr_telefone numeric(10) not null,
    tp_telefone varchar(20) not null,
    st_telefone char(1) not null check(st_telefone in ('i', 'a')),

    primary key(id_paciente, id_telefone),
    FOREIGN KEY (id_paciente) REFERENCES T_RHSTU_PACIENTE(id_paciente)
);
    
CREATE TABLE T_RHSTU_PLANO_SAUDE(
    id_plano_saude numeric(5) primary key NOT NULL,
    ds_razao_social varchar(70) not null,
    nm_fantasia_plano_saude varchar(80),
    ds_plano_saude varchar(100) not null,
    nr_cnpj numeric(14) not null,
    nm_contato varchar(30),
    ds_telefone varchar(30),
    dt_inicio date not null,
    dt_fim date
);

CREATE TABLE T_RHSTU_PACIENTE_PLANO_SAUDE(
    id_paciente_ps numeric(10) primary key,
    id_paciente numeric(9) not null ,
    id_plano_saude numeric(5) not null,
    nr_carteira_ps numeric(15),       
    dt_inicio date not null,
    dt_fim date,

    FOREIGN KEY (id_paciente) REFERENCES T_RHSTU_PACIENTE(id_paciente),
    FOREIGN KEY (id_plano_saude) REFERENCES T_RHSTU_PLANO_SAUDE(id_plano_saude)
);


--Caso necessario deletar as tabelas
/*DROP TABLE T_RHSTU_PACIENTE_PLANO_SAUDE  ;
DROP TABLE T_RHSTU_PLANO_SAUDE  ;
DROP TABLE T_RHSTU_EMAIL_PACIENTE  ;
DROP TABLE T_RHSTU_TELEFONE_PACIENTE  ;
DROP TABLE T_RHSTU_CONTATO_PACIENTE  ;
DROP TABLE T_RHSTU_ENDERECO_PACIENTE  ;
DROP TABLE T_RHSTU_FORMA_CONVENIO  ;
DROP TABLE T_RHSTU_FORMA_PIX  ;
DROP TABLE T_RHSTU_FOMRA_CARTAO  ;
DROP TABLE T_RHSTU_FORMA_PAGAMENTO  ;
DROP TABLE T_RHSTU_FUNCIONARIO  ;
DROP TABLE T_RHSTU_CONSULTA ;
DROP TABLE T_RHSTU_TIPO_CONTATO  ;
DROP TABLE T_RHSTU_UNID_HOSPITALAR  ;
DROP TABLE T_RHSTU_PACIENTE;
DROP TABLE T_RHSTU_AUTENTICA ;*/


--Criacao das sequencias
CREATE SEQUENCE SEQ_PACIENTE_PLANO_SAUDE;
CREATE SEQUENCE SEQ_PLANO_SAUDE;
CREATE SEQUENCE SEQ_TELEFONE_PACIENTE;
CREATE SEQUENCE SEQ_EMAIL_PACIENTE;
CREATE SEQUENCE SEQ_FORMA_CARTAO;
CREATE SEQUENCE SEQ_FORMA_PIX;
CREATE SEQUENCE SEQ_FORMA_CONVENIO;
CREATE SEQUENCE SEQ_FORMA_PAGAMENTO;
CREATE SEQUENCE SEQ_ENDERECO_PACIENTE;
CREATE SEQUENCE SEQ_CONTATO_PACIENTE;
CREATE SEQUENCE SEQ_CONSULTA;
CREATE SEQUENCE SEQ_UNID_HOSPITALAR;
CREATE SEQUENCE SEQ_FUNCIONARIO;
CREATE SEQUENCE SEQ_PACIENTE;
CREATE SEQUENCE SEQ_TIPO_CONTATO;
CREATE SEQUENCE SEQ_AUTENTICA;


--Caso necessario deletar as sequencias
/* DROP SEQUENCE SEQ_PACIENTE_PLANO_SAUDE;
DROP SEQUENCE SEQ_PLANO_SAUDE;
DROP SEQUENCE SEQ_TELEFONE_PACIENTE;
DROP SEQUENCE SEQ_EMAIL_PACIENTE;
DROP SEQUENCE SEQ_FORMA_CARTAO;
DROP SEQUENCE SEQ_FORMA_PIX;
DROP SEQUENCE SEQ_FORMA_CONVENIO;
DROP SEQUENCE SEQ_FORMA_PAGAMENTO;
DROP SEQUENCE SEQ_ENDERECO_PACIENTE;
DROP SEQUENCE SEQ_CONTATO_PACIENTE;
DROP SEQUENCE SEQ_CONSULTA;
DROP SEQUENCE SEQ_UNID_HOSPITALAR;
DROP SEQUENCE SEQ_FUNCIONARIO;
DROP SEQUENCE SEQ_PACIENTE;
DROP SEQUENCE SEQ_TIPO_CONTATO;
DROP SEQUENCE SEQ_AUTENTICA;*/


-- Duas Inserções de dados em cada Tabela ;

INSERT INTO T_RHSTU_AUTENTICA(id_autentica,login,senha,st_login) 
    VALUES(SEQ_AUTENTICA.nextval,'astolfo@gmail.com','123456','a');
INSERT INTO T_RHSTU_AUTENTICA(id_autentica,login,senha,st_login) 
    VALUES(SEQ_AUTENTICA.nextval,'cleuza@bol.com','654321','i');   
INSERT INTO T_RHSTU_AUTENTICA(id_autentica,login,senha,st_login) 
    VALUES(SEQ_AUTENTICA.nextval,'ritinha@yahoo.com','654321','i');
INSERT INTO T_RHSTU_AUTENTICA(id_autentica,login,senha,st_login) 
    VALUES(SEQ_AUTENTICA.nextval,'orlando@bol.com','654321','i');

INSERT INTO T_RHSTU_TIPO_CONTATO (id_tipo_contato,nm_tipo_contato,dt_inicio,dt_fim)
    VALUES(SEQ_TIPO_CONTATO.nextval,'Filho(a)',to_date('2023-02-28','YYYY-MM-DD'),to_date('2024-04-23','YYYY-MM-DD'));
INSERT INTO T_RHSTU_TIPO_CONTATO (id_tipo_contato,nm_tipo_contato,dt_inicio,dt_fim)
    VALUES(SEQ_TIPO_CONTATO.nextval,'Esposo(a)',to_date('2020-05-02','YYYY-MM-DD'),to_date('2023-11-12','YYYY-MM-DD'));

INSERT INTO T_RHSTU_PACIENTE(id_paciente,nm_paciente,nr_cpf,nr_rg,dt_nascimento,fl_sexo,ds_escolaridade,ds_estado_civil,tip_grupo_sanguineo,nr_altura,nr_peso,id_autentica)
    VALUES(SEQ_PACIENTE.nextval,'Astolfo Dias da Silva',44477733322,'99-666-888',to_date('1960-01-02','YYYY-MM-DD'),'M','Ensino Medio Completo','Viuvo','O-',1.83,78,1);
INSERT INTO T_RHSTU_PACIENTE(id_paciente,nm_paciente,nr_cpf,nr_rg,dt_nascimento,fl_sexo,ds_escolaridade,ds_estado_civil,tip_grupo_sanguineo,nr_altura,nr_peso,id_autentica)
    VALUES(SEQ_PACIENTE.nextval,'Cleuza Mendes Reis',55588811133,'77-444-333',to_date('1986-10-22','YYYY-MM-DD'),'F','Superior Completo','Casada','AB-',1.72,65.7,2);

INSERT INTO T_RHSTU_FUNCIONARIO(id_funcionario,nm_funcionario,fl_sexo,ds_escolaridade,dt_nascimento,id_autentica)
    VALUES(SEQ_FUNCIONARIO.nextval,'Rita Alves','F','Superior Completo',to_date('1978-09-12','YYYY-MM-DD'),3);
INSERT INTO T_RHSTU_FUNCIONARIO(id_funcionario,nm_funcionario,fl_sexo,ds_escolaridade,dt_nascimento,id_autentica)
    VALUES(SEQ_FUNCIONARIO.nextval,'Orlando Rocha','I','Pos Graduacao Completo',to_date('1994-11-05','YYYY-MM-DD'),4);

INSERT INTO T_RHSTU_UNID_HOSPITALAR(id_unid_hospitalar,razao_social,nr_logradouro,ds_complemento_numero,ds_ponto_referencia,dt_cadastro,st_unid_hospitalar)
    VALUES(SEQ_UNID_HOSPITALAR.nextval,'Santa Casa de Misericordia',666,'Rua Santa','Em frente ao 24 Batalhao',to_date('1980-06-25','YYYY-MM-DD'),'a');
INSERT INTO T_RHSTU_UNID_HOSPITALAR(id_unid_hospitalar,razao_social,nr_logradouro,ds_complemento_numero,ds_ponto_referencia,dt_cadastro,st_unid_hospitalar)
    VALUES(SEQ_UNID_HOSPITALAR.nextval,'Hospital da Familia',21,'Rua Alegria','Proximo ao parque',to_date('2005-03-17','YYYY-MM-DD'),'a');

INSERT INTO T_RHSTU_CONSULTA(id_consulta,dt_hr_consulta,tp_unidade,tp_modalidade,id_paciente,id_unid_hospitalar,tel_central)
    VALUES(SEQ_CONSULTA.nextval,to_date('2024-05-13 14:00', 'YYYY-MM-DD HH24:MI'),'Hospital','Ortopedia',1,1,'11-23358844');
INSERT INTO T_RHSTU_CONSULTA(id_consulta,dt_hr_consulta,tp_unidade,tp_modalidade,id_paciente,id_unid_hospitalar,tel_central)
    VALUES(SEQ_CONSULTA.nextval,to_date('2024-06-03 08:00', 'YYYY-MM-DD HH24:MI'),'Hospital','Angiologia',2,2,'11-33776611');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato,id_paciente,id_tipo_contato,nm_contato,nr_ddi,nr_ddd,nr_telefone)
    VALUES(SEQ_CONTATO_PACIENTE.nextval,1,1,'Perpetua Goncalves',055,011,55882266);
INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato,id_paciente,id_tipo_contato,nm_contato,nr_ddi,nr_ddd,nr_telefone)
    VALUES(SEQ_CONTATO_PACIENTE.nextval,2,2,'Sebastiao Reis',055,021,77995511);    

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco,id_paciente,nr_logradouro,ds_cidade,ds_complemento_numero,ds_ponto_referencia,dt_inicio,dt_fim)
    VALUES(SEQ_ENDERECO_PACIENTE.nextval,1,0,'Esmero','Rua dos Bobos','Casa engracada',to_date('2000-02-03','YYYY-MM-DD'),to_date('2024-04-23','YYYY-MM-DD'));
INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco,id_paciente,nr_logradouro,ds_cidade,ds_complemento_numero,ds_ponto_referencia,dt_inicio,dt_fim)
    VALUES(SEQ_ENDERECO_PACIENTE.nextval,2,51,'Felixlandia','Rua Alegre','Perto Circo',to_date('2015-12-11','YYYY-MM-DD'),to_date('2024-04-23','YYYY-MM-DD'));

INSERT INTO T_RHSTU_FORMA_PAGAMENTO(id_forma_pagamento,vl_total,st_forma_pagamento,id_consulta)
    VALUES(SEQ_FORMA_PAGAMENTO.nextval,280,'i',1);
INSERT INTO T_RHSTU_FORMA_PAGAMENTO(id_forma_pagamento,vl_total,st_forma_pagamento,id_consulta)
    VALUES(SEQ_FORMA_PAGAMENTO.nextval,360,'i',2);

INSERT INTO  T_RHSTU_FORMA_CONVENIO(id_forma_convenio,nr_carteira,nr_trasacao,dt_trasacao,dt_vencimento,id_forma_pagamento)
    VALUES(SEQ_FORMA_CONVENIO.nextval,5556661112,1,to_date('2024-05-13','YYYY-MM-DD'),to_date('2024-05-20','YYYY-MM-DD'),1);
INSERT INTO  T_RHSTU_FORMA_CONVENIO(id_forma_convenio,nr_carteira,nr_trasacao,dt_trasacao,dt_vencimento,id_forma_pagamento)
    VALUES(SEQ_FORMA_CONVENIO.nextval,3330004447,2,to_date('2024-06-03','YYYY-MM-DD'),to_date('2024-06-13','YYYY-MM-DD'),2);

INSERT INTO T_RHSTU_FORMA_PIX(id_forma_pix,nr_transacao,dt_transacao,tp_chave,id_forma_pagamento)
    VALUES(SEQ_FORMA_PIX.nextval,3,to_date('2024-05-13','YYYY-MM-DD'),'CPF',1);
INSERT INTO T_RHSTU_FORMA_PIX(id_forma_pix,nr_transacao,dt_transacao,tp_chave,id_forma_pagamento)
    VALUES(SEQ_FORMA_PIX.nextval,4,to_date('2024-06-03','YYYY-MM-DD'),'E-mail',2);

INSERT INTO T_RHSTU_FOMRA_CARTAO(id_forma_cartao,nr_cartao,nr_transacao,dt_transacao,tp_bandeira,dt_vencimento,id_forma_pagamento)
    VALUES(SEQ_FORMA_CARTAO.nextval,5592319040003888,5,to_date('2024-05-13','YYYY-MM-DD'),'VISA',to_date('2026-04-22','YYYY-MM-DD'),1);
INSERT INTO T_RHSTU_FOMRA_CARTAO(id_forma_cartao,nr_cartao,nr_transacao,dt_transacao,tp_bandeira,dt_vencimento,id_forma_pagamento)
    VALUES(SEQ_FORMA_CARTAO.nextval,5432095375280531,6,to_date('2024-06-03','YYYY-MM-DD'),'MASTERCARD',to_date('2024-09-22','YYYY-MM-DD'),2);

INSERT INTO T_RHSTU_EMAIL_PACIENTE(id_email,id_paciente,ds_email,tp_email,st_email)
    VALUES(SEQ_EMAIL_PACIENTE.nextval,1,'astolfo@gmail.com','Pessoal','a');
INSERT INTO T_RHSTU_EMAIL_PACIENTE(id_email,id_paciente,ds_email,tp_email,st_email)
    VALUES(SEQ_EMAIL_PACIENTE.nextval,2,'cleuza@bol.com','Pessoal','a');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE(id_paciente,id_telefone,nr_ddi,nr_ddd,nr_telefone,tp_telefone,st_telefone)
    VALUES(1,SEQ_TELEFONE_PACIENTE.nextval,055,31,999251644,'Celular','a');
INSERT INTO T_RHSTU_TELEFONE_PACIENTE(id_paciente,id_telefone,nr_ddi,nr_ddd,nr_telefone,tp_telefone,st_telefone)
    VALUES(2,SEQ_TELEFONE_PACIENTE.nextval,055,11,999512744,'Celular','a');

INSERT INTO T_RHSTU_PLANO_SAUDE(id_plano_saude,ds_razao_social,nm_fantasia_plano_saude,ds_plano_saude,nr_cnpj,nm_contato,ds_telefone,dt_inicio,dt_fim)
    VALUES(SEQ_PLANO_SAUDE.nextval,'Sul America Serviços de Saude S.A.','Sul America','Especial 101',02866602000151,'Joao de Jesus','0800-722-0504',to_date('2023-06-02','YYYY-MM-DD'),null);
INSERT INTO T_RHSTU_PLANO_SAUDE(id_plano_saude,ds_razao_social,nm_fantasia_plano_saude,ds_plano_saude,nr_cnpj,nm_contato,ds_telefone,dt_inicio,dt_fim)
    VALUES(SEQ_PLANO_SAUDE.nextval,'Bradesco Saúde S/A','Bradesco Saude','Montreal 185',92693118000160,'Maria das Dores','0800-722-5514',to_date('2023-04-02','YYYY-MM-DD'),null);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE(id_paciente_ps,id_paciente,id_plano_saude,nr_carteira_ps,dt_inicio,dt_fim)
    VALUES(SEQ_PACIENTE_PLANO_SAUDE.nextval,1,1,5556661112,to_date('2023-06-02','YYYY-MM-DD'),null);
INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE(id_paciente_ps,id_paciente,id_plano_saude,nr_carteira_ps,dt_inicio,dt_fim)
    VALUES(SEQ_PACIENTE_PLANO_SAUDE.nextval,2,2,3330004447,to_date('2023-01-02','YYYY-MM-DD'),null);


-- Uma Remoção de dados em cada Tabela utilizando o WHERE;

DELETE FROM T_RHSTU_PACIENTE_PLANO_SAUDE WHERE (id_paciente_ps=1);

DELETE FROM T_RHSTU_PLANO_SAUDE WHERE (id_plano_saude=1);

DELETE FROM T_RHSTU_EMAIL_PACIENTE WHERE (id_paciente=1);

DELETE FROM T_RHSTU_TELEFONE_PACIENTE WHERE (id_telefone=1);

DELETE FROM T_RHSTU_CONTATO_PACIENTE WHERE (id_paciente=1);

DELETE FROM T_RHSTU_ENDERECO_PACIENTE WHERE (id_endereco=1);

DELETE FROM T_RHSTU_FORMA_CONVENIO WHERE (id_forma_convenio=1);

DELETE FROM T_RHSTU_FORMA_PIX WHERE (id_forma_pix=1);

DELETE FROM T_RHSTU_FOMRA_CARTAO WHERE (id_forma_cartao=1);

DELETE FROM T_RHSTU_FORMA_PAGAMENTO WHERE (id_consulta=1);

DELETE FROM T_RHSTU_FUNCIONARIO WHERE (id_funcionario=1);

DELETE FROM T_RHSTU_CONSULTA WHERE (id_consulta=1);

DELETE FROM T_RHSTU_TIPO_CONTATO WHERE (id_tipo_contato=1);

DELETE FROM T_RHSTU_UNID_HOSPITALAR WHERE (id_unid_hospitalar=1);

DELETE FROM T_RHSTU_PACIENTE WHERE (id_paciente=1);

DELETE FROM T_RHSTU_AUTENTICA WHERE (id_autentica=1);


--Uma Atualização Simples para a Tabela T_RHSTU_ENDERECO_PACIENTE utilizando o WHERE;

UPDATE T_RHSTU_ENDERECO_PACIENTE SET nr_logradouro = 111, ds_cidade = 'Abracadabra' WHERE id_endereco = 2;


--Uma Atualização Simples para a Tabela T_RHSTU_TELEFONE_PACIENTE utilizando o WHERE;

UPDATE T_RHSTU_TELEFONE_PACIENTE SET tp_telefone = 'Fixo' WHERE id_paciente = 2;


-- Uma Consulta Simples em cada Tabela;

SELECT * FROM T_RHSTU_AUTENTICA;

SELECT * FROM T_RHSTU_TIPO_CONTATO;

SELECT * FROM T_RHSTU_PACIENTE;

SELECT * FROM T_RHSTU_FUNCIONARIO;

SELECT * FROM T_RHSTU_UNID_HOSPITALAR;

SELECT * FROM T_RHSTU_CONSULTA;
   
SELECT * FROM T_RHSTU_CONTATO_PACIENTE;

SELECT * FROM T_RHSTU_ENDERECO_PACIENTE;

SELECT * FROM T_RHSTU_FORMA_PAGAMENTO;

SELECT * FROM T_RHSTU_FORMA_CONVENIO;

SELECT * FROM T_RHSTU_FORMA_PIX;

SELECT * FROM T_RHSTU_FOMRA_CARTAO;

SELECT * FROM T_RHSTU_EMAIL_PACIENTE;

SELECT * FROM T_RHSTU_TELEFONE_PACIENTE;

SELECT * FROM T_RHSTU_PLANO_SAUDE;

SELECT * FROM T_RHSTU_PACIENTE_PLANO_SAUDE;


--Duas Consulta Simples utilizando o WHERE (tabela à escolha do grupo)

SELECT * FROM T_RHSTU_PACIENTE WHERE ds_estado_civil = 'Casada';

SELECT * FROM T_RHSTU_CONTATO_PACIENTE WHERE id_paciente = 2;


--Uma Consulta de Junção para a Tabela T_RHSTU_CONSULTA e suas dependências

SELECT * FROM T_RHSTU_CONSULTA, T_RHSTU_FORMA_PAGAMENTO 
    WHERE T_RHSTU_CONSULTA.id_consulta = T_RHSTU_FORMA_PAGAMENTO.id_consulta;


--Uma Consulta de Junção para a Tabela T_RHSTU_PACIENTE e suas dependências

SELECT * FROM T_RHSTU_PACIENTE 
    JOIN T_RHSTU_CONSULTA ON T_RHSTU_PACIENTE.id_paciente = T_RHSTU_CONSULTA.id_paciente 
    JOIN T_RHSTU_CONTATO_PACIENTE ON T_RHSTU_PACIENTE.id_paciente = T_RHSTU_CONTATO_PACIENTE.id_paciente 
    JOIN T_RHSTU_ENDERECO_PACIENTE ON T_RHSTU_PACIENTE.id_paciente = T_RHSTU_ENDERECO_PACIENTE.id_paciente 
    JOIN T_RHSTU_EMAIL_PACIENTE ON T_RHSTU_PACIENTE.id_paciente = T_RHSTU_EMAIL_PACIENTE.id_paciente 
    JOIN T_RHSTU_TELEFONE_PACIENTE ON T_RHSTU_PACIENTE.id_paciente = T_RHSTU_TELEFONE_PACIENTE.id_paciente 
    JOIN T_RHSTU_PACIENTE_PLANO_SAUDE ON T_RHSTU_PACIENTE.id_paciente = T_RHSTU_PACIENTE_PLANO_SAUDE.id_paciente;



