
-- CRIAÇÃO DAS TABELAS ESSENCIAIS PARA O MODELO
CREATE TABLE Dim_Cidades(
	codigo INT PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	area FLOAT NOT NULL
)
GO

CREATE TABLE Dim_Chuvas(
	id INT PRIMARY KEY,
	observado INT NOT NULL,
	climatologia FLOAT,
	desvio FLOAT,
	desvio_percentual FLOAT
)
GO

CREATE TABLE Dim_Economia(
	id INT PRIMARY KEY,
	receita_total FLOAT NOT NULL,
	despesa_total FLOAT NOT NULL,
	idh FLOAT NOT NULL,
	pib_per_capita FLOAT NOT NULL,
	percentual_receitas_origem_externa FLOAT NOT NULL
)
GO
CREATE TABLE Dim_Educacao(
	id INT PRIMARY KEY,
	matriculas_fundamental INT NOT NULL,
	matriculas_medio INT NOT NULL,
	docentes_fundamental INT,
	docentes_medio INT,
	num_escolas_fundamental INT,
	num_escolas_medio INT,
	percentual_escolarizacao FLOAT
)
GO
CREATE TABLE Dim_Populacao(
	id INT PRIMARY KEY,
	total INT NOT NULL,
	urbana INT NOT NULL,
	rural INT NOT NULL,
	percentual_urbana FLOAT NOT NULL,
	percentual_rural FLOAT NOT NULL,
	densidade_demografica FLOAT NOT NULL
)
GO
CREATE TABLE Dim_Saude(
	id INT PRIMARY KEY,
	n_estabelecimento_de_saude_SUS INT,
	mortalidade_infantil_por_mil FLOAT,
	esgotamento_sanitario_adequado_percentual FLOAT,
	internacoes_por_diarreia INT
)
GO
CREATE TABLE Dim_Trabalho(
	id INT PRIMARY KEY,
	pessoal_ocupado INT NOT NULL,
	percentual_populacao_ocupada FLOAT NOT NULL,
	salario_medio FLOAT NOT NULL, -- em salários mínimos
	percentual_pobreza FLOAT NOT NULL -- % da população que recebe menos de 0,5 salário minimo
)
GO
CREATE TABLE Fatos_CidadesPB(
	municipio_fk INT NOT NULL,
	chuvas_fk INT NOT NULL,
	economia_fk INT NOT NULL,
	educacao_fk INT NOT NULL,
	populacao_fk INT NOT NULL,
	saude_fk INT NOT NULL,
	trabalho_fk INT NOT NULL
)
GO

-- MAPEAMENTO DOS IDs COM AS TABELAS FONTES PARA INSERIR DADOS EM FATOS

CREATE TABLE Map_Chuvas(
	id INT IDENTITY(1,1) PRIMARY KEY,
	fk_cidades INT NOT NULL
)
GO

CREATE TABLE Map_Economia(
	id INT IDENTITY(1,1) PRIMARY KEY,
	fk_cidades INT NOT NULL
)
GO

CREATE TABLE Map_Educacao(
	id INT IDENTITY(1,1) PRIMARY KEY,
	fk_cidades INT NOT NULL
)
GO

CREATE TABLE Map_Populacao(
	id INT IDENTITY(1,1) PRIMARY KEY,
	fk_cidades INT NOT NULL
)
GO

CREATE TABLE Map_Saude(
	id INT IDENTITY(1,1) PRIMARY KEY,
	fk_cidades INT NOT NULL
)
GO

CREATE TABLE Map_Trabalho(
	id INT IDENTITY(1,1) PRIMARY KEY,
	fk_cidades INT NOT NULL
)
GO
-- Foreign Keys para as tabelas de mapeamento
ALTER TABLE Map_Chuvas
	ADD CONSTRAINT mapping_chuvas FOREIGN KEY (fk_cidades)
		REFERENCES cidades(codigo)
		ON DELETE CASCADE
		ON UPDATE CASCADE
GO
ALTER TABLE Map_Economia
	ADD CONSTRAINT mapping_economia FOREIGN KEY (fk_cidades)
		REFERENCES cidades(codigo)
		ON DELETE CASCADE
		ON UPDATE CASCADE
GO
ALTER TABLE Map_Educacao
	ADD CONSTRAINT mapping_educacao FOREIGN KEY (fk_cidades)
		REFERENCES cidades(codigo)
		ON DELETE CASCADE
		ON UPDATE CASCADE
GO
ALTER TABLE Map_Populacao
	ADD CONSTRAINT mapping_populacao FOREIGN KEY (fk_cidades)
		REFERENCES cidades(codigo)
		ON DELETE CASCADE
		ON UPDATE CASCADE
GO
ALTER TABLE Map_Saude
	ADD CONSTRAINT mapping_saude FOREIGN KEY (fk_cidades)
		REFERENCES cidades(codigo)
		ON DELETE CASCADE
		ON UPDATE CASCADE
GO
ALTER TABLE Map_Trabalho
	ADD CONSTRAINT mapping_trabalho FOREIGN KEY (fk_cidades)
		REFERENCES cidades(codigo)
		ON DELETE CASCADE
		ON UPDATE CASCADE
GO
-- Foreign Keys para a tabela de fatos
ALTER TABLE Fatos_CidadesPB
	ADD CONSTRAINT ref_cidades FOREIGN KEY (municipio_fk)
		REFERENCES Dim_Cidades(codigo)
		ON DELETE CASCADE
		ON UPDATE CASCADE
GO
ALTER TABLE Fatos_CidadesPB
	ADD CONSTRAINT ref_chuvas FOREIGN KEY (chuvas_fk)
		REFERENCES Dim_Chuvas(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
GO

ALTER TABLE Fatos_CidadesPB
	ADD CONSTRAINT ref_economia FOREIGN KEY (economia_fk)
		REFERENCES Dim_Economia(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
GO

ALTER TABLE Fatos_CidadesPB
	ADD CONSTRAINT ref_educacao FOREIGN KEY (educacao_fk)
		REFERENCES Dim_Educacao(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
GO

ALTER TABLE Fatos_CidadesPB
	ADD CONSTRAINT ref_populacao FOREIGN KEY (populacao_fk)
		REFERENCES Dim_Populacao(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
GO

ALTER TABLE Fatos_CidadesPB
	ADD CONSTRAINT ref_saude FOREIGN KEY (saude_fk)
		REFERENCES Dim_Saude(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
GO

ALTER TABLE Fatos_CidadesPB
	ADD CONSTRAINT ref_Trabalho FOREIGN KEY (trabalho_fk)
		REFERENCES Dim_Trabalho(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
GO
