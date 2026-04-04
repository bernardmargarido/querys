USE [LABOR-BI]
GO
/****** Object:  StoredProcedure [dbo].[cpq_orcamentos]    Script Date: 02/03/2023 16:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ncm_logcomex]
	-- Add the parameters for the stored procedure here
@idpagesize int,
@idpage int,
@anomes_de varchar(10),
@anomes_ate varchar(10),
@ncm nvarchar(max)

AS
BEGIN
	
	declare @ncm_proc nvarchar(max)
	declare @query varchar(max)

	if charindex(',',@ncm) > 0
		set @ncm_proc = char(39) + replace(@ncm, ',', ''',''' ) + char(39) --char(39) + char(44) + char(39)
	else
		set @ncm_proc = @ncm

	
	set @query = N'SELECT '
	set @query +='	TOP(' + cast( @idpagesize as varchar) + ') rNum,' 
	set @query +='	recno,'
	set @query +='	anoMes,'
	set @query +='	idItem,'
	set @query +='	idImport,'
	set @query +='	descricaoProduto,'
	set @query +='	ncm,'
	set @query +='	unidadeMedidaEstatica,'
	set @query +='	paisOrigem,'
	set @query +='	paisAquisicao,'
	set @query +='	quantidadeComercializada,'
	set @query +='	quantidadeEstatica,'
	set @query +='	pesoLiquido,'
	set @query +='	pesoCaixa,'
	set @query +='	valorFobEstimadoUnitario,'
	set @query +='	valorSeguroUnitario,'
	set @query +='	valorCifUnitario,'
	set @query +='	valorFreteUnitario,'
	set @query +='	valorFobTotal,'
	set @query +='	valorCifTotal,'
	set @query +='	valorSeguroItem,'
	set @query +='	valorFreteItem,'
	set @query +='	valorFreteTotal,'
	set @query +='	valorSeguroTotal,'
	set @query +='	incoterm,'
	set @query +='	urfEntrada,'
	set @query +='	model,'
	set @query +='	importadorCnpj,'
	set @query +='	importadorNome,'
	set @query +='	importadorEndereco,'
	set @query +='	exportadorNome,'
	set @query +='	exportadorEndereco,'
	set @query +='	palavrasChave,'
	set @query +='	relavanciaPalavraChave,'
	set @query +='	palavraChave01,'
	set @query +='	relevanciaFob01,'
	set @query +='	relevanciaQtd01,'
	set @query +='	palavraChave02,'
	set @query +='	relevanciaFob02,'
	set @query +='	relevanciaQtd02,'
	set @query +='	palavraChave03,'
	set @query +='	relevanciaFob03,'
	set @query +='	relevanciaQtd03,'
	set @query +='	palavraChave04,'
	set @query +='	relevanciaFob04,'
	set @query +='	relevanciaQtd04,'
	set @query +='	palavraChave05,'
	set @query +='	relevanciaFob05,'
	set @query +='	relevanciaQtd05'
	set @query +=' FROM ('
	set @query +='		SELECT '
	set @query +='			ROW_NUMBER() OVER(ORDER BY recno DESC) rNum,'
	set @query +='			recno,'
	set @query +='			anoMes,'
	set @query +='			idItem,'
	set @query +='			idImport,'
	set @query +='			descricaoProduto,'
	set @query +='			ncm,'
	set @query +='			unidadeMedidaEstatica,'
	set @query +='			paisOrigem,'
	set @query +='			paisAquisicao,'
	set @query +='			quantidadeComercializada,'
	set @query +='			quantidadeEstatica,'
	set @query +='			pesoLiquido,'
	set @query +='			pesoCaixa,'
	set @query +='			valorFobEstimadoUnitario,'
	set @query +='			valorSeguroUnitario,'
	set @query +='			valorCifUnitario,'
	set @query +='			valorFreteUnitario,'
	set @query +='			valorFobTotal,'
	set @query +='			valorCifTotal,'
	set @query +='			valorSeguroItem,'
	set @query +='			valorFreteItem,'
	set @query +='			valorFreteTotal,'
	set @query +='			valorSeguroTotal,'
	set @query +='			incoterm,'
	set @query +='			urfEntrada,'
	set @query +='			model,'
	set @query +='			importadorCnpj,'
	set @query +='			importadorNome,'
	set @query +='			importadorEndereco,'
	set @query +='			exportadorNome,'
	set @query +='			exportadorEndereco,'
	set @query +='			palavrasChave,'
	set @query +='			relavanciaPalavraChave,'
	set @query +='			palavraChave01,'
	set @query +='			relevanciaFob01,'
	set @query +='			relevanciaQtd01,'
	set @query +='			palavraChave02,'
	set @query +='			relevanciaFob02,'
	set @query +='			relevanciaQtd02,'
	set @query +='			palavraChave03,'
	set @query +='			relevanciaFob03,'
	set @query +='			relevanciaQtd03,'
	set @query +='			palavraChave04,'
	set @query +='			relevanciaFob04,'
	set @query +='			relevanciaQtd04,'
	set @query +='			palavraChave05,'
	set @query +='			relevanciaFob05,'
	set @query +='			relevanciaQtd05'
	set @query +='		FROM '
	set @query +='			[LABOR-BI]..NCM_LOGCOMEX NCM'
	set @query +='		WHERE '
	set @query +='			ncm in(' + @ncm + ') and '
	set @query +='			anoMes between ' + @anomes_de + ' and ' + @anomes_ate  
	set @query +='	)NCMS '
	set @query +=' WHERE rNum > ' + cast( @idpagesize as varchar) + ' * ( ' + cast( @idpage - 1 as varchar) + ' ) '

	EXECUTE (@query)

END