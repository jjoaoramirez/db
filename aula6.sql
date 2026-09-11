-- LIMPEZA
DROP DATABASE IF EXISTS ECOMMERCE;
CREATE DATABASE ECOMMERCE;
USE ECOMMERCE;

-- ======================================================
-- 1. CREATE TABLE - BASE DO ALUNO
-- ======================================================
CREATE TABLE CATEGORIA(
idcategoria int AUTO_INCREMENT PRIMARY KEY,
nome varchar(30) NOT NULL);

CREATE TABLE PRODUTO(
idproduto       int NOT NULL,
nome            varchar(40) NOT NULL,
preco_unitario  decimal(10,2),
estoque         int,
categoria_id    int);

CREATE TABLE CLIENTE(
idcliente int NOT NULL,
nome      varchar(30) NOT NULL,
cpf       varchar(12),
email     varchar(60));

CREATE TABLE PEDIDO(
idpedido int AUTO_INCREMENT PRIMARY KEY,
cliente_id int,
data_pedido date,
total_pedido decimal(10,2));

CREATE TABLE ITEMPEDIDO(
pedido_id int,
produto_id int,
quantidade int,
preco_unitario decimal(10,2));

-- ======================================================
-- 2. ALTER TABLE - CONSTRAINTS
-- ======================================================
ALTER TABLE PRODUTO ADD CONSTRAINT produto_pk PRIMARY KEY (idproduto);
ALTER TABLE PRODUTO ADD CONSTRAINT produto_preco_unitario_ck CHECK (preco_unitario > 0);
ALTER TABLE PRODUTO ADD CONSTRAINT produto_estoque_ck CHECK (estoque >=0);
ALTER TABLE PRODUTO ADD CONSTRAINT categoria_produto_fk FOREIGN KEY (categoria_id) REFERENCES CATEGORIA(idcategoria);

ALTER TABLE CLIENTE ADD CONSTRAINT cliente_pk PRIMARY KEY (idcliente);
ALTER TABLE CLIENTE ADD CONSTRAINT cliente_cpf_uq UNIQUE (cpf);
ALTER TABLE CLIENTE ADD CONSTRAINT cliente_email_uq UNIQUE (email);
ALTER TABLE CLIENTE ADD status varchar(10) DEFAULT 'Ativo';
ALTER TABLE CLIENTE ADD CONSTRAINT cliente_status_ck CHECK (status IN ('Ativo','Inativo'));

ALTER TABLE PEDIDO ADD CONSTRAINT cliente_pedido_fk FOREIGN KEY (cliente_id) REFERENCES CLIENTE(idcliente);

ALTER TABLE ITEMPEDIDO ADD CONSTRAINT pedido_produto_pk PRIMARY KEY (pedido_id, produto_id);
ALTER TABLE ITEMPEDIDO ADD CONSTRAINT pedido_itempedido_fk FOREIGN KEY (pedido_id) REFERENCES PEDIDO(idpedido);
ALTER TABLE ITEMPEDIDO ADD CONSTRAINT produto_itempedido_fk FOREIGN KEY (produto_id) REFERENCES PRODUTO(idproduto);
ALTER TABLE ITEMPEDIDO ADD CONSTRAINT itempedido_quantidade_ck CHECK (quantidade > 0);
ALTER TABLE ITEMPEDIDO ADD CONSTRAINT itempedido_preco_unitario_ck CHECK (preco_unitario > 0);

-- ======================================================
-- 3. INSERT - POPULANDO A BASE PARA O JOIN FUNCIONAR
-- ======================================================

-- INSERT ÚNICO
INSERT INTO CATEGORIA (nome) VALUES ('Periféricos');
-- INSERT MÚLTIPLO
INSERT INTO CATEGORIA (nome) VALUES 
('Eletrônicos'),
('Cadeiras Gamer'),
('Acessórios'),
('Monitores');

-- Agora idcategoria: 1=Periféricos, 2=Eletrônicos, 3=Cadeiras Gamer, 4=Acessórios, 5=Monitores

INSERT INTO PRODUTO VALUES
(1, 'Mouse Gamer RGB', 149.90, 50, 1),
(2, 'Teclado Gamer Mecânico', 299.90, 25, 1),
(3, 'Headset Gamer PRO', 199.90, 8, 1),
(4, 'Cadeira Gamer Thunder', 899.00, 15, 3),
(5, 'Mousepad Gamer XXL', 79.90, 100, 4),
(6, 'Monitor 24pol 144Hz', 1199.90, 12, 5),
(7, 'Notebook Gamer', 4599.90, 5, 2),
(8, 'Webcam Full HD', 189.90, 0, 2),
(9, 'Cadeira Escritório', 450.00, 20, 3),
(10, 'Suporte Monitor', 129.90, 30, 4);

INSERT INTO CLIENTE (idcliente, nome, cpf, email, status) VALUES
(1, 'Ana Silva', '11111111111', 'ana.silva@email.com', 'Ativo'),
(2, 'Bruno Costa', '22222222222', 'bruno.costa@email.com', 'Ativo'),
(3, 'Carla Dias', '33333333333', NULL, 'Inativo'),
(4, 'Diego Souza', '44444444444', 'diego.souza@email.com', 'Ativo'),
(5, 'Eva Lima', '55555555555', 'eva.lima@email.com', 'Ativo');

INSERT INTO PEDIDO (idpedido, cliente_id, data_pedido, total_pedido) VALUES
(1, 1, '2024-11-10', 449.80),
(2, 2, '2024-11-12', 899.00),
(3, 1, '2024-12-01', 1199.90),
(4, 4, '2025-01-15', 4759.70),
(5, 2, '2025-02-20', 209.80);

-- Note: Cliente 3 (Carla) e Cliente 5 (Eva) ainda NÃO têm pedido - proposital para LEFT JOIN
-- Produto 8, 9, 10 ainda NÃO foram vendidos - proposital

INSERT INTO ITEMPEDIDO VALUES
(1, 1, 1, 149.90),
(1, 2, 1, 299.90),
(2, 4, 1, 899.00),
(3, 6, 1, 1199.90),
(4, 7, 1, 4599.90),
(4, 5, 2, 79.90),
(5, 1, 1, 149.90),
(5, 3, 1, 199.90);

SELECT * FROM CLIENTE 
WHERE email IS NOT NULL;

SELECT SUM(ESTOQUE) AS TOTAL_ESTOQUE
FROM PRODUTO;

SELECT SUM(QUANTIDADE) AS QUANTIDADE_TOTAL
FROM ITEMPEDIDO;

SELECT 
	SUM(QUANTIDADE) AS QUANTIDADE_TOTAL_VENDIDA,
    SUM(PRECO_UNITARIO) AS VALOR_TOTAL_UNITARIO,
    SUM(QUANTIDADE * PRECO_UNITARIO) AS VALOR_TOTAL_VENDIDO,
    ROUND(AVG(QUANTIDADE * PRECO_UNITARIO)) AS TICKET_MEDIO,
    MAX(QUANTIDADE * PRECO_UNITARIO) AS MAIOR_VENDA,
    MIN(QUANTIDADE * PRECO_UNITARIO) AS MENOR_VENDA
FROM ITEMPEDIDO;

SELECT COUNT(IDCLIENTE) AS QTDE_CLIENTES,
	   COUNT(EMAIL) AS QTDE_EMAIL,
       SUM(1) AS QTDE_CLIENTES_INCREMENTO
FROM CLIENTE;

SELECT CATEGORIA_ID, SUM(ESTOQUE) AS QTDE_ESTOQUE_CATEGORIA
FROM PRODUTO
GROUP BY CATEGORIA_ID
HAVING QTDE_ESTOQUE_CATEGORIA > 100
ORDER BY QTDE_ESTOQUE_CATEGORIA DESC;

SELECT P.IDPRODUTO, P.NOME AS NOMEPRODUTO, C.IDCATEGORIA, C.NOME AS NOMECATEGORIA
FROM PRODUTO P
		INNER JOIN CATEGORIA C ON P.CATEGORIA_ID = C.IDCATEGORIA;
        
SELECT C.NOME AS NOMECATEGORIA, SUM(ESTOQUE) AS QTDE_ESTOQUE_CATEGORIA
FROM PRODUTO P
		INNER JOIN CATEGORIA C ON P.CATEGORIA_ID = C.IDCATEGORIA
GROUP BY C.NOME;