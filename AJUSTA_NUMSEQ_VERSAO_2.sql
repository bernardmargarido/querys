begin transaction;
WITH duplicados AS (
    SELECT D2_NUMSEQ
    FROM SD2010
    WHERE D2_FILIAL = '0101' AND D_E_L_E_T_ = ''
    GROUP BY D2_NUMSEQ
    HAVING COUNT(*) > 1
),
ranked AS (
    SELECT 
        s.R_E_C_N_O_,
        s.D2_NUMSEQ,
        ROW_NUMBER() OVER (PARTITION BY s.D2_NUMSEQ ORDER BY s.R_E_C_N_O_) AS rn
    FROM SD2010 s
    INNER JOIN duplicados d
        ON s.D2_NUMSEQ = d.D2_NUMSEQ
    WHERE s.D2_FILIAL = '0101' AND s.D_E_L_E_T_ = ''
),
to_update AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY r.R_E_C_N_O_) AS seq_global
    FROM ranked r
    WHERE rn > 1
),
calc AS (
    SELECT *,
           (seq_global / 10000) AS prefix_offset,
           (seq_global % 10000) AS number_part
    FROM to_update
),
final AS (
    SELECT 
        c.R_E_C_N_O_,
        'A' + CHAR(66 + prefix_offset) + RIGHT('0000' + CAST(number_part AS varchar(4)), 4) AS NUMSEQ_NOVO
    FROM calc c
)
UPDATE s
SET s.D2_NUMSEQ = f.NUMSEQ_NOVO
FROM SD2010 s
INNER JOIN final f ON s.R_E_C_N_O_ = f.R_E_C_N_O_;

commit;