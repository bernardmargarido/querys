USE [GATEWAY]
GO
/****** Object:  StoredProcedure [dbo].[cpq_queue_estoque]    Script Date: 01/02/2023 14:14:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[cpq_queue_estoque]
	-- Add the parameters for the stored procedure here
@ID integer

AS
BEGIN

update [LABOR-1233]..SB2040 SET B2_XCPQEXP = convert(varchar,GETDATE(),112)
from 
	[LABOR-1233]..SB2040 B2 
	inner join[LABOR-1233]..SB1040 B1 ON B1.B1_FILIAL = '' AND B1.R_E_C_N_O_ = @ID AND B1.D_E_L_E_T_ = ''
where 
	B2.B2_FILIAL = '0404' AND 
	B2.B2_COD = B1.B1_COD AND 
	B2.B2_LOCAL = '01' AND
	B2.D_E_L_E_T_ = ''
end