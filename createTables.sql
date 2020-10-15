USE [sad_group3]
GO

/* Auxiliary drops*/
DROP TABLE IF EXISTS diarioCovid;
DROP TABLE IF EXISTS obitos;


/* CRIA TABELA DE DIARIO DA COVID NA PARAIBA*/

CREATE TABLE [diarioCovid](
	[dia] [int] NOT NULL,
	[data] [date] NULL,
	[casosAcumulados] [int] NULL,
	[novosCasos] [int] NULL,
	[casosDescartados] [int] NULL,
	[casosRecuperados] [int] NULL,
	[obitosAcumulados] [int] NULL,
	[obitosNovos] [int] NULL,
	[letalidade] [float] NULL,
 CONSTRAINT [PK_boletimDiarioCovid] PRIMARY KEY CLUSTERED 

(
	[dia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO

/*Cria chave estrangeira*/
ALTER TABLE [DiarioCovid]  WITH CHECK ADD  CONSTRAINT [FK_boletimDiarioCovid] FOREIGN KEY([dia])
REFERENCES [DiarioCovid] ([dia])
GO
ALTER TABLE [DiarioCovid] CHECK CONSTRAINT [FK_boletimDiarioCovid]
GO


/* CRIA TABELA DE OBITOS*/
CREATE TABLE [obitos](
	[defunto_id] [int] identity (1,1) NOT NULL,
	[FK_diario] [int] NOT NULL, 
	[dataObito] [date] NULL,
	[sexo] [nchar](10) NULL,
	[idade] [int] NULL,
	[metodo] [nchar](20) NULL,
	[inicioSintomas] [date] NULL,
	[residencia] [nchar](30) NULL,
	[doencasPreexistentes] [nchar](100) NULL,
 CONSTRAINT [PK_obitos] PRIMARY KEY CLUSTERED
 (
	[defunto_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/*Cria chave estrangeira*/
ALTER TABLE [obitos]  
	ADD  CONSTRAINT [FK_obitos_boletim] FOREIGN KEY([FK_diario])
		REFERENCES [diarioCovid] ([dia])
GO



