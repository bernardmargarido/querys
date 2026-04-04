-- =====================================================
-- QUERY DE TESTE - Simulação da Trigger TRG_CALCULA_CUSTO_W7
-- Valida o cálculo antes de aplicar a trigger
-- =====================================================

DECLARE @W6_HAWB VARCHAR(50) = '25.09-MFE' -- Altere para o HAWB que deseja testar

SELECT 
    -- Identificação
    W7.W7_HAWB,
    -- Produto
    W7.W7_COD_I,
    -- Valores base
    W7.W7_PESO,
    W7.W7_QTDE,
    W7.W7_PRECO,
    W7.W7_SALDO_Q,
    W6.W6_PESOL,
    W6.W6_VLFRECC,
    W6.W6_XVLRNUM / W6.W6_TX_FRET W6_XVLRNUM,

    -- Cálculos intermediários
    (W7.W7_PESO * W7.W7_QTDE)                                          AS RATEIO_PESO,
    CASE 
        WHEN W6.W6_PESOL <> 0 
        THEN (W7.W7_PESO * W7.W7_QTDE) / W6.W6_PESOL
        ELSE 0 
    END                                                                 AS RATEIO,

    -- Parcelas do custo
    (W7.W7_PRECO * W7.W7_SALDO_Q) /  W7.W7_QTDE                         AS FOB,

    CASE 
        WHEN W6.W6_PESOL <> 0 
        THEN ((W7.W7_PESO * W7.W7_QTDE) / W6.W6_PESOL) * W6.W6_VLFRECC
        ELSE 0 
    END / W7.W7_QTDE                                                                 AS CUSTOFRETE,

    CASE 
        WHEN W6.W6_PESOL <> 0 
        THEN ((W7.W7_PESO * W7.W7_QTDE) / W6.W6_PESOL) * (W6.W6_XVLRNUM / W6.W6_TX_FRET)
        ELSE 0 
    END / W7.W7_QTDE                                                                AS NUMERARIO,

    -- RESULTADO FINAL (valor que será gravado em W7_XCUSTO)
    (W7.W7_PRECO * W7.W7_SALDO_Q) /  W7.W7_QTDE
    
    + 
    
    CASE 
        WHEN W6.W6_PESOL <> 0 
        THEN ((W7.W7_PESO * W7.W7_QTDE) / W6.W6_PESOL) * W6.W6_VLFRECC
        ELSE 0 
      END / W7.W7_QTDE 
     + 
     
     CASE 
        WHEN W6.W6_PESOL <> 0 
        THEN ((W7.W7_PESO * W7.W7_QTDE) / W6.W6_PESOL) * (W6.W6_XVLRNUM / W6.W6_TX_FRET)
        ELSE 0 
      END / W7.W7_QTDE                                                            AS W7_XCUSTO_CALCULADO,
    
    -- Valor atual gravado no campo (para comparação)
    W7.W7_XCUSTO                                                        AS W7_XCUSTO_ATUAL,

    -- Diferença entre o calculado e o atual (ideal = 0)
    (
        (W7.W7_PRECO * W7.W7_SALDO_Q)
        + CASE 
            WHEN W6.W6_PESOL <> 0 
            THEN ((W7.W7_PESO * W7.W7_QTDE) / W6.W6_PESOL) * W6.W6_VLFRECC
            ELSE 0 
          END
        + CASE 
            WHEN W6.W6_PESOL <> 0 
            THEN ((W7.W7_PESO * W7.W7_QTDE) / W6.W6_PESOL) * (W6.W6_XVLRNUM / W6.W6_TX_FRET)
            ELSE 0 
          END
    ) - ISNULL(W7.W7_XCUSTO, 0)                                        AS DIFERENCA,

    -- Status da validação
    CASE 
        WHEN W6.W6_PESOL = 0           THEN 'W6_PESOL é zero (divisão evitada)'
        WHEN W6.W6_XVLRNUM IS NULL 
          OR W6.W6_XVLRNUM = 0        THEN 'W6_XVLRNUM não preenchido (trigger não dispararia)'
        WHEN W7.W7_XCUSTO IS NULL      THEN 'W7_XCUSTO ainda não preenchido'
        ELSE                                'Cálculo validado'
    END                                                                 AS STATUS_VALIDACAO

FROM 
    SW7040 W7
    INNER JOIN SW6040 W6 ON W6.W6_HAWB = W7.W7_HAWB
                         AND W6.D_E_L_E_T_ = ''
WHERE 
    W7.W7_HAWB = @W6_HAWB
    AND W7.D_E_L_E_T_ = ''


