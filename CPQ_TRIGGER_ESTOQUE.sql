USE [LABOR-PROD12]
GO
/****** Object:  Trigger [dbo].[TG_SB2040]    Script Date: 31/03/2023 14:36:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER
 TRIGGER [dbo].[TG_SB2040] 
 ON [dbo].[SB2040]
 FOR UPDATE AS 
 BEGIN 
 IF @@ROWCOUNT = 0 RETURN 
		IF 	NOT UPDATE(B2_FILIAL) AND 
		NOT UPDATE(B2_COD) AND 
		NOT UPDATE(B2_QFIM) AND 
		NOT UPDATE(B2_LOCAL) AND 
		NOT UPDATE(B2_QATU) AND 
		NOT UPDATE(B2_VFIM1) AND 
		NOT UPDATE(B2_VATU1) AND 
		NOT UPDATE(B2_CM1) AND 
		NOT UPDATE(B2_VFIM2) AND 
		NOT UPDATE(B2_VATU2) AND 
		NOT UPDATE(B2_CM2) AND 
		NOT UPDATE(B2_VFIM3) AND 
		NOT UPDATE(B2_VATU3) AND 
		NOT UPDATE(B2_CM3) AND 
		NOT UPDATE(B2_VFIM4) AND 
		NOT UPDATE(B2_VATU4) AND 
		NOT UPDATE(B2_CM4) AND 
		NOT UPDATE(B2_VFIM5) AND 
		NOT UPDATE(B2_VATU5) AND 
		NOT UPDATE(B2_CM5) AND 
		NOT UPDATE(B2_QEMP) AND 
		NOT UPDATE(B2_QEMPN) AND 
		NOT UPDATE(B2_QTSEGUM) AND 
		NOT UPDATE(B2_USAI) AND 
		NOT UPDATE(B2_RESERVA) AND 
		NOT UPDATE(B2_QPEDVEN) AND 
		NOT UPDATE(B2_LOCALIZ) AND 
		NOT UPDATE(B2_NAOCLAS) AND 
		NOT UPDATE(B2_SALPEDI) AND 
		NOT UPDATE(B2_DINVENT) AND 
		NOT UPDATE(B2_DINVFIM) AND 
		NOT UPDATE(B2_QTNP) AND 
		NOT UPDATE(B2_QNPT) AND 
		NOT UPDATE(B2_QTER) AND 
		NOT UPDATE(B2_QFIM2) AND 
		NOT UPDATE(B2_QACLASS) AND 
		NOT UPDATE(B2_DTINV) AND 
		NOT UPDATE(B2_CMFF1) AND 
		NOT UPDATE(B2_CMFF2) AND 
		NOT UPDATE(B2_CMFF3) AND 
		NOT UPDATE(B2_CMFF4) AND 
		NOT UPDATE(B2_CMFF5) AND 
		NOT UPDATE(B2_VFIMFF1) AND 
		NOT UPDATE(B2_VFIMFF2) AND 
		NOT UPDATE(B2_VFIMFF3) AND 
		NOT UPDATE(B2_VFIMFF4) AND 
		NOT UPDATE(B2_VFIMFF5) AND 
		NOT UPDATE(B2_QEMPSA) AND 
		NOT UPDATE(B2_QEMPPRE) AND 
		NOT UPDATE(B2_SALPPRE) AND 
		NOT UPDATE(B2_QEMP2) AND 
		NOT UPDATE(B2_QEMPN2) AND 
		NOT UPDATE(B2_RESERV2) AND 
		NOT UPDATE(B2_QPEDVE2) AND 
		NOT UPDATE(B2_QEPRE2) AND 
		NOT UPDATE(B2_QFIMFF) AND 
		NOT UPDATE(B2_SALPED2) AND 
		NOT UPDATE(B2_QEMPPRJ) AND 
		NOT UPDATE(B2_QEMPPR2) AND 
		NOT UPDATE(B2_STATUS) AND 
		NOT UPDATE(B2_CMFIM1) AND 
		NOT UPDATE(B2_CMFIM2) AND 
		NOT UPDATE(B2_CMFIM3) AND 
		NOT UPDATE(B2_CMFIM4) AND 
		NOT UPDATE(B2_CMFIM5) AND 
		NOT UPDATE(B2_TIPO) AND 
		NOT UPDATE(B2_CMRP1) AND 
		NOT UPDATE(B2_VFRP1) AND 
		NOT UPDATE(B2_CMRP2) AND 
		NOT UPDATE(B2_VFRP2) AND 
		NOT UPDATE(B2_CMRP3) AND 
		NOT UPDATE(B2_VFRP3) AND 
		NOT UPDATE(B2_CMRP4) AND 
		NOT UPDATE(B2_VFRP4) AND 
		NOT UPDATE(B2_CMRP5) AND 
		NOT UPDATE(B2_VFRP5) AND 
		NOT UPDATE(B2_QULT) AND 
		NOT UPDATE(B2_DULT) AND 
		NOT UPDATE(B2_BLOQUEI) AND 
		NOT UPDATE(B2_ECSALDO) AND 
		NOT UPDATE(B2_XDTFIN) AND 
		NOT UPDATE(B2_XDTINI) AND 
		NOT UPDATE(B2_HMOV) AND 
		NOT UPDATE(B2_HULT) AND 
		NOT UPDATE(B2_DMOV) 
  RETURN  
 	DECLARE @OLD VARCHAR(10) 
	SELECT  @OLD = [B2_XCPQEXP] FROM DELETED 
 	DECLARE @ID INT 
 	SELECT @ID = R_E_C_N_O_ FROM INSERTED 
 	--UPDATE SB2040 SET B2_XCPQEXP = '' WHERE R_E_C_N_O_ = @ID AND @OLD = convert(varchar,GETDATE(),112) 
	UPDATE SB2040 SET B2_XCPQEXP = '' WHERE R_E_C_N_O_ = @ID 
END 