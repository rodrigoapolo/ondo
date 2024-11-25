
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
    (6.0, 'A temperatura exige atenção', 4, '2024-11-25 05:45:17');
    
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
    (21.3, 'A temperatura exige atenção', 4, '2024-11-18 17:02:12');
    
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

select * from alerta;
    
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


select * from medicao;

select * from alerta;