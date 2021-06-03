
SELECT SUM(A.QUANTIDADE * A.[PRE�O]) AS FATURAMENTO,
SUM(A.QUANTIDADE * A.[PRE�O])/10 AS COMISSAO
FROM [ITENS NOTAS FISCAIS] A INNER JOIN [NOTAS FISCAIS] B
ON A.NUMERO = B.NUMERO WHERE B.CPF = '1471156710' AND YEAR(B.[DATA]) = 2016

DECLARE @DENOMINADOR INT
SET @DENOMINADOR = 0
SELECT SUM(A.QUANTIDADE * A.[PRE�O]) AS FATURAMENTO,
SUM(A.QUANTIDADE * A.[PRE�O])/@DENOMINADOR AS COMISSAO
FROM [ITENS NOTAS FISCAIS] A INNER JOIN [NOTAS FISCAIS] B
ON A.NUMERO = B.NUMERO WHERE B.CPF = '1471156710' AND YEAR(B.[DATA]) = 2016


CREATE PROCEDURE TrataErroZero @CPF VARCHAR(12), @ANO INT, @DENOMINADOR INT, 
@NUMERRO INT OUTPUT, @NUMLINHA INT OUTPUT
AS
BEGIN
  SELECT SUM(A.QUANTIDADE * A.[PRE�O]) AS FATURAMENTO,
  SUM(A.QUANTIDADE * A.[PRE�O])/@DENOMINADOR AS COMISSAO
  FROM [ITENS NOTAS FISCAIS] A INNER JOIN [NOTAS FISCAIS] B
  ON A.NUMERO = B.NUMERO WHERE B.CPF = @CPF AND YEAR(B.[DATA]) = @ANO
  SELECT @NUMERRO = @@ERROR, @NUMLINHA = @@ROWCOUNT
END

DECLARE @DENOMINADOR INT
DECLARE @CPF VARCHAR(12)
DECLARE @ANO INT
DECLARE @NUMERRO INT
DECLARE @NUMLINHA INT
SET @CPF = '1471156710'
SET @ANO = 2016
SET @DENOMINADOR = 25
EXEC TrataErroZero @CPF = @CPF, @ANO = @ANO, @DENOMINADOR = @DENOMINADOR, @NUMERRO = @NUMERRO OUTPUT, @NUMLINHA = @NUMLINHA OUTPUT
IF @NUMERRO <> 0
 PRINT 'Houve um erro: ' + CONVERT(VARCHAR(30), @NUMERRO) + ' - ' + CONVERT(VARCHAR(30), @NUMLINHA)


 -- 

 CREATE PROCEDURE InclusaoVendedor01 
@MATRICULA AS VARCHAR(5), @NOME AS VARCHAR(100), 
    @PERCENTUAL AS FLOAT,
@DATAADMISSAO AS DATE, @FERIAS AS BIT, @BAIRRO AS VARCHAR(50), 
@NUMERRO INT OUTPUT, @NUMLINHA INT OUTPUT
AS
BEGIN
INSERT INTO [TABELA DE VENDEDORES] (MATRICULA, NOME, 
    [PERCENTUAL COMISS�O], [DATA ADMISS�O], [DE FERIAS], BAIRRO)
VALUES (@MATRICULA, @NOME, @PERCENTUAL, @DATAADMISSAO, @FERIAS, @BAIRRO)
SELECT @NUMERRO = @@ERROR, @NUMLINHA = @@ROWCOUNT
END
-- E depois execute-a:

DECLARE @NUMERRO INT
DECLARE @NUMLINHA INT
EXEC InclusaoVendedor01 '00238', 'Pericles Alves', 0.11, 
    '20160821', 0, 'Santo Amaro', @NUMERRO = 
        @NUMERRO OUTPUT, @NUMLINHA = @NUMLINHA OUTPUT
IF @NUMERRO <> 0
    PRINT 'Houve um erro: ' + 
        CONVERT(VARCHAR(30), @NUMERRO) + ' - ' + 
        CONVERT(VARCHAR(30), @NUMLINHA)



