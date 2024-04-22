create table Clientes(
    id number(5) primary key,
    nome varchar2(255),
    cidade varchar2(255)
);

create table Pedidos(
    id number(5) primary key,
    cliente_id number(5),
    produto varchar2(255),
    foreign key (cliente_id) references Clientes(id)
);

insert all 
    into Clientes (id, nome, cidade) 
        values (1,'João', 'São Paulo')
    into Clientes (id, nome, cidade)
        values (2,'Maria', 'Rio de Janeiro')
    into Clientes (id, nome, cidade)
        values (3,'Carlos', 'Belo Horizonte')
    into Clientes (id, nome, cidade)
        values (4,'Ana', 'Porto Alegre')
    into Clientes (id, nome, cidade)
        values (5,'Rafael', 'Brasília')
    select * from dual;

select * from Clientes;

insert all 
    into Pedidos (id, cliente_id, produto) 
        values (101,1, 'Celular')
    into Pedidos (id, cliente_id, produto)
        values (102,2, 'Laptop')
    into Pedidos (id, cliente_id, produto)
        values (103,3, 'Tablet')
    into Pedidos (id, cliente_id, produto)
        values (104,4, 'TV')
    into Pedidos (id, cliente_id, produto)
        values (105,5, 'Geladeira')
    select * from dual;
    
insert into Pedidos (id,produto) values (106,'Notebook');
    
select * from Pedidos;

-- cross join
select * from Clientes, Pedidos;

-- inner equi join
select * from Clientes, Pedidos where Pedidos.cliente_id = Clientes.id;

-- apelido em tabelas
select * from Clientes C, Pedidos P where P.cliente_id = C.id;

-- inner join
select C.nome nominho, P.id from Pedidos P inner join Clientes C on P.cliente_id = C.id;

-- left join
select C.nome, P.id from Pedidos P left join Clientes C on P.cliente_id = C.id;

-- right join
select C.nome, P.id from Pedidos P right join Clientes C on P.cliente_id = C.id;


    

