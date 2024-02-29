    CREATE TABLE T_UNV_ALUNO(
            id_aluno int primary key, -- chave primaria
            nm_aluno varchar2(100) not null,
            dt_nascimento date,
            cpf number(11) not null unique,
            sexo char(1) CHECK(sexo="M" OR sexo="F" OR sexo="I")
    );
    CREATE TABLE T_UNV_CURSO(
            id_curso int primary key,
            nm_curso varchar2(100) not null
    );
    CREATE TABLE T_UNV_PROFESSOR(
            id_professor int primary key,
            nm_professor varchar2(100) not null
    );
    CREATE TABLE T_UNV_DISCIPLINA(
            id_disciplina int primary key,
            nm_disciplina varchar2(155) not null,
            ementa varchar2(155),
            ref_bibliografica varchar2(155) not null,
            metodologia varchar2(155) not null,
            carga_horaria int CHECK(carga_horaria>0 AND carga_horaria<200,
            modalidade varchar2(1) CHECK(modadlidade IN("P","R")),
            id_curso int REFERENCES T_UNV_CURSO(id_curso)
            
            
    );
    CREATE TABLE T_UNV_TURMA(
            id_turma int primary key,
            data_criacao date not null,
            nm_turma varchar2(100) not null,
            situacao char check,
            foreign key (t_unv_curso_id_curso) references
    );
  

