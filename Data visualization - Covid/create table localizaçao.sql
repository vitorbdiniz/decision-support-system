--Dimensao extra
CREATE TABLE Dim_Localizacao(
	id INT IDENTITY(1,1) PRIMARY KEY,
	latitude FLOAT NOT NULL,
	longitude FLOAT NOT NULL
)
GO



ALTER TABLE Fato_COVIDPB
	ADD CONSTRAINT Dim_Loc_fk FOREIGN KEY (loc_fk)
		REFERENCES Dim_Localizacao(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
GO