
-------------- criação de metadados para o boletim diário a fim de reduzir processamento on the fly

DECLARE @today DATE
SET  @today = GETDATE()

--casos_novos= 
DECLARE @novos_casos INT
SET @novos_casos = (SELECT COUNT(caso_id)
					FROM casos
					WHERE data_entrada = @today
					)

--casos_acumulados=
DECLARE @casos_acumulados INT
SET @casos_acumulados = (SELECT COUNT(caso_id)
           				 FROM casos
						)


--descartados=
DECLARE @descartados INT
SET @descartados = (SELECT COUNT(caso_id)
					FROM casos
					WHERE descartado = 1 AND data_desdobramento = @today
					)

--recuperados
DECLARE @recuperados INT
SET @recuperados = (SELECT COUNT(caso_id)
					FROM casos
					WHERE recuperado = 1 AND data_desdobramento = @today
					)


-- obitos_novos
DECLARE @novos_obitos INT
SET @novos_obitos = (SELECT COUNT(caso_id)
					FROM casos
					WHERE veio_a_obito=1 AND data_desdobramento = @today
					)

-- obitos_acumulados INT,
DECLARE @obitos_acumulados INT
SET @obitos_acumulados = (SELECT COUNT(caso_id)
						FROM casos
						WHERE veio_a_obito=1
						)


-- letalidade REAL
DECLARE @letalidade REAL
IF @casos_acumulados IN (0)
	SET @letalidade = 0
ELSE
	SET @letalidade = @obitos_acumulados/@casos_acumulados

					

--semana_epidemiologica
DECLARE @semana INT
SET @semana = (SELECT COUNT(_data)%7+1
				FROM boletim_diario
				)



INSERT INTO boletim_diario(_data, semana_epidemiologica, casos_novos, casos_acumulados, descartados, recuperados,obitos_novos, obitos_acumulados, letalidade)
VALUES (GETDATE(),@semana,@novos_casos,@casos_acumulados,@descartados,@recuperados,@novos_obitos,@obitos_acumulados,@letalidade);
