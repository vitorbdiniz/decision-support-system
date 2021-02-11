
--Inserção na dimensão município
INSERT INTO Dim_Mun(id,nome_municipio, nome_microregiao, nome_macroregiao)
	SELECT id_munc, nm_munc, nm_micro_regiao, nm_meso_regiao 
	FROM municipios
	ORDER BY nm_munc
GO


--Inserção na dimensão tempo
INSERT INTO Dim_Tempo (data, dia_mes, mes, bimestre, trimestre, semestre, ano)
	SELECT Data, Dia, Mes, Bimestre, Trimestre, Semestre, Ano
	FROM tempo
GO


--Inserção na dimensão extra localização
INSERT INTO Dim_Localizacao(latitude, longitude)
	SELECT latitude, longitude
	FROM localização
	ORDER BY nome
GO

--Inserção na tabela de fatos
INSERT INTO Fato_COVIDPB (data_fk, loc_fk, municipio_fk, num_obitos, num_obitos_acc, num_casos, num_casos_acc)
	SELECT t.id, loc.id, mun.id, obitosNovos, obitosAcumulado, casosNovos, casosAcumulado
	FROM HISTORICO_COVID_PB_CASOS AS casos, HISTORICO_COVID_PB_OBITOS AS defuntos,
		 Dim_Tempo AS t, Dim_Mun AS mun, Dim_Localizacao AS loc
	WHERE (
			casos.data = defuntos.data AND defuntos.data = t.data AND
			casos.municipio = defuntos.municipio AND defuntos.municipio = mun.nome_municipio AND
			loc.id = mun.id
				
	)
GO