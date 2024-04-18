


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


-- CONTINUAR CORREÇÃO
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












