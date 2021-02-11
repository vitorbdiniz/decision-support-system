--Dim_Cidades
INSERT INTO Dim_Cidades(codigo, nome, area)
	SELECT c.codigo, c.nome , p.Area
	FROM cidades AS c JOIN populacao AS p ON c.codigo=p.codigo
GO

--Dim_Chuvas
INSERT INTO Map_Chuvas(fk_cidades)
	SELECT Codigo
	FROM chuvas
GO

INSERT INTO Dim_Chuvas(id,observado,climatologia,desvio,desvio_percentual)
	SELECT id,observado,climatologia,desvio,desvio_percentual
	FROM chuvas JOIN Map_Chuvas ON Codigo = fk_cidades
GO

--Dim_Economia
INSERT INTO Map_Economia(fk_cidades)
	SELECT Codigo
	FROM economia
GO

INSERT INTO Dim_Economia(id,receita_total, despesa_total, idh, pib_per_capita, percentual_receitas_origem_externa)
	SELECT id,receita_total, despesa_total, idh, pib_per_capita, percentual_receitas_origem_externa
	FROM economia, Map_Economia AS map
	WHERE fk_cidades = Codigo
GO

INSERT INTO Map_Educacao(fk_cidades)
	SELECT codigo
	FROM educacao

INSERT INTO Dim_Educacao(id,matriculas_fundamental, matriculas_medio, docentes_fundamental, docentes_medio, num_escolas_fundamental, num_escolas_medio, percentual_escolarizacao)
	SELECT id,matriculas_fundamental, matriculas_medio, docentes_fundamental, docentes_medio, num_escolas_fundamental, num_escolas_medio, percentual_escolarizacao
	FROM educacao, Map_Educacao
	WHERE codigo = fk_cidades
GO


INSERT INTO Map_Populacao(fk_cidades)
	SELECT Codigo
	FROM populacao
GO

INSERT INTO Dim_Populacao(id,total, urbana, rural, percentual_urbana, percentual_rural, densidade_demografica)
	SELECT id,Total, Urbana, Rural, Urbana_percentual, Rural_percentual, densidade
	FROM populacao, Map_Populacao
	WHERE fk_cidades = Codigo
GO

--Dim_Saude
INSERT INTO Map_Saude(fk_cidades)
	SELECT Codigo
	FROM saude
GO

INSERT INTO Dim_Saude (id,n_estabelecimento_de_saude_SUS, mortalidade_infantil_por_mil, esgotamento_sanitario_adequado_percentual, internacoes_por_diarreia)
	SELECT id,N_Estabelecimentos_de_Saude_SUS, Mortalidade_Infantil_por_mil, Esgotamento_sanitario_adequado_percentual, Internacoes_por_diarreia
	FROM saude JOIN Map_Saude ON fk_cidades = Codigo
GO

--Dim_Trabalho
INSERT INTO Map_Trabalho(fk_cidades)
	SELECT codigo
	FROM trabalho
GO
	
INSERT INTO Dim_Trabalho (id,pessoal_ocupado, percentual_populacao_ocupada, salario_medio, percentual_pobreza)
	SELECT id, pessoal_ocupado, percentual_populacao_ocupada, salario_medio, percentual_pobreza
	FROM trabalho JOIN Map_Trabalho ON fk_cidades = Codigo
GO



--Dim_Fatos
INSERT INTO Fatos_CidadesPB(municipio_fk,chuvas_fk,economia_fk,educacao_fk,populacao_fk,saude_fk,trabalho_fk)
	SELECT ci.codigo, ch.id, ec.id, ed.id, pop.id, s.id, t.id
	FROM( 
			Dim_Cidades AS ci JOIN Dim_Chuvas AS ch ON codigo = cidade_id
			JOIN Map_Economia AS ec   ON ec.fk_cidades =ci.codigo
			JOIN Map_Educacao AS ed   ON ed.fk_cidades =ci.codigo
			JOIN Map_Populacao AS pop ON pop.fk_cidades=ci.codigo
			JOIN Map_Saude AS s       ON s.fk_cidades  =ci.codigo
			JOIN Map_Trabalho AS t    ON t.fk_cidades  =ci.codigo
		) 
GO	
