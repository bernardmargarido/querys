USE [GATEWAY]
GO
/****** Object:  StoredProcedure [dbo].[cpq_queue_clientes]    Script Date: 03/03/2023 17:15:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[cpq_queue_orcamentos]
	-- Add the parameters for the stored procedure here
@ORCAMENTO varchar(6)

AS
BEGIN

update [LABOR-PROD12]..SUA040 SET UA_MSEXP = convert(varchar,GETDATE(),112)
where 
	UA_FILIAL = '0404' AND 
	UA_NUM = @ORCAMENTO AND  
	D_E_L_E_T_ = ''

end