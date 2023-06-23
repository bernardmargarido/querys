USE [GATEWAY]
GO
/****** Object:  StoredProcedure [dbo].[cpq_queue_clientes]    Script Date: 03/03/2023 17:15:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[cpq_queue_status]
	-- Add the parameters for the stored procedure here
@PEDIDO varchar(6)

AS
BEGIN

update [LABOR-PROD12]..Z05040 SET Z05_MSEXP = convert(varchar,GETDATE(),112)
where 
Z05_FILIAL = '0404' AND 
Z05_PEDIDO = @PEDIDO AND 
D_E_L_E_T_ = ''

end