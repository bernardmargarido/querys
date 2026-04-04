CREATE TABLE dbo.saldos_contabeis (
    ano CHAR(4) NOT NULL,
    contaContabil VARCHAR(30) NOT NULL,
    saldoJan DECIMAL(18,2) DEFAULT 0,
    saldoFev DECIMAL(18,2) DEFAULT 0,
    saldoMar DECIMAL(18,2) DEFAULT 0,
    saldoAbr DECIMAL(18,2) DEFAULT 0,
    saldoMai DECIMAL(18,2) DEFAULT 0,
    saldoJun DECIMAL(18,2) DEFAULT 0,
    saldoJul DECIMAL(18,2) DEFAULT 0,
    saldoAgo DECIMAL(18,2) DEFAULT 0,
    saldoSet DECIMAL(18,2) DEFAULT 0,
    saldoOut DECIMAL(18,2) DEFAULT 0,
    saldoNov DECIMAL(18,2) DEFAULT 0,
    saldoDez DECIMAL(18,2) DEFAULT 0,
    dataProcessamento DATETIME DEFAULT GETDATE()
);

ALTER TABLE dbo.saldos_contabeis
ADD CONSTRAINT uqSaldosContabeis UNIQUE (ano, contaContabil);

DROP INDEX IF EXISTS uqSaldosContabeis ON dbo.saldos_contabeis;

ALTER TABLE dbo.saldos_contabeis
DROP COLUMN mesFinal;