
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
('Estufa F', 55.5, 25.0, 3),
('Estufa G', 70.0, 35.0, 4),
('Estufa H', 85.3, 50.0, 4),
('Estufa I', 40.0, 20.0, 5),
('Estufa J', 65.0, 30.0, 5),
('Estufa K', 72.0, 32.5, 1),
('Estufa L', 68.5, 28.0, 3),
('Estufa M', 95.0, 45.0, 2),
('Estufa N', 80.0, 40.0, 1),
('Estufa O', 50.0, 20.0, 3),
('Estufa P', 60.5, 30.5, 4),
('Estufa Q', 85.0, 42.5, 5),
('Estufa R', 47.0, 18.0, 3),
('Estufa S', 78.5, 36.5, 2),
('Estufa T', 100.0, 50.0, 5),
('Estufa U', 64.5, 28.5, 4),
('Estufa V', 93.0, 45.0, 1),
('Estufa W', 88.0, 40.0, 2),
('Estufa X', 70.0, 35.0, 4),
('Estufa Y', 55.0, 25.5, 3),
('Estufa Z', 75.0, 32.0, 1);

SELECT * FROM estufa;


-- Inserir dados na tabela sensor
INSERT INTO sensor (localidade, tipo, fkEstufa) 
VALUES 
('corredor principal', 'temperatura', 1),
('corredor lateral esquerdo', 'temperatura', 1),
('corredor lateral direito', 'temperatura', 1),
('corredor 1', 'temperatura', 2),
('corredor 2', 'temperatura', 2),
('corredor A', 'temperatura', 3),
('corredor B', 'temperatura', 3),
('corredor Verde', 'temperatura', 4),
('corredor Azul', 'temperatura', 4),
('entrada', 'umidade', 5),
('saida', 'temperatura', 5),
('zona norte', 'temperatura', 6),
('zona sul', 'temperatura', 6),
('corredor leste', 'temperatura', 7),
('corredor oeste', 'temperatura', 7),
('área 1', 'temperatura', 8),
('área 2', 'temperatura', 8),
('corredor superior', 'temperatura', 9),
('corredor inferior', 'temperatura', 9),
('setor central', 'temperatura', 10),
('setor periférico', 'temperatura', 10),
('entrada principal', 'temperatura', 11),
('corredor lateral', 'temperatura', 11),
('zona A', 'temperatura', 12),
('zona B', 'temperatura', 12),
('corredor C', 'temperatura', 13),
('corredor D', 'temperatura', 13),
('área 1', 'temperatura', 14),
('área 2', 'temperatura', 14),
('entrada leste', 'temperatura', 15),
('saída oeste', 'temperatura', 15),
('setor vermelho', 'temperatura', 16),
('setor azul', 'temperatura', 16),
('área nova', 'temperatura', 17),
('área antiga', 'temperatura', 17),
('corredor interno', 'temperatura', 18),
('corredor externo', 'temperatura', 18),
('zona superior', 'temperatura', 19),
('zona inferior', 'temperatura', 19),
('área verde', 'temperatura', 20),
('área amarela', 'temperatura', 20),
('corredor alfa', 'temperatura', 21),
('corredor beta', 'temperatura', 21),
('setor 1', 'temperatura', 22),
('setor 2', 'temperatura', 22),
('área de controle', 'temperatura', 23),
('área de teste', 'temperatura', 23),
('entrada oeste', 'temperatura', 24),
('saída leste', 'temperatura', 24),
('área técnica', 'temperatura', 25),
('área comum', 'temperatura', 25),
('corredor nova zona', 'temperatura', 26),
('corredor experimental', 'temperatura', 26);

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

INSERT INTO medicao (temperatura, dataHora, fkSensor)
VALUES 
    (21.45, '2024-11-15 10:00:00', 1),
	(23.51, '2024-11-15 15:30:00', 1),
    (23.52, '2024-11-15 11:30:00', 1),
	(23.53, '2024-11-13 11:30:00', 1),
    (23.54, '2024-11-14 11:30:00', 1),
    (23.56, '2024-11-14 11:30:00', 1),
    (24.25, '2024-11-14 12:45:00', 1);

    
    
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
-- insert a baixo
INSERT INTO alerta (temperatura, mensagem, fkSensor, dataHora) 
VALUES 
	(9.0, 'A temperatura exige atenção', 1, '2024-11-23 14:02:12'),
    (8.0, 'A temperatura exige atenção', 1, '2024-11-23 13:02:12'),
    (7.0, 'A temperatura exige atenção', 1, '2024-11-23 12:02:12'),
    (9.5, 'A temperatura exige atenção', 1, '2024-11-22 11:02:12'),
    (8.5, 'A temperatura exige atenção', 1, '2024-11-22 10:02:12'),
    (15.0, 'A temperatura exige atenção', 1, '2024-11-22 15:02:12'),
	(9.5, 'A temperatura exige atenção', 1, '2024-11-21 11:02:12'),
    (8.5, 'A temperatura exige atenção', 1, '2024-11-21 10:02:12'),
    (15.0, 'A temperatura exige atenção', 1, '2024-11-21 15:02:12'),
	(9.0, 'A temperatura exige atenção', 2, '2024-11-23 09:02:12'),
    (8.0, 'A temperatura exige atenção', 2, '2024-11-23 08:02:12'),
    (7.0, 'A temperatura exige atenção', 2, '2024-11-23 08:30:12'),
    (9.5, 'A temperatura exige atenção', 2, '2024-11-22 09:02:12'),
    (8.5, 'A temperatura exige atenção', 2, '2024-11-22 10:00:12'),
    (15.0, 'A temperatura exige atenção', 2, '2024-11-22 10:10:12'),
    (8.5, 'A temperatura exige atenção', 2, '2024-11-21 18:02:12'),
    (8.5, 'A temperatura exige atenção', 2, '2024-11-21 19:02:12'),
    (8.5, 'A temperatura exige atenção', 2, '2024-11-21 20:02:12');

-- acima
INSERT INTO alerta (temperatura, mensagem, fkSensor, dataHora) 
VALUES 
	(20.0, 'A temperatura exige atenção', 1, '2024-11-23 14:02:12'),
    (21.0, 'A temperatura exige atenção', 1, '2024-11-23 13:02:12'),
    (22.0, 'A temperatura exige atenção', 1, '2024-11-23 12:02:12'),
    (20.5, 'A temperatura exige atenção', 1, '2024-11-22 11:02:12'),
    (21.5, 'A temperatura exige atenção', 1, '2024-11-22 10:02:12'),
    (20.1, 'A temperatura exige atenção', 1, '2024-11-22 15:02:12'),
	(21.9, 'A temperatura exige atenção', 1, '2024-11-21 11:02:12'),
    (22.5, 'A temperatura exige atenção', 1, '2024-11-21 10:02:12'),
    (20.3, 'A temperatura exige atenção', 1, '2024-11-21 15:02:12'),
	(21.3, 'A temperatura exige atenção', 2, '2024-11-23 09:02:12'),
    (20.2, 'A temperatura exige atenção', 2, '2024-11-23 08:02:12'),
    (21.5, 'A temperatura exige atenção', 2, '2024-11-23 08:30:12'),
    (20.0, 'A temperatura exige atenção', 2, '2024-11-22 09:02:12'),
    (20.5, 'A temperatura exige atenção', 2, '2024-11-22 10:00:12'),
    (21.0, 'A temperatura exige atenção', 2, '2024-11-22 10:10:12'),
    (22.5, 'A temperatura exige atenção', 2, '2024-11-21 18:02:12'),
    (20.5, 'A temperatura exige atenção', 2, '2024-11-21 19:02:12'),
    (22.1, 'A temperatura exige atenção', 2, '2024-11-21 20:02:12');
    
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

INSERT INTO medicao (temperatura, dataHora, fkSensor) 
VALUES 

(11.5, '2024-09-02 16:00:00', 5),
(12.3, '2024-09-02 16:30:00', 5),
(19.8, '2024-09-02 17:00:00', 6),
(20.5, '2024-09-02 17:30:00', 6),
(12.0, '2024-09-03 10:00:00', 7),
(13.4, '2024-09-03 10:30:00', 7),
(13.1, '2024-09-03 11:00:00', 8),
(14.7, '2024-09-03 11:30:00', 8),
(15.8, '2024-09-03 12:00:00', 9),
(16.2, '2024-09-03 12:30:00', 9),
(10.3, '2024-09-04 08:00:00', 10),
(11.9, '2024-09-04 08:30:00', 10),
(19.5, '2024-09-04 09:00:00', 11),
(20.8, '2024-09-04 09:30:00', 11),
(14.7, '2024-09-04 14:00:00', 12),
(15.2, '2024-09-04 14:30:00', 12),
(10.9, '2024-09-04 15:00:00', 13),
(11.3, '2024-09-04 15:30:00', 13),
(12.4, '2024-09-05 16:00:00', 14),
(13.6, '2024-09-05 16:30:00', 14),
(18.1, '2024-09-05 17:00:00', 15),
(19.2, '2024-09-05 17:30:00', 15),
(14.0, '2024-09-05 18:00:00', 16),
(15.5, '2024-09-05 18:30:00', 16),
(16.8, '2024-09-06 08:00:00', 17),
(17.3, '2024-09-06 08:30:00', 17),
(13.7, '2024-09-06 09:00:00', 18),
(14.5, '2024-09-06 09:30:00', 18),
(11.7, '2024-09-06 10:00:00', 19),
(12.2, '2024-09-06 10:30:00', 19),
(20.0, '2024-09-06 11:00:00', 20),
(20.6, '2024-09-06 11:30:00', 20),
(15.3, '2024-09-07 12:00:00', 21),
(16.4, '2024-09-07 12:30:00', 21),
(12.9, '2024-09-07 13:00:00', 22),
(13.8, '2024-09-07 13:30:00', 22),
(18.6, '2024-09-07 14:00:00', 23),
(19.4, '2024-09-07 14:30:00', 23),
(14.7, '2024-09-07 15:00:00', 24),
(15.6, '2024-09-07 15:30:00', 24),
(11.1, '2024-09-07 16:00:00', 25),
(12.0, '2024-09-07 16:30:00', 25),
(19.0, '2024-09-07 17:00:00', 26),
(19.8, '2024-09-07 17:30:00', 26);


INSERT INTO alerta (temperatura, mensagem, fkSensor, dataHora) 
VALUES 
    (7.5, 'A temperatura exige atenção', 1, '2024-11-23 14:02:12'),
    (5.2, 'A temperatura exige atenção', 1, '2024-11-23 15:02:12'),
    (6.8, 'A temperatura exige atenção', 2, '2024-11-23 16:02:12'),
    (4.9, 'A temperatura exige atenção', 2, '2024-11-23 17:02:12'),
    (7.0, 'A temperatura exige atenção', 3, '2024-11-23 18:02:12'),
    (6.3, 'A temperatura exige atenção', 3, '2024-11-23 19:02:12'),
    (6.9, 'A temperatura exige atenção', 4, '2024-11-23 20:02:12'),
    (5.0, 'A temperatura exige atenção', 4, '2024-11-23 21:02:12'),
    (7.2, 'A temperatura exige atenção', 5, '2024-11-23 22:02:12'),
    (5.8, 'A temperatura exige atenção', 5, '2024-11-23 23:02:12'),
    (6.6, 'A temperatura exige atenção', 6, '2024-11-24 00:02:12'),
    (4.5, 'A temperatura exige atenção', 6, '2024-11-24 01:02:12'),
    (7.3, 'A temperatura exige atenção', 7, '2024-11-24 02:02:12'),
    (6.2, 'A temperatura exige atenção', 7, '2024-11-24 03:02:12'),
    (6.0, 'A temperatura exige atenção', 8, '2024-11-24 04:02:12'),
    (4.8, 'A temperatura exige atenção', 8, '2024-11-24 05:02:12'),
    (6.7, 'A temperatura exige atenção', 9, '2024-11-24 06:02:12'),
    (5.4, 'A temperatura exige atenção', 9, '2024-11-24 07:02:12'),
    (7.9, 'A temperatura exige atenção', 10, '2024-11-24 08:02:12'),
    (5.1, 'A temperatura exige atenção', 10, '2024-11-24 09:02:12'),
    (6.4, 'A temperatura exige atenção', 11, '2024-11-24 10:02:12'),
    (5.3, 'A temperatura exige atenção', 11, '2024-11-24 11:02:12'),
    (6.5, 'A temperatura exige atenção', 12, '2024-11-24 12:02:12'),
    (4.7, 'A temperatura exige atenção', 12, '2024-11-24 13:02:12'),
    (6.1, 'A temperatura exige atenção', 13, '2024-11-24 14:02:12'),
    (5.0, 'A temperatura exige atenção', 13, '2024-11-24 15:02:12'),
    (7.8, 'A temperatura exige atenção', 14, '2024-11-24 16:02:12'),
    (5.6, 'A temperatura exige atenção', 14, '2024-11-24 17:02:12'),
    (6.2, 'A temperatura exige atenção', 15, '2024-11-24 18:02:12'),
    (4.9, 'A temperatura exige atenção', 15, '2024-11-24 19:02:12'),
    (7.7, 'A temperatura exige atenção', 16, '2024-11-24 20:02:12'),
    (5.2, 'A temperatura exige atenção', 16, '2024-11-24 21:02:12'),
    (6.3, 'A temperatura exige atenção', 17, '2024-11-24 22:02:12'),
    (4.4, 'A temperatura exige atenção', 17, '2024-11-24 23:02:12'),
    (6.9, 'A temperatura exige atenção', 18, '2024-11-25 00:02:12'),
    (4.6, 'A temperatura exige atenção', 18, '2024-11-25 01:02:12'),
    (6.0, 'A temperatura exige atenção', 19, '2024-11-25 02:02:12'),
    (5.0, 'A temperatura exige atenção', 19, '2024-11-25 03:02:12'),
    (7.5, 'A temperatura exige atenção', 20, '2024-11-25 04:02:12'),
    (6.2, 'A temperatura exige atenção', 20, '2024-11-25 05:02:12'),
    (7.1, 'A temperatura exige atenção', 21, '2024-11-25 06:02:12'),
    (4.8, 'A temperatura exige atenção', 21, '2024-11-25 07:02:12'),
    (6.6, 'A temperatura exige atenção', 22, '2024-11-25 08:02:12'),
    (5.1, 'A temperatura exige atenção', 22, '2024-11-25 09:02:12'),
    (6.8, 'A temperatura exige atenção', 23, '2024-11-25 10:02:12'),
    (5.0, 'A temperatura exige atenção', 23, '2024-11-25 11:02:12'),
    (6.9, 'A temperatura exige atenção', 24, '2024-11-25 12:02:12'),
    (4.5, 'A temperatura exige atenção', 24, '2024-11-25 13:02:12'),
    (7.4, 'A temperatura exige atenção', 25, '2024-11-25 14:02:12'),
    (5.3, 'A temperatura exige atenção', 25, '2024-11-25 15:02:12'),
    (7.6, 'A temperatura exige atenção', 26, '2024-11-25 16:02:12'),
    (5.7, 'A temperatura exige atenção', 26, '2024-11-25 17:02:12');


INSERT INTO alerta (temperatura, mensagem, fkSensor, dataHora) 
VALUES 
    (25.3, 'A temperatura exige atenção', 1, '2024-11-23 14:02:12'),
    (28.7, 'A temperatura exige atenção', 1, '2024-11-23 15:02:12'),
    (24.5, 'A temperatura exige atenção', 2, '2024-11-23 16:02:12'),
    (27.2, 'A temperatura exige atenção', 2, '2024-11-23 17:02:12'),
    (22.8, 'A temperatura exige atenção', 3, '2024-11-23 18:02:12'),
    (29.1, 'A temperatura exige atenção', 3, '2024-11-23 19:02:12'),
    (23.4, 'A temperatura exige atenção', 4, '2024-11-23 20:02:12'),
    (26.9, 'A temperatura exige atenção', 4, '2024-11-23 21:02:12'),
    (25.7, 'A temperatura exige atenção', 5, '2024-11-23 22:02:12'),
    (28.0, 'A temperatura exige atenção', 5, '2024-11-23 23:02:12'),
    (22.6, 'A temperatura exige atenção', 6, '2024-11-24 00:02:12'),
    (29.5, 'A temperatura exige atenção', 6, '2024-11-24 01:02:12'),
    (23.9, 'A temperatura exige atenção', 7, '2024-11-24 02:02:12'),
    (28.4, 'A temperatura exige atenção', 7, '2024-11-24 03:02:12'),
    (26.3, 'A temperatura exige atenção', 8, '2024-11-24 04:02:12'),
    (21.9, 'A temperatura exige atenção', 8, '2024-11-24 05:02:12'),
    (27.5, 'A temperatura exige atenção', 9, '2024-11-24 06:02:12'),
    (24.1, 'A temperatura exige atenção', 9, '2024-11-24 07:02:12'),
    (28.8, 'A temperatura exige atenção', 10, '2024-11-24 08:02:12'),
    (21.4, 'A temperatura exige atenção', 10, '2024-11-24 09:02:12'),
    (26.7, 'A temperatura exige atenção', 11, '2024-11-24 10:02:12'),
    (22.5, 'A temperatura exige atenção', 11, '2024-11-24 11:02:12'),
    (28.2, 'A temperatura exige atenção', 12, '2024-11-24 12:02:12'),
    (23.3, 'A temperatura exige atenção', 12, '2024-11-24 13:02:12'),
    (25.9, 'A temperatura exige atenção', 13, '2024-11-24 14:02:12'),
    (29.3, 'A temperatura exige atenção', 13, '2024-11-24 15:02:12'),
    (23.2, 'A temperatura exige atenção', 14, '2024-11-24 16:02:12'),
    (27.7, 'A temperatura exige atenção', 14, '2024-11-24 17:02:12'),
    (25.1, 'A temperatura exige atenção', 15, '2024-11-24 18:02:12'),
    (28.6, 'A temperatura exige atenção', 15, '2024-11-24 19:02:12'),
    (23.8, 'A temperatura exige atenção', 16, '2024-11-24 20:02:12'),
    (21.6, 'A temperatura exige atenção', 16, '2024-11-24 21:02:12'),
    (26.4, 'A temperatura exige atenção', 17, '2024-11-24 22:02:12'),
    (29.0, 'A temperatura exige atenção', 17, '2024-11-24 23:02:12'),
    (24.9, 'A temperatura exige atenção', 18, '2024-11-25 00:02:12'),
    (22.8, 'A temperatura exige atenção', 18, '2024-11-25 01:02:12'),
    (27.3, 'A temperatura exige atenção', 19, '2024-11-25 02:02:12'),
    (23.7, 'A temperatura exige atenção', 19, '2024-11-25 03:02:12'),
    (25.6, 'A temperatura exige atenção', 20, '2024-11-25 04:02:12'),
    (28.1, 'A temperatura exige atenção', 20, '2024-11-25 05:02:12'),
    (23.5, 'A temperatura exige atenção', 21, '2024-11-25 06:02:12'),
    (29.6, 'A temperatura exige atenção', 21, '2024-11-25 07:02:12'),
    (22.7, 'A temperatura exige atenção', 22, '2024-11-25 08:02:12'),
    (26.8, 'A temperatura exige atenção', 22, '2024-11-25 09:02:12'),
    (24.3, 'A temperatura exige atenção', 23, '2024-11-25 10:02:12'),
    (28.5, 'A temperatura exige atenção', 23, '2024-11-25 11:02:12'),
    (25.0, 'A temperatura exige atenção', 24, '2024-11-25 12:02:12'),
    (29.2, 'A temperatura exige atenção', 24, '2024-11-25 13:02:12'),
    (26.5, 'A temperatura exige atenção', 25, '2024-11-25 14:02:12'),
    (22.9, 'A temperatura exige atenção', 25, '2024-11-25 15:02:12'),
    (27.0, 'A temperatura exige atenção', 26, '2024-11-25 16:02:12'),
    (23.6, 'A temperatura exige atenção', 26, '2024-11-25 17:02:12');
