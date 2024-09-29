CREATE DATABASE ondo;

USE ondo;

-- Tabela usuario
CREATE TABLE usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    senha VARCHAR(100)
);

-- Tabela empresa
CREATE TABLE empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    cnpj CHAR(14),
    cep CHAR(8),
    numero VARCHAR(45),
    rua VARCHAR(100),
    cidade VARCHAR(100),
    estado VARCHAR(100),
    pais VARCHAR(100),
    fkUsuario INT,
    CONSTRAINT fkEmpresaUsuario
    FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario)
);

-- Tabela estufa
CREATE TABLE estufa (
    idEstufa INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    tamanho DECIMAL(10,2),
    espaco DECIMAL(10,2),
    fkEmpresa INT,
    CONSTRAINT fkEstufaEmpresa
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

-- Tabela sensor
CREATE TABLE sensor (
    idSensor INT AUTO_INCREMENT PRIMARY KEY,
    localidade VARCHAR(100),
    fkEstufa INT,
    CONSTRAINT fkSensorEstufa
    FOREIGN KEY (fkEstufa) REFERENCES estufa(idEstufa)
);

-- Tabela temperatura
CREATE TABLE temperatura (
    idTemperatura INT AUTO_INCREMENT PRIMARY KEY,
    temperatura FLOAT(7,2),
    dataHora DATETIME,
    fkSensor INT,
    CONSTRAINT fkTemperaturaSensor
    FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor)
);

-- Tabela aviso
CREATE TABLE aviso (
    idAviso INT AUTO_INCREMENT PRIMARY KEY,
    temperatura DECIMAL(10,2),
    mensagem VARCHAR(200),
    fkEmpresa INT,
    CONSTRAINT fkAvisoEmpresa
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);


-- Inserir dados da tabela usuario
INSERT INTO usuario (nome, email, senha) VALUES
('João Silva', 'joao.silva@example.com',  MD5('senha123')),
('Maria Oliveira', 'maria.oliveira@example.com',  MD5('senha456')),
('Pedro Santos', 'pedro.santos@example.com',  MD5('senha789'));

SELECT * FROM usuario;

-- Inserir dados na tabela empresa
INSERT INTO empresa (nome, cnpj, cep, numero, rua, cidade, estado, pais, fkUsuario) VALUES
('Minato Wasabi', '12345678901234', '12345678', '101', 'Rua Verde', 'São Paulo', 'SP', 'Brasil', 1),
('Wasabi Chicara', '98765432109876', '87654321', '202', 'Avenida Azul', 'Rio de Janeiro', 'RJ', 'Brasil', 2),
('Yama Wasabi', '11223344556677', '13579135', '303', 'Rua das Plantas', 'Belo Horizonte', 'MG', 'Brasil', 3);

SELECT * FROM empresa;

-- Inserir dados na tabela estufa
INSERT INTO estufa (nome, tamanho, espaco, fkEmpresa) VALUES
('Estufa A', 50.5, 20.75, 1),
('Estufa B', 75.2, 30.90, 1),
('Estufa C', 60.0, 30.0, 2),
('Estufa D', 45.3, 15.60, 3);

SELECT * FROM estufa;

-- Inserir dados na tabela sensor
INSERT INTO sensor (localidade, fkEstufa) VALUES
('corredor principal', 1),
('corredor entrada', 1),
('corredor 1', 2),
('corredor A', 3),
('corredor Azul', 4);

SELECT * FROM sensor;

-- Inserir dados na tabela temperatura
INSERT INTO temperatura (temperatura, dataHora, fkSensor) VALUES
('15.5', '2024-09-01 12:30:00', 1),
('8.1', '2024-09-01 13:30:00', 2),
('18.0', '2024-09-02 14:30:00', 3),
('10.8', '2024-09-02 15:30:00', 4),
('13.7', '2024-09-02 16:30:00', 5);

SELECT * FROM temperatura;

-- Inserir dados na tabela aviso
INSERT INTO aviso (temperatura, mensagem, fkEmpresa) VALUES
(19.0, 'A temperatura exige atenção. na Estufa A', 1),
(9.0, 'A temperatura exige atenção na Estufa', 2),
(5.0, 'Alerta! A temperatura está fora do limite.', 3);

SELECT * FROM aviso;


-- criar select para aviso com o nome da estufa


