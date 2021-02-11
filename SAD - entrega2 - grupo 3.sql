---------CREATE TABLES UTILIZANDO O DESIGN STAR SCHEME

--DROP TABLE gerencia_casos, casos, desdobramentos, municipios, testes, boletim_diario, tempo;
--tabela de fatos
CREATE TABLE gerencia_casos(
	caso_id INT NOT NULL,
	desdobramento_id INT,
	teste_id INT NOT NULL,
	municipio_id INT NOT NULL,
	data_entrada INT NOT NULL,
	data_desdobramento INT,
	boletim_dia INT NOT NULL
);

--Cria tabela de casos de covid
CREATE TABLE casos(
	caso_id INT PRIMARY KEY,
	sexo VARCHAR(10) NOT NULL,
	idade INT NOT NULL,
	estado_grave BIT NOT NULL,
	cor_pele VARCHAR(10),
	comorbidades VARCHAR(255)
);

--Cria tabela de desdobramento do caso pela covid-19
CREATE TABLE desdobramentos(
	desdobramento_id INT PRIMARY KEY,
	recuperado BIT NOT NULL,
	falecido BIT NOT NULL,
	descartado BIT NOT NULL
);

--Cria tabela de municipios do estado com suas variáveis sobre a covid-19
CREATE TABLE municipios(
	municipio_id INT PRIMARY KEY,
	nome VARCHAR(255),
	populacao INT,
	casos_confirmados INT,
	casos_descartados INT,
	obitos INT,
	recuperados INT

);

--Cria tabela de testes de um municipio
CREATE TABLE testes(
	teste_id INT PRIMARY KEY,
	numero_adquirido INT,
	numero_utilizado INT,
	distribuidos_para_municipio INT,
	distribuidos_para_rede_hospitalar INT,
	distribuidos_para_gerencia_regional INT,
	distribuidos_para_centro_testagem INT

);

--Cria tabela de informações diárias para reduzir custo de processamento
CREATE TABLE boletim_diario(
	dia INT PRIMARY KEY IDENTITY,
	casos_novos INT,
	casos_acumulados INT,
	descartados INT,
	recuperados INT,
	obitos_novos INT,
	obitos_acumulados INT,
	letalidade REAL
)

CREATE TABLE tempo(
	time_key INT PRIMARY KEY,
	semana_epidemiologica INT NOT NULL,
	dia INT NOT NULL, 
	mes INT NOT NULL,
	ano INT NOT NULL

);


------------ Criação das chaves estrangeiras necessárias


ALTER TABLE gerencia_casos
	ADD CONSTRAINT mngt_casos_id FOREIGN KEY (caso_id)
		REFERENCES casos(caso_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
;
ALTER TABLE gerencia_casos
	ADD CONSTRAINT mngt_municipio_id FOREIGN KEY(municipio_id) 
		REFERENCES municipios(municipio_id) 
		ON DELETE CASCADE
		ON UPDATE CASCADE
;
ALTER TABLE gerencia_casos
	ADD CONSTRAINT mngt_testes_id FOREIGN KEY (teste_id)
		REFERENCES testes(teste_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
;

ALTER TABLE gerencia_casos
	ADD CONSTRAINT mngt_boletim_dia FOREIGN KEY (boletim_dia)
		REFERENCES boletim_diario(dia)
		ON DELETE CASCADE
		ON UPDATE CASCADE
;
ALTER TABLE gerencia_casos
	ADD CONSTRAINT mngt_desdobramento FOREIGN KEY (desdobramento_id)
		REFERENCES desdobramentos(desdobramento_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
;

ALTER TABLE gerencia_casos
	ADD CONSTRAINT mngt_time_key FOREIGN KEY (data_entrada)
		REFERENCES tempo(time_key)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
;

ALTER TABLE gerencia_casos
	ADD CONSTRAINT mngt_time_desdobramento FOREIGN KEY (data_desdobramento)
		REFERENCES tempo(time_key)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
;
