SELECT *
FROM (
		SELECT row_number() OVER (ORDER BY Populacao DESC) AS row_number, *
       FROM ibge_cidades
	 ) ibge_top20_cidades
WHERE row_number <= 20

GO