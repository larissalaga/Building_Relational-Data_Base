CREATE TABLE T_ALUNO (
    id_aluno int,
    nm_aluno varchar(100)

);
CREATE TABLE T_ENDERECO (
    cep int primary key,
    nm_rua varchar(100),
    cidade varchar(100)
);

--remover tabela
DROP TABLE T_ALUNO;
-- Meu primeiro comentario
/*Comentario
em
bloco*/