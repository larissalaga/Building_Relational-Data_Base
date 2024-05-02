-- CRIANDO UMA VIEW

CREATE VIEW media_veiculos AS
    select avg(valor) as media, ds_modelo from modelo group by ds_modelo;
    
-- CONSULTANDO UMA VIEW
SELECT * FROM media_veiculos; 

--SUBQUERIE ( OU SUBCONSULTA)
-- marcas que possui o veiculo superiores a 40mil
SELECT ds_marca
    FROM marca
    WHERE id_marca in (select id_marca FROM modelo WHERE valor >40000);
    
-- atualizando marcas que possuem o valor superior a 40 mil
--subquarie com updade
UPDATE modelo 
    set valor = 45000
    WHERE id_marca in (select id_marca FROM modelo WHERE VALOR >40000);
    
select * from modelo;






-- CRIANDO SEQUENCE - NOCYCLE
CREATE SEQUENCE seq_cor
    minvalue 3
    maxvalue 10
    nocycle;

-- CRIANDO SEQUENCE - CYCLE
CREATE SEQUENCE seq_cor2
    minvalue 3
    maxvalue 50
    cycle;
    
--REMOVENDO A SEQUENCE
drop sequence seq_cor;


CREATE TABLE cor_veiculo(
    id_cor int default seq_cor.nextval primary key,
    ds_cor varchar(60)
);

--consultando o valor atual da sequence
select seq_cor.currval from dual;

INSERT INTO COR_VEICULO(ds_cor) VALUES ('VERDE');
INSERT INTO COR_VEICULO(ds_cor) VALUES ('AMARELO');
INSERT INTO COR_VEICULO(ds_cor) VALUES ('VERMELHO');
INSERT INTO COR_VEICULO(ds_cor) VALUES ('PRETO');
INSERT INTO COR_VEICULO(ds_cor) VALUES ('PRATA');
INSERT INTO COR_VEICULO(ds_cor) VALUES ('BRANCO');


INSERT INTO cor_veiculo(id_cor, ds_cor)
    VALUES(seq_cor2.nexval,'LARANJA');
--proximoo valor
select seq_cor.nextval from dual;

select seq_cor2.nextval from dual;

select * from cor_veiculo;
    