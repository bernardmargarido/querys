USE [GATEWAY]
GO
/****** Object:  StoredProcedure [dbo].[cpq_queue_clientes]    Script Date: 15/07/2022 20:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cpq_queue_lote]
	-- Add the parameters for the stored procedure here
@ID integer

AS
BEGIN

update [LABOR-PROD12]..SB8040 SET B8_MSEXP = convert(varchar,GETDATE(),112)
where R_E_C_N_O_ = @ID

end