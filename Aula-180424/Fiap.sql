-- LOCADORA
-- 1 MARCA PODE TER N MODELOS
-- SEQUENCE AUTOMPATICOS
-- CONTADORES AUTOMÁTICOS

CREATE SEQUENCE SEQ_MARCA;
CREATE SEQUENCE SEQ_MODELO;
-- NEXTVAL: PRÓXIMO VALOR
-- CURVAL: É O VALOR ATUAL

--DEFAULT É A DEFINIÇÃO DE UM VALOR PADRÁO A SER INSERIDO - CASO NÃO SEJA MENCIONADO NO INSET

CREATE TABLE MARCA(
    id_marca int DEFAULT SEQ_MARCA.nextval primary key,
    ds_marca varchar(100) not null
);

CREATE TABLE MODELO(
    id_modelo int DEFAULT SEQ_MODELO.nextval primary key,
    ds_modelo varchar(100) not null,
    cor varchar(30),
    ano date,
    cambio varchar(10) CHECK(cambio IN('AUT','MANUAL','SEMI-AUT')),
    categoria varchar(10) CHECK(categoria IN('HATCH','SEDAN','SUV')),
    id_marca int REFERENCES MARCA(id_marca)
);

INSERT INTO MARCA (ds_marca) VALUES('FIAT');
INSERT INTO MARCA (ds_marca) VALUES('FORD');
INSERT INTO MARCA (ds_marca) VALUES('JEEP');


INSERT INTO MODELO(ds_modelo, cor, ano, cambio, categoria, id_marca)
        VALUES('UNO','VERDE', to_date('2010','YYYY'), 'MANUAL', 'HATCH',1);
INSERT INTO MODELO(ds_modelo, cor, ano, cambio, categoria, id_marca)
        VALUES('SIENA','VERMELHO', to_date('2015','YYYY'), 'MANUAL', 'SEDAN',1);
INSERT INTO MODELO(ds_modelo, cor, ano, cambio, categoria, id_marca)
        VALUES('KA','PRETO', to_date('2018','YYYY'), 'MANUAL', 'HATCH',2);
INSERT INTO MODELO(ds_modelo, cor, ano, cambio, categoria, id_marca)
        VALUES('ECOSPORT','CINZA', to_date('2024','YYYY'), 'AUT', 'SUV',2);
INSERT INTO MODELO(ds_modelo, cor, ano, cambio, categoria, id_marca)
        VALUES('C4','VERDE', to_date('2022','YYYY'), 'AUT', 'SUV',3);
INSERT INTO MODELO(ds_modelo, cor, ano, cambio, categoria, id_marca)
        VALUES('FUSCA','AMARELO', to_date('1970','YYYY'), 'MANUAL', 'HATCH',4);


-- ATUALIZAÇÃO NA FK
UPDATE MODELO SET id_marca=4 WHERE id_modelo=5 or id_modelo=6;
    
    
--DELETE FROM MODELO WHERE ID_MARCA IN('1','2','4');         

SELECT * FROM MODELO;
SELECT * FROM MARCA;

-- CROSS JON
--NÃO ESÁ REALIZANDO JUNÇÃO, APENAS CRUZAMENTO DOS DADOS
SELECT * FROM MARCA, MODELO;

--EQUI JOIN
SELECT * FROM MARCA, MODELO
WHERE marca.id_marca=modelo.id_marca;

--alias (ou apelido)
SELECT * FROM MARCA ma, MODELO md
WHERE ma.id_marca = md.id_marca;
