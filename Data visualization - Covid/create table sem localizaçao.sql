
CREATE TABLE Dim_Mun(
	id INT PRIMARY KEY,
	nome_municipio VARCHAR(100),
	nome_microregiao VARCHAR(100),
	nome_macroregiao VARCHAR(100)
)
GO


CREATE TABLE Fato_COVIDPB(
	data_fk INT NOT NULL,
	municipio_fk INT NOT NULL,
	num_obitos INT,
	num_obitos_acc INT,
	num_casos INT,
	num_casos_acc INT
)
GO

CREATE TABLE Dim_Tempo(
	id INT IDENTITY(1,1) PRIMARY KEY,
	data date,
	dia_mes INT,
	mes INT,
	bimestre INT,
	trimestre INT,
	semestre INT,
	ano INT
)
GO


-- Cria��o das chaves estrangeiras necess�rias

ALTER TABLE Fato_COVIDPB
	ADD CONSTRAINT Dim_Mun_fk FOREIGN KEY (municipio_fk)
		REFERENCES Dim_Mun(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
GO
ALTER TABLE Fato_COVIDPB
	ADD CONSTRAINT Dim_Tempo_fk FOREIGN KEY (data_fk)
		REFERENCES Dim_Tempo(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
GO
