;WITH chars AS (
    SELECT c, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS pos
    FROM (VALUES 
        ('0'),('1'),('2'),('3'),('4'),('5'),('6'),('7'),('8'),('9'),
        ('A'),('B'),('C'),('D'),('E'),('F'),('G'),('H'),('I'),('J'),
        ('K'),('L'),('M'),('N'),('O'),('P'),('Q'),('R'),('S'),('T'),
        ('U'),('V'),('W'),('X'),('Y'),('Z')
    ) v(c)
),
duplicados AS (
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
        ROW_NUMBER() OVER (PARTITION BY s.D2_NUMSEQ ORDER BY s.R_E_C_N_O_ DESC) AS rn
    FROM SD2010 s
    INNER JOIN duplicados d
        ON s.D2_NUMSEQ = d.D2_NUMSEQ
    WHERE s.D2_FILIAL = '0101' AND s.D_E_L_E_T_ = ''
),
sequencia AS (
    SELECT *,
        -- Força o início da sequência em 9ASD22
        '9ASD' AS PREFIXO,
        '23' AS SUFIXO,
        ROW_NUMBER() OVER (ORDER BY R_E_C_N_O_) - 1 AS RN_SEQ
    FROM ranked
    WHERE rn = 1
),
novo_numseq AS (
    SELECT *,
        (SELECT TOP 1 pos FROM chars WHERE c = SUBSTRING(SUFIXO,1,1)) AS SUF1_POS,
        (SELECT TOP 1 pos FROM chars WHERE c = SUBSTRING(SUFIXO,2,1)) AS SUF2_POS,
        (SELECT TOP 1 pos FROM chars WHERE c = RIGHT(PREFIXO,1)) AS PREFIXO_POS
    FROM sequencia
),
incrementado AS (
    SELECT *,
        (SUF2_POS + RN_SEQ) % 36 AS SUF2_NOVA_POS,
        ((SUF2_POS + RN_SEQ) / 36 + SUF1_POS) % 36 AS SUF1_NOVA_POS,
        ((SUF2_POS + RN_SEQ) / 36 + SUF1_POS) / 36 AS PREFIXO_OVERFLOW,
        (PREFIXO_POS + ((SUF2_POS + RN_SEQ) / 36 + SUF1_POS) / 36) % 36 AS PREFIXO_NOVO_POS
    FROM novo_numseq
),
final AS (
    SELECT *,
        (SELECT c FROM chars WHERE pos = SUF1_NOVA_POS) AS SUF1_NOVA,
        (SELECT c FROM chars WHERE pos = SUF2_NOVA_POS) AS SUF2_NOVA,
        LEFT(PREFIXO,3) + (SELECT c FROM chars WHERE pos = PREFIXO_NOVO_POS) AS PREFIXO_NOVO
    FROM incrementado
)
-- UPDATE na tabela SD2010
UPDATE s
SET D2_NUMSEQ = f.PREFIXO_NOVO + f.SUF1_NOVA + f.SUF2_NOVA
FROM SD2010 s
INNER JOIN final f
    ON s.R_E_C_N_O_ = f.R_E_C_N_O_;
