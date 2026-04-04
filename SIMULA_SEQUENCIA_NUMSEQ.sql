;WITH duplicados AS (
    SELECT D2_NUMSEQ
    FROM SD2010
    WHERE D2_FILIAL = '0101' AND D_E_L_E_T_ = ''
    GROUP BY D2_NUMSEQ
    HAVING COUNT(*) > 1
),
ranked AS (
    SELECT 
        s.D2_FILIAL,
        s.D2_DOC,
        s.D2_SERIE,
        s.D2_EMISSAO,
        s.D2_NUMSEQ,
        s.R_E_C_N_O_,
        ROW_NUMBER() OVER (PARTITION BY s.D2_NUMSEQ ORDER BY s.R_E_C_N_O_) AS rn
    FROM SD2010 s
    INNER JOIN duplicados d
        ON s.D2_NUMSEQ = d.D2_NUMSEQ
    WHERE s.D2_FILIAL = '0101' AND s.D_E_L_E_T_ = ''
),
to_update AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY s.R_E_C_N_O_) AS seq_global
    FROM ranked s
    WHERE rn > 1 -- só pega duplicados (exceto o primeiro)
),
calc AS (
    SELECT *,
           (seq_global / 10000) AS prefix_offset,    -- muda prefixo a cada 10000
           (seq_global % 10000) AS number_part       -- parte numérica
    FROM to_update
),
final AS (
    SELECT 
        c.D2_FILIAL,
        c.D2_DOC,
        c.D2_SERIE,
        c.D2_EMISSAO,
        c.D2_NUMSEQ AS NUMSEQ_ATUAL,
        c.R_E_C_N_O_,
        'A' + CHAR(66 + prefix_offset) + RIGHT('0000' + CAST(number_part AS VARCHAR(4)), 4) AS NUMSEQ_NOVO
    FROM calc c
)
SELECT *
FROM final
ORDER BY NUMSEQ_ATUAL, R_E_C_N_O_;
