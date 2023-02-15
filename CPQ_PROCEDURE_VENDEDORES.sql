CREATE PROCEDURE [dbo].[cpq_queue_vendedores]
	-- Add the parameters for the stored procedure here
@ID integer

AS
BEGIN

update [LABOR-PROD12]..SA3040 SET A3_MSEXP = convert(varchar,GETDATE(),112)
where R_E_C_N_O_ = @ID

end