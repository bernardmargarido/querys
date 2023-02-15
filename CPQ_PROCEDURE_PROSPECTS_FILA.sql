USE [GATEWAY]
GO
/****** Object:  StoredProcedure [dbo].[cpq_queue_clientes]    Script Date: 13/12/2022 18:05:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cpq_queue_prospects]
	-- Add the parameters for the stored procedure here
@ID integer

AS
BEGIN

update [LABOR-PROD12]..SUS040 SET US_MSEXP = convert(varchar,GETDATE(),112)
where R_E_C_N_O_ = @ID

end