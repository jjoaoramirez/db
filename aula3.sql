CREATE DATABASE ECOMMERCE;
USE ECOMMERCE;

CREATE TABLE Categoria (
idcategoria int AUTO_INCREMENT PRIMARY KEY,
nome varchar(30) NOT NULL
);

CREATE TABLE Produto (
idproduto int NOT NULL,
nome varchar(30) NOT NULL,
preco_unitario decimal(10, 2), 
estoque int,
categoria_id int 
);

ALTER TABLE PRODUTO ADD CONSTRAINT 
produto_pk PRIMARY KEY (idproduto);

ALTER TABLE PRODUTO ADD CONSTRAINT
produto_preco_unitario_ck CHECK (preco_unitario > 0);

ALTER TABLE PRODUTO ADD CONSTRAINT
produto_estoque_ck CHECK (estoque >= 0);

ALTER TABLE PRODUTO ADD CONSTRAINT 
categoria_produto_fk FOREIGN KEY (categoria_id)
REFERENCES Categoria(idcategoria);

CREATE TABLE Cliente(
idcliente int NOT NULL,
nome varchar(30) NOT NULL,
cpf varchar(12),
email varchar(60)
);

ALTER TABLE CLIENTE ADD CONSTRAINT
cliente_pk PRIMARY KEY (idcliente);

ALTER TABLE CLIENTE ADD CONSTRAINT 
cliente_cpf_uq UNIQUE (cpf);

ALTER TABLE CLIENTE ADD CONSTRAINT 
cliente_email_uq UNIQUE (email);

ALTER TABLE CLIENTE ADD status varchar(10)
DEFAULT 'Ativo';

ALTER TABLE CLIENTE ADD CONSTRAINT 
cliente_status_ck CHECK (status IN ('Ativo', 'Inativo'));

CREATE TABLE Pedido(
idpedido int AUTO_INCREMENT PRIMARY KEY,
cliente_id int,
data_pedido date,
total_pedido decimal(10, 2)
);

ALTER TABLE PEDIDO ADD CONSTRAINT 
pedido_fk FOREIGN KEY (cliente_id)
REFERENCES Cliente(idcliente);

CREATE TABLE ITEMPEDIDO(
pedido_id int,
produto_id int,
quantidade int,
preco_unitario decimal(10, 2)
); 

ALTER TABLE ITEMPEDIDO ADD CONSTRAINT 
pedido_produto_pk PRIMARY KEY (pedido_id, produto_id);

ALTER TABLE ITEMPEDIDO ADD CONSTRAINT 
pedido_itempedido_fk FOREIGN KEY (pedido_id)
REFERENCES PEDIDO(idpedido);

ALTER TABLE ITEMPEDIDO ADD CONSTRAINT 
produto_itempedido_fk FOREIGN KEY (produto_id)
REFERENCES PRODUTO(idproduto);

ALTER TABLE ITEMPEDIDO ADD CONSTRAINT 
itempedido_quantidade_ck CHECK (quantidade > 0);

ALTER TABLE ITEMPEDIDO ADD CONSTRAINT 
itempedido_preco_unitario_ck CHECK (preco_unitario > 0);
