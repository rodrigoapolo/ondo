
-- mysql -u root -p -P 3307
-- SPTech#2024
-- create user 'api'@'%' identified by 'Sptech#2024';
-- GRANT INSERT ON *.* TO 'api';
-- grant all privileges on *.* to aluno;
-- flush privileges;
-- exit
-- mysql -u api -p -P 3307
-- Sptech#2024
DROP DATABASE ondo;

CREATE DATABASE ondo;

USE ondo;

CREATE TABLE usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
	senha VARCHAR(45) NOT NULL
);

ALTER TABLE usuario ADD COLUMN	tipoUsuario CHAR(10);

select * from usuario;
-- Tabela empresa
CREATE TABLE empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
	cnpj CHAR(14),
    razaoSocial VARCHAR(100),
    nomeFantasia VARCHAR(45),
    cep CHAR(8),
    bairro VARCHAR(45),
    logradouro VARCHAR(100),
	numero VARCHAR(45),
    cidade VARCHAR(100),
    estado VARCHAR(100),
    fkUsuario INT,
    CONSTRAINT fkEmpresaUsuario
    FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario)
);

SELECT * FROM empresa;

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
    tipo VARCHAR(45),
    fkEstufa INT,
    CONSTRAINT fkSensorEstufa 
    FOREIGN KEY (fkEstufa) REFERENCES estufa(idEstufa)
);

-- Tabela temperatura
CREATE TABLE medicao (
    idMedicao INT AUTO_INCREMENT,
    temperatura FLOAT(7,2),
    dataHora DATETIME DEFAULT current_timestamp,
    fkSensor INT,
    CONSTRAINT pkCompostaMedicao PRIMARY KEY(idMedicao, fkSensor),
    FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor)
);

-- Tabela aviso/alerta
CREATE TABLE alerta (
    idAlerta INT AUTO_INCREMENT,
    temperatura DECIMAL(10,2),
    mensagem VARCHAR(200),
    dataHora DATETIME DEFAULT current_timestamp,
    fkSensor INT,
	CONSTRAINT pkCompostAlerta PRIMARY KEY(idAlerta, fkSensor),
    FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor)
);

-- Inserir dados da tabela usuario
INSERT INTO usuario (nome, email, senha) 
VALUES 
('John Doe', 'john.doe@example.com', MD5('senha123')),
('Jane Doe', 'jane.doe@example.com', MD5('senha456')),
('Admin User', 'admin@example.com', MD5('senha789'));

UPDATE usuario set tipoUsuario = 'user'
where idUsuario = 1;
UPDATE usuario set tipoUsuario = 'user'
where idUsuario = 2;
UPDATE usuario set tipoUsuario = 'suporte'
where idUsuario = 3;

SELECT * FROM usuario;

-- Inserir dados na tabela empresa
INSERT INTO empresa (razaoSocial, nomeFantasia, cnpj, cep, numero, logradouro, cidade, estado, fkUsuario) 
VALUES 
('Minato Wasabi LTDA', 'Minato Wasabi', '12345678901234', '12345678', '101', 'Rua Verde', 'São Paulo', 'SP', 1),
('Wasabi Chicara LTDA', 'Wasabi Chicara', '98765432109876', '87654321', '202', 'Avenida Azul', 'Rio de Janeiro', 'RJ', 2),
('Yama Wasabi LTDA', 'Yama Wasabi', '11223344556677', '13579135', '303', 'Rua das Plantas', 'Belo Horizonte', 'MG', 3);

SELECT * FROM empresa;


-- Inserir dados na tabela estufa
INSERT INTO estufa (nome, tamanho, espaco, fkEmpresa) 
VALUES 
('Estufa A', 50.5, 20.75, 1),
('Estufa B', 75.2, 30.90, 1),
('Estufa C', 60.0, 30.0, 2),
('Estufa D', 45.3, 15.60, 3),
('Estufa E', 90.0, 40.0, 2),
('Estufa F', 55.5, 25.0, 3);


SELECT * FROM estufa;

-- Inserir dados na tabela sensor
INSERT INTO sensor (localidade, tipo, fkEstufa) 
VALUES 

('corredor principal', 'temperatura', 1),
('corredor lateral direito', 'temperatura', 1),
('corredor lateral esquerdo', 'temperatura', 1),
('corredor final', 'temperatura', 1),
('corredor 1', 'temperatura', 2),
('corredor 2', 'temperatura', 2),
('corredor A', 'temperatura', 3),
('corredor Azul', 'temperatura', 4);


SELECT * FROM sensor;


-- Inserir dados na tabela temperatura
INSERT INTO medicao (temperatura, dataHora, fkSensor) 
VALUES 
(15.5, '2024-09-01 12:30:00', 1),
(17, '2024-09-01 12:50:00', 1),
(8.1, '2024-09-01 13:30:00', 2),
(8.7, '2024-09-01 13:50:00', 2),
(18.0, '2024-09-02 14:30:00', 3),
(10.8, '2024-09-02 15:30:00', 4);

SELECT * FROM medicao;

-- Inserir dados na tabela aviso
INSERT INTO alerta (temperatura, mensagem, fkSensor) 
VALUES 
(19.0, 'A temperatura exige atenção', 1),
(9.0, 'A temperatura exige atenção', 3),
(5.0, 'Alerta! A temperatura está fora do limite', 3);

SELECT * FROM alerta;

-- criar select para aviso com o nome da estufa
SELECT s.localidade, date(a.dataHora) as 'data', time(dataHora) as hora, a.mensagem
FROM alerta a JOIN sensor s
ON a.fksensor = s.idSensor
JOIN estufa e
ON s.fkEstufa = e.idEstufa
WHERE e.idEstufa = 1 AND a.dataHora >= NOW() - INTERVAL 7 DAY
ORDER BY a.dataHora DESC;

-- Temperatura altual de um estufa
SELECT m.temperatura AS temperatura_atual
FROM medicao AS m JOIN sensor AS s 
ON m.fkSensor = s.idSensor
JOIN estufa AS e ON s.fkEstufa = e.idEstufa
WHERE e.idEstufa = 1
ORDER BY m.dataHora DESC
LIMIT 1;

-- SELECT de temperatura MÁXIMA da ''ESTUFA A'' no ''Corredor principal'' 
SELECT MAX(m.temperatura) AS temperatura_maxima
FROM medicao AS m JOIN sensor AS s 
ON m.fkSensor = s.idSensor
JOIN estufa AS e ON s.fkEstufa = e.idEstufa
WHERE e.idEstufa = 1 AND dataHora >= NOW() - INTERVAL 1 DAY;

select * from medicao;

INSERT INTO medicao (temperatura, dataHora, fkSensor)
VALUES 
    (21.45, '2024-11-15 10:00:00', 1),
	(23.51, '2024-11-15 15:30:00', 1),
    (23.52, '2024-11-15 11:30:00', 1),
	(23.53, '2024-11-13 11:30:00', 1),
    (23.54, '2024-11-14 11:30:00', 1),
    (23.56, '2024-11-14 11:30:00', 1),
    (24.25, '2024-11-14 12:45:00', 1);

    INSERT INTO medicao (temperatura, dataHora, fkSensor)
VALUES 
	(11.45, '2024-11-18 10:00:00', 1),
	(12.11, '2024-11-18 11:30:00', 1),
    (13.62, '2024-11-18 12:30:00', 1),
	(14.23, '2024-11-18 13:30:00', 1),
    (14.34, '2024-11-18 14:30:00', 1),
    (15.46, '2024-11-24 15:30:00', 1),
    (16.75, '2024-11-24 16:45:00', 1),
    (16.45, '2024-11-25 17:00:00', 1),
	(17.11, '2024-11-25 18:30:00', 1),
    (17.62, '2024-11-25 19:30:00', 1),
	(18.23, '2024-11-24 20:30:00', 1),
    (18.34, '2024-11-24 21:30:00', 1),
    (16.46, '2024-11-24 21:40:00', 1),
    (15.75, '2024-11-24 22:45:00', 1),
    (12.45, '2024-11-25 10:00:00', 2),
	(13.11, '2024-11-25 11:30:00', 2),
    (13.62, '2024-11-25 12:30:00', 2),
	(14.23, '2024-11-23 13:30:00', 2),
    (14.34, '2024-11-24 14:30:00', 2),
    (14.46, '2024-11-24 15:30:00', 2),
    (15.75, '2024-11-24 16:45:00', 2),
    (15.45, '2024-11-25 17:00:00', 2),
	(16.11, '2024-11-25 18:30:00', 2),
    (16.62, '2024-11-25 19:30:00', 2),
	(17.23, '2024-11-23 20:30:00', 2),
    (16.34, '2024-11-24 21:30:00', 2),
    (16.46, '2024-11-24 22:30:00', 2),
    (15.75, '2024-11-24 22:45:00', 2),
    (11.45, '2024-11-25 10:00:00', 3),
	(12.11, '2024-11-25 11:30:00', 3),
    (12.62, '2024-11-25 12:30:00', 3),
	(13.23, '2024-11-23 13:30:00', 3),
    (13.34, '2024-11-24 14:30:00', 3),
    (13.46, '2024-11-24 15:30:00', 3),
    (14.75, '2024-11-24 16:45:00', 3),
    (15.75, '2024-11-24 17:45:00', 3),
    (16.45, '2024-11-25 18:00:00', 3),
	(17.11, '2024-11-25 18:30:00', 3),
    (17.62, '2024-11-25 19:30:00', 3),
	(14.23, '2024-11-23 20:30:00', 3),
    (13.34, '2024-11-24 21:30:00', 3),
    (12.46, '2024-11-24 21:35:00', 3),
    (11.45, '2024-11-25 10:00:00', 4),
	(13.11, '2024-11-25 11:30:00', 4),
    (13.62, '2024-11-25 12:30:00', 4),
	(14.23, '2024-11-23 13:30:00', 4),
    (14.34, '2024-11-24 14:30:00', 4),
    (15.46, '2024-11-24 15:30:00', 4),
    (15.75, '2024-11-24 15:45:00', 4),
    (16.75, '2024-11-24 16:45:00', 4),
    (17.75, '2024-11-24 17:45:00', 4),
    (18.45, '2024-11-25 18:00:00', 4),
	(19.11, '2024-11-25 18:30:00', 4),
    (19.62, '2024-11-25 18:40:00', 4),
	(17.23, '2024-11-23 19:30:00', 4),
    (17.34, '2024-11-24 19:40:00', 4),
    (17.46, '2024-11-24 20:30:00', 4),
    (16.75, '2024-11-24 21:45:00', 4);
    
    -- insert a baixo
INSERT INTO alerta (temperatura, mensagem, fkSensor, dataHora) 
VALUES 
	(9.0, 'A temperatura exige atenção', 1, '2024-11-18 09:40:11'),
    (8.0, 'A temperatura exige atenção', 1, '2024-11-18 08:20:11'),
    (7.0, 'A temperatura exige atenção', 1, '2024-11-18 07:45:11'),
    (7.5, 'A temperatura exige atenção', 1, '2024-11-24 07:20:11'),
    (7.5, 'A temperatura exige atenção', 1, '2024-11-24 07:02:11'),
    (7.0, 'A temperatura exige atenção', 1, '2024-11-24 06:40:11'),
	(6.5, 'A temperatura exige atenção', 1, '2024-11-24 06:32:11'),
    (6.5, 'A temperatura exige atenção', 1, '2024-11-25 06:12:11'),
    (6.0, 'A temperatura exige atenção', 1, '2024-11-25 05:45:11'),
	(9.0, 'A temperatura exige atenção', 2, '2024-11-18 09:40:12'),
    (8.0, 'A temperatura exige atenção', 2, '2024-11-18 08:20:12'),
    (7.0, 'A temperatura exige atenção', 2, '2024-11-18 07:45:12'),
    (7.5, 'A temperatura exige atenção', 2, '2024-11-25 07:20:12'),
    (7.5, 'A temperatura exige atenção', 2, '2024-11-25 07:02:12'),
    (7.0, 'A temperatura exige atenção', 2, '2024-11-25 06:40:12'),
	(6.5, 'A temperatura exige atenção', 2, '2024-11-25 06:32:12'),
    (6.5, 'A temperatura exige atenção', 2, '2024-11-25 06:12:12'),
    (6.0, 'A temperatura exige atenção', 2, '2024-11-25 05:45:12'),
    (9.0, 'A temperatura exige atenção', 3, '2024-11-18 09:40:13'),
    (8.0, 'A temperatura exige atenção', 3, '2024-11-18 08:20:13'),
    (7.0, 'A temperatura exige atenção', 3, '2024-11-18 07:45:13'),
    (7.5, 'A temperatura exige atenção', 3, '2024-11-18 07:20:13'),
    (7.5, 'A temperatura exige atenção', 3, '2024-11-24 07:02:13'),
    (7.0, 'A temperatura exige atenção', 3, '2024-11-24 06:40:13'),
	(6.5, 'A temperatura exige atenção', 3, '2024-11-24 06:32:13'),
    (6.5, 'A temperatura exige atenção', 3, '2024-11-25 06:12:13'),
    (6.0, 'A temperatura exige atenção', 3, '2024-11-25 05:45:13'),
	(9.0, 'A temperatura exige atenção', 4, '2024-11-18 09:40:13'),
    (8.0, 'A temperatura exige atenção', 4, '2024-11-18 08:20:13'),
    (7.0, 'A temperatura exige atenção', 4, '2024-11-18 07:45:12'),
    (7.5, 'A temperatura exige atenção', 4, '2024-11-18 07:20:13'),
    (7.5, 'A temperatura exige atenção', 4, '2024-11-24 07:02:11'),
    (7.0, 'A temperatura exige atenção', 4, '2024-11-24 06:40:11'),
	(6.5, 'A temperatura exige atenção', 4, '2024-11-24 06:32:12'),
    (6.5, 'A temperatura exige atenção', 4, '2024-11-25 06:12:16'),
    (6.0, 'A temperatura exige atenção', 4, '2024-11-25 05:45:17'),
    
	(7.0, 'A temperatura exige atenção', 1, '2024-10-25 06:00:00'),
    (5.5, 'A temperatura exige atenção', 1, '2024-10-25 12:00:00'),
    (8.0, 'A temperatura exige atenção', 1, '2024-10-25 18:00:00'),
    (6.3, 'A temperatura exige atenção', 1, '2024-10-26 06:00:00'),
    (5.7, 'A temperatura exige atenção', 1, '2024-10-26 12:00:00'),
    (7.9, 'A temperatura exige atenção', 1, '2024-10-26 18:00:00'),
    (6.8, 'A temperatura exige atenção', 1, '2024-10-27 06:00:00'),
    (4.9, 'A temperatura exige atenção', 1, '2024-10-27 12:00:00'),
    (7.5, 'A temperatura exige atenção', 1, '2024-10-27 18:00:00'),
    (8.2, 'A temperatura exige atenção', 1, '2024-10-28 06:00:00'),
    (6.4, 'A temperatura exige atenção', 1, '2024-10-28 12:00:00'),
    (5.8, 'A temperatura exige atenção', 1, '2024-10-28 18:00:00'),
    (7.7, 'A temperatura exige atenção', 1, '2024-10-29 06:00:00'),
    (5.2, 'A temperatura exige atenção', 1, '2024-10-29 12:00:00'),
    (6.5, 'A temperatura exige atenção', 1, '2024-10-29 18:00:00'),
    (7.8, 'A temperatura exige atenção', 1, '2024-10-30 06:00:00'),
    (6.0, 'A temperatura exige atenção', 1, '2024-10-30 12:00:00'),
    (8.1, 'A temperatura exige atenção', 1, '2024-10-30 18:00:00'),
    (7.3, 'A temperatura exige atenção', 1, '2024-10-31 06:00:00'),
    (5.6, 'A temperatura exige atenção', 1, '2024-10-31 12:00:00'),
    (6.9, 'A temperatura exige atenção', 1, '2024-10-31 18:00:00'),
    (8.0, 'A temperatura exige atenção', 1, '2024-11-01 06:00:00'),
    (6.7, 'A temperatura exige atenção', 1, '2024-11-01 12:00:00'),
    (5.4, 'A temperatura exige atenção', 1, '2024-11-01 18:00:00'),
    (7.6, 'A temperatura exige atenção', 1, '2024-11-02 06:00:00'),
    (6.2, 'A temperatura exige atenção', 1, '2024-11-02 12:00:00'),
    (5.1, 'A temperatura exige atenção', 1, '2024-11-02 18:00:00'),
    (7.2, 'A temperatura exige atenção', 1, '2024-11-03 06:00:00'),
    (6.4, 'A temperatura exige atenção', 1, '2024-11-03 12:00:00'),
    (8.0, 'A temperatura exige atenção', 1, '2024-11-03 18:00:00'),
    (5.3, 'A temperatura exige atenção', 1, '2024-11-04 06:00:00'),
    (6.8, 'A temperatura exige atenção', 1, '2024-11-04 12:00:00'),
    (7.5, 'A temperatura exige atenção', 1, '2024-11-04 18:00:00'),
    (5.9, 'A temperatura exige atenção', 1, '2024-11-05 06:00:00'),
    (6.6, 'A temperatura exige atenção', 1, '2024-11-05 12:00:00'),
    (8.0, 'A temperatura exige atenção', 1, '2024-11-05 18:00:00'),
    (7.0, 'A temperatura exige atenção', 1, '2024-11-06 06:00:00'),
    (6.3, 'A temperatura exige atenção', 1, '2024-11-06 12:00:00'),
    (5.4, 'A temperatura exige atenção', 1, '2024-11-06 18:00:00'),
    (8.2, 'A temperatura exige atenção', 1, '2024-11-07 06:00:00'),
    (7.3, 'A temperatura exige atenção', 1, '2024-11-07 12:00:00'),
    (6.1, 'A temperatura exige atenção', 1, '2024-11-07 18:00:00'),
    (7.8, 'A temperatura exige atenção', 1, '2024-11-08 06:00:00'),
    (5.6, 'A temperatura exige atenção', 1, '2024-11-08 12:00:00'),
    (6.9, 'A temperatura exige atenção', 1, '2024-11-08 18:00:00'),
    (7.4, 'A temperatura exige atenção', 1, '2024-11-09 06:00:00'),
    (6.0, 'A temperatura exige atenção', 1, '2024-11-09 12:00:00'),
    (8.1, 'A temperatura exige atenção', 1, '2024-11-09 18:00:00'),
    
	(6.8, 'A temperatura exige atenção', 1, '2024-11-10 06:00:00'),
    (7.1, 'A temperatura exige atenção', 1, '2024-11-10 12:00:00'),
    (5.2, 'A temperatura exige atenção', 1, '2024-11-10 18:00:00'),
    (7.9, 'A temperatura exige atenção', 1, '2024-11-11 06:00:00'),
    (6.5, 'A temperatura exige atenção', 1, '2024-11-11 12:00:00'),
    (5.4, 'A temperatura exige atenção', 1, '2024-11-11 18:00:00'),
    (7.7, 'A temperatura exige atenção', 1, '2024-11-12 06:00:00'),
    (5.9, 'A temperatura exige atenção', 1, '2024-11-12 12:00:00'),
    (6.6, 'A temperatura exige atenção', 1, '2024-11-12 18:00:00'),
    (8.0, 'A temperatura exige atenção', 1, '2024-11-13 06:00:00'),
    (6.4, 'A temperatura exige atenção', 1, '2024-11-13 12:00:00'),
    (5.7, 'A temperatura exige atenção', 1, '2024-11-13 18:00:00'),
    (7.2, 'A temperatura exige atenção', 1, '2024-11-14 06:00:00'),
    (6.0, 'A temperatura exige atenção', 1, '2024-11-14 12:00:00'),
    (5.5, 'A temperatura exige atenção', 1, '2024-11-14 18:00:00'),
    (8.1, 'A temperatura exige atenção', 1, '2024-11-15 06:00:00'),
    (7.6, 'A temperatura exige atenção', 1, '2024-11-15 12:00:00'),
    (5.8, 'A temperatura exige atenção', 1, '2024-11-15 18:00:00'),
    (7.4, 'A temperatura exige atenção', 1, '2024-11-16 06:00:00'),
    (6.3, 'A temperatura exige atenção', 1, '2024-11-16 12:00:00'),
    (5.9, 'A temperatura exige atenção', 1, '2024-11-16 18:00:00'),
    (6.7, 'A temperatura exige atenção', 1, '2024-11-17 06:00:00'),
    (7.8, 'A temperatura exige atenção', 1, '2024-11-17 12:00:00'),
    (5.6, 'A temperatura exige atenção', 1, '2024-11-17 18:00:00'),
    (7.3, 'A temperatura exige atenção', 1, '2024-11-18 06:00:00'),
    (6.1, 'A temperatura exige atenção', 1, '2024-11-18 12:00:00'),
    (8.0, 'A temperatura exige atenção', 1, '2024-11-18 18:00:00'),
    (7.0, 'A temperatura exige atenção', 1, '2024-11-19 06:00:00'),
    (5.4, 'A temperatura exige atenção', 1, '2024-11-19 12:00:00'),
    (6.5, 'A temperatura exige atenção', 1, '2024-11-19 18:00:00'),
    (8.2, 'A temperatura exige atenção', 1, '2024-11-20 06:00:00'),
    (7.2, 'A temperatura exige atenção', 1, '2024-11-20 12:00:00'),
    (5.3, 'A temperatura exige atenção', 1, '2024-11-20 18:00:00'),
    (7.8, 'A temperatura exige atenção', 1, '2024-11-21 06:00:00'),
    (6.9, 'A temperatura exige atenção', 1, '2024-11-21 12:00:00'),
    (5.7, 'A temperatura exige atenção', 1, '2024-11-21 18:00:00'),
    (6.8, 'A temperatura exige atenção', 1, '2024-11-22 06:00:00'),
    (7.4, 'A temperatura exige atenção', 1, '2024-11-22 12:00:00'),
    (5.2, 'A temperatura exige atenção', 1, '2024-11-22 18:00:00'),
    (7.9, 'A temperatura exige atenção', 1, '2024-11-23 06:00:00'),
    (6.0, 'A temperatura exige atenção', 1, '2024-11-23 12:00:00'),
    (8.0, 'A temperatura exige atenção', 1, '2024-11-23 18:00:00'),
    (7.1, 'A temperatura exige atenção', 1, '2024-11-24 06:00:00'),
    (6.6, 'A temperatura exige atenção', 1, '2024-11-24 12:00:00'),
    (5.9, 'A temperatura exige atenção', 1, '2024-11-24 18:00:00'),
    (7.5, 'A temperatura exige atenção', 1, '2024-11-25 06:00:00'),
    (6.7, 'A temperatura exige atenção', 1, '2024-11-25 12:00:00'),
    (5.8, 'A temperatura exige atenção', 1, '2024-11-25 18:00:00');
    
-- acima
INSERT INTO alerta (temperatura, mensagem, fkSensor, dataHora) 
VALUES 
	(20.0, 'A temperatura exige atenção', 1, '2024-11-18 16:02:12'),
    (21.0, 'A temperatura exige atenção', 1, '2024-11-18 16:22:12'),
    (22.0, 'A temperatura exige atenção', 1, '2024-11-18 17:02:12'),
    (21.5, 'A temperatura exige atenção', 1, '2024-11-18 17:22:12'),
    (21.5, 'A temperatura exige atenção', 1, '2024-11-24 17:32:12'),
    (21.1, 'A temperatura exige atenção', 1, '2024-11-24 17:42:12'),
	(21.9, 'A temperatura exige atenção', 1, '2024-11-25 17:52:12'),
    (21.5, 'A temperatura exige atenção', 1, '2024-11-25 18:02:12'),
    (20.3, 'A temperatura exige atenção', 1, '2024-11-25 18:12:12'),
	(21.3, 'A temperatura exige atenção', 2, '2024-11-25 20:02:12'),
    (21.2, 'A temperatura exige atenção', 2, '2024-11-18 20:12:12'),
    (21.5, 'A temperatura exige atenção', 2, '2024-11-18 20:20:12'),
    (22.0, 'A temperatura exige atenção', 2, '2024-11-18 20:32:12'),
    (22.5, 'A temperatura exige atenção', 2, '2024-11-18 21:10:12'),
    (22.0, 'A temperatura exige atenção', 2, '2024-11-25 21:20:12'),
    (21.5, 'A temperatura exige atenção', 2, '2024-11-25 21:42:12'),
    (20.5, 'A temperatura exige atenção', 2, '2024-11-25 22:02:12'),
    (20.1, 'A temperatura exige atenção', 2, '2024-11-24 22:22:12'),
    (20.0, 'A temperatura exige atenção', 3, '2024-11-24 14:02:12'),
    (21.0, 'A temperatura exige atenção', 3, '2024-11-24 13:02:12'),
    (21.0, 'A temperatura exige atenção', 3, '2024-11-25 12:02:12'),
    (21.5, 'A temperatura exige atenção', 3, '2024-11-25 11:02:12'),
    (21.5, 'A temperatura exige atenção', 3, '2024-11-25 10:02:12'),
    (22.1, 'A temperatura exige atenção', 3, '2024-11-24 15:02:12'),
	(22.9, 'A temperatura exige atenção', 3, '2024-11-24 11:02:12'),
    (22.5, 'A temperatura exige atenção', 3, '2024-11-18 10:02:12'),
    (21.3, 'A temperatura exige atenção', 3, '2024-11-18 15:02:12'),
    (20.0, 'A temperatura exige atenção', 4, '2024-11-25 13:02:12'),
    (20.0, 'A temperatura exige atenção', 4, '2024-11-25 13:02:12'),
    (21.0, 'A temperatura exige atenção', 4, '2024-11-25 14:02:12'),
    (21.5, 'A temperatura exige atenção', 4, '2024-11-24 14:12:12'),
    (22.5, 'A temperatura exige atenção', 4, '2024-11-24 15:02:12'),
    (22.1, 'A temperatura exige atenção', 4, '2024-11-24 15:12:12'),
	(21.9, 'A temperatura exige atenção', 4, '2024-11-18 16:02:12'),
    (21.5, 'A temperatura exige atenção', 4, '2024-11-18 16:12:12'),
    (21.3, 'A temperatura exige atenção', 4, '2024-11-18 17:02:12'),
    
	(20.5, 'A temperatura exige atenção', 1, '2024-10-25 06:00:00'),
    (25.7, 'A temperatura exige atenção', 1, '2024-10-25 12:00:00'),
    (30.2, 'A temperatura exige atenção', 1, '2024-10-25 18:00:00'),
    (22.8, 'A temperatura exige atenção', 1, '2024-10-26 06:00:00'),
    (27.3, 'A temperatura exige atenção', 1, '2024-10-26 12:00:00'),
    (32.1, 'A temperatura exige atenção', 1, '2024-10-26 18:00:00'),
    (21.9, 'A temperatura exige atenção', 1, '2024-10-27 06:00:00'),
    (26.5, 'A temperatura exige atenção', 1, '2024-10-27 12:00:00'),
    (33.0, 'A temperatura exige atenção', 1, '2024-10-27 18:00:00'),
    (23.7, 'A temperatura exige atenção', 1, '2024-10-28 06:00:00'),
    (28.4, 'A temperatura exige atenção', 1, '2024-10-28 12:00:00'),
    (31.5, 'A temperatura exige atenção', 1, '2024-10-28 18:00:00'),
    (24.5, 'A temperatura exige atenção', 1, '2024-10-29 06:00:00'),
    (29.1, 'A temperatura exige atenção', 1, '2024-10-29 12:00:00'),
    (34.7, 'A temperatura exige atenção', 1, '2024-10-29 18:00:00'),
    (20.9, 'A temperatura exige atenção', 1, '2024-10-30 06:00:00'),
    (27.8, 'A temperatura exige atenção', 1, '2024-10-30 12:00:00'),
    (30.6, 'A temperatura exige atenção', 1, '2024-10-30 18:00:00'),
    (22.5, 'A temperatura exige atenção', 1, '2024-10-31 06:00:00'),
    (25.9, 'A temperatura exige atenção', 1, '2024-10-31 12:00:00'),
    (31.7, 'A temperatura exige atenção', 1, '2024-10-31 18:00:00'),
    (21.2, 'A temperatura exige atenção', 1, '2024-11-01 06:00:00'),
    (26.8, 'A temperatura exige atenção', 1, '2024-11-01 12:00:00'),
    (32.3, 'A temperatura exige atenção', 1, '2024-11-01 18:00:00'),
    (23.1, 'A temperatura exige atenção', 1, '2024-11-02 06:00:00'),
    (29.4, 'A temperatura exige atenção', 1, '2024-11-02 12:00:00'),
    (30.8, 'A temperatura exige atenção', 1, '2024-11-02 18:00:00'),
    (22.9, 'A temperatura exige atenção', 1, '2024-11-03 06:00:00'),
    (28.6, 'A temperatura exige atenção', 1, '2024-11-03 12:00:00'),
    (33.2, 'A temperatura exige atenção', 1, '2024-11-03 18:00:00'),
    (20.7, 'A temperatura exige atenção', 1, '2024-11-04 06:00:00'),
    (25.5, 'A temperatura exige atenção', 1, '2024-11-04 12:00:00'),
    (31.9, 'A temperatura exige atenção', 1, '2024-11-04 18:00:00'),
    (24.2, 'A temperatura exige atenção', 1, '2024-11-05 06:00:00'),
    (27.7, 'A temperatura exige atenção', 1, '2024-11-05 12:00:00'),
    (34.1, 'A temperatura exige atenção', 1, '2024-11-05 18:00:00'),
    (22.6, 'A temperatura exige atenção', 1, '2024-11-06 06:00:00'),
    (26.9, 'A temperatura exige atenção', 1, '2024-11-06 12:00:00'),
    (32.5, 'A temperatura exige atenção', 1, '2024-11-06 18:00:00'),
    (21.4, 'A temperatura exige atenção', 1, '2024-11-07 06:00:00'),
    (25.8, 'A temperatura exige atenção', 1, '2024-11-07 12:00:00'),
    (30.3, 'A temperatura exige atenção', 1, '2024-11-07 18:00:00'),
    (24.0, 'A temperatura exige atenção', 1, '2024-11-08 06:00:00'),
    (29.9, 'A temperatura exige atenção', 1, '2024-11-08 12:00:00'),
    (34.0, 'A temperatura exige atenção', 1, '2024-11-08 18:00:00'),
    (23.5, 'A temperatura exige atenção', 1, '2024-11-09 06:00:00'),
    (27.1, 'A temperatura exige atenção', 1, '2024-11-09 12:00:00'),
    (31.0, 'A temperatura exige atenção', 1, '2024-11-09 18:00:00');
    
    INSERT INTO alerta (temperatura, mensagem, fkSensor, dataHora) 
VALUES 
    (22.3, 'A temperatura exige atenção', 1, '2024-11-10 06:00:00'),
    (26.4, 'A temperatura exige atenção', 1, '2024-11-10 12:00:00'),
    (32.7, 'A temperatura exige atenção', 1, '2024-11-10 18:00:00'),
    (23.8, 'A temperatura exige atenção', 1, '2024-11-11 06:00:00'),
    (28.2, 'A temperatura exige atenção', 1, '2024-11-11 12:00:00'),
    (31.9, 'A temperatura exige atenção', 1, '2024-11-11 18:00:00'),
    (21.9, 'A temperatura exige atenção', 1, '2024-11-12 06:00:00'),
    (27.3, 'A temperatura exige atenção', 1, '2024-11-12 12:00:00'),
    (34.2, 'A temperatura exige atenção', 1, '2024-11-12 18:00:00'),
    (24.1, 'A temperatura exige atenção', 1, '2024-11-13 06:00:00'),
    (26.8, 'A temperatura exige atenção', 1, '2024-11-13 12:00:00'),
    (31.5, 'A temperatura exige atenção', 1, '2024-11-13 18:00:00'),
    (23.2, 'A temperatura exige atenção', 1, '2024-11-14 06:00:00'),
    (25.9, 'A temperatura exige atenção', 1, '2024-11-14 12:00:00'),
    (33.1, 'A temperatura exige atenção', 1, '2024-11-14 18:00:00'),
    (22.7, 'A temperatura exige atenção', 1, '2024-11-15 06:00:00'),
    (28.5, 'A temperatura exige atenção', 1, '2024-11-15 12:00:00'),
    (30.4, 'A temperatura exige atenção', 1, '2024-11-15 18:00:00'),
    (24.3, 'A temperatura exige atenção', 1, '2024-11-16 06:00:00'),
    (29.2, 'A temperatura exige atenção', 1, '2024-11-16 12:00:00'),
    (31.7, 'A temperatura exige atenção', 1, '2024-11-16 18:00:00'),
    (23.6, 'A temperatura exige atenção', 1, '2024-11-17 06:00:00'),
    (27.0, 'A temperatura exige atenção', 1, '2024-11-17 12:00:00'),
    (32.8, 'A temperatura exige atenção', 1, '2024-11-17 18:00:00'),
    (21.8, 'A temperatura exige atenção', 1, '2024-11-18 06:00:00'),
    (26.7, 'A temperatura exige atenção', 1, '2024-11-18 12:00:00'),
    (30.9, 'A temperatura exige atenção', 1, '2024-11-18 18:00:00'),
    (24.0, 'A temperatura exige atenção', 1, '2024-11-19 06:00:00'),
    (28.4, 'A temperatura exige atenção', 1, '2024-11-19 12:00:00'),
    (33.5, 'A temperatura exige atenção', 1, '2024-11-19 18:00:00'),
    (23.1, 'A temperatura exige atenção', 1, '2024-11-20 06:00:00'),
    (27.9, 'A temperatura exige atenção', 1, '2024-11-20 12:00:00'),
    (31.4, 'A temperatura exige atenção', 1, '2024-11-20 18:00:00'),
    (22.5, 'A temperatura exige atenção', 1, '2024-11-21 06:00:00'),
    (26.6, 'A temperatura exige atenção', 1, '2024-11-21 12:00:00'),
    (30.2, 'A temperatura exige atenção', 1, '2024-11-21 18:00:00'),
    (24.4, 'A temperatura exige atenção', 1, '2024-11-22 06:00:00'),
    (29.7, 'A temperatura exige atenção', 1, '2024-11-22 12:00:00'),
    (34.0, 'A temperatura exige atenção', 1, '2024-11-22 18:00:00'),
    (21.7, 'A temperatura exige atenção', 1, '2024-11-23 06:00:00'),
    (26.5, 'A temperatura exige atenção', 1, '2024-11-23 12:00:00'),
    (31.6, 'A temperatura exige atenção', 1, '2024-11-23 18:00:00'),
    (22.9, 'A temperatura exige atenção', 1, '2024-11-24 06:00:00'),
    (28.1, 'A temperatura exige atenção', 1, '2024-11-24 12:00:00'),
    (32.3, 'A temperatura exige atenção', 1, '2024-11-24 18:00:00'),
    (24.2, 'A temperatura exige atenção', 1, '2024-11-25 06:00:00'),
    (27.4, 'A temperatura exige atenção', 1, '2024-11-25 12:00:00'),
    (30.8, 'A temperatura exige atenção', 1, '2024-11-25 18:00:00');
    
    
    INSERT INTO medicao (temperatura, dataHora, fkSensor)
VALUES 
    (21.45, '2024-12-01 10:00:00', 1),
	(23.51, '2024-12-01 15:30:00', 1),
    (23.52, '2024-12-01 11:30:00', 1),
	(23.53, '2024-12-02 11:30:00', 1),
    (23.54, '2024-12-02 11:30:00', 1),
    (23.56, '2024-12-02 11:30:00', 1),
    (24.25, '2024-12-02 12:45:00', 1);

INSERT INTO medicao (temperatura, dataHora, fkSensor)
VALUES 
	(11.45, '2024-12-03 10:00:00', 1),
	(12.11, '2024-12-03 11:30:00', 1),
    (13.62, '2024-12-03 12:30:00', 1),
	(14.23, '2024-12-03 13:30:00', 1),
    (14.34, '2024-12-03 14:30:00', 1),
    (15.46, '2024-12-03 15:30:00', 1),
    (16.75, '2024-12-03 16:45:00', 1),
    (16.45, '2024-12-04 17:00:00', 1),
	(17.11, '2024-12-04 18:30:00', 1),
    (17.62, '2024-12-04 19:30:00', 1),
	(18.23, '2024-12-03 20:30:00', 1),
    (18.34, '2024-12-03 21:30:00', 1),
    (16.46, '2024-12-03 21:40:00', 1),
    (15.75, '2024-12-03 22:45:00', 1),
    (12.45, '2024-12-04 10:00:00', 2),
	(13.11, '2024-12-04 11:30:00', 2),
    (13.62, '2024-12-04 12:30:00', 2),
	(14.23, '2024-12-02 13:30:00', 2),
    (14.34, '2024-12-03 14:30:00', 2),
    (14.46, '2024-12-03 15:30:00', 2),
    (15.75, '2024-12-03 16:45:00', 2),
    (15.45, '2024-12-04 17:00:00', 2),
	(16.11, '2024-12-04 18:30:00', 2),
    (16.62, '2024-12-04 19:30:00', 2),
	(17.23, '2024-12-02 20:30:00', 2),
    (16.34, '2024-12-03 21:30:00', 2),
    (16.46, '2024-12-03 22:30:00', 2),
    (15.75, '2024-12-03 22:45:00', 2),
    (11.45, '2024-12-04 10:00:00', 3),
	(12.11, '2024-12-04 11:30:00', 3),
    (12.62, '2024-12-04 12:30:00', 3),
	(13.23, '2024-12-02 13:30:00', 3),
    (13.34, '2024-12-03 14:30:00', 3),
    (13.46, '2024-12-03 15:30:00', 3),
    (14.75, '2024-12-03 16:45:00', 3),
    (15.75, '2024-12-03 17:45:00', 3),
    (16.45, '2024-12-04 18:00:00', 3),
	(17.11, '2024-12-04 18:30:00', 3),
    (17.62, '2024-12-04 19:30:00', 3),
	(14.23, '2024-12-02 20:30:00', 3),
    (13.34, '2024-12-03 21:30:00', 3),
    (12.46, '2024-12-03 21:35:00', 3),
    (11.45, '2024-12-04 10:00:00', 4),
	(13.11, '2024-12-04 11:30:00', 4),
    (13.62, '2024-12-04 12:30:00', 4),
	(14.23, '2024-12-02 13:30:00', 4),
    (14.34, '2024-12-03 14:30:00', 4),
    (15.46, '2024-12-03 15:30:00', 4),
    (15.75, '2024-12-03 15:45:00', 4),
    (16.75, '2024-12-03 16:45:00', 4),
    (17.75, '2024-12-03 17:45:00', 4),
    (18.45, '2024-12-04 18:00:00', 4),
	(19.11, '2024-12-04 18:30:00', 4),
    (19.62, '2024-12-04 18:40:00', 4),
	(17.23, '2024-12-02 19:30:00', 4),
    (17.34, '2024-12-03 19:40:00', 4),
    (17.46, '2024-12-03 20:30:00', 4),
    (16.75, '2024-12-03 21:45:00', 4);

INSERT INTO medicao (temperatura, dataHora, fkSensor)
VALUES 
    -- Sensor 5 - Últimos 7 dias
    (9.0, '2024-11-27 08:30:00', 5),
    (10.5, '2024-11-28 09:30:00', 5),
    (12.3, '2024-11-29 10:30:00', 5),
    (11.8, '2024-11-30 11:30:00', 5),
    (8.9, '2024-12-01 12:30:00', 5),
    (7.4, '2024-12-02 13:30:00', 5),
    (5.2, '2024-12-03 14:30:00', 5),

    -- Sensor 6 - Últimos 7 dias
    (3.0, '2024-11-27 07:33:00', 6),
    (5.6, '2024-11-28 08:33:00', 6),
    (6.2, '2024-11-29 09:33:00', 6),
    (7.5, '2024-11-30 10:33:00', 6),
    (4.8, '2024-12-01 11:33:00', 6),
    (5.1, '2024-12-02 12:33:00', 6),
    (6.7, '2024-12-03 13:33:00', 6);

INSERT INTO alerta (temperatura, mensagem, fkSensor, dataHora)
VALUES 
    -- Sensor 5 - Últimos 7 dias
    (9.3, 'A temperatura exige atenção', 5, '2024-11-27 08:00:00'),
    (10.4, 'A temperatura exige atenção', 5, '2024-11-28 08:30:00'),
    (8.1, 'A temperatura exige atenção', 5, '2024-11-29 09:00:00'),
    (18.2, 'A temperatura exige atenção', 5, '2024-11-30 09:30:00'),
    (19.5, 'A temperatura exige atenção', 5, '2024-12-01 10:00:00'),
    (07.8, 'A temperatura exige atenção', 5, '2024-12-02 10:30:00'),
    (06.7, 'A temperatura exige atenção', 5, '2024-12-03 11:00:00'),

    -- Sensor 6 - Últimos 7 dias
    (22.1, 'A temperatura exige atenção', 6, '2024-11-27 07:00:00'),
    (23.2, 'A temperatura exige atenção', 6, '2024-11-28 07:30:00'),
    (24.4, 'A temperatura exige atenção', 6, '2024-11-29 08:00:00'),
    (25.6, 'A temperatura exige atenção', 6, '2024-11-30 08:30:00'),
    (11.7, 'A temperatura exige atenção', 6, '2024-12-01 09:00:00'),
    (07.8, 'A temperatura exige atenção', 6, '2024-12-02 09:30:00'),
    (05.9, 'A temperatura exige atenção', 6, '2024-12-03 10:00:00');

    
-- SELECT de temperatura MÍNIMA da ''ESTUFA A'' no ''Corredor principal''     
SELECT MIN(m.temperatura) AS temperatura_minima
FROM medicao AS m
JOIN sensor AS s ON m.fkSensor = s.idSensor
JOIN estufa AS e ON s.fkEstufa = e.idEstufa
WHERE e.idEstufa = 1 AND dataHora >= NOW() - INTERVAL 1 DAY;

-- SELECT quantidade de alertas da ''ESTUFA A'' NA SEMANA
SELECT COUNT(a.idAlerta) AS quantidade_alertas
FROM alerta a
JOIN sensor s ON a.fkSensor = s.idSensor
JOIN estufa e ON s.fkEstufa = e.idEstufa
WHERE e.idEstufa = 1 AND a.dataHora >= NOW() - INTERVAL 7 DAY;

-- SELECT quantidade de alertas da empresa A'' NA SEMANA
SELECT COUNT(a.idAlerta) AS quantidade_alertas
FROM alerta a
JOIN sensor s ON a.fkSensor = s.idSensor
JOIN estufa e ON s.fkEstufa = e.idEstufa
WHERE e.fkEmpresa = 1 AND a.dataHora >= NOW() - INTERVAL 7 DAY;

-- mostar a temperatura para o grafico de linha
SELECT m.temperatura, TIME(m.dataHora) AS hora
FROM medicao m JOIN sensor s
ON m.fkSensor = s.idSensor
JOIN estufa e
ON s.fkEstufa = e.idEstufa
WHERE e.idEstufa = 1 AND dataHora >= NOW() - INTERVAL 1 DAY
ORDER BY m.dataHora DESC
LIMIT 10;

-- mostra a quantidade alertas pelo dia
SELECT 
    DATE(a.dataHora) AS dataDia,
    COUNT(a.idAlerta) AS quantidade_alertas
FROM alerta a
JOIN sensor s ON a.fkSensor = s.idSensor
JOIN estufa e ON s.fkEstufa = e.idEstufa
WHERE 
    e.idEstufa = 1 
    AND a.dataHora >= NOW() - INTERVAL 30 DAY 
    AND a.temperatura > 20.0
GROUP BY DATE(a.dataHora)
ORDER BY dataDia;

-- mostra a quantidade de alerta abaixo
SELECT COUNT(a.idAlerta) AS quantidade_alertas
FROM alerta a
JOIN sensor s ON a.fkSensor = s.idSensor
JOIN estufa e ON s.fkEstufa = e.idEstufa
WHERE e.idEstufa = 1 AND a.dataHora >= NOW() - INTERVAL 7 DAY AND temperatura > 9.0;

-- mostra a quantidade de alerta acima
SELECT COUNT(a.idAlerta) AS quantidade_alertas
FROM alerta a
JOIN sensor s ON a.fkSensor = s.idSensor
JOIN estufa e ON s.fkEstufa = e.idEstufa
WHERE e.idEstufa = 1 AND a.dataHora >= NOW() - INTERVAL 7 DAY AND temperatura > 17.0;

-- contar a quantidade de medicao
select count(idMedicao) as total
FROM medicao m JOIN sensor s
ON m.fkSensor = s.idSensor
JOIN estufa e
ON s.fkEstufa = e.idEstufa
WHERE e.idEstufa = 1 AND m.dataHora >= NOW() - INTERVAL 7 DAY;


-- estufas monitoradas
SELECT COUNT(idEstufa) qtdEstufas
FROM estufa
WHERE fkEmpresa = 1;

-- Temperaturas inadequadas
SELECT COUNT(e.idEstufa) as qtdEstufas
FROM estufa e JOIN sensor s
ON e.idEstufa = s.fkEstufa
JOIN medicao m
ON s.idSensor = m.fkSensor
WHERE e.fkEmpresa = 1 AND (m.temperatura > 21 OR m.temperatura < 8) AND m.dataHora >= NOW();

INSERT INTO medicao (temperatura, dataHora, fkSensor)
VALUES 
    (7.0, '2024-11-16 23:00:00', 1),
    (22.45, '2024-11-16 23:00:00', 1);

-- Temperaturas Adequadas
SELECT COUNT(e.idEstufa) as qtdEstufas
FROM estufa e JOIN sensor s
ON e.idEstufa = s.fkEstufa
JOIN medicao m
ON s.idSensor = m.fkSensor
WHERE e.fkEmpresa = 1 AND m.temperatura > 8 AND m.temperatura < 21 AND m.dataHora >= NOW();

SELECT * FROM medicao;
UPDATE medicao
set temperatura = 14
WHERE idMedicao = 14;

-- Para pegar as estufa monitoradas
SELECT idEstufa 
FROM estufa
WHERE fkEmpresa = 1;

SELECT e.idEstufa, e.nome, m.temperatura
FROM estufa e JOIN sensor s
ON e.idEstufa = s.fkEstufa
JOIN medicao m
ON s.idSensor = m.fkSensor
WHERE e.idEstufa = 1
ORDER BY m.dataHora DESC
LIMIT 1;

SELECT m.fkSensor, m.temperatura, m.dataHora, s.localidade
FROM medicao m
JOIN (
    SELECT fkSensor, MAX(dataHora) AS ultimaMedicao
    FROM medicao
    where fkSensor IN((select idSensor from sensor where fkEstufa = 1 ))
    GROUP BY fkSensor
) ultimas ON m.fkSensor = ultimas.fkSensor AND m.dataHora = ultimas.ultimaMedicao
JOIN sensor s
on s.idSensor = m.fkSensor;

select * from medicao where fkSensor IN(1,2);
update medicao 
set dataHora = '2024-11-16 14:00:00'
where idMedicao = 14;

SELECT m.temperatura, TIME(m.dataHora) AS hora
FROM medicao m 
where m.fkSensor = 1 AND dataHora >= NOW() - INTERVAL 1 DAY
ORDER BY m.dataHora DESC
LIMIT 10;

select e.razaoSocial, z.nome, z.idEstufa
FROM empresa as e
JOIN estufa as z
ON e.idEmpresa = z.fkEmpresa
GROUP BY razaoSocial;

SELECT e.razaoSocial, z.nome, z.idEstufa
FROM empresa AS e
JOIN estufa AS z
ON e.idEmpresa = z.fkEmpresa
GROUP BY e.razaoSocial, z.nome, z.idEstufa;

SELECT 
    e.razaoSocial, 
    GROUP_CONCAT(z.nome SEPARATOR ', ') AS estufas,
    GROUP_CONCAT(z.idEstufa SEPARATOR ', ') AS idsEstufas
FROM empresa AS e
JOIN estufa AS z
ON e.idEmpresa = z.fkEmpresa
GROUP BY e.razaoSocial;

SELECT COUNT(e.idEstufa) as qtdEstufas
FROM estufa e JOIN sensor s
ON e.idEstufa = s.fkEstufa
JOIN medicao m
ON s.idSensor = m.fkSensor;
                      
-- estufas adequadas
SELECT COUNT(DISTINCT e.idEstufa) AS quantidadeEstufasAdequadas
FROM estufa e
JOIN sensor s ON e.idEstufa = s.fkEstufa
JOIN medicao m ON s.idSensor = m.fkSensor
WHERE e.fkEmpresa = 1
  AND m.temperatura > 8 
  AND m.temperatura < 21
  AND m.dataHora >= NOW();

-- estufas inadequadas
SELECT COUNT(DISTINCT e.idEstufa) AS quantidadeEstufasInadequadas
FROM estufa e
JOIN sensor s ON e.idEstufa = s.fkEstufa
JOIN medicao m ON s.idSensor = m.fkSensor
WHERE e.fkEmpresa = 1
  AND (m.temperatura < 10 OR m.temperatura > 19)
  AND m.dataHora >= NOW();
