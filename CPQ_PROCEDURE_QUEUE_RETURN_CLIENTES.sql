USE [GATEWAY]
GO
/****** Object:  StoredProcedure [dbo].[cpq_return_queue_clientes]    Script Date: 16/05/2023 11:02:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[cpq_return_queue_clientes]
	-- Add the parameters for the stored procedure here
@ID integer

AS
BEGIN

update [LABOR-1233]..SA1040 SET A1_MSEXP = ''
where R_E_C_N_O_ = @ID

end

--exec dbo.cpq_return_queue_clientes 35257