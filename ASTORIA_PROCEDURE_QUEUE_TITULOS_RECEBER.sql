USE [GATEWAY]
GO
/****** Object:  StoredProcedure [dbo].[cpq_queue_estoque]    Script Date: 28/02/2023 19:00:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[astoria_queue_titulo]
	-- Add the parameters for the stored procedure here
@ID integer

AS
BEGIN

update [PROTHEUS_PRO]..SE1010 SET E1_MSEXP = convert(varchar,GETDATE(),112)
where R_E_C_N_O_ = @ID

end