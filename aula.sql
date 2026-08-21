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
