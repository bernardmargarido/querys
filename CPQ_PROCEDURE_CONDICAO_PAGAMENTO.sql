USE [GATEWAY]
GO
/****** Object:  StoredProcedure [dbo].[cpq_queue_estoque]    Script Date: 21/07/2022 18:46:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cpq_queue_condicao]
	-- Add the parameters for the stored procedure here
@ID integer

AS
BEGIN

update [LABOR-PROD12]..SE4040 SET E4_MSEXP = convert(varchar,GETDATE(),112)
where R_E_C_N_O_ = @ID

end