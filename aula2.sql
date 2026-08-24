-- Comandos de DDL

CREATE DATABASE MECANICA;
USE MECANICA;

CREATE TABLE Cliente (
id_cliente int NOT NULL,
nome varchar(30) NOT NULL,
cpf int,
status varchar(10));

ALTER TABLE CLIENTE ADD CONSTRAINT cliente_pk PRIMARY KEY (id_cliente);
ALTER TABLE CLIENTE ADD CONSTRAINT cliente_cpf_uq UNIQUE (cpf);
ALTER TABLE CLIENTE ADD CONSTRAINT cliente_status_ck CHECK (status IN ('Ativo', 'Inativo'));

CREATE TABLE Veiculo (
id_veiculo int NOT NULL,
placa varchar(10) NOT NULL,
ano int,
id_cliente int NOT NULL);

ALTER TABLE VEICULO ADD CONSTRAINT veiculo_pk PRIMARY KEY (id_veiculo);
ALTER TABLE VEICULO ADD CONSTRAINT veiculo_placa_uq UNIQUE (placa);
ALTER TABLE VEICULO ADD CONSTRAINT veiculo_ano_ck CHECK (ano >= 1980);
ALTER TABLE VEICULO ADD CONSTRAINT cliente_veiculo_fk FOREIGN KEY (id_cliente) REFERENCES Cliente (id_cliente);

ALTER TABLE Cliente MODIFY COLUMN Status varchar(10) DEFAULT 'Ativo';

CREATE TABLE ORDEM_SERVICO(
id_os int AUTO_INCREMENT NOT NULL primary key,
id_veiculo int NOT NULL,
valor decimal(10, 2),
status varchar(12) DEFAULT 'Pendente');

ALTER TABLE ORDEM_SERVICO ADD CONSTRAINT id_os PRIMARY KEY (id_os);
ALTER TABLE ORDEM_SERVICO ADD CONSTRAINT veiculo_ordem_servico_fk FOREIGN KEY (id_veiculo) REFERENCES Veiculo (id_veiculo);
ALTER TABLE ORDEM_SERVICO ADD CONSTRAINT valor_ck CHECK (valor > 0);
ALTER TABLE ORDEM_SERVICO ADD CONSTRAINT status_ck CHECK (status IN ('Pendente', 'Em andamento', 'Cancelado', 'Concluida')); 

-- DML -> Linguagem de Manipulação de Dados
-- CRUD - Create, Read, Update, Delete

-- CREATE -> INSERT
-- INSERT INTO TABELA <(Colunas)> VALUES (Valores)

INSERT INTO Cliente (id_cliente, nome, cpf, status) VALUES (1, 'Ana', 123, 'Ativo'); 
INSERT INTO Cliente (id_cliente, nome, cpf) VALUES (2, 'Isabel', 456); 
INSERT INTO Cliente (id_cliente, nome, cpf, status) VALUES (3, 'José', 457, 'Ativo'); 

INSERT INTO Veiculo VALUES (1, 'AAB-2050', 1982, 1);
INSERT INTO Veiculo (id_cliente, id_veiculo, ano, placa) VALUES (2, 2, 1990, 'ABX-4050');
INSERT INTO Veiculo (id_cliente, id_veiculo, ano, placa) VALUES (1, 3, 1990, 'ABX-4051');

SELECT * FROM Veiculo;

INSERT INTO ORDEM_SERVICO(id_veiculo, valor) VALUES (2, 399.99);
INSERT INTO ORDEM_SERVICO(id_veiculo, valor, status) VALUES (2, 1500, 'Pendente');

UPDATE Cliente set status = 'Inativo' WHERE id_cliente = 1;

SELECT * FROM Cliente WHERE id_cliente = 1;

SELECT * FROM ORDEM_SERVICO;

SELECT id_os, valor, valor * 1.10 novo_valor FROM ORDEM_SERVICO;

UPDATE ORDEM_SERVICO set valor = valor * 1.10 WHERE id_os = 2;

SELECT * FROM ORDEM_SERVICO WHERE id_os = 2;

DELETE FROM ORDEM_SERVICO WHERE id_os = 1;

SELECT * FROM ORDEM_SERVICO;