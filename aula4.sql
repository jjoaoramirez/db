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

-- DML
-- CREATE -> INSERT
-- INSERT INTO nomeTABELA <(coluna(s))> VALUES (valor(es))

INSERT INTO CATEGORIA (nome)
VALUES ('Eletrônicos'); 

SELECT * FROM CATEGORIA;
SELECT idcategoria, nome FROM CATEGORIA;
SELECT nome FROM CATEGORIA;
SELECT nome as nomeCategoria FROM CATEGORIA;

INSERT INTO CATEGORIA (nome)
VALUES ('Alimentos');

INSERT INTO CATEGORIA (nome)
VALUES ('Higiene');

SELECT * FROM CATEGORIA;

INSERT INTO PRODUTO (idProduto, nome, preco_unitario, estoque, categoria_id) 
VALUES (1, 'Impressora', 600.50, 10, 1);

INSERT INTO PRODUTO 
VALUES (2, 'Mouse', 50.00, 20, 1);

INSERT INTO PRODUTO (idProduto, nome, preco_unitario, estoque, categoria_id)
VALUES (3, 'Sabonete', 20.00, 40, 2); 

INSERT INTO PRODUTO (idProduto, nome, preco_unitario, estoque, categoria_id)
VALUES (4, 'Shampoo', 25.00, 30, 2);

INSERT INTO PRODUTO (idProduto, nome, preco_unitario, estoque, categoria_id)
VALUES (5, 'Feijão', 25.00, 30, 1);

SELECT * FROM PRODUTO;

INSERT INTO CLIENTE (idcliente, nome, cpf, email)
VALUES (1, 'Ana', '123', 'ana@gmail.com');

INSERT INTO CLIENTE (idcliente, nome, cpf, email, status)
VALUES (2, 'Maria', '456', 'maria@gmail.com', 'Inativo');

SELECT * FROM CLIENTE;

-- SELECT COM PROJEÇÃO E SELEÇÃO E PROJEÇÃO
SELECT * FROM PRODUTO;
SELECT idproduto as codigo, nome as nomedoproduto, preco_unitario as valor
FROM PRODUTO;

-- SELEÇÃO -> WHERE
-- OPERADORES DE COMPARAÇÃO
SELECT * FROM PRODUTO
WHERE idproduto = 3;

SELECT * FROM PRODUTO
WHERE idproduto != 3;

SELECT * FROM PRODUTO 
WHERE preco_unitario > 100;

SELECT * FROM PRODUTO
WHERE preco_unitario >=  50;

SELECT * FROM PRODUTO 
WHERE preco_unitario >= 25 AND categoria_id = 2;

SELECT * FROM PRODUTO
WHERE preco_unitario >= 50 OR categoria_id = 2;

-- Exibir os produtos onde o preco_unitario esteja entre 10 50

SELECT nome, preco_unitario as valor FROM PRODUTO
WHERE preco_unitario >= 10 AND preco_unitario <= 50;

SELECT * FROM PRODUTO
WHERE preco_unitario BETWEEN 10 AND 50;

-- Strings

SELECT * FROM PRODUTO
WHERE nome = 'Feijão';

-- Inicia com: -> LIKE
SELECT nome, preco_unitario FROM PRODUTO
WHERE NOME LIKE 'F%';

-- Termina com: 
SELECT * FROM PRODUTO
WHERE NOME LIKE '%a';

-- Contém a palavra
SELECT * FROM PRODUTO
WHERE NOME LIKE '%ei%';

SELECT idproduto, nome, preco_unitario * estoque as valor_estoque FROM PRODUTO;

UPDATE PRODUTO
SET preco_unitario = 5.30
WHERE idproduto= 3;

UPDATE PRODUTO
SET preco_unitario = 30.00, estoque = 40
WHERE idproduto = 4;

DELETE FROM CATEGORIA 
WHERE idcategoria = 1;

INSERT INTO CATEGORIA (nome)
VALUES ('Teste');

DELETE FROM CATEGORIA 
WHERE idcategoria = 4;

SELECT * FROM PRODUTO;

SELECT * FROM PEDIDO;

INSERT INTO PEDIDO (cliente_id, data_pedido, total_pedido)
VALUES (1, '2026-08-31', 0);

INSERT INTO PEDIDO (cliente_id, data_pedido, total_pedido)
VALUES (2, '2026-09-01', 0);

SELECT * FROM ITEMPEDIDO;
INSERT INTO ITEMPEDIDO (pedido_id, produto_id, quantidade, preco_unitario)
VALUES (1, 1, 10, 600.50);