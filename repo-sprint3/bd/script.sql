
-- mysql -u root -p -P 3307
-- SPTech#2024
-- create user 'api'@'%' identified by 'Sptech#2024';
-- GRANT INSERT ON *.* TO 'api';
-- grant all privileges on *.* to aluno;
-- flush privileges;
-- exit
-- mysql -u api -p -P 3307
-- Sptech#2024
CREATE DATABASE ondo;

USE  ondo;

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

ALTER TABLE empresa RENAME COLUMN UF TO estado;

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
('Estufa D', 45.3, 15.60, 3);

SELECT * FROM estufa;


-- Inserir dados na tabela sensor
INSERT INTO sensor (localidade, tipo, fkEstufa) 
VALUES 
('corredor principal', 'temperatura', 1),
('corredor lateral esquerdo', 'temperatura', 1),
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
SELECT a.temperatura, a.mensagem, e.nome AS nomeEstufa
FROM alerta a
JOIN sensor s ON a.fkSensor = s.idSensor
JOIN estufa e ON s.fkEstufa = e.idEstufa;

SELECT m.temperatura, m.dataHora, s.localidade, e.nome as 'Nome Estufa'	FROM medicao as m  JOIN sensor as s  ON m.fkSensor = s.idSensor  JOIN estufa as e   ON s.fkEstufa = e.idEstufa ORDER BY m.dataHora DESC;

SELECT e.*,

max(temperatura) FROM medicao;

SELECT s.localidade, 
       MAX(m.temperatura) AS temperatura_maxima
FROM medicao AS m
JOIN sensor AS s ON m.fkSensor = s.idSensor
JOIN estufa AS e ON s.fkEstufa = e.idEstufa
WHERE e.nome = 'Estufa A'  
GROUP BY s.localidade;

SELECT s.localidade, 
       MIN(m.temperatura) AS temperatura_maxima
FROM medicao AS m
JOIN sensor AS s ON m.fkSensor = s.idSensor
JOIN estufa AS e ON s.fkEstufa = e.idEstufa
WHERE e.nome = 'Estufa A'  
GROUP BY s.localidade;

-- SELECT de temperatura MÁXIMA da ''ESTUFA A'' no ''Corredor principal'' 
SELECT 
    MAX(m.temperatura) AS temperatura_maxima
FROM 
    medicao AS m
JOIN 
    sensor AS s ON m.fkSensor = s.idSensor
JOIN 
    estufa AS e ON s.fkEstufa = e.idEstufa
WHERE 
    e.nome = 'Estufa A';
    
    
-- SELECT de temperatura MÍNIMA da ''ESTUFA A'' no ''Corredor principal''     
    SELECT 
    MIN(m.temperatura) AS temperatura_maxima
FROM 
    medicao AS m
JOIN 
    sensor AS s ON m.fkSensor = s.idSensor
JOIN 
    estufa AS e ON s.fkEstufa = e.idEstufa
WHERE 
    e.nome = 'Estufa A';
    
-- SELECT de temperatura MÉDIA, MÍNIMA e MÁXIMA da ''ESTUFA A'' 
SELECT 
    ROUND(AVG(m.temperatura),2) AS temperatura_media,
    MIN(m.temperatura) AS temperatura_minima,
    MAX(m.temperatura) AS temperatura_maxima
FROM 
    medicao m
JOIN 
    sensor s ON m.fkSensor = s.idSensor
JOIN 
    estufa e ON s.fkEstufa = e.idEstufa
WHERE 
    e.nome = 'Estufa A';

-- SELECT quantidade de alertas da ''ESTUFA A''
SELECT 
    COUNT(a.idAlerta) AS quantidade_alertas
FROM 
    alerta a
JOIN 
    sensor s ON a.fkSensor = s.idSensor
JOIN 
    estufa e ON s.fkEstufa = e.idEstufa
WHERE 
    e.nome = 'Estufa A';
    
select * from usuario;
    