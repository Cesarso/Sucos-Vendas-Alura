
SELECT SUM(QUANTIDADE * [PREÇO]) FROM [ITENS NOTAS FISCAIS]
WHERE NUMERO = 100

CREATE FUNCTION FaturamentoNota (@NUMERO AS INT) RETURNS FLOAT
AS
BEGIN
  DECLARE @FATURAMENTO FLOAT
  SELECT @FATURAMENTO = SUM(QUANTIDADE * [PREÇO]) FROM [ITENS NOTAS FISCAIS]
  WHERE NUMERO = @NUMERO
  RETURN @FATURAMENTO
END


SELECT NUMERO, [dbo].[FaturamentoNota](NUMERO) AS FATURAMENTO 
FROM [NOTAS FISCAIS]

-- -------------------------------------------------------------------------

DECLARE @NUMNOTAS INT
SELECT @NUMNOTAS = COUNT(*) FROM [NOTAS FISCAIS] 
    WHERE DATA = '20170101'
PRINT @NUMNOTAS

/* Transforme este script em uma função onde passamos a data como parâmetro e retornamos o
 número de notas. Chame esta função de NumeroNotas. 
 Após a sua criação, teste seu uso com um SELECT.*/

 CREATE FUNCTION NumeroNotas (@DATA date) returns int
 AS
 BEGIN
	DECLARE @NUMERO_NOTAS INT
SELECT @NUMERO_NOTAS = COUNT(*) FROM [NOTAS FISCAIS] 
    WHERE DATA = @DATA
	RETURN @NUMERO_NOTAS
 END

 SELECT [dbo].[NumeroNotas] ('20170202')
