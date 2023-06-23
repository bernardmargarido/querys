SELECT 
	XTA_ID,
	XTA_IDPAY,
	XTA_DTEMIS,
	XTA_DTPGTO,
	XTA_TYPE,
	XTA_PARC,
	COUNT(*)
FROM 
	XTA010 
WHERE 
	XTA_FILIAL = '06' AND
	D_E_L_E_T_ = ''
GROUP BY XTA_ID,XTA_IDPAY,XTA_DTEMIS,XTA_DTPGTO,XTA_TYPE,XTA_PARC HAVING COUNT(*) > 1
ORDER BY XTA_ID,XTA_IDPAY,XTA_DTEMIS,XTA_DTPGTO,XTA_TYPE,XTA_PARC


--DELETE FROM XTA010 XTA
XTA_CODIGO,
	XTA_ID,
	XTA_IDPAY,
	XTA_DTEMIS,
	XTA_DTPGTO,
	XTA_TYPE,
	XTA_PARC,


select * from  ##DUPLICATEXTA

UPDATE XTA010 SET D_E_L_E_T_ = '*', R_E_C_D_E_L_ = XTA.R_E_C_N_O_
FROM 
	XTA010 XTA
WHERE 
	XTA.R_E_C_N_O_ IN ( SELECT RECNOXTA FROM ##DUPLICATEXTA )

SELECT 
	XTA.R_E_C_N_O_ RECNOXTA
	into ##DUPLICATEXTA
FROM 
	XTA010 XTA
--DELETE FROM XTA010 XTA
WHERE 
	XTA_CODIGO > (
				SELECT 
					MIN(XTA_A.XTA_CODIGO) 
				FROM 
					XTA010 XTA_A 
				WHERE 
					XTA_A.XTA_ID = XTA.XTA_ID AND 
					XTA_A.XTA_IDPAY = XTA.XTA_IDPAY AND
					XTA_A.XTA_DTEMIS = XTA.XTA_DTEMIS AND
					XTA_A.XTA_DTPGTO = XTA.XTA_DTPGTO AND 
					XTA_A.XTA_TYPE = XTA.XTA_TYPE AND 
					XTA_A.XTA_PARC = XTA.XTA_PARC AND 
					XTA_A.D_E_L_E_T_ = ''
			) AND
	XTA.D_E_L_E_T_ = ''
	ORDER BY XTA_ID,XTA_IDPAY,XTA_DTEMIS,XTA_DTPGTO,XTA_TYPE,XTA_PARC

SELECT
	DupRank
FROM(
	SELECT XTA_ID,XTA_IDPAY,XTA_DTEMIS,XTA_DTPGTO,XTA_TYPE,XTA_PARC
	, DupRank = ROW_NUMBER() OVER (
				  PARTITION BY XTA.XTA_ID + XTA.XTA_IDPAY + XTA.XTA_DTEMIS + XTA.XTA_DTPGTO + XTA.XTA_TYPE + XTA.XTA_PARC
				  ORDER BY (SELECT NULL)
				)
	FROM XTA010 XTA
) DUPLI 
WHERE DupRank > 1